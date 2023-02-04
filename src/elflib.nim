import elflib/[file, program, section]

type
    ElfFile32* = object
        fileHeaderStart : FileHeaderStart
        fileHeaderRest : FileHeaderRest32
        programHeaders : seq[ProgramHeader32]
        sectionHeaders : seq[SectionHeader32]
    ElfFile64* = object
        fileHeaderStart : FileHeaderStart
        fileHeaderRest : FileHeaderRest64
        programHeaders : seq[ProgramHeader64]
        sectionHeaders : seq[SectionHeader64]