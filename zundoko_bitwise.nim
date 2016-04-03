# How to compile&run: nim c -r FILENAME.nim
import ./lib/zdcore

var count: int = 1
while true:
  for z_or_d in zundokoGenerator():
    case z_or_d
    of zun:
      count = count shl 1  # bitwise: SHift Left
    of doko:
      defer: count = 1
      if 0 != count shr 4: # bitwise: SHift Right
        echo "キ ヨ シ!"
        quit 0
