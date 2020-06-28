#!/bin/sh
#Compiling the appropriate program for the proper level
ghc -dynamic decoder$1.hs > /dev/null

# Removing all new lines from the file, then removing <~ and ~>, and finally decoding through our compiled haskell program
tr -d '\n' < $2 | grep -o "<~.*~>" | sed 's/<~//; s/~>//' | ./decoder$1

