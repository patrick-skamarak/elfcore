discard """
    exitcode: 0
"""
import os, ../src/elflib, json

echo %getElf32Headers("./tests/app")