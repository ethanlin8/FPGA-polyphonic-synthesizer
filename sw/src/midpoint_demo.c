#include <stdint.h>

#include "lw_usb/GenericMacros.h"
#include "lw_usb/GenericTypeDefs.h"
#include "lw_usb/MAX3421E.h"
#include "lw_usb/USB.h"
#include "lw_usb/usb_ch9.h"
#include "lw_usb/transfer.h"
#include "lw_usb/HID.h"
#include "lw_usb/project_config.h"

#include "xparameters.h"
#include "xil_io.h"
#include "xil_printf.h"
#include "xtmrctr.h"

#include "midi_engine.h"
#include "midi_songs.h"

#ifndef XPAR_HDMI_TEXT_CONTROLLER_0_AXI_BASEADDR
#error "The Vitis platform must define XPAR_HDMI_TEXT_CONTROLLER_0_AXI_BASEADDR."
#endif
#define BASE_ADDR XPAR_HDMI_TEXT_CONTROLLER_0_AXI_BASEADDR

#define MIDI_TIMER_TICKS_PER_MS USB_TIMER_TICKS_PER_MS

#if defined(XPAR_AXI_UARTLITE_0_BASEADDR)
#define MIDI_UART_BASEADDR XPAR_AXI_UARTLITE_0_BASEADDR
#elif defined(XPAR_UARTLITE_0_BASEADDR)
#define MIDI_UART_BASEADDR XPAR_UARTLITE_0_BASEADDR
#else
#define MIDI_UART_BASEADDR 0x40600000U
#endif
#define UART_RX_FIFO_OFFSET 0x00U
#define UART_STATUS_OFFSET  0x08U
#define UART_RX_VALID       0x01U
#define MIDI_LOOP_MAX_EVENTS 256U
#define NO_NOTE 0xFFU

extern HID_DEVICE hid_device;
extern XTmrCtr Usb_timer;

static BYTE usb_addr = 1;
static uint8_t midi_running_status;
static uint8_t midi_data1;
static uint8_t midi_data_count;
static uint32_t previous_timer_ticks;
static uint64_t elapsed_timer_ticks;
static uint8_t timer_sample_initialized;

static midi_event_t loop_events[MIDI_LOOP_MAX_EVENTS];
static uint16_t loop_event_count;
static uint16_t loop_record_index;
static uint32_t loop_record_last_ms;
static uint16_t loop_playback_index;
static uint32_t loop_next_event_ms;
static uint8_t loop_recording;
static uint8_t loop_playing;

static uint8_t song_playing;
static uint8_t song_selection;
static uint16_t song_event_index;
static uint32_t song_next_event_ms;

static uint8_t previous_usb_notes[6] = {
    NO_NOTE, NO_NOTE, NO_NOTE, NO_NOTE, NO_NOTE, NO_NOTE
};
static uint8_t previous_keycodes[6];
static uint8_t previous_octave_down;
static uint8_t previous_octave_up;
static uint8_t previous_key_1;
static uint8_t previous_key_2;
static uint8_t previous_key_3;
static uint8_t previous_key_9;
static uint8_t previous_key_0;
static uint8_t previous_key_minus;
static uint8_t previous_key_equal;
static uint8_t previous_backspace;

static uint32_t now_ms(void)
{
    uint32_t current_ticks = XTmrCtr_GetValue(&Usb_timer, 0);

    if (!timer_sample_initialized) {
        previous_timer_ticks = current_ticks;
        timer_sample_initialized = 1;
    } else {
        elapsed_timer_ticks += (uint32_t)(current_ticks - previous_timer_ticks);
        previous_timer_ticks = current_ticks;
    }

    return (uint32_t)(elapsed_timer_ticks / MIDI_TIMER_TICKS_PER_MS);
}

static uint8_t time_reached(uint32_t now, uint32_t deadline)
{
    return (uint32_t)(now - deadline) < 0x80000000U;
}

static uint8_t key_was_held(uint8_t keycode)
{
    unsigned int i;
    for (i = 0; i < 6U; ++i) {
        if (previous_keycodes[i] == keycode)
            return 1U;
    }
    return 0U;
}

static int keycode_to_note_offset(BYTE keycode)
{
    switch (keycode) {
    case 0x04: return 0;  /* A */
    case 0x1A: return 1;  /* W */
    case 0x16: return 2;  /* S */
    case 0x08: return 3;  /* E */
    case 0x07: return 4;  /* D */
    case 0x09: return 5;  /* F */
    case 0x17: return 6;  /* T */
    case 0x0A: return 7;  /* G */
    case 0x1C: return 8;  /* Y */
    case 0x0B: return 9;  /* H */
    case 0x18: return 10; /* U */
    case 0x0D: return 11; /* J */
    case 0x0E: return 12; /* K */
    case 0x12: return 13; /* O */
    case 0x0F: return 14; /* L */
    case 0x13: return 15; /* P */
    case 0x33: return 16; /* ; */
    case 0x34: return 17; /* ' */
    default:   return -1;
    }
}

