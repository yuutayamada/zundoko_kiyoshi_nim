# How to compile: nim c -r --threads:on FILENAME.nim
import math, threadpool, locks
import ./lib/zdcore

const max_threads = 10

var
  L: Lock
  count {.global.} = 0'u

initLock(L)

proc kiyoshi(id: int = 0) {.thread.} =
  block done:
    while count.int <= 4:
      L.withLock: 
        for z_or_d in zundokoGenerator(id):
          if z_or_d == doko:
            if count.int >= 4:
              echo "キ ヨ シ!" & $id
              quit(0)
          else:
            count += 1

when isMainModule:
  for i in 1..max_threads:
    spawn kiyoshi(i)
  sync()
