#!/usr/bin/env python3
"""
Create an Acorn Electron UEF tape image from a binary file
UEF format: a file header, then chunks of carrier tone and of tape blocks
"""

import sys
import os
import struct

BLOCK_SIZE = 256        # The Electron saves a file in blocks of 256 bytes
SYNC_BYTE = 0x2A        # Every block on tape starts with this byte

# Chunk numbers of the UEF format
CHUNK_ORIGIN = 0x0000   # Text: what made this file
CHUNK_DATA = 0x0100     # Bytes as they are on the tape
CHUNK_CARRIER = 0x0110  # Carrier tone, the length in cycles
CHUNK_GAP = 0x0112      # Silence

def crc16(data):
    """The check sum the Electron puts after a block header and after the data"""
    crc = 0
    for byte in data:
        crc ^= byte << 8
        for _ in range(8):
            if crc & 0x8000:
                crc = ((crc << 1) ^ 0x1021) & 0xFFFF
            else:
                crc = (crc << 1) & 0xFFFF
    # On tape the high byte comes first
    return bytes([crc >> 8, crc & 0xFF])

def chunk(number, data):
    """A UEF chunk: its number, its length and the data"""
    return struct.pack('<HI', number, len(data)) + data

def create_uef(input_file, output_file, load_addr=0x0E00):
    """Convert a binary file to a UEF tape image with one file on it"""

    # Read input file
    with open(input_file, 'rb') as f:
        data = f.read()

    # File name on the tape (max 10 chars)
    name = os.path.basename(input_file)[:10].upper()

    # UEF file header: the format's name and its version, 0.10
    uef_data = bytearray(b'UEF File!\x00')
    uef_data.extend([10, 0])

    uef_data.extend(chunk(CHUNK_ORIGIN, b'mk_uef.py\x00'))

    # The tape starts with a long carrier tone
    uef_data.extend(chunk(CHUNK_CARRIER, struct.pack('<H', 1500)))

    # The file, block by block
    blocks = [data[i:i + BLOCK_SIZE] for i in range(0, len(data), BLOCK_SIZE)]
    for number, block in enumerate(blocks):
        last = number == len(blocks) - 1

        # Block header: name, load address, execution address (the program
        # starts where it is loaded), block number, block length, flags
        # (bit 7 = last block) and four bytes that are not used
        header = name.encode('ascii') + b'\x00'
        header += struct.pack('<IIHHBI', load_addr, load_addr, number,
                              len(block), 0x80 if last else 0x00, 0)

        tape_block = bytes([SYNC_BYTE]) + header + crc16(header)
        tape_block += block + crc16(block)
        uef_data.extend(chunk(CHUNK_DATA, tape_block))

        # A short carrier tone between the blocks
        uef_data.extend(chunk(CHUNK_CARRIER, struct.pack('<H', 600)))

    # Silence at the end of the tape
    uef_data.extend(chunk(CHUNK_GAP, struct.pack('<H', 1200)))

    # Write output
    with open(output_file, 'wb') as f:
        f.write(uef_data)

    end_addr = load_addr + len(data) - 1
    print(f"✓ UEF file created:{output_file}")
    print(f"  Start address: ${load_addr:04X}")
    print(f"  End address:   ${end_addr:04X}")
    print(f"  Size:          {len(data)} bytes")

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: mk_uef.py <input_file> <output_file> [load_address]")
        print("Example: mk_uef.py platformer platformer.uef 0x0E00")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]
    load_addr = int(sys.argv[3], 0) if len(sys.argv) > 3 else 0x0E00

    create_uef(input_file, output_file, load_addr)
