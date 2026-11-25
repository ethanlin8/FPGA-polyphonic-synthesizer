#ifndef MIDI_SONGS_H
#define MIDI_SONGS_H

#include <stdint.h>

typedef struct {
    uint32_t delta_ms;
    uint8_t status;
    uint8_t data1;
    uint8_t data2;
} midi_event_t;

/* Compact 8-voice Bach-style phrase: repeated minor tonic and dominant harmony. */
static const midi_event_t bach_prelude[] = {
    {0,    0x90, 48, 85}, {0, 0x90, 55, 78}, {0, 0x90, 60, 82}, {0, 0x90, 64, 80},
    {500,  0x80, 48, 0},  {0, 0x80, 55, 0}, {0, 0x80, 60, 0}, {0, 0x80, 64, 0},
    {500,  0x90, 43, 82}, {0, 0x90, 55, 76}, {0, 0x90, 59, 80}, {0, 0x90, 62, 78},
    {500,  0x80, 43, 0},  {0, 0x80, 55, 0}, {0, 0x80, 59, 0}, {0, 0x80, 62, 0},
    {500,  0x90, 45, 84}, {0, 0x90, 52, 76}, {0, 0x90, 57, 82}, {0, 0x90, 60, 80},
    {500,  0x80, 45, 0},  {0, 0x80, 52, 0}, {0, 0x80, 57, 0}, {0, 0x80, 60, 0},
    {500,  0x90, 48, 86}, {0, 0x90, 55, 78}, {0, 0x90, 60, 84}, {0, 0x90, 64, 82},
    {500,  0x80, 48, 0},  {0, 0x80, 55, 0}, {0, 0x80, 60, 0}, {0, 0x80, 64, 0}
};

#define BACH_PRELUDE_EVENT_COUNT (sizeof(bach_prelude) / sizeof(bach_prelude[0]))

#endif
