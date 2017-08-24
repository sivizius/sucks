#!/bin/bash
echo "$[$3]@$[$2]"
dd if=$1 of=/dev/stdout bs=1 skip=$[$2] count=$[$3] status=none
echo