from sys import argv
def fib(n):
    if n == 1 or n == 0:
        return n
    else:
        return fib(n-1) + fib(n-2)
    
if __name__ == "__main__":
    if len(argv) >= 2:
        print(fib(int(argv[1])))
    else:
        print('fib(n) | no input n')