#!/usr/bin/env python3
import argparse
import sys
import time

try:
    import mido
except ImportError:
    print("Missing dependency: pip install mido")
    sys.exit(1)

try:
    import serial
    import serial.tools.list_ports
except ImportError:
    print("Missing dependency: pip install pyserial")
    sys.exit(1)


def list_ports():
    ports = serial.tools.list_ports.comports()
    if not ports:
        print("No serial ports found")
    for port in ports:
        print(port.device)


def fold_note(note):
    for _ in range(8):
        if note < 21:
            note += 12
        elif note > 108:
            note -= 12
        else:
            break
    if not 21 <= note <= 108:
        raise ValueError(f"Unable to fold MIDI note {note} into 21..108")
    return note


def forward_message(uart, message, include_drums):
    channel = getattr(message, "channel", None)
    if channel == 9 and not include_drums:
        return

    if message.type in ("note_on", "note_off"):
        original_note = message.note
        folded_note = fold_note(original_note)
        if folded_note != original_note:
            print(
                f"Folded MIDI note {original_note} -> {folded_note} "
                f"(channel {channel + 1})",
                flush=True,
            )
            message = message.copy(note=folded_note)

    uart.write(message.bin())
    uart.flush()


def main():
    parser = argparse.ArgumentParser(description="Forward USB MIDI or MIDI files to the Urbana UART")
    parser.add_argument("--port", help="Serial port, for example COM7")
    parser.add_argument("--baud", type=int, default=115200)
    parser.add_argument("--list", action="store_true")
    parser.add_argument("--midi", help="Optional .mid file")
    parser.add_argument(
        "--include-drums",
        action="store_true",
        help="Forward General MIDI percussion on channel 10",
    )
    args = parser.parse_args()

    if args.list:
        print("Serial ports:")
        list_ports()
        print("MIDI inputs:")
        for name in mido.get_input_names():
            print(name)
        return

    if not args.port:
        parser.error("--port COMx is required unless --list is used")

    with serial.Serial(args.port, args.baud, timeout=0) as uart:
        if args.midi:
            midi = mido.MidiFile(args.midi)
            print("Playing", args.midi)
            for message in midi.play():
                if not message.is_meta:
                    forward_message(uart, message, args.include_drums)
        else:
            names = mido.get_input_names()
            if not names:
                parser.error("No USB MIDI input devices found")
            print("Listening on", names[0])
            with mido.open_input(names[0]) as midi_input:
                while True:
                    for message in midi_input.iter_pending():
                        if not message.is_meta:
                            forward_message(uart, message, args.include_drums)
                    time.sleep(0.001)


if __name__ == "__main__":
    main()