static uint8_t note_in_list(const uint8_t notes[6], uint8_t note)
{
    unsigned int i;
    for (i = 0; i < 6U; ++i) {
        if (notes[i] == note)
            return 1U;
    }
    return 0U;
}

static void record_note_event(uint8_t status, uint8_t note, uint8_t velocity)
{
    uint32_t now;
    uint16_t index;

    if (!loop_recording || loop_record_index >= MIDI_LOOP_MAX_EVENTS)
        return;

    now = now_ms();
    index = loop_record_index;
    loop_events[index].delta_ms = (index == 0U) ? 0U : now - loop_record_last_ms;
    loop_events[index].status = status;
    loop_events[index].data1 = note;
    loop_events[index].data2 = velocity;
    loop_record_last_ms = now;
    loop_record_index++;
    loop_event_count = loop_record_index;
}

static void send_live_note_on(uint8_t note, uint8_t velocity)
{
    midi_note_on(note, velocity);
    record_note_event(0x90U, note, velocity);
}

static void send_live_note_off(uint8_t note)
{
    midi_note_off(note);
    record_note_event(0x80U, note, 0U);
}

static void update_usb_notes(const uint8_t current_notes[6])
{
    unsigned int i;

    for (i = 0; i < 6U; ++i) {
        if (current_notes[i] != NO_NOTE &&
            !note_in_list(previous_usb_notes, current_notes[i]))
            send_live_note_on(current_notes[i], 100U);
    }
    for (i = 0; i < 6U; ++i) {
        if (previous_usb_notes[i] != NO_NOTE &&
            !note_in_list(current_notes, previous_usb_notes[i]))
            send_live_note_off(previous_usb_notes[i]);
    }
    for (i = 0; i < 6U; ++i)
        previous_usb_notes[i] = current_notes[i];
}

static void collect_usb_notes(const BOOT_KBD_REPORT *report,
                              unsigned int octave_base,
                              uint8_t notes[6])
{
    unsigned int i;
    int note_offset;
    unsigned int note;

    for (i = 0; i < 6U; ++i) {
        notes[i] = NO_NOTE;
        note_offset = keycode_to_note_offset(report->keycode[i]);
        if (note_offset >= 0) {
            note = octave_base + (unsigned int)note_offset;
            if (note >= 36U && note <= 96U)
                notes[i] = (uint8_t)note;
        }
    }
}

static void stop_song(void)
{
    if (song_playing) {
        midi_all_notes_off();
        xil_printf("MIDI song stopped\r\n");
    }
    song_playing = 0;
}

static void start_song(uint8_t selection)
{
    song_playing = 1;
    song_selection = selection;
    song_event_index = 0;
    song_next_event_ms = now_ms();
    xil_printf(selection == 1U ? "Bach-style MIDI song started\r\n"
                               : "Synth MIDI progression started\r\n");
}

static void toggle_song(uint8_t selection)
{
    if (song_playing && song_selection == selection)
        stop_song();
    else {
        stop_song();
        start_song(selection);
    }
}

static void service_song(void)
{
    const midi_event_t *events;
    uint16_t event_count;
    uint32_t now;

    if (!song_playing)
        return;

    if (song_selection == 1U) {
        events = bach_prelude;
        event_count = (uint16_t)BACH_PRELUDE_EVENT_COUNT;
    } else {
        events = synth_progression;
        event_count = (uint16_t)SYNTH_PROGRESSION_EVENT_COUNT;
    }

    now = now_ms();
    if (!time_reached(now, song_next_event_ms))
        return;
    if (song_event_index >= event_count) {
        stop_song();
        return;
    }

    midi_send_packet(events[song_event_index].status,
                     events[song_event_index].data1,
                     events[song_event_index].data2);
    song_event_index++;
    if (song_event_index >= event_count) {
        song_next_event_ms = now;
    } else {
        song_next_event_ms += events[song_event_index].delta_ms;
    }
}

static void toggle_loop_recording(void)
{
    if (loop_recording) {
        loop_recording = 0;
        loop_event_count = loop_record_index;
        xil_printf("Loop recording stopped: %u events\r\n", loop_event_count);
    } else {
        loop_playing = 0;
        loop_record_index = 0;
        loop_event_count = 0;
        loop_record_last_ms = now_ms();
        loop_recording = 1;
        xil_printf("Loop recording started\r\n");
    }
}

