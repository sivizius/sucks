#!/bin/bash

file="$(basename $1)"
file="${file%.*}"

fasmg "-i" "theInput Equ '$1'" "compiler.fasm" "build/$file"
hexdump -v -e '"0x%04_ax " 16/1 "%02X " " | "' -e '16/1 "%_p" "\n"' "build/$file"