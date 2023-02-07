import json, strutils

type
    ProgramHeaderKind* = enum
        phUnused = 0x00000000'u32 #	Program header table entry unused.
        phLoadable = 0x00000001'u32 #	Loadable segment.
        phDynamicLinkingInfo = 0x00000002'u32 #	Dynamic linking information.
        phInterpreterInfo = 0x00000003'u32 #	Interpreter information.
        phNote = 0x00000004'u32 #	Auxiliary information.
        phShlib = 0x00000005'u32 #	Reserved.
        phProgramHeaderTable = 0x00000006'u32 #	Segment containing program header table itself.
        phThreadLocalStorageTemplate = 0x00000007'u32 #	Thread-Local Storage template.
        phOsLowBound = 0x60000000'u32 #	Reserved inclusive range. Operating system specific.
        phOsHighBound = 0x6FFFFFFF'u32 #
        phProcessorLowBound = 0x70000000'u32 #	Reserved inclusive range. Processor specific.
        phProcessHighBound = 0x7FFFFFFF'u32 #
    
    ProgramHeader32* = object
        kind* : uint32
        offsetInFileImage* : uint32
        addressInMemory* : uint32
        physicalAddress* : uint32
        sizeInFileImage* : uint32
        sizeInMemory* : uint32
        flags* : uint32
        # 0 and 1 specify no alignment. Otherwise should be a positive, integral power of 2, with p_vaddr equating p_offset modulus p_align.
        alignment* : uint32

    ProgramHeader64* = object
        kind* : uint32
        flags* : uint32
        offsetInFileImage* : uint64
        addressInMemory* : uint64
        physicalAddress* : uint64
        sizeInFileImage* : uint64
        sizeInMemory* : uint64
        # 0 and 1 specify no alignment. Otherwise should be a positive, integral power of 2, with p_vaddr equating p_offset modulus p_align.
        alignment* : uint64

proc `%`*( programHeader32 : ProgramHeader32 ) : JsonNode = 
    result = %{
        "kind" : %("0x"&programHeader32.kind.toHex()),
        "offsetInFileImage" : %("0x"&programHeader32.offsetInFileImage.toHex()),
        "addressInMemory" : %("0x"&programHeader32.addressInMemory.toHex()),
        "physicalAddress" : %("0x"&programHeader32.physicalAddress.toHex()),
        "sizeInFileImage" : %programHeader32.sizeInFileImage,
        "sizeInMemory" : %programHeader32.sizeInMemory,
        "flags" : %("0x"&programHeader32.flags.toHex()),
        "alignment" : %("0x"&programHeader32.alignment.toHex())
    }

proc `%`*( programHeader64 : ProgramHeader64 ) : JsonNode = 
    result = %{
        "kind" : %("0x"&programheader64.kind.toHex()),
        "flags" : %("0x"&programheader64.flags.toHex()),
        "offsetInFileImage" : %("0x"&programheader64.offsetInFileImage.toHex()),
        "addressInMemory" : %("0x"&programheader64.addressInMemory.toHex()),
        "physicalAddress" : %("0x"&programheader64.physicalAddress.toHex()),
        "sizeInFileImage" : %programheader64.sizeInFileImage,
        "sizeInMemory" : %programheader64.sizeInMemory,
        "alignment" : %("0x"&programheader64.alignment.toHex())
    }