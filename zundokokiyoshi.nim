# How to compile:
# 1. nim c -r FILENAME.nim
# 2. nim c -r --define:zunGreaterThan4 FILENAME.nim

import math, ./lib/zdcore

template isKiyoshi(num: typed): bool =
  when defined(zunGreaterThan4):
    4 <= num.sum
  else:
    4 == num.sum

var zdPattern: seq[int] = @[]
while true:
  for z_or_d in zundokoGenerator():
    zdPattern.add(z_or_d.int)
    if z_or_d == doko:
      defer: zdPattern = @[]
      if zdPattern.isKiyoshi:
        echo "キ ヨ シ!"
        quit 0
