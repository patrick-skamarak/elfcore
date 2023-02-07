discard """
    exitcode: 0
    output:'''{"fileHeaderCommon":{"magic":"0x00000000","format":"0x00","endianness":"0x00","elfVersion":"0x00","targetOsAbi":"0x00","abiVersion":"0x00","pad":[0,0,0,0,0,0,0],"kind":"0x0000","targetArchitecture":"0x0000","elfVersion2":"0x00000000"},"fileHeader32":{"entryPoint":"0x00000000","programHeaderOffset":"0x00000000","sectionHeaderOffset":"0x00000000","flags":"0x00000000","fileHeaderSize":0,"programHeaderEntrySize":0,"numProgramHeaderEntries":0,"sectionHeaderEntrySize":0,"numSectionHeaderEntries":0,"sectionHeaderTableIndex":0},"programHeaders":[],"sectionHeaders":[]}'''
"""
import ../src/elfcore, json

echo %Elf32Headers()