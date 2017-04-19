bad([X,Y]):-
    (X<1;X>7;Y<1;Y>7).

moves([X,Y],Sofar,[Xnew,Ynew]):-
    ((Xnew is X-2,Ynew is Y-1);
     (Xnew is X-2,Ynew is Y+1);
     (Xnew is X-1,Ynew is Y-2);
     (Xnew is X-1,Ynew is Y+2);
     (Xnew is X+1,Ynew is Y-2);
     (Xnew is X+1,Ynew is Y+2);
     (Xnew is X+2,Ynew is Y-1);
     (Xnew is X+2,Ynew is Y+1)),
    not(bad([Xnew,Ynew])),
    not(member(pair(Xnew,Ynew),Sofar)).
    
										  
tour(Res):-
    play([1,1],[pair(1,1)],S),
    reverse(S,Sol),
    write(Sol),!.

play([Xin,Yin],Sofar,Res):-
    loop_entry(Xin,Yin,Sofar,Res).

loop_entry(X,Y,Sofar,Res):-
    moves([X,Y],Sofar,[Xnext,Ynext]),
    loop_entry(Xnext,Ynext,[pair(Xnext,Ynext)|Sofar],Res).
loop_entry(Xf,Yf,Sofar,Sofar):-
    length(Sofar,L),
    L=49.
    
    
