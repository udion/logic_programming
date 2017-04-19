/**
On the left bank of a river, there are 3 cannibals and 3 missionaries. There is also a boat
on the left bank which can carry at most 2 persons across the river. If any bank has more
cannibals than missionaries, then it is a dangerous situation, since the cannibals may eat the
missionaries. Needless to say, missionaries do not eat cannibals; they prefer biryani. 
The problem is to determine how they can all cross the river without anyone getting eaten up. You must have
a predicate safe(Ans) such that at the end of the execution, Ans must be bound to a list which
looks like [[3, 3, left], [2, 2, right], [3, 2, left], [3, 0, right], ...]. 
Here an element [M, C, B] of the list represents the number of missionaries (M) and cannibals (C)
on the left bank and the boat position (B).
**/

:-use_module(library(clpfd)).
switch(X,Y):-
    member(Y,[left,right]),
    not(Y=X).

initial(3,3,left,0,0).
final(0,0,right,3,3).

bad(Ml,Cl,_,Mr,Cr):-
    (Ml>0, Ml<Cl);
    (Mr>0, Mr<Cr).

move(Ml,Cl,Boat,Mr,Cr,UpdMl,UpdCl,UpdB,UpdMr,UpdCr):-
    left2right(Ml,Cl,Boat,Mr,Cr,UpdMl,UpdCl,UpdB,UpdMr,UpdCr);
    right2left(Ml,Cl,Boat,Mr,Cr,UpdMl,UpdCl,UpdB,UpdMr,UpdCr).
boat(M,C):-
    member([M,C],[[0,1],[1,0],[1,1],[2,0],[0,2]]).


left2right(Ml,Cl,Boat,Mr,Cr,UpdMl,UpdCl,UpdB,UpdMr,UpdCr):-
    Boat=left,
    boat(M,C),
    Ml>=M, UpdMl is Ml-M,
    Cl>=C, UpdCl is Cl-C,
    UpdMr is Mr+M,
    UpdCr is Cr+C,
    switch(Boat,UpdB).
right2left(Ml,Cl,Boat,Mr,Cr,UpdMl,UpdCl,UpdB,UpdMr,UpdCr):-
    Boat=right,
    boat(M,C),
    Mr>=M, UpdMr is Mr-M,
    Cr>=C, UpdCr is Cr-C,
    UpdMl is Ml+M,
    UpdCl is Cl+C,
    switch(Boat,UpdB).

save(Ans):-
    initial(Mlin,Clin,Bin,Mrin,Crin),
    play(Mlin,Clin,Bin,Mrin,Crin,Sol),
    reverse(X,Sol),
    write(X),!.

play(Mlin, Clin, Bin,Mrin,Crin, Ans):-
    loop_entry(Mlin,Clin,Bin,Mrin,Crin,[],Ans).

loop_entry(Ml,Cl,B,Mr,Cr,Sofar,Ans):-
    move(Ml,Cl,B,Mr,Cr,UpdMl,UpdCl,UpdB,UpdMr,UpdCr),
    not(bad(UpdMl,UpdCl,UpdB,UpdMr,UpdCr)),
    State = [Ml,Cl,B],
    not(member(State,Sofar)),
    loop_entry(UpdMl,UpdCl,UpdB,UpdMr,UpdCr,[State|Sofar],Ans).
loop_entry(Ml,Cl,B,Mr,Cr,Sofar,[[Ml,Cl,B]|Sofar]):-
    final(Ml,Cl,B,Mr,Cr),!.
