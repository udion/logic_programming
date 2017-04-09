:- use_module(library(clpfd)).
occupancy(Z):-
    X = [Sanket,Ankush,Ashwin,Umang,Krishna],
    X ins 1..5,
    Ashwin #\= 5,
    Ankush #\= 1,
    (Umang #\= 5, Umang #\= 1),
    (Umang #\= Krishna-1 , Umang #\= Krishna+1),
    (Umang #\= Ankush-1 , Umang #\= Ankush+1),
    Sanket #> Ankush,
    all_different(X),
    label(X),
    people(Y),
    gen_list_of_list(Y,X,Z).

people([sanket,ankush,ashwin,umang,krishna]).
gen_pair(Name,Floor,Res) :- Res = [Name,Floor].

gen_list_of_list([NameHead|NameTail], [FloorHead|FloorTail], [RHead|RTail]):-
    gen_pair(NameHead,FloorHead,Z),
    RHead = Z,
    gen_list_of_list(NameTail,FloorTail,RTail).
gen_list_of_list([],[],[]).
