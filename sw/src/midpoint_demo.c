#include <stdint.h>

#include "lw_usb/GenericMacros.h"
#include "lw_usb/GenericTypeDefs.h"
#include "lw_usb/MAX3421E.h"
#include "lw_usb/USB.h"
#include "lw_usb/usb_ch9.h"
#include "lw_usb/transfer.h"
#include "lw_usb/HID.h"

#include "xparameters.h"
#include "xil_io.h"
#include "xil_printf.h"

#ifndef XPAR_HDMI_TEXT_CONTROLLER_0_AXI_BASEADDR
#error "The Vitis platform must define XPAR_HDMI_TEXT_CONTROLLER_0_AXI_BASEADDR."
#endif
#define BASE_ADDR XPAR_HDMI_TEXT_CONTROLLER_0_AXI_BASEADDR

#define KEY_MASK_LOW_OFFSET    0x00U
#define KEY_MASK_HIGH_OFFSET   0x04U
#define TUNING_WORDS_OFFSET    0x08U
#define VOICE_CONTROL_OFFSET   0x28U
#define MIDI_NOTE_COUNT        61U
#define VOICE_COUNT            8U
#define DEFAULT_OCTAVE_BASE    12U
#define WAVE_SEL_SINE          0U
#define WAVE_SEL_SAWTOOTH      1U
#define WAVE_SEL_SQUARE        2U

extern HID_DEVICE hid_device;

static BYTE usb_addr = 1;
static const char * const device_classes[] = {
    " Uninitialized", " HID Keyboard", " HID Mouse", " Mass storage"
};

static const uint32_t MIDI_TUNING_WORDS[MIDI_NOTE_COUNT] = {
    0x00000AF9U, 0x00000BA0U, 0x00000C51U, 0x00000D0DU,
    0x00000DD3U, 0x00000EA6U, 0x00000F85U, 0x00001071U,
    0x0000116BU, 0x00001274U, 0x0000138DU, 0x000014B7U,
    0x000015F2U, 0x00001740U, 0x000018A2U, 0x00001A19U,
    0x00001BA7U, 0x00001D4CU, 0x00001F0AU, 0x000020E2U,
    0x000022D7U, 0x000024E9U, 0x0000271BU, 0x0000296EU,
    0x00002BE5U, 0x00002E81U, 0x00003145U, 0x00003433U,
    0x0000374DU, 0x00003A97U, 0x00003E13U, 0x000041C4U,
    0x000045ADU, 0x000049D2U, 0x00004E36U, 0x000052DCU,
    0x000057C9U, 0x00005D02U, 0x0000628AU, 0x00006866U,
    0x00006E9BU, 0x0000752EU, 0x00007C26U, 0x00008388U,
    0x00008B5AU, 0x000093A4U, 0x00009C6BU, 0x0000A5B8U,
    0x0000AF93U, 0x0000BA04U, 0x0000C513U, 0x0000D0CBU,
    0x0000DD36U, 0x0000EA5DU, 0x0000F84DU, 0x00010710U,
    0x000116B5U, 0x00012747U, 0x000138D6U, 0x00014B71U,
    0x00015F26U
};

static BYTE get_keyboard_device(void)
{
    BYTE i;
    BYTE rcode;
    BYTE device = 0xFF;
    BYTE tmpbyte;
    DEV_RECORD *entry;

    for (i = 1; i < USB_NUMDEVICES; ++i) {
        entry = GetDevtable(i);
        if (entry->epinfo != NULL) {
            if (entry->devclass < (sizeof(device_classes) / sizeof(device_classes[0])))
                xil_printf("Device: %d%s\n", i, device_classes[entry->devclass]);
            else
                xil_printf("Device: %d class %d\n", i, entry->devclass);
            device = entry->devclass;
        }
    }

    rcode = XferGetIdle(usb_addr, 0, hid_device.interface, 0, &tmpbyte);
    if (rcode != 0)
        xil_printf("GetIdle error: %x\n", rcode);

    rcode = XferGetProto(usb_addr, 0, hid_device.interface, &tmpbyte);
    if (rcode != 0)
        xil_printf("GetProto error: %x\n", rcode);
    else
        xil_printf("HID protocol: %d\n", tmpbyte);

    return device;
}

