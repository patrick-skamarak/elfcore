import json, strutils

const ELF_MAGIC* = 0x46_4C_45_7F'u32

type
    FileHeaderFormat* = enum
        fhThirtyTwo = 0x1'u8
        fhSixtyFour = 0x2'u8

    FileHeaderEndianness* = enum
        fhLittle = 0x1'u8
        fhBig = 0x2'u8

    FileHeaderKind* = enum
        fhNone = 0x00'u16 # Unknown.
        fhRelocatable = 0x01'u16 # Relocatable file.
        fhExecutable = 0x02'u16 # Executable file.
        fhDynamic = 0x03'u16 #	Shared object.
        fhCore = 0x04'u16 # Core file.
        fhOsLowBound = 0xFE00'u16 # Reserved inclusive range. Operating system specific.
        fhOsHighBound = 0xFEFF'u16
        fhProcessorLowBound = 0xFF00'u16 # Reserved inclusive range. Processor specific.
        fhProcessHighBound = 0xFFFF'u16

    FileHeaderCommon* = object
        magic* : uint32
        format* : FileHeaderFormat
        endianness* : FileHeaderEndianness
        elfVersion* : uint8
        targetOsAbi* : uint8
        abiVersion* : uint8
        pad* : array[7, uint8]
        kind* : FileHeaderKind
        targetArchitecture* : uint16
        elfVersion2* : uint32

    FileHeader32* = object
        entryPoint* : uint32
        programHeaderOffset* : uint32
        sectionHeaderOffset* : uint32
        flags* : uint32
        fileHeaderSize* : uint16
        programHeaderEntrySize* : uint16
        numProgramHeaderEntries* : uint16
        sectionHeaderEntrySize* : uint16
        numSectionHeaderEntries* : uint16
        sectionHeaderTableIndex* : uint16

    FileHeader64* = object
        entryPoint* : uint64
        programHeaderOffset* : uint64
        sectionHeaderOffset* : uint64
        flags* : uint32
        fileHeaderSize* : uint16
        programHeaderEntrySize* : uint16
        numProgramHeaderEntries* : uint16
        sectionHeaderEntrySize* : uint16
        numSectionHeaderEntries* : uint16
        sectionHeaderTableIndex* : uint16

proc isValidHeader*( fileHeaderCommon : FileHeaderCommon ) : bool =
    if fileHeaderCommon.magic != ELF_MAGIC : return false
    if fileHeaderCommon.elfVersion != fileHeaderCommon.elfVersion2 : return false
    if not (fileHeaderCommon.format in FileHeaderFormat.low..FileHeaderFormat.high) : return false
    if not (fileHeaderCommon.endianness in FileHeaderEndianness.low..FileHeaderEndianness.high) : return false
    return true

proc `%`*( fileHeaderCommon : FileHeaderCommon ) : JsonNode = 
    result = %{
        "magic" : %("0x"&fileHeaderCommon.magic.toHex()),
        "format" : %("0x"&(uint8 fileHeaderCommon.format).toHex()),
        "endianness" : %("0x"&(uint8 fileHeaderCommon.endianness).toHex()),
        "elfVersion" : %("0x"&fileHeaderCommon.elfVersion.toHex()),
        "targetOsAbi" : %("0x"&fileHeaderCommon.targetOsAbi.toHex()),
        "abiVersion" : %("0x"&fileHeaderCommon.abiVersion.toHex()),
        "pad" : % fileHeaderCommon.pad,
        "kind" : %("0x"&(uint16 fileHeaderCommon.kind).toHex()),
        "targetArchitecture" : %("0x"&fileHeaderCommon.targetArchitecture.toHex()),
        "elfVersion2" : %("0x"&fileHeaderCommon.elfVersion2.toHex())
    }

proc `%`*( fileHeader32 : FileHeader32 ) : JsonNode = 
    result = %{
        "entryPoint" : %("0x"&fileHeader32.entryPoint.toHex()),
        "programHeaderOffset" : %("0x"&fileHeader32.programHeaderOffset.toHex()),
        "sectionHeaderOffset" : %("0x"&fileHeader32.sectionHeaderOffset.toHex()),
        "flags" : %("0x"&fileHeader32.flags.toHex()),
        "fileHeaderSize" : %fileHeader32.fileHeaderSize,
        "programHeaderEntrySize" : %fileHeader32.programHeaderEntrySize,
        "numProgramHeaderEntries" : %fileHeader32.numProgramHeaderEntries,
        "sectionHeaderEntrySize" : %fileHeader32.sectionHeaderEntrySize,
        "numSectionHeaderEntries" : %fileHeader32.numSectionHeaderEntries,
        "sectionHeaderTableIndex" : %fileHeader32.sectionHeaderTableIndex
    }

proc `%`*( fileHeader64 : FileHeader64 ) : JsonNode = 
    result = %{
        "entryPoint" : %("0x"&fileHeader64.entryPoint.toHex()),
        "programHeaderOffset" : %("0x"&fileHeader64.programHeaderOffset.toHex()),
        "sectionHeaderOffset" : %("0x"&fileHeader64.sectionHeaderOffset.toHex()),
        "flags" : %("0x"&fileHeader64.flags.toHex()),
        "fileHeaderSize" : %fileHeader64.fileHeaderSize,
        "programHeaderEntrySize" : %fileHeader64.programHeaderEntrySize,
        "numProgramHeaderEntries" : %fileHeader64.numProgramHeaderEntries,
        "sectionHeaderEntrySize" : %fileHeader64.sectionHeaderEntrySize,
        "numSectionHeaderEntries" : %fileHeader64.numSectionHeaderEntries,
        "sectionHeaderTableIndex" : %fileHeader64.sectionHeaderTableIndex
    }