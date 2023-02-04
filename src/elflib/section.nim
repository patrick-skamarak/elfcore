import json, strutils

type
    SectionHeaderFlag* = enum
        SHF_WRITE = 0x1 # Writable
        SHF_ALLOC = 0x2 # Occupies memory during execution
        SHF_EXECINSTR = 0x4 # Executable
        SHF_MERGE = 0x10 # Might be merged
        SHF_STRINGS = 0x20 # Contains null-terminated strings
        SHF_INFO_LINK = 0x40 # 'sh_info' contains SHT index
        SHF_LINK_ORDER = 0x80 # Preserve order after combining
        SHF_OS_NONCONFORMING = 0x100 # Non-standard OS specific handling required
        SHF_GROUP = 0x200 # Section is member of a group
        SHF_TLS = 0x400 # Section hold thread-local data
        SHF_ORDERED = 0x4000000 # Special ordering requirement (Solaris)
        SHF_EXCLUDE = 0x8000000 # Section is excluded unless referenced or allocated (Solaris)
        SHF_MASKOS = 0x0FF00000 # OS-specific
        SHF_MASKPROC = 0xF0000000 # Processor-specific

    SectionHeaderKind* = enum
        SHK_NULL = 0x0'u32 # Section header table entry unused
        SHK_PROGBITS = 0x1'u32 # Program data
        SHK_SYMTAB = 0x2'u32 # Symbol table
        SHK_STRTAB = 0x3'u32 # String table
        SHK_RELA = 0x4'u32 # Relocation entries with addends
        SHK_HASH = 0x5'u32 # Symbol hash table
        SHK_DYNAMIC = 0x6'u32 # Dynamic linking information
        SHK_NOTE = 0x7'u32 # Notes
        SHK_NOBITS = 0x8'u32 # Program space with no data (bss)
        SHK_REL = 0x9'u32 # Relocation entries, no addends
        SHK_SHLIB = 0x0A'u32 # Reserved
        SHK_DYNSYM = 0x0B'u32 # Dynamic linker symbol table
        SHK_INIT_ARRAY = 0x0E'u32 # Array of constructors
        SHK_FINI_ARRAY = 0x0F'u32 # Array of destructors
        SHK_PREINIT_ARRAY = 0x10'u32 # Array of pre-constructors
        SHK_GROUP = 0x11'u32 # Section group
        SHK_SYMTAB_SHNDX = 0x12'u32 # Extended section indices
        SHK_NUM = 0x13'u32 # Number of defined types.
        SHK_LOOS = 0x60000000'u32 # Start OS-specific.

    SectionHeader32* = object
        name* : uint32
        kind* : uint32
        flags* : uint32
        virtualAddress* : uint32
        offset* : uint32
        sizeInFile* : uint32
        link* : uint32
        info* : uint32
        alignment* : uint32
        sizeOfEntries* : uint32

    SectionHeader64* = object
        name* : uint32
        kind* : uint32
        flags* : uint64
        virtualAddress* : uint64
        offset* : uint64
        sizeInFile* : uint64
        link* : uint32
        info* : uint32
        alignment* : uint64
        sizeOfEntries* : uint64

proc `%`*( sectionHeader32 : SectionHeader32 ) : JsonNode = 
    result = %{
        "name" : %("0x"&sectionHeader32.name.toHex()),
        "kind" : %("0x"&sectionHeader32.kind.toHex()),
        "flags" : %("0x"&sectionHeader32.flags.toHex()),
        "virtualAddress" : %("0x"&sectionHeader32.virtualAddress.toHex()),
        "offset" : %("0x"&sectionHeader32.offset.toHex()),
        "sizeInFile" : %("0x"&sectionHeader32.sizeInFile.toHex()),
        "link" : %("0x"&sectionHeader32.link.toHex()),
        "info" : %("0x"&sectionHeader32.info.toHex()),
        "alignment" : %("0x"&sectionHeader32.alignment.toHex()),
        "sizeOfEntries" : %("0x"&sectionHeader32.sizeOfEntries.toHex())
    }

proc `%`*( sectionHeader64 : SectionHeader64 ) : JsonNode = 
    result = %{
        "name" : %("0x"&sectionHeader64.name.toHex()),
        "kind" : %("0x"&sectionHeader64.kind.toHex()),
        "flags" : %("0x"&sectionHeader64.flags.toHex()),
        "virtualAddress" : %("0x"&sectionHeader64.virtualAddress.toHex()),
        "offset" : %("0x"&sectionHeader64.offset.toHex()),
        "sizeInFile" : %("0x"&sectionHeader64.sizeInFile.toHex()),
        "link" : %("0x"&sectionHeader64.link.toHex()),
        "info" : %("0x"&sectionHeader64.info.toHex()),
        "alignment" : %("0x"&sectionHeader64.alignment.toHex()),
        "sizeOfEntries" : %("0x"&sectionHeader64.sizeOfEntries.toHex())
    }