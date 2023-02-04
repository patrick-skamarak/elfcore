# Package

version       = "0.1.0"
author        = "patrick-skamarak"
description   = "An elf file library for nim"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.0.0"

task test, "Run tests":
    exec """testament pattern "./tests/*Test.nim""""
