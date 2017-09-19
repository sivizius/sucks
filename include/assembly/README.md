include/assembly
================
This macrosubset provides macroinstructions to generate binary code for several processors as well as virtual machines and interpreters, e.g. various x86-processors and fruitbot bytecode.
There are also macroinstructions to provide some nice instruction listing in *lister.flib* as well.

usage
-----
You shall not include theses files directly, but *../assembly.flib*, this file makes this instruction sets available as `code`-blocks like this i386-assembly:
```
    code 80386
      xor eax, eax
      ret
    end code
```

You cannot use this unless you use this in a format, that provides such `code`-blocks, e.g. *uf4* and *elf*,
  but you can use this even if the format is not designed to contain a certain machine code, e.g. java byte code in an elf-file, as long as the format does not explicitly prevent it.

adding instructionsets
----------------------
To add your own instructionset you have to add at least two files:
  The first file
    contains some internal macros for your instructionset, e.g. operand parser and encoder,
    adds your instructionset to the list of availabe instructionsets used by theses `code`-blocks and
    will be included by *../assembly.flib*, so you have to add this file there.
  The second file contains the actual macros of the instruction set and should contain a destructor, so the macroinstructions of your instructionset is only available inside a `code`-block.
If there are different versions of your instructionset you can add more files, that are similar to the second file.
Consider to put all the different versions of the instructionset in a seperate directory,
  e.g. if your instructionset is *yourInstructionSet*, you create the file *yourInstructionSet.flib* and the directory *yourInstructionSet*.

To add your instructionset to the list of availabe instructionsets you have to provide a macro like this:
```
    Struc assembly@@yourInstructionSet  optionalArguments&                                          ;You can have more than one argument, but the last argument should be a list, e.g. ignoredArguments&.
      Macro assembly@@finaliser                                                                     ;assembly@@yourInstructionSet will be called with `code`, assembly@@finaliser with `end code`.
        yourInstructionSet@@killMySelf                                                              ;Purges all your macros, except internal ones.
      End Macro                                                                                     ;Make sure, that all the instructions are not available anymore.
      Include 'include/assembly/yourInstructionSet/version0.flib'                                   ;Load the instructionset version 0. E.g. 80386.flib for i386-assembly. (second file)
      .machine = yourInstructionSet@@version0                                                       ;Used e.g. by uf4 to specify the ISA of a code-yapter.
                                                                                                    ;Make sure, that this magic value does not interfere with other instructionsets.
    End Struc                                                                                       ;Please use upper-case, otherwise it could cause hardly debuggable errors.
    assembly@@addInstructionSet         yourInstructionSet, assembly@@yourInstructionSet            ;This actually adds the yourInstructionSet to the list of instructionsets.
```

Finally you have to add `Include 'include/assembly/yourInstructionSet.flib'` (first file) below `add your instructionsets here` in *../assembly.flib*.
Internal macros, structures, variables, constants, etc. should start with `yourInstructionSet@@`, so they do not interfere with other modules.
Local symbols, that are not accessable outside an macro, i.e. `temp`, can be named as you want. Nobody cares about your local shit.
All you files should use *flib* as file-extension.
Have a look at the other.

include/assembly/lister.flib
----------------------------
This module is loaded by *../assembly.flib* and all its macros should be available and ready to use.
Consider to add theses macroinstructions to you instructionset:
* `lister@@putPrefix thePrefix&` – if the instruction has any prefixes (optional).
* `lister@@putInstruction theInstruction&` – the instruction itself.
* `lister@@putOperand theOperand&` – for each operand the instruction has, if there any.
* `lister@@putComment theComment&` – add a comment (optional).
* `lister@@putLabel theLabel&` – add a label (optional). This will increase indentation.
* `lister@@indentMore` – increase indentation.
* `lister@@indentLess` – decrease indentation.

currently available instructionsets
-----------------------------------
* x86
  * 8086
  * 80186
  * 80286
  * 80386
  * 80486
  * Pentium
  * subsets
    * MMX
* fruitbot byte code
  * version 0
* yet another symbolic instruction code