import math

type ZunDoko* = enum
  doko, zun

iterator zundokoGenerator*(): ZunDoko =
  yield case math.random(2).ZunDoko:
          of zun:  echo "ズン"; zun
          of doko: echo "ドコ"; doko

iterator zundokoGenerator*(id: int): ZunDoko =
  yield case math.random(2).ZunDoko:
          of zun:  echo "ズン" & $id; zun
          of doko: echo "ドコ" & $id; doko
