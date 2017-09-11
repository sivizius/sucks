#!/bin/bash

file="$(basename $1)"
file="${file%.*}"

fasmg "-i" "random@@seed = (( $RANDOM shl 60 ) xor ( $RANDOM shl 45 ) xor ( $RANDOM shl 30 ) xor ( $RANDOM shl 15 ) xor $RANDOM )" "-i" "theInput Equ '$1'" "compiler.fasm" "build/$file"
hexdump -v -e '"0x%04_ax " 32/1 "%02X " " | "' -e '32/1 "%_p" "\n"' "build/$file"