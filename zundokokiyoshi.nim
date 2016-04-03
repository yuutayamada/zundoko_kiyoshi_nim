# How to compile: nim c -r FILENAME.nim
import math

type ZunDoko = enum
  doko, zun

iterator zundokoGenerator(): ZunDoko =
  yield case math.random(2).ZunDoko:
          of zun:  echo "ズン"; zun
          of doko: echo "ドコ"; doko

proc kiyoshi() =
  block done:
    var song: seq[int] = @[]
    while true:
      for z_or_d in zundokoGenerator():
        song.add(z_or_d.int)
        if z_or_d == doko:
          defer: song = @[]
          if song.sum >= 4:
            echo "キ ヨ シ!"
            break done

when isMainModule:
  kiyoshi()
