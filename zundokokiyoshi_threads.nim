# How to compile: nim c -r --threads:on FILENAME.nim
import math, threadpool, locks
import ./lib/zdcore

const max_threads = 10

var
  L: Lock
  zdPattern {.threadvar.}: seq[int]

initLock(L)

proc kiyoshi(id: int = 0) {.thread.} =
  block done:
    zdPattern = @[]
    while true:
      L.withLock: 
        for z_or_d in zundokoGenerator(id):
          zdPattern.add(z_or_d.int)
          if z_or_d == doko:
            defer: zdPattern = @[]
            if zdPattern.sum >= 4:
              echo "キ ヨ シ! " & $id, zdPattern
              break done

when isMainModule:
  for i in 1..max_threads:
    spawn kiyoshi(i)
  sync()
