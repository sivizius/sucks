#!/bin/bash

rm $(find ./ | egrep '(~|\.swp|\.save)$')
rm build/*