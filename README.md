sucks
=====
Sucks is a macroinstruction set for flatassembler G [fasmg](https://flatassembler.net/download.php) with the main-purpose of creating executables from a high-level language.
As such you can call this a extension for the compiler fasmg.
There is actually not the purpose but many purposes and ways you can use this repository and I try to show a lot of aspects.

usage and key files
-------------------
You need [flatassembler g](http://flatassembler.net/download.php "click here to download flatassembler G") for building this project and
also the text editor of your choice to view and edit the files locally.

| file name           | description                                                                                     |
| ---                 | ---                                                                                             |
| *README.md*         | this file.                                                                                      |
| *LICENCE.md*        | this is the licence that applies to this repository.                                            |
| *make.sh*           | bash script to build the examples.                                                              |
| *examples/*         | examples that use this macroinstructions.                                                       |
| *build/*            | working directory of the compilers (logs, etc.).                                                |
| *final/*            | final output of the compilers (bin, deasm, etc.).                                               |
| *include/*          | the macroinstructions. actually the core of this repository.                                    |
| *include/assembly/* | [assembly-like instructions](#assembly), for example the x86-instructionset.                    |
| *include/format/*   | different [output-formats](#formats).                                                           |
| *include/yasic/*    | [yasic](#yet-another-symbolic-instruction-code), a high-level programming language.             |

Do not include the sub-directories of *include/* directly!
Include *include/assembly.flib*,  *include/format.flib* and *include/yasic.flib* instead.
Other directories and files are a product of carelessness and may be moved, deleted or included in this list in the future.
Do not rely on them yet!

coding and language conventions
-------------------------------
I tried and try to follow the following conventions:
* I indented the code with two spaces, tabs (ascii 0x09) are forbidden!
* The following criteria must apply on names:
    * Internal variables and macros of modules, which are not present in the actual source, starts with the name of the file or module,
      then »@@«, and then the actual name of the symbol: *format@@addFormat*.
      * An exception are local variables and macros inside such macros, which cannot be accessed from the outside.
    * Names do not contain abbreviation, except common and unambiguous ones like
      *ctr* (a counter), *num* (number of), *ptr* (pointer), *len* (length), *args* (arguments), *lst* (list), *func* (function), *dns* (domain name system), etc.
    * Lower case camel casing of variables (*numOfPointers*)
    * Names are descriptive, however *i*/*j*/*k* for iteratives in loops are allowed, but I prefer not to use them.
    * I utilized the British English spelling: *colour*, *organisation*, *centre*, *licence*, etc.; this will probably confuse a lot of people, but it is intended.
* the code should have a tabular shape. E.g. »=« in `a = b ;comment` should have an offset of 41, the »b« an offset of 81, »;the comment« an offset of 121, etc.;
  Sometimes multiple of 10 plus 1 (11, 21, 31, ..., 10·n+1) are more rational.
* Something about remarks, comments and notes:
  * Also use the British English spelling.
    * Never use short forms like »can't«, »it's«, etc.; always use the long form i.e. »cannot«, »it is«, but 
    * Qutation marks are Guillemets: »›‹«.
    * I probably use ugly punctuation, because I am used to German punctuation.
    * If you know British English better than me, do not hesitate to correct me.
  * Comments should not descripe what code does, but why code is written the way it is.
  * Comments can be added for code-structure:
```  
    ;( description )
    ;{
      ...code...
    ;}
```

assembly
--------
This macroinstruction subset provides some macros for assembly languages of different processor architectures and byte code binaries:

* Intel x86
  * 16 bit
    - [x] 8086 and 8086
    - [x] 80186 and 80188
    - [x] 80286/i286
  * 32 bit
    - [x] 80386/i386
    - [x] 80486/i486
    - [x] Pentium
    - [x] Pentium MMX
  * 64 bit
  * x87 (floating point co-processor)
    - [ ] 8087
    - [ ] 80187
    - [ ] 80287
    - [ ] 80387
* PIC – peripheral interface controller
  * comming soon
* Atmel AVR
  * comming soon
* Zilog Z80
  * comming soon
* byte code
    - [x] [fbc0 – fruitbot byte code version 0](#fruitbot-byte-code)
    - [ ] jvm – java virtual machine
    - [ ] web assembly
    - [ ] CIL – common intermediate language
    - [ ] EBC – EFI byte code
* suggest more, but as you can see, I already have a bunch of work to do.

formats
-------
This macroinstruction subset provides some macros to define the structure of the output.
Some formats may allow other formats inside, e.g. a container-format, that contains multiple files of different formats.
I already implemented or planned to implement the following formats:
-[x] elf – executable and linking file format
-[x] [uf4 – universal fancy and fluffy file format](#universal fancy and fluffy file format)
-[ ] pe – portable executable

fruitbot byte code
------------------
Fruitbot was an IRC-bot I wrote in python about 5-8 years ago.
I am not really sure when I wrote the bot.
I rewrote it multiple times in purebasic and I created an bytecode, so the bot could remotly execute scripts.
The bot only had a small instruction-set and I do not had to worry much about malicious scripts.

Today *fruitbot-code* is the name of various bytecodes by me, so fruitbot code version 0 is actually version over 9000, but fbc0 shall be the first documented version.

fbc0 was designed as an intermediate language between the front end (depending on the progamming language) and the back end (depending on the processor architecture) of an compiler,
but you can also write fruitbot byte code by hand and perhaps there will be a just-in-time compiler in the future.
This instructionset is based on a stack-machine, there are only a few instructions with arguments, that stores values on top of the stack.
Other instruction are just one-byte-opcodes operating on values on the stack.
I chose this design to compile expressions in a fast and simple way.
The expression `f((a+b)*(c-d))` can easily compiled with the shunting-yard algorithm to
```
  pushQWord a
  pushQWord b
  add
  pushQWord c
  pushQWord d
  sub
  mul
  pushQWord f
  call
```
These instructions can the easily transformed to an abstract syntax tree by just pushing all instruction onto the stack and then poping to a binary tree, when an action (e.g. `call`) is taken.
A high-level language only have to provide its macroinstructions (e.g. for an `if`), that produces fbc0 byte code.

yet another symbolic instruction set
------------------------------------
Yasic is a high-level programming language, that is implemented as a set of fasmg-macroinstruction and its syntax is very depentent on that of fasmg.
Most of its instructions interfere with fasmgs symbols, e.g. `if` of yasic is a redefined `if` of fasmg and macroinstructions must use `If` instead.
The macroinstructions of yasic generate fbc0.
Do not get confused with the repository *yasic*, it is another language.
I am looking forward to solve this contradiction soon.


universal fancy and fluffy file format
--------------------------------------
uf4 (spelled: »ufo«) is designed as a multi-purpose file format with a very simple structure:

| meaning       | description                                                             |
| ---           | ---                                                                     |
| Magic String  | ascii[32]:  »#!~/sba/bin/suckmore'«, \n                                 |
|               |             »#«, 0x19, 0x96, 0x10, 0x03, 0x23, 0x42, 0x13, 0x37, \n, \0 |
| yapters[]     | yapter-table:                                                           |
|               |   word  type    defines how this entry is processed.                    |
|               |   word  dataW   depending on type.                                      |
|               |   dword dataD   depending on type.                                      |
|               |   qword dataQ0  depending on type.                                      |
|               |   qword dataQ1  depending on type, usually the size in file.            |
|               |   qword dataQ2  depending on type, usually the offset from content.     |
| ycontent      | ycontent:                                                               |
|               |   bytes[]                                                               |

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

The following pseudo-code describes how to parse a uf4 file:
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
