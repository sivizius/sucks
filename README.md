sucks
=====
Sucks is a macroinstruction set for [flatassembler G (fasmg)](https://flatassembler.net/) with the main-purpose of creating executables from a high-level language.
As such you can call this a extension for the compiler fasmg.
There is actually not the purpose but many purposes and ways you can use this repository and I try to show a lot of aspects.

usage and key files
-------------------
You need [flatassembler g](http://flatassembler.net/download.php "click here to download flatassembler G") for building this project and
also the text editor of your choice to view and edit the files locally.

| file name                                             | description                                                             |
| ----------------------------------------------------- | ----------------------------------------------------------------------- |
| *README.md*                                           | this file.                                                              |
| *LICENCE.md*                                          | this is the licence that applies to this repository.                    |
| *make.sh*                                             | bash script to build the examples.                                      |
| *clean.sh*                                            | bash script to clean repository. (removes a lot of temporary files)     |
| *examples/*                                           | examples that use this macroinstructions.                               |
| *build/*                                              | working directory of *make.sh* and its output (bin, deasm, logs, etc.). |
| *include/*                                            | the macroinstructions. actually the core of this repository.            |
| [*include/assembly/*](include/assembly/README.md)     | assembly-like instructions, for example the x86-instructionset.         |
| *include/formats/*                                    | different [output-formats](#formats).                                   |
| *include/crypto/*                                     | macroinstructions to encrypt, decrypt and sign data.                    |
| *include/main/*                                       | some general purpose macroinstructions and constants.                   |

Do not include the sub-directories of *include/* directly!
Include *include/assembly.flib*,  *include/formats.flib*, etc. instead.
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
