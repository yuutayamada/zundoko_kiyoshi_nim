# How to compile: nim c -r --threads:on FILENAME.nim
import math, os, sequtils
import threadpool

type ZunDoko = enum
  doko, zun

iterator zundokoGenerator(id: int): ZunDoko =
  yield case math.random(2).ZunDoko:
          of zun:  echo "ズン" & $id; zun
          of doko: echo " ドコ" & $id; doko

const max_threads = 5

var
  song {.threadvar.}: seq[int]
  mike: int = 1
  order: array[0 .. max_threads-1, int] = [1,2,3,4,5]

proc change(id: int) =
  let rest = @order.filterIt(it != id and it != 0)
  if -1 != rest.high:
    let next = math.random(max(1, rest.high))
    mike = rest[next]

proc kiyoshi(id: int = 0) {.thread.} =
  block done:
    song = @[]
    while true:
      if mike == id:
        for z_or_d in zundokoGenerator(id):
          song.add(z_or_d.int)
          if z_or_d == doko:
            change id
            defer: song = @[]
            if song.sum >= 4:
              defer:
                change id
                if 0 == order[max(0, id-1)]:
                  break done
              echo "キ ヨ シ!" & $id & "\n"
              order[max(0, id-1)] = 0
      else:
        sleep(100)

when isMainModule:
  for i in 1..max_threads:
    spawn kiyoshi(i)

  sync()
