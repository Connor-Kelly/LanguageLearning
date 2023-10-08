# What I've learned so far
Ocaml is very different. And from what I've seen so far, not in the best way.\
I really like the idea of functional programming, but so far the tooling really 
sucks. As in, from copying and pasting in examples directly from the documentation,
I can't get it to run reliably. 
For one, it appears that the lsp for VS code just isn't great, or I need to work 
more on setting it up, because I'm getting random syntax errors from what could 
not possibly be an error. Ex:
```ocaml
let () = print_endline "Hello, World!" (*LSP_Error: Illegal character (\r)ocamllsp*)
```
From what I understand, this is the result of the LSP not knowing how to parse 
files, probably somewhere in the file, a `\r\n` gets put in the file, instead of
a `\n`, but come on man... why is a `\r` an illegal character? \
On another note, doing a little `ctrl-a -> ctrl-x -> ctrl-v`, fixes the issue.
Which is pretty dumb.

This issue with the tooling is pretty difficult to deal with, because I've never
written in an ml based language, so I don't quite understand the syntax, and thus
cannot intuit where is a lsp fuckup vs me not knowing the language. \
This really makes me want to try out learning different ml like elixir.

