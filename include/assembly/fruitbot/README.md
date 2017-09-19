fruitbot byte code
==================
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
