# How to compile: nim c -r --threads:on FILENAME.nim
import math, threadpool

type ZunDoko = enum
  doko, zun

iterator zundokoGenerator(id: int): ZunDoko =
  yield case math.random(2).ZunDoko:
          of zun:  echo "ズン" & $id; zun
          of doko: echo "ドコ" & $id; doko

var song {.threadvar.}: seq[int]

proc kiyoshi(id: int = 0) {.thread.} =
  block done:
    song = @[]
    while true:
      for z_or_d in zundokoGenerator(id):
        song.add(z_or_d.int)
        if z_or_d == doko:
          defer: song = @[]
          if song.sum >= 4:
            echo "キ ヨ シ!" & $id
            break done

when isMainModule:
  let max_threads = 10
  for i in 1..max_threads:
    spawn kiyoshi(i)
  sync()