static int keycode_to_note(BYTE keycode)
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

static void clear_voice_state(int8_t voice_note[VOICE_COUNT],
                              uint32_t tuning_words[VOICE_COUNT],
                              uint8_t *voice_gate)
{
    unsigned int voice;

    for (voice = 0; voice < VOICE_COUNT; ++voice) {
        voice_note[voice] = -1;
        tuning_words[voice] = 0;
    }
    *voice_gate = 0;
}

static void write_piano_registers(uint64_t key_mask,
                                  const uint32_t tuning_words[VOICE_COUNT],
                                  uint8_t voice_gate,
                                  uint8_t wave_sel)
{
    unsigned int voice;

    Xil_Out32(BASE_ADDR + KEY_MASK_LOW_OFFSET, (uint32_t)key_mask);
    Xil_Out32(BASE_ADDR + KEY_MASK_HIGH_OFFSET, (uint32_t)(key_mask >> 32));
    for (voice = 0; voice < VOICE_COUNT; ++voice)
        Xil_Out32(BASE_ADDR + TUNING_WORDS_OFFSET + (4U * voice), tuning_words[voice]);
    Xil_Out32(BASE_ADDR + VOICE_CONTROL_OFFSET,
              ((uint32_t)(wave_sel & 0x03U) << 8) | (uint32_t)voice_gate);
}

