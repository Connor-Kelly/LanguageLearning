
I've been learning about different languages, and I'm thinking about building one 
of my own. I like parts of many langs, but have yet to find one I really love. 
So far, I like the name Rho currently

In learning these different languages, I've learned that I have a few things i like:

## Compiler
A compiler should just work. It should give effective errors, but be willing to let you fuck it all up. It should warn you as much as it can, but in the end, let you tell it to fuck off and and run it till something breaks. The rust compiler is a pretty good example here, it usually give you an idea of proper errors and warns you about the rest. This is required, because Rust seems to be a memory minefield, coming from someone whose literally had to manually manage memory for a project, writing relatively memory safe code shouldn't be that hard.
Where rust is rough is the amount of time it takes to iterate code. I've only used toy programs, and the compile times are already feeling burdensome. I'd rather have a simpler language that doesn't have so many idiosyncicies.

Running the compiler should be as simple as 
```sh
$compiler {--build_options} {build | b} {-o $outputBinary} {$files}
    && ./$outputBinary

# or 
$compiler ?{watch} {run | r} {$files}
```

## Style and Syntax
Syntax should follow standard C like languages.
Code blocks should be enclosed with braces {}
Semicolons should be optional, but recommended. The lsp should by default format terminated lines to end with a semicolon. Line nontermination should be allowed by separator disconnect, ie if `... var \n something else => .. var;\n something else` but `.. var,\n something else` requires no change.

### Variables
variables exist in 3 states: const, mut, and ref.
const variables are immutable literals of simple types, like str, int, :atom
mut varaibles are mutable literals of simple types
ref variables are pointers to structs in memory, the simplest version of this is a basic array.

Pointers are scary, so one should never trust a pointer. Because programmers are bad at memory, we should always assume that the underlying memory can and will change without our approval. Pointers are nullable, but easy to check with a validate/! essentially, when a boolean statement takes in a struct, it may call struct.valid() to cast implicitly cast the struct to a bool. For example:
```ts
struct Array<Type> {
    addr int,
    len int,
    items []<Type>
}

fn main() {
    ref my_arr = [1, 2, 3]

    try foo(my_arr) (e error) => { // a try call short circuts on any call in the which returns a banger. thus if foo(foo(arr)) returns an error for the first foo(arr), the outer foo will not run, and the passed function (e error) => {} will be executed.
        print(error)
    }

    // try can take in code blocks:
    try {
        t = time(foo(arr)) // if foo(arr) fails, it will short circuit to the (e) => {}
        print(t)
    } (e) => {
        print(e)
    }
}
fn foo(arr Array) ! { // foo operates on an array, and returns an error on failure, void otherwise 
                      // the lone ! mark is refered to as a banger. 
    if (!arr) { // !arr returns !arr.valid() call, which determines if a struct is valid. the default behavior of this arr.valid is (arr) => (arr.addr != 0)
        return error('you gave me a non-existent array you absolute twat.')
    }

    arr.foreach((a) => {
        print(a, '\n')
    })
}
```

### functions
- functions should be defined in something similar to this:
```js
<? (pub | priv) &| static> fn <? $attachedStruct> $functionName(<$inputName ?$inputType>, ...) <$outputType> {
    // sample code here.
    return ...$returns;
}
```
Functions and methods are attached to a namespace anyways, the function's namespace is the scope of the current code block, while the method's namespace is that of the function to which it attaches
- functions should be able identify as pub or private, though the parameter should be optional and default to private
- static function are static...
- input declaration should include a csl of space separated pairs of inputs. 

- Anonymous functions should be simple and essentially very js like:
```js
(<$inputName ?$inputType>, ...) <$outputType> => {
    // sample code here.
    return ...$returns;
}
```

### Error handling
Errors should be handled as values. Any function that attempts to throw an error should have a banger in its output parameters like so: 
```ts
fn mayFail(inp string) ! {}
fn mayFailButAlsoReturnsIntOnSuccess(inp string) !(out int) {}
```
functions with a banger should be called with a try statement.
```ts
fn main() {
    try mayFail('anything') (e) => {
        print(e)
    }

    mut my_int = 0
    try {my_int = mayFailButAlsoReturnsIntOnSuccess('something')} (e) => {
        print(e)
        // should probably return or jump gracefully when if error code gets executed
    }
    print(my_int)

}
```


## Control Flow
The language should have all standard control flow. 
```ts
if (<bool>) {
    // inner scope
}

while (<bool>) {
    // inner scope
} ?break {
    
}

do {
    // inner scope
} (<bool>)

for (setup <void>, shouldContinue <bool>, afterEach <void>) {
    // inner scope
}
```
### Labels and Jumps
labels and gotos are generally accepted to be harmful to programmers. 
I tend to assume that most programmers aren't very intelligent, if you can't give me 
a fundamental understanding of what a stack frame is, do not use these. 
Most of you have used unlabeled jumps, aka `continue` and `break` in other langs,
the reason these have strange syntax is because they dont fit with standard control flow.
For those who enjoy casual masochism, jumps are cool. 
```ts
#label
// labeled scope

// jumps to that label can only jump to labels within its directly accessible scope
// compiler throws an error if you jump over any declarations, even if they are unused.
jump #label
```

## Memory
Memory management should be unobtrusive, and direct.
I like being able to go access everything on a byte level. A good language should 
allow any common mad man to index directly across his own memory. Pointers though should be a little simpler to handle. When passed as arguments to a function, a parameter should be introduced to determine whether the caller or callee function should handle freeing said pointer. For example: 
```ts
struct Org {}
struct Person{
    ...
}
const my_person = Person(){ ... }

fn (Org o) hirePerson(ex Person) {} 
// hirePerson uses a bare pointer reference, this gives a copy of the referenced object to the callee, and both caller and callee free their respective handled objects at their independant scope teardown.

```
```ts
fn (Org o) firePerson(>ex Person) {} 
// indicates that the firePerson function should free the person struct. 
// This means that there must be no reference in the caller to ex after firePerson(ex) has been called.
```
```ts

fn (Org o) retirePerson(<ex Person) {} // indicates that the calling function will free the person struct after the retirePerson function is called.

// The retirePerson doesn't handle freeing, so the caller must handle this.
// freeing the ex param can take 2 possible methods,
//   if the programmer is worried about efficiency and speed, they can elect to free everything manually via the call:
free(ex);
//   however, that fucking sucks, so opting for an auto-freeing method is preferable. This will be managed by the scope of the caller. When a function is handling a pointerType, the teardown of it's scope will free all of its handled pointers. 

```

## Built In Functionality
I think a good built in library handles the following operations well:
- basic math and algorithmic composition
- functional lambdas as first class citizens
- good string functions
- a robust type system including generics
- event and/or promise driven design
- ? cheap multithreading with go style green threads
- an lsp that works well


