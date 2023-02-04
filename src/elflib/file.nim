import json, strutils
const
    THIRTY_TWO* = 0x1'u8
    SIXTY_FOUR* = 0x2'u8
    ELF_MAGIC* = 0x46_4C_45_7F'u32

type
    FH_ENDIANNESS* = enum
        LITTLE = 0x1'u8
        BIG = 0x2'u8

    FH_TYPE* = enum
        NONE = 0x00'u16 # Unknown.
        RELOCATABLE = 0x01'u16 # Relocatable file.
        EXECUTABLE = 0x02'u16 # Executable file.
        SHARED = 0x03'u16 #	Shared object.
        CORE = 0x04'u16 # Core file.
        LOOS = 0xFE00'u16 # Reserved inclusive range. Operating system specific.
        HIOS = 0xFEFF'u16
        LOPROC = 0xFF00'u16 # Reserved inclusive range. Processor specific.
        HIPROC = 0xFFFF'u16

    FileHeaderStart* = object
        magic* : uint32
        format* : uint8
        endianness* : uint8
        elfVersion* : uint8
        osAbi* : uint8
        abiVersion* : uint8
        pad* : array[7, uint8]
        objectFileType* : uint16
        instructionSetArch* : uint16
        elfVersion2* : uint32

    FileHeaderRest32* = object
        entryPoint* : uint32
        programHeaderOffset* : uint32
        sectionHeaderOffset* : uint32
        flags* : uint32
        fileHeaderSize* : uint16
        programHeaderSize* : uint16
        numProgramHeaders* : uint16
        sectionHeaderSize* : uint16
        numSectionHeaders* : uint16
        sectionNameIndex* : uint16

    FileHeaderRest64* = object
        entryPoint* : uint64
        programHeaderOffset* : uint64
        sectionHeaderOffset* : uint64
        flags* : uint32
        fileHeaderSize* : uint16
        programHeaderSize* : uint16
        numProgramHeaders* : uint16
        sectionHeaderSize* : uint16
        numSectionHeaders* : uint16
        sectionNameIndex* : uint16

proc `%`*( fileHeaderStart : FileHeaderStart ) : JsonNode = 
    result = %{
        "magic" : %("0x"&fileHeaderStart.magic.toHex()),
        "format" : %("0x"&fileHeaderStart.format.toHex()),
        "endianness" : %("0x"&fileHeaderStart.endianness.toHex()),
        "elfVersion" : %("0x"&fileHeaderStart.elfVersion.toHex()),
        "osAbi" : %("0x"&fileHeaderStart.osAbi.toHex()),
        "abiVersion" : %("0x"&fileHeaderStart.abiVersion.toHex()),
        "pad" : % fileHeaderStart.pad,
        "objectFileType" : %("0x"&fileHeaderStart.objectFileType.toHex()),
        "instructionSetArch" : %("0x"&fileHeaderStart.instructionSetArch.toHex()),
        "elfVersion2" : %("0x"&fileHeaderStart.elfVersion2.toHex())
    }

proc `%`*( fileHeaderRest32 : FileHeaderRest32 ) : JsonNode = 
    result = %{
        "entryPoint" : %("0x"&fileHeaderRest32.entryPoint.toHex()),
        "programHeaderOffset" : %("0x"&fileHeaderRest32.programHeaderOffset.toHex()),
        "sectionHeaderOffset" : %("0x"&fileHeaderRest32.sectionHeaderOffset.toHex()),
        "flags" : %("0x"&fileHeaderRest32.flags.toHex()),
        "fileHeaderSize" : %("0x"&fileHeaderRest32.fileHeaderSize.toHex()),
        "programHeaderSize" : %("0x"&fileHeaderRest32.programHeaderSize.toHex()),
        "numProgramHeaders" : %("0x"&fileHeaderRest32.numProgramHeaders.toHex()),
        "sectionHeaderSize" : %("0x"&fileHeaderRest32.sectionHeaderSize.toHex()),
        "numSectionHeaders" : %("0x"&fileHeaderRest32.numSectionHeaders.toHex()),
        "sectionNameIndex" : %("0x"&fileHeaderRest32.sectionNameIndex.toHex())
    }

proc `%`*( fileHeaderRest64 : FileHeaderRest64 ) : JsonNode = 
    result = %{
        "entryPoint" : %("0x"&fileHeaderRest64.entryPoint.toHex()),
        "programHeaderOffset" : %("0x"&fileHeaderRest64.programHeaderOffset.toHex()),
        "sectionHeaderOffset" : %("0x"&fileHeaderRest64.sectionHeaderOffset.toHex()),
        "flags" : %("0x"&fileHeaderRest64.flags.toHex()),
        "fileHeaderSize" : %("0x"&fileHeaderRest64.fileHeaderSize.toHex()),
        "programHeaderSize" : %("0x"&fileHeaderRest64.programHeaderSize.toHex()),
        "numProgramHeaders" : %("0x"&fileHeaderRest64.numProgramHeaders.toHex()),
        "sectionHeaderSize" : %("0x"&fileHeaderRest64.sectionHeaderSize.toHex()),
        "numSectionHeaders" : %("0x"&fileHeaderRest64.numSectionHeaders.toHex()),
        "sectionNameIndex" : %("0x"&fileHeaderRest64.sectionNameIndex.toHex())
    }