int midpoint_demo_main(void)
{
    BYTE rcode;
    BYTE device = 0xFF;
    BYTE running = 0;
    BYTE error_reported = 0;
    BYTE previous_octave_down = 0;
    BYTE previous_octave_up = 0;
    BYTE octave_down_now;
    BYTE octave_up_now;
    BYTE octave_down_pressed;
    BYTE octave_up_pressed;
    BYTE error_rollover;
    BOOT_KBD_REPORT keyboard_report;
    uint64_t key_mask = 0;
    int8_t voice_note[VOICE_COUNT];
    uint32_t tuning_words[VOICE_COUNT];
    uint8_t voice_gate = 0;
    uint8_t wave_sel = 1U;
    unsigned int octave_base = DEFAULT_OCTAVE_BASE;
    unsigned int i;
    unsigned int voice;
    unsigned int free_voice;
    int assigned;
    int note;
    int note_offset;

    clear_voice_state(voice_note, tuning_words, &voice_gate);
    MAX3421E_init();
    USB_init();
    write_piano_registers(0, tuning_words, voice_gate, wave_sel);

    while (1) {
        MAX3421E_Task();
        USB_Task();

        if (GetUsbTaskState() == USB_STATE_RUNNING) {
            error_reported = 0;
            if (!running) {
                running = 1;
                device = get_keyboard_device();
            } else if (device == 1) {
                rcode = kbdPoll(&keyboard_report);
                if (rcode == hrNAK)
                    continue;
                if (rcode != 0) {
                    xil_printf("Keyboard poll error: %x\n", rcode);
                    continue;
                }

                error_rollover = 0;
                for (i = 0; i < 6; ++i) {
                    if (keyboard_report.keycode[i] == 0x01)
                        error_rollover = 1;
                }
                if (error_rollover)
                    continue;

                octave_down_now = 0;
                octave_up_now = 0;
                for (i = 0; i < 6; ++i) {
                    switch (keyboard_report.keycode[i]) {
                    case 0x1E:
                        if (wave_sel != WAVE_SEL_SINE) {
                            wave_sel = WAVE_SEL_SINE;
                            xil_printf("Waveform: Sine\r\n");
                        }
                        break;
                    case 0x1F:
                        if (wave_sel != WAVE_SEL_SAWTOOTH) {
                            wave_sel = WAVE_SEL_SAWTOOTH;
                            xil_printf("Waveform: Sawtooth\r\n");
                        }
                        break;
                    case 0x20:
                        if (wave_sel != WAVE_SEL_SQUARE) {
                            wave_sel = WAVE_SEL_SQUARE;
                            xil_printf("Waveform: Square\r\n");
                        }
                        break;
                    default:
                        break;
                    }

                    if (keyboard_report.keycode[i] == 0x2F)
                        octave_down_now = 1;
                    else if (keyboard_report.keycode[i] == 0x30)
                        octave_up_now = 1;
                }

                octave_down_pressed = octave_down_now && !previous_octave_down;
                octave_up_pressed = octave_up_now && !previous_octave_up;
                if (octave_down_pressed != octave_up_pressed) {
                    if (octave_down_pressed && octave_base >= 12U)
                        octave_base -= 12U;
                    else if (octave_up_pressed && octave_base < 48U)
                        octave_base += 12U;
                }
                previous_octave_down = octave_down_now;
                previous_octave_up = octave_up_now;

                key_mask = 0;
                for (i = 0; i < 6; ++i) {
                    note_offset = keycode_to_note(keyboard_report.keycode[i]);
                    if (note_offset >= 0) {
                        note = (int)octave_base + note_offset;
                        if (note < (int)MIDI_NOTE_COUNT)
                            key_mask |= (uint64_t)1U << (unsigned int)note;
                    }
                }

                for (voice = 0; voice < VOICE_COUNT; ++voice) {
                    if ((voice_note[voice] >= 0) &&
                        ((key_mask & ((uint64_t)1U << (unsigned int)voice_note[voice])) == 0U))
                        voice_note[voice] = -1;
                }

                for (note = 0; note < (int)MIDI_NOTE_COUNT; ++note) {
                    if ((key_mask & ((uint64_t)1U << (unsigned int)note)) != 0U) {
                        assigned = 0;
                        for (voice = 0; voice < VOICE_COUNT; ++voice) {
                            if (voice_note[voice] == note)
                                assigned = 1;
                        }
                        if (!assigned) {
                            for (free_voice = 0; free_voice < VOICE_COUNT; ++free_voice) {
                                if (voice_note[free_voice] < 0) {
                                    voice_note[free_voice] = (int8_t)note;
                                    break;
                                }
                            }
                        }
                    }
                }

                voice_gate = 0;
                for (voice = 0; voice < VOICE_COUNT; ++voice) {
                    tuning_words[voice] = 0;
                    if (voice_note[voice] >= 0) {
                        tuning_words[voice] = MIDI_TUNING_WORDS[(unsigned int)voice_note[voice]];
                        voice_gate |= (uint8_t)(1U << voice);
                    }
                }
                write_piano_registers(key_mask, tuning_words, voice_gate, wave_sel);
            }
        } else if (GetUsbTaskState() == USB_STATE_ERROR) {
            if (!error_reported) {
                xil_printf("USB error state\n");
                running = 0;
                device = 0xFF;
                key_mask = 0;
                clear_voice_state(voice_note, tuning_words, &voice_gate);
                octave_base = DEFAULT_OCTAVE_BASE;
                previous_octave_down = 0;
                previous_octave_up = 0;
                write_piano_registers(0, tuning_words, voice_gate, wave_sel);
                error_reported = 1;
            }
        } else if (running) {
            running = 0;
            device = 0xFF;
            key_mask = 0;
            clear_voice_state(voice_note, tuning_words, &voice_gate);
            octave_base = DEFAULT_OCTAVE_BASE;
            previous_octave_down = 0;
            previous_octave_up = 0;
            write_piano_registers(0, tuning_words, voice_gate, wave_sel);
            MAX3421E_init();
            USB_init();
        }
    }
}
