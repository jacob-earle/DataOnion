# DataOnion

## Introduction
A repo to contain my progress on solving Tom's Data Onion, a textfile-based cryptographic puzzle. 
The original puzzle can be found by following [this link](https://www.tomdalling.com/toms-data-onion/).

## Following Along
In order to simplify using my code to decode the various layers of the onion, I have provided the simple script peel.sh:
---
./peel.sh LEVEL FILE
---
This script will attempt to compile the haskell program necessary for completing the level LEVEL and will then isolate the
encoded region of FILE for easy decoding. Then, the compiled haskell program will print the decoded output to standard output.

For example, to _unpeel_ the code from level 0 located in level0.txt into level1.txt, use
---
chmod +x peel.sh
./peel.sh 0 level0.txt > level1.txt
---

## Dependencies
It is assumed that you are running on a Unix-based operating system, as peel.sh is a bash script and line endings in Windows
could affect the decoding of data.
Aside from the common Unix utilities tr, sed, and grep, which should already be installed on your system, you will also need to
have a working installation of Haskell and its compiler ghc.
For more information on installing Haskell, visit [the official Haskell installation guide](https://www.haskell.org/downloads/).
