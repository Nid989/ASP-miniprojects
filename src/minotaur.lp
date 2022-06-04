% Guess solution candidates
% you may move 1 field in any of the directions or remain in current field
diff(0,1). diff(0,-1). diff(1,0). diff(-1,0). diff(0,0).

% Theseus: 
% initialise start field as step 0
at(X,Y,0) :- start(X,Y).

% start from given field, move to one neighbouring field ->  cannot move out of bounds (is part of fields)
% Theseus shall not pass through walls, in neither direction, Theseus can't walk past Minotaur
{ at(X2,Y2,S+1) : diff(A,B), X2=(X1+A), Y2=(Y1+B), field(X2,Y2), not wall(X1,Y1,X2,Y2), not wall(X2,Y2,X1,Y1), not minostep(X2,Y2,S,_) } = 1 
        :- at(X1,Y1,S), not goal(X1,Y1), maxsteps(M), S < M.

% Minotaur: 
% after Theseus (Theseus' steps > 0) moved a step (aka the difference of S between Theseus and Minotaur is 1)
% then the minotaur gets to move, and for every step of Theseus, the Minotaur has 2 steps
% first horizontal, then vertical -> first try to minimise X, then Y
% initialize minostep -> (X,Y,S,part of step)
minostep(X,Y,0,2) :- mino(X,Y).

% Minotaur walks horizontally as much as it can to reduce distance
hminostep(X1+Z,Y1,S2,1) :- minostep(X1,Y1,S1,2), at(X2,_,S2), diff(Z,0), S2-S1=1, |X2-(X1+Z)| < |X2-X1|, 
        not wall(X1+Z,Y1,X1,Y1), not wall(X1,Y1,X1+Z,Y1).
hminostep(X1+Z,Y1,S,2) :- minostep(X1,Y1,S,1), at(X2,_,S), diff(Z,0), |X2-(X1+Z)| < |X2-X1|, 
        not wall(X1+Z,Y1,X1,Y1), not wall(X1,Y1,X1+Z,Y1).

% only walk vertically if Minotaur hasn't walked horizontally before
vminostep(X1,Y1+Z,S2,1) :- minostep(X1,Y1,S1,2), at(_,Y2,S2), not hminostep(_,_,S2,1), diff(0,Z), S2-S1=1, |Y2-(Y1+Z)| < |Y2-Y1|, 
        not wall(X1,Y1+Z,X1,Y1), not wall(X1,Y1,X1,Y1+Z).
vminostep(X1,Y1+Z,S,2) :- minostep(X1,Y1,S,1), at(_,Y2,S), not hminostep(_,_,S,2), diff(0,Z), |Y2-(Y1+Z)| < |Y2-Y1|, 
        not wall(X1,Y1+Z,X1,Y1), not wall(X1,Y1,X1,Y1+Z).

% if Minotaur can't get any closer to Theseus, it stays put
minostep(X1,Y1,S,1) :- at(_,_,S), minostep(X1,Y1,S-1,2), not hminostep(_,_,S,1), not vminostep(_,_,S,1).
minostep(X1,Y1,S,2) :- at(_,_,S), minostep(X1,Y1,S,1), not hminostep(_,_,S,2), not vminostep(_,_,S,2).


minostep(X,Y,S,P) :- hminostep(X,Y,S,P).
minostep(X,Y,S,P) :- vminostep(X,Y,S,P).

% Check solution candidates
% Theseus must reach the goal
:- goal(X,Y), not at(X,Y,_).

% Minotaur should not catch Theseus
:- at(X,Y,S), minostep(X,Y,S,_).

% don't do the same things several times 
% OPTIONAL (improves grounding for bigger instances, slows down grounding for smaller instances)
:- at(X1,Y1,S1), minostep(X2,Y2,S1,2), at(X1,Y1,S2), minostep(X2,Y2,S2,2), S1<S2.

% Optimize solutions
% minimize theseus' step
#minimize{S : at(_,_,S)}.

% Display
#show at/3.
