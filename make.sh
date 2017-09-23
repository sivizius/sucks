#!/bin/bash

file="$(basename $1)"
file="${file%.*}"
echo "#!sba:log" > "build/${file}.log"
if fasmg  "-i" "random@@seed = (( $RANDOM shl 60 ) xor ( $RANDOM shl 45 ) xor ( $RANDOM shl 30 ) xor ( $RANDOM shl 15 ) xor $RANDOM )"  \
          "-i" "theInput Equ '$1'"                                                                                                      \
          "-i" "theOutput Equ 'build/$file'"                                                                                            \
          "-v" "1"                                                                                                                      \
          "compiler.fasm" "build/$file" 2>&1 | tee -a "build/${file}.log"
then
  hexdump -v -e '"0x%04_ax " 16/1 "%02X " " | "' -e '16/1 "%_p" "\n"' "build/$file" | tee -a "build/${file}.log"
#    objdump "-D" "-Mintel" "-bbinary" "-m$2" "build/$file"
fi