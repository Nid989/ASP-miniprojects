% define the size of subgrids
subgrid_size(3).

% create the possible numbers
number(1..9).

% assign the cells to subgrids
subgrid(((R-1)/S*S + (C-1)/S),R,C) :- subgrid_size(S), number(R), number(C).

% only one integer allowed per cell, integer allowed only once per row and column
{ sudoku(R,C,I) : number(I) } = 1 :- number(R), number(C).
{ sudoku(R,C,I) : number(R) } = 1 :- number(I), number(C).
{ sudoku(R,C,I) : number(C) } = 1 :- number(R), number(I).

% integer allowed only once per subgrid 
:- sudoku(R,C,I), sudoku(R2,C2,I), subgrid(S,R,C), subgrid(S,R2,C2), R != R2, C != C2.

% initial cell values have to be in answer set
:- initial(R,C,I), not sudoku(R,C,I).

#show sudoku/3.