static void toggle_loop_playback(void)
{
    if (loop_playing) {
        loop_playing = 0;
        midi_all_notes_off();
        xil_printf("Loop playback stopped\r\n");
    } else if (loop_event_count != 0U) {
        loop_playback_index = 0;
        loop_next_event_ms = now_ms();
        loop_playing = 1;
        xil_printf("Loop playback started\r\n");
    } else {
        xil_printf("Loop empty\r\n");
    }
}

static void service_loop(void)
{
    uint32_t now;
    const midi_event_t *event;

    if (!loop_playing)
        return;
    now = now_ms();
    if (!time_reached(now, loop_next_event_ms))
        return;

    if (loop_playback_index >= loop_event_count) {
        loop_playback_index = 0;
        loop_next_event_ms = now;
        return;
    }

    event = &loop_events[loop_playback_index];
    midi_send_packet(event->status, event->data1, event->data2);
    loop_playback_index++;
    if (loop_playback_index >= loop_event_count) {
        loop_playback_index = 0;
        loop_next_event_ms = now;
    } else {
        loop_next_event_ms += loop_events[loop_playback_index].delta_ms;
    }
}

static void parse_midi_byte(uint8_t byte)
{
    uint8_t message;
    uint8_t status;
    uint8_t needed;

    if (byte >= 0xF8U)
        return;
    if (byte & 0x80U) {
        midi_data_count = 0;
        if (byte >= 0xF0U) {
            midi_running_status = 0;
            return;
        }
        midi_running_status = byte;
        return;
    }

    status = midi_running_status;
    if (status == 0U)
        return;
    message = status & 0xF0U;
    needed = ((message == 0xC0U) || (message == 0xD0U)) ? 1U : 2U;

    if (midi_data_count == 0U) {
        midi_data1 = byte & 0x7FU;
        midi_data_count = 1U;
        if (needed == 1U) {
            if (message == 0xC0U) {
                midi_engine_use_midi_program();
                midi_program_change(midi_data1);
            }
            midi_data_count = 0U;
        }
        return;
    }

    midi_data_count = 0U;
    if (message == 0x80U) {
        midi_note_off(midi_data1);
        record_note_event(0x80U, midi_data1, byte & 0x7FU);
    } else if (message == 0x90U) {
        if ((byte & 0x7FU) == 0U) {
            midi_note_off(midi_data1);
            record_note_event(0x80U, midi_data1, 0U);
        } else {
            midi_note_on(midi_data1, byte & 0x7FU);
            record_note_event(0x90U, midi_data1, byte & 0x7FU);
        }
    } else if (message == 0xB0U) {
        if (midi_data1 == 120U || midi_data1 == 123U)
            midi_all_notes_off();
        else
            midi_send_packet(status, midi_data1, byte & 0x7FU);
    } else if (message == 0xE0U) {
        midi_pitch_bend((uint16_t)(((byte & 0x7FU) << 7) | midi_data1));
    }
}

static void service_uart_midi(void)
{
    while ((Xil_In32(MIDI_UART_BASEADDR + UART_STATUS_OFFSET) &
            UART_RX_VALID) != 0U) {
        parse_midi_byte(
            (uint8_t)Xil_In32(MIDI_UART_BASEADDR + UART_RX_FIFO_OFFSET));
    }
}

static BYTE get_keyboard_device(void)
{
    BYTE i;
    BYTE rcode;
    BYTE device = 0xFF;
    BYTE tmpbyte;
    DEV_RECORD *entry;

    for (i = 1; i < USB_NUMDEVICES; ++i) {
        entry = GetDevtable(i);
        if (entry->epinfo != NULL)
            device = entry->devclass;
    }

    rcode = XferGetIdle(usb_addr, 0, hid_device.interface, 0, &tmpbyte);
    if (rcode != 0)
        xil_printf("GetIdle error: %x\r\n", rcode);
    rcode = XferGetProto(usb_addr, 0, hid_device.interface, &tmpbyte);
    if (rcode == 0)
        rcode = XferSetProto(usb_addr, 0, hid_device.interface, BOOT_PROTOCOL);
    if (rcode != 0)
        xil_printf("Set boot protocol error: %x\r\n", rcode);
    else
        xil_printf("USB keyboard boot protocol active\r\n");
    return device;
}

