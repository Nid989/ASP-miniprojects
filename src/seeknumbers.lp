% represent the differences between the coordinates of neighboring cells
diff(0,1). diff(0,-1). diff(1,0). diff(-1,0).

% start from first cell, move to one neighbouring cell -> first path; cannot move out of bounds (is part of cells)
{ path(X1,Y1,X2,Y2) : diff(A,B), X2=(X1+A), Y2=(Y1+B), cell(X2,Y2) } = 1 :- first(X1,Y1).

% from existing path, use path end cell as start cell for new path, move to one neighbouring cell; cannot move out of bounds
{ path(X1,Y1,X2,Y2) : diff(A,B), X2=(X1+A), Y2=(Y1+B), cell(X2,Y2) } 1 :- path(_,_,X1,Y1).

% except for start cell, all cells have to be reached by a path
:- cell(X,Y), not path(_,_,X,Y), not first(X,Y).

% a cell may never be reached by more than one path
:- cell(X,Y), 2{path(_,_,X,Y)}.

% paths ultimately need to end in final cell (no path leading away from designated final cell)
:- final(X1,Y1), path(X1,Y1,X2,Y2).

% in which cells do we have bends?
bend(X,Y) :- path(X0,Y0,X,Y), path(X,Y,X2,Y2), X0=X, Y=Y2.
bend(X,Y) :- path(X0,Y0,X,Y), path(X,Y,X2,Y2), Y0=Y, X=X2.


% helper predicate to count bends and such
% initiate helper cell for start cell
helper(X,Y,0) :- first(X,Y).

% update bends left (L) that need to be seen until next hint/the end
helper(X,Y,L) :- hint(X,Y,L).

% if current cell is not bending, take L count from previous cell on path
helper(X,Y,L) :- path(X0,Y0,X,Y), not bend(X,Y), helper(X0,Y0,L), not hint(X,Y,_).

% if current cell is bending, take L-1 from previous cell on path
% L>0 to avoid endless grounding (?)
helper(X,Y,L-1) :- path(X0,Y0,X,Y), bend(X,Y), helper(X0,Y0,L), L>0, not hint(X,Y,_).

% there mustn't be any bends left when we reach the final cell
:- helper(X,Y,L), final(X,Y), L>0.

% there mustn't be any bends left when we reach a new hint cell
:- helper(X,Y,L), L>0, path(X,Y,X2,Y2), hint(X2,Y2,N).

% there mustn't be any cell without a helper
:- cell(X,Y), not helper(X,Y,_).

% Display
#show path/4.
