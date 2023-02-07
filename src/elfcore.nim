import elfcore/[fileHeader, programHeader, sectionHeader], streams, json

type
    Elf32Headers* = object
        fileHeaderCommon : FileHeaderCommon
        fileHeader32 : FileHeader32
        programHeaders : seq[ProgramHeader32]
        sectionHeaders : seq[SectionHeader32]
    Elf64Headers* = object
        fileHeaderCommon : FileHeaderCommon
        fileHeader64 : FileHeader64
        programHeaders : seq[ProgramHeader64]
        sectionHeaders : seq[SectionHeader64]

proc getFileHeaderCommon*( fileName : string ) : FileHeaderCommon =
    var fileStream = newFileStream(fileName, fmRead)
    if not isNil fileStream:
        discard fileStream.readData(addr result, sizeof FileHeaderCommon)
        if not isValidHeader result:
            raiseAssert("Invalid header.")

proc getElf32Headers*( fileName : string ) : Elf32Headers =
    # file header commmon
    var fileHeaderCommon = getFileHeaderCommon(fileName)
    if (uint8 fileHeaderCommon.format) != (uint8 fhThirtyTwo) :
        raiseAssert("32 bit header requested but found other.")
    result.fileHeaderCommon = fileHeaderCommon
    var fileStream = openFileStream(fileName, fmRead)

    # file header
    fileStream.setPosition(sizeof FileHeaderCommon)
    discard fileStream.readData(addr result.fileHeader32, sizeof FileHeader32)
    if (result.fileHeader32.programHeaderEntrySize != (uint16 sizeof ProgramHeader32)):
            raiseAssert("Program header size mismatch.")
    if (result.fileHeader32.sectionHeaderEntrySize != (uint16 sizeof SectionHeader32)):
            raiseAssert("Section header size mismatch.")

    # program headers
    fileStream.setPosition(int result.fileHeader32.programHeaderOffset)

    for i in 0..<(int result.fileHeader32.numProgramHeaderEntries):
        var programHeader : ProgramHeader32
        discard fileStream.readData(addr programHeader, sizeof ProgramHeader32)
        result.programHeaders.add(programHeader)

    # section headers
    fileStream.setPosition(int result.fileHeader32.sectionHeaderOffset)

    for i in 0..<(int result.fileHeader32.numSectionHeaderEntries):
        var sectionHeader : SectionHeader32
        discard fileStream.readData(addr sectionHeader, sizeof SectionHeader32)
        result.sectionHeaders.add(sectionHeader)

proc getElf64Headers*( fileName : string ) : Elf64Headers =
    # file header commmon
    var fileHeaderCommon = getFileHeaderCommon(fileName)
    if (uint8 fileHeaderCommon.format) != (uint8 fhThirtyTwo) :
        raiseAssert("64 bit header requested but found other.")
    result.fileHeaderCommon = fileHeaderCommon
    var fileStream = openFileStream(fileName, fmRead)

    # file header
    fileStream.setPosition(sizeof FileHeaderCommon)
    discard fileStream.readData(addr result.fileHeader64, sizeof FileHeader64)
    if (result.fileHeader64.programHeaderEntrySize != (uint16 sizeof ProgramHeader64)):
            raiseAssert("Program header size mismatch.")
    if (result.fileHeader64.sectionHeaderEntrySize != (uint16 sizeof SectionHeader64)):
            raiseAssert("Section header size mismatch.")

    # program headers
    fileStream.setPosition(int result.fileHeader64.programHeaderOffset)

    for i in 0..<(int result.fileHeader64.numProgramHeaderEntries):
        var programHeader : ProgramHeader64
        discard fileStream.readData(addr programHeader, sizeof ProgramHeader64)
        result.programHeaders.add(programHeader)

    # section headers
    fileStream.setPosition(int result.fileHeader64.sectionHeaderOffset)

    for i in 0..<(int result.fileHeader64.numSectionHeaderEntries):
        var sectionHeader : SectionHeader64
        discard fileStream.readData(addr sectionHeader, sizeof SectionHeader64)
        result.sectionHeaders.add(sectionHeader)

proc `%`*( elf32Headers : Elf32Headers ) : JsonNode =
    result = %{
        "fileHeaderCommon" : %elf32Headers.fileHeaderCommon,
        "fileHeader32" : %elf32Headers.fileHeader32,
        "programHeaders" : %elf32Headers.programHeaders,
        "sectionHeaders" : %elf32Headers.sectionHeaders
    }

proc `%`*( elf64Headers : Elf64Headers ) : JsonNode =
    result = %{
        "fileHeaderCommon" : %elf64Headers.fileHeaderCommon,
        "fileHeader64" : %elf64Headers.fileHeader64,
        "programHeaders" : %elf64Headers.programHeaders,
        "sectionHeaders" : %elf64Headers.sectionHeaders
    }

export
    fileHeader.FileHeaderCommon,
    fileHeader.isValidHeader,
    fileHeader.FileHeader64,
    fileHeader.FileHeader32,
    fileHeader.FileHeaderKind,
    fileHeader.FileHeaderFormat,
    fileHeader.FileHeaderEndianness,
    fileHeader.ELF_MAGIC,
    fileHeader.`%`,

    sectionHeader.SectionHeaderFlag,
    sectionHeader.SectionHeaderKind,
    sectionHeader.SectionHeader32,
    sectionHeader.SectionHeader64,
    sectionHeader.`%`,

    programHeader.ProgramHeader32,
    programHeader.ProgramHeader64,
    programHeader.ProgramHeaderKind,
    programHeader.`%`
