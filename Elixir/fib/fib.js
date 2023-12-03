function fib(n) {
    if (n == 1 || n == 0) {
        return n
    }
    return fib(n - 1) + fib(n - 2)
}

if (process.argv && process.argv.length >= 3 && process.argv[2]) {
    // console.log(process.argv[2])
    console.log(fib(process.argv[2]))
} else {
    console.log('fib(n) | no input n')
}