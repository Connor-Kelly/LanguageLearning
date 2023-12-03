#include <stdio.h>
#include <stdlib.h> 
int fib(int n) {
    if (n == 1 || n == 0) {
        return n;
    }
    return fib(n-1) + fib(n-2);
}

int main(int argc, char **argv) {
    // printf("%d\n", argc);
    if (argc >= 2) {
        char* buf = argv[1];
        int val = atoi(buf);
        // printf("%d\n", val);
        int ans = fib(val);
        printf("%d\n", ans);
    } else {
        printf("could not read command line arguments");
    }
}