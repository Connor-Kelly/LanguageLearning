# Learning Zig

## install (on Windows)
you can either download direct from source, and add it to your path, or you can 
download with `winget install -e --id zig.zig`

# Zig -> C libraries
I tested this out, and it doesn't seem to work, after pasting in code directly 
from the ziglang.org docs. I messed with it a little, but can't get it to run.\
The furthest I could get it to run was to emit the .h files:
`zig build-lib mathtest.zig -femit-h`
which look a little like:
```h
#include "zig.h"
zig_extern int32_t add(int32_t const a0, int32_t const a1);
zig_extern unsigned long RemoveVectoredExceptionHandler(void *const a0);
zig_extern zig_noreturn void ExitProcess(unsigned int const a0);
...
```
The only function in mathtest.zig is the add function. So I assume that the rest
are build in to the -h output to link in, but I don't know for sure.\
What I do know is that the `zig build` does seem to build the zig files, but seems
to fail when it comes to linking the C file in. \
It gives me an error concerning the `"#include zig.h"`, which I'm a little unsure about.
Maybe the build is supposed to emit a `zig.h` file or something.

*However*, I'm calling it on this one, it seems to buggy and poorly documented.

# Speaking of docs
Speaking of the docs, zig could really use an overhaul. The zig docs is served 
all in a single html document, with some templating language I'm not familiar with.\
Seriously, these docs could use some help, and I think I could write a script to make it a little more
simple to navigate, so that could be a *prospective project*




