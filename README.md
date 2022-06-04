# ASP-miniprojects
This repository contains example encodings for solving Sudoku, Seek Numbers, and Minotaur games with [clingo](https://github.com/potassco/clingo). The encodings were created in a joint effort with [Antonia Schmidt](https://github.com/Antonia-Schmidt) as part of the course "Advanced Problem Solving Techniques" at the University of Potsdam.

# Repository Structure
## instances
Contains sample test instances for all three problem encodings (these and more instances were provided during the course).

## src
Contains the source code for all three problem encodings.

`minotaur.lp`: problem encoding for various-size Theseus and the Minotaur riddles.

`seeknumbers.lp`: problem encoding for various-size Seek Numbers riddles.

`sudoku.lp`: problem encoding for 9x9 Sudokus (can be adapted to work with other parameters).

# Requirements
In order to run this code you need to have clingo installed on your system. Installation is possible via [package managers](https://potassco.org/clingo/#packages) or [from source](https://github.com/potassco/clingo/blob/master/INSTALL.md).

The encodings in this repository were tested against clingo version 5.5.0.

# Usage
You can run the problem encodings, i.e. get solutions to the sample problem instances of the respective games, for example by running the following command in the terminal:

``$ clingo ./instances/xxx.lp ./src/yyy.lp 0``

where `xxx` is the name of a test instance (e.g. `sudoku1.lp`) and `yyy` is the name of the corresponding problem encoding (e.g. `sucoku.lp`).