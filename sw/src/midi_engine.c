#include "midi_engine.h"

#include "xil_io.h"

#define MIDI_EVENT_OFFSET 0x2CU
#define VOICE_CONTROL_OFFSET 0x28U
#define ADSR_CONFIG_OFFSET 0x30U
#define WAVE_OVERRIDE_ENABLE (1U << 10)

static uint32_t midi_base_addr;

void midi_engine_init(uint32_t base_addr)
{
    midi_base_addr = base_addr;
}

void midi_send_packet(uint8_t status, uint8_t data1, uint8_t data2)
{
    uint32_t packet = ((uint32_t)status << 16) |
                      ((uint32_t)data1 << 8) |
                      (uint32_t)data2;
    Xil_Out32(midi_base_addr + MIDI_EVENT_OFFSET, packet);
}

void midi_note_on(uint8_t note, uint8_t velocity)
{
    midi_send_packet(0x90U, note, velocity);
}

void midi_note_off(uint8_t note)
{
    midi_send_packet(0x80U, note, 0U);
}

void midi_pitch_bend(uint16_t bend_value)
{
    bend_value &= 0x3FFFU;
    midi_send_packet(0xE0U, (uint8_t)(bend_value & 0x7FU),
                     (uint8_t)((bend_value >> 7) & 0x7FU));
}

void midi_program_change(uint8_t program)
{
    midi_send_packet(0xC0U, program, 0U);
}

void midi_all_notes_off(void)
{
    midi_send_packet(0xB0U, 123U, 0U);
}

void midi_engine_set_waveform(uint8_t wave_sel)
{
    uint32_t control = WAVE_OVERRIDE_ENABLE |
                       ((uint32_t)(wave_sel % 3U) << 8);
    Xil_Out32(midi_base_addr + VOICE_CONTROL_OFFSET, control);
}

void midi_engine_use_midi_program(void)
{
    Xil_Out32(midi_base_addr + VOICE_CONTROL_OFFSET, 0U);
}

void midi_engine_set_adsr_config(uint32_t config)
{
    Xil_Out32(midi_base_addr + ADSR_CONFIG_OFFSET, config);
}