static void service_keyboard_controls(const BOOT_KBD_REPORT *report)
{
    BYTE keycode;
    unsigned int i;
    uint8_t down;

    for (i = 0; i < 6U; ++i) {
        keycode = report->keycode[i];
        down = key_was_held(keycode);
        if (keycode == 0x1EU && !down) {
            midi_engine_set_waveform(0U);
            xil_printf("Waveform: Sine\r\n");
        } else if (keycode == 0x1FU && !down) {
            midi_engine_set_waveform(1U);
            xil_printf("Waveform: Sawtooth\r\n");
        } else if (keycode == 0x20U && !down) {
            midi_engine_set_waveform(2U);
            xil_printf("Waveform: Square\r\n");
        } else if (keycode == 0x26U && !down) {
            toggle_song(1U);
        } else if (keycode == 0x27U && !down) {
            toggle_song(2U);
        } else if (keycode == 0x2DU && !down) {
            toggle_loop_recording();
        } else if (keycode == 0x2EU && !down) {
            toggle_loop_playback();
        } else if (keycode == 0x2AU && !down) {
            midi_all_notes_off();
            xil_printf("MIDI panic\r\n");
        }
    }
}

static void remember_keyboard_report(const BOOT_KBD_REPORT *report)
{
    unsigned int i;
    for (i = 0; i < 6U; ++i)
        previous_keycodes[i] = report->keycode[i];
}

static void release_usb_notes(void)
{
    unsigned int i;
    for (i = 0; i < 6U; ++i) {
        if (previous_usb_notes[i] != NO_NOTE)
            midi_note_off(previous_usb_notes[i]);
        previous_usb_notes[i] = NO_NOTE;
    }
}

int midpoint_demo_main(void)
{
    BYTE rcode;
    BYTE device = 0xFF;
    BYTE running = 0;
    BYTE error_reported = 0;
    BYTE error_rollover;
    BOOT_KBD_REPORT report;
    WORD bytes_rd;
    uint8_t current_usb_notes[6];
    unsigned int octave_base = 60U;
    unsigned int i;
    uint8_t octave_down_now;
    uint8_t octave_up_now;

    midi_engine_init(BASE_ADDR);
    midi_engine_set_waveform(1U);
    midi_engine_set_adsr_config(MIDI_ADSR_DEFAULT_CONFIG);
    xil_printf("Waveform: Sawtooth\r\n");
    MAX3421E_init();
    USB_init();

    while (1) {
        MAX3421E_Task();
        USB_Task();
        service_uart_midi();
        service_song();
        service_loop();

        if (GetUsbTaskState() == USB_STATE_RUNNING) {
            error_reported = 0;
            if (!running) {
                running = 1;
                device = get_keyboard_device();
            } else if (device == 1) {
                rcode = kbdPoll(&report, &bytes_rd);
                if (rcode == hrNAK)
                    continue;
                if (rcode != 0 || bytes_rd < (WORD)sizeof(report))
                    continue;

                error_rollover = 0;
                for (i = 0; i < 6U; ++i) {
                    if (report.keycode[i] == 0x01U ||
                        report.keycode[i] == 0x02U)
                        error_rollover = 1;
                }
                if (error_rollover)
                    continue;

                octave_down_now = 0;
                octave_up_now = 0;
                for (i = 0; i < 6U; ++i) {
                    if (report.keycode[i] == 0x2FU)
                        octave_down_now = 1;
                    if (report.keycode[i] == 0x30U)
                        octave_up_now = 1;
                }
                if (octave_down_now && !previous_octave_down && octave_base >= 48U)
                    octave_base -= 12U;
                if (octave_up_now && !previous_octave_up && octave_base < 84U)
                    octave_base += 12U;
                previous_octave_down = octave_down_now;
                previous_octave_up = octave_up_now;

                collect_usb_notes(&report, octave_base, current_usb_notes);
                update_usb_notes(current_usb_notes);
                service_keyboard_controls(&report);
                remember_keyboard_report(&report);
            }
        } else if (GetUsbTaskState() == USB_STATE_ERROR) {
            if (!error_reported) {
                release_usb_notes();
                for (i = 0; i < 6U; ++i)
                    previous_keycodes[i] = 0;
                octave_base = 60U;
                stop_song();
                xil_printf("USB error state\r\n");
                running = 0;
                device = 0xFF;
                error_reported = 1;
            }
        } else if (running) {
            running = 0;
            device = 0xFF;
            release_usb_notes();
            for (i = 0; i < 6U; ++i)
                previous_keycodes[i] = 0;
            octave_base = 60U;
            stop_song();
            MAX3421E_init();
            USB_init();
        }
    }
}
