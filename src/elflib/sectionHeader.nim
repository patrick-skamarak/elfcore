import json, strutils

type

    SectionHeaderFlag* = enum
        shIsWritable = 0x1 # Writable
        shAlloc = 0x2 # Occupies memory during execution
        shIsExecutable = 0x4 # Executable
        shMightBeMerged = 0x10 # Might be merged
        shContainsStrings = 0x20 # Contains null-terminated strings
        shInfoLink = 0x40 # 'sh_info' contains SHT index
        shPreserveOrderAfterCombining = 0x80 # Preserve order after combining
        shNonStandardOsHandling = 0x100 # Non-standard OS specific handling required
        shIsGroupMember = 0x200 # Section is member of a group
        shHoldsThreadLocalData = 0x400 # Section hold thread-local data
        shSpecialOrdering = 0x4000000 # Special ordering requirement (Solaris)
        shExcludedUnlessReferencedOrAllocated = 0x8000000 # Section is excluded unless referenced or allocated (Solaris)
        shOsSpecificMask = 0x0FF00000 # OS-specific
        shProcessorSpecificMask = 0xF0000000 # Processor-specific

    SectionHeaderKind* = enum
        shUnused = 0x0'u32 # Section header table entry unused
        shProgramData = 0x1'u32 # Program data
        shSymbolTable = 0x2'u32 # Symbol table
        shStringTable = 0x3'u32 # String table
        shRelocationWithAddends = 0x4'u32 # Relocation entries with addends
        shSymbolHashTable = 0x5'u32 # Symbol hash table
        shDynamicLinkingInfo = 0x6'u32 # Dynamic linking information
        shNote = 0x7'u32 # Notes
        shProgramSpaceNoData = 0x8'u32 # Program space with no data (bss)
        shRelocationNoAddends = 0x9'u32 # Relocation entries, no addends
        shShlib = 0x0A'u32 # Reserved
        shDynamicSymbolLinkerTable = 0x0B'u32 # Dynamic linker symbol table
        shArrayOfConstructors = 0x0E'u32 # Array of constructors
        shArrayOfDesctructors = 0x0F'u32 # Array of destructors
        shArrayOfPreconstructors = 0x10'u32 # Array of pre-constructors
        shSectionGroup = 0x11'u32 # Section group
        shExtendedSectionIndices = 0x12'u32 # Extended section indices
        shNumberOfDefinedTypes = 0x13'u32 # Number of defined types.
        shOsLowerBound = 0x60000000'u32 # Start OS-specific.

    SectionHeader32* = object
        name* : uint32
        kind* : SectionHeaderKind
        flags* : uint32
        virtualAddress* : uint32
        fileImageOffset* : uint32
        sizeInFileImage* : uint32
        associatedSectionIndex* : uint32
        sectionInfo* : uint32
        alignment* : uint32
        sizeOfEntries* : uint32

    SectionHeader64* = object
        name* : uint32
        kind* : SectionHeaderKind
        flags* : uint64
        virtualAddress* : uint64
        fileImageOffset* : uint64
        sizeInFileImage* : uint64
        associatedSectionIndex* : uint32
        sectionInfo* : uint32
        alignment* : uint64
        sizeOfEntries* : uint64

proc `%`*( sectionHeader32 : SectionHeader32 ) : JsonNode = 
    result = %{
        "name" : %("0x"&sectionHeader32.name.toHex()),
        "kind" : %("0x"&(uint32 sectionHeader32.kind).toHex()),
        "flags" : %("0x"&sectionHeader32.flags.toHex()),
        "virtualAddress" : %("0x"&sectionHeader32.virtualAddress.toHex()),
        "fileImageOffset" : %("0x"&sectionHeader32.fileImageOffset.toHex()),
        "sizeInFileImage" : %sectionHeader32.sizeInFileImage,
        "associatedSectionIndex" : %("0x"&sectionHeader32.associatedSectionIndex.toHex()),
        "sectionInfo" : %("0x"&sectionHeader32.sectionInfo.toHex()),
        "alignment" : %("0x"&sectionHeader32.alignment.toHex()),
        "sizeOfEntries" : %sectionHeader32.sizeOfEntries
    }

proc `%`*( sectionHeader64 : SectionHeader64 ) : JsonNode = 
    result = %{
        "name" : %("0x"&sectionHeader64.name.toHex()),
        "kind" : %("0x"&(uint32 sectionHeader64.kind).toHex()),
        "flags" : %("0x"&sectionHeader64.flags.toHex()),
        "virtualAddress" : %("0x"&sectionHeader64.virtualAddress.toHex()),
        "fileImageOffset" : %("0x"&sectionHeader64.fileImageOffset.toHex()),
        "sizeInFileImage" : %sectionHeader64.sizeInFileImage,
        "associatedSectionIndex" : %("0x"&sectionHeader64.associatedSectionIndex.toHex()),
        "sectionInfo" : %("0x"&sectionHeader64.sectionInfo.toHex()),
        "alignment" : %("0x"&sectionHeader64.alignment.toHex()),
        "sizeOfEntries" : %sectionHeader64.sizeOfEntries
    }