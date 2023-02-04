import json, strutils

type
    ProgramHeaderKind* = enum
        PHK_NULL = 0x00000000'u32 #	Program header table entry unused.
        PHK_LOAD = 0x00000001'u32 #	Loadable segment.
        PHK_DYNAMIC = 0x00000002'u32 #	Dynamic linking information.
        PHK_INTERP = 0x00000003'u32 #	Interpreter information.
        PHK_NOTE = 0x00000004'u32 #	Auxiliary information.
        PHK_SHLIB = 0x00000005'u32 #	Reserved.
        PHK_PHDR = 0x00000006'u32 #	Segment containing program header table itself.
        PHK_TLS = 0x00000007'u32 #	Thread-Local Storage template.
        PHK_LOOS = 0x60000000'u32 #	Reserved inclusive range. Operating system specific.
        PHK_HIOS = 0x6FFFFFFF'u32 #
        PHK_LOPROC = 0x70000000'u32 #	Reserved inclusive range. Processor specific.
        PHK_HIPROC = 0x7FFFFFFF'u32 #
    
    ProgramHeader32* = object
        kind* : uint32
        offset* : uint32
        virtualAddress* : uint32
        physicalAddress* : uint32
        fileSize* : uint32
        memorySize* : uint32
        flags* : uint32
        alignment* : uint32

    ProgramHeader64* = object
        kind* : uint32
        flags* : uint32
        offset* : uint64
        virtualAddress* : uint64
        physicalAddress* : uint64
        fileSize* : uint64
        memorySize* : uint64
        alignment* : uint64

proc `%`*( programHeader32 : ProgramHeader32 ) : JsonNode = 
    result = %{
        "kind" : %("0x"&programHeader32.kind.toHex()),
        "offset" : %("0x"&programHeader32.offset.toHex()),
        "virtualAddress" : %("0x"&programHeader32.virtualAddress.toHex()),
        "physicalAddress" : %("0x"&programHeader32.physicalAddress.toHex()),
        "fileSize" : %("0x"&programHeader32.fileSize.toHex()),
        "memorySize" : %("0x"&programHeader32.memorySize.toHex()),
        "flags" : %("0x"&programHeader32.flags.toHex()),
        "alignment" : %("0x"&programHeader32.alignment.toHex())
    }

proc `%`*( programHeader64 : ProgramHeader64 ) : JsonNode = 
    result = %{
        "kind" : %("0x"&programheader64.kind.toHex()),
        "flags" : %("0x"&programheader64.flags.toHex()),
        "offset" : %("0x"&programheader64.offset.toHex()),
        "virtualAddress" : %("0x"&programheader64.virtualAddress.toHex()),
        "physicalAddress" : %("0x"&programheader64.physicalAddress.toHex()),
        "fileSize" : %("0x"&programheader64.fileSize.toHex()),
        "memorySize" : %("0x"&programheader64.memorySize.toHex()),
        "alignment" : %("0x"&programheader64.alignment.toHex())
    }