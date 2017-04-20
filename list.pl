/**
This file contains definition of some list predicates which are very handy
The definitions are based on usually recurssion.
**/

%predicate to return last element
my_last(X,[H]):-
    X=H.
my_last(X,[_|T]):-
    my_last(X,T).

%predicate to return second-last element
my_last_but_1(X,[A,_]):-
    X=A.
my_last_but_1(X,[_|T]):-
    my_last_but_1(X,T).

%predicate to return Kth element
my_kth(X,[H|_],1):-
    X=H.
my_kth(X,[_|T],K):-
    K_ is K-1,
    my_kth(X,T,K_).

%predicate to return length of lists
my_length([_],L):-
    L=1.
my_length([_|T],L):-
    my_length(T,L_),
    L is L_+1.

%predicate to reverse a list
my_reverse([],Rev):-
    Rev = [].
my_reverse([H|T],Rev):-
    my_reverse(T,R_),
    append(R_,[H],Rev).

%predicate to check for palindrome
is_pallindrome(L):-
    my_reverse(L,Lrev),
    Lrev = L.

%predicate to flatten the nested list structure
my_flatten([],F):-
    F=[].
my_flatten([H],F):-
    not(is_list(H)),
    F=[H].
my_flatten([H],F):-
    is_list(H),
    my_flatten(H,F).
my_flatten([H|T],F):-
    my_flatten([H],F1),
    my_length(T,L), L \= 0,
    my_flatten(T,F2),
    append(F1,F2,F).

%predicate to compress a string
compress([],C):-
    C=[].
compress([H],C):-
    C=[H].
compress([H|T],C):-
    compress(T,[H_|T_]),
    H \= H_,
    append([H],[H_|T_],C).
compress([H|T],C):-
    compress(T,[H_|T_]),
    H \= H_,
    append([H],[H_|T_],C).
compress([H|T],C):-
    compress(T,[H_|T_]),
    H = H_,
    C = [H_|T_].

%predicate to  pack consecutive same elements of the list in sublists
pack([],P):-
    P=[].
pack([X],P):-
    P=[[X]].
pack([H|T],P):-
    pack(T,[[H_|Tt]|T_]),
    H=H_,
    append([H],[H_|Tt],Hh),
    append([Hh],T_,P).
pack([H|T],P):-
    pack(T,[[H_|Tt]|T_]),
    H \= H_,
    append([[H]],[[H_|Tt]|T_],P).
