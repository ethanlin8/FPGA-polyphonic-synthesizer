#ifndef MIDI_ENGINE_H
#define MIDI_ENGINE_H

#include <stdint.h>

/* Packed as {release_10ms, sustain_0_to_255, decay_10ms, attack_ms}. */
#define MIDI_ADSR_DEFAULT_CONFIG 0x28991204U
#define MIDI_ADSR_PIANO_CONFIG 0x236E000BU

void midi_engine_init(uint32_t base_addr);
void midi_send_packet(uint8_t status, uint8_t data1, uint8_t data2);
void midi_note_on(uint8_t note, uint8_t velocity);
void midi_note_off(uint8_t note);
void midi_pitch_bend(uint16_t bend_value);
void midi_program_change(uint8_t program);
void midi_all_notes_off(void);
void midi_engine_set_waveform(uint8_t wave_sel);
void midi_engine_set_echo_enabled(uint8_t enabled);
void midi_engine_use_midi_program(void);
void midi_engine_set_adsr_config(uint32_t config);
void midi_engine_set_display_status(uint8_t octave_index, uint8_t mode);

#endif
