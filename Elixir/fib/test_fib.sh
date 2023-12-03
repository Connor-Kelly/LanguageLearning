
runs=45

#!/bin/bash
echo C
time echo $(gcc fib.c -o fib.exe && ./fib.exe $runs)

echo Elixir
time Elixir fib.ex $runs

echo Javascript
time node fib.js $runs

echo Python
time python fib.py $runs