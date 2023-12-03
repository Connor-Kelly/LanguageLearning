# @echo off
name:= d8
src := $(name).cpp
# o := hello.o
exe := $(name).exe

build:
	g++ $(src) -o $(exe)

run: build
	@echo ------------
	@./$(exe)

clean:
	rm $(exe)