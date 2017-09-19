formats
=======
This macroinstruction subset provides some macros to define the structure of the output.
Some formats may allow other formats inside, e.g. a container-format, that contains multiple files of different formats.
I already implemented or planned to implement the following formats:
- [x] elf – executable and linking file format
- [x] [uf4 – universal fancy and fluffy file format](#universal-fancy-and-fluffy-file-format)
- [ ] pe – portable executable

universal fancy and fluffy file format
--------------------------------------
uf4 (spelled: »ufo«) is designed as a multi-purpose file format with a very simple structure:

| meaning       | description                                                             |
| ---           | ---                                                                     |
| Magic String  | ascii[32]:                                                              |
|               | → »#!~/sba/bin/suckmore'«, \n                                           |
|               | → »#«, 0x19, 0x96, 0x10, 0x03, 0x23, 0x42, 0x13, 0x37, \n, \0           |
| yapters[]     | yapter-table:                                                           |
|               | → word  type    defines how this entry is processed.                    |
|               | → word  dataW   depending on type.                                      |
|               | → dword dataD   depending on type.                                      |
|               | → qword dataQ0  depending on type.                                      |
|               | → qword dataQ1  depending on type, usually the size in file.            |
|               | → qword dataQ2  depending on type, usually the offset from content.     |
| ycontent      | ycontent:                                                               |
|               | → bytes[]                                                               |

The file format is actually a container format for so-called yapters, named after chapters of a book.
Every of these yapters has an 32-byte-entry in the yapter-table.
All bytes, except the first two, can be used freely, but i recomment to use the qword at offset 24 as offset and qword 16 as size of data.
The first word defines the type of the entry and the yapter-table always has a final yapter.
I recomment the value `null` as the `type` of the final yapter.
After this final yapter could be some bytes (called »content«), that could be used and refered freely by the yapters.
I recomment to refer relatively to the label `ycontent`, so new yapters can be added to the yapter-table without changing the offsets in the other yapters.
There is no list of types yet, so except for type null every other value between 0 and 2^16 could be used.
The Magic String can differ, but it must be exactly 32 bytes long, it must begin with »#!« and it must end with a linefeed (\n=10) and null (\0=0).

I hope, I will provide a list soon.

The following pseudo-code describes how to parse an uf4 file:
```
function parseFile( fileName )
  file theFile = openFile( fileName )
  int  size    = sizeOfFile( theFile )
  int  pointer, entry
  word type
  if ( size < 32 )
    fail( »file too small!« )
  end if
  if ( readStringFromFile( theFile, offset = 0, lenght = 32) != MAGIC_STRING )
    fail( »invalid magic number!« )
  end if
  pointer = 0
  while ( true )
    if (( size - pointer ) < 32 )
      fail( »reached end of file before end of yapter-table!« )
    end if
    pointer = pointer + 32
    type = theFile.readWord( offset = pointer )
    if ( buildYapter( ytable, type, pointer ) == null )
      break
    end if
  end while
  entry = 0
  while ( true )
    type = yTable[entry].type
    if ( loadYapter( ytable, type, entry ) == null )
      break
    end if
    entry = entry + 1
  end while
end function
```
