/**
A bag has 3 green caps, 2 yellow caps and 2 red caps. Three persons A, B and C are called,
blindfolded, and a cap is put on each persons head from the bag. When the blindfolds are opened,
everyone can see the caps on the other’s heads but not the one on his own. In addition everyone
knows the contents of the bag. Each person is asked to make a statement of the following form:
(a) I know that the color of my cap is X.
(b) I know that the color of my cap is not X.
(c) I can’t say anything definite.
A is asked first. He says that he cannot say anything definite. B is asked next and he says the
same thing. Finally when C is asked, he says that he knows that the color of his cap is X. Write
a prolog program that encodes exactly the information contained in A’s and B’s answers, and
determine the color of C’s cap.
**/

green(g).
yellow(y).
red(r).

% formula phi(X) which represents that X is in union of all three colours and X is only one colour
phi(X):-
    (green(X);yellow(X);red(X)),
    not((green(X),yellow(X))),
    not((green(X),red(X))),
    not((red(X),yellow(X))).

% predicate to give a count of a particular element in a list
count([X|T],X,Y):-
    count(T,X,Z),
    Y is 1+Z.
count([_|T],X,Y):-
    count(T,X,Y).
count([],X,0).

% predicate to impose the condition of upper bounds to the number of caps
upperbounds(L):-
    count(L,g,Ngreen),
    count(L,y,Nyellow),
    count(L,r,Nred),
    not(Ngreen>3),
    not(Nyellow>2),
    not(Nred>2),
    N is Nred+Nyellow+Ngreen,
    N=3.

% formula which encodes the implications of A's answer
aNotSure([A,B,C]):-
    (green(A);yellow(A);red(A)),
    not((yellow(B),yellow(C))),
    not((red(B),red(C))).
% formula which encodes the implications of B's answer
bNotSure([A,B,C]):-
    (green(A);yellow(A);red(A)),
    (green(B);yellow(B);red(B)),
    not(yellow(C)),
    not(red(C)).

cap_assignments([A,B,C]):-
    phi(A),
    phi(B),
    phi(C),
    upperbounds([A,B,C]),
    aNotSure([A,B,C]),
    bNotSure([A,B,C]).

goal(Z,[A,B,C]):-
    cap_assignments([A,B,C]),
    Z=C.
