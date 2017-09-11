#!/bin/bash

file="$(basename $1)"
file="${file%.*}"

if fasmg "-i" "random@@seed = (( $RANDOM shl 60 ) xor ( $RANDOM shl 45 ) xor ( $RANDOM shl 30 ) xor ( $RANDOM shl 15 ) xor $RANDOM )" "$1" "build/$file";
then
  objdump "-D" "-Mintel" "-bbinary" "-m$2" "build/$file"
fi