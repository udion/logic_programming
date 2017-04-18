%% Four people need to cross a rickety bridge at
%% night. Unfortunately, they have only one torch and the bridge is
%% too dangerous to cross without one. The bridge is only strong
%% enough to support two people at a time. Not all people take the
%% same time to cross the bridge. Times for each person: 1 min, 2
%% mins, 7 mins and 10 mins. Unfortunately, the torch can last for
%% 17 minutes only. How can all four of them cross the bridge?

% Crossings is a list of single_crossings; each single_crossing
% is of the form pair(L ,Bank) meaning the list of people L just
% crossed over from bank Bank. Bank is one of l or r.

% example of Crossings:
%[pair([a, b], l), pair([a], r), pair([c, d], l), pair([b], r), pair([b, a], l)]

% State_of_the_river is a pair which tells us who are in the left
% bank and who are in the right bank. Example

% pair([a,b,c], [d])

% the complete state of the system is

%state(Crossings, State_of_the_river, Where_is_the_torch, Time_taken)

%% When does the search end? When we reach the initial state in
%% which right bank is empty and the left bank has all the members,
%% and the time is 0.

%% Suppose the goal state is (Crossings', pair(LB,RB), r, T).

%% This state was achieved because, from the earlier state, one or
%% two persons travelled from the left bank to the right
%% bank. Consider the two persons case first. Denote the earlier
%% state as (Crossings, pair(LB1, RB1), l, T1), and the persons as X
%% and Y.
%%                                    (X,Y)
%% (Crossings, pair(LB1, RB1), l, T1)-------> (Crossings', pair(LB,RB), r, T)

%% 1. X and Y are in RB. This causes an immediate pruning of the search space, since RB is instantiated.							 
%% 2. Crossings' = append(Crossing, [pair([X,Y], l)])
%% 3. LB1 = append([X,Y], LB)
%% 4. RB1 = delete([X,Y], RB)
%% 5. T1 = T - max(TX, TY), where TX and TY are the time reqd by X and Y to cross the bridge.
%% 6. T1 >= 0

/**
First solution using backward-reachability, I will start off with final state
and move backwards to the intial state.
hence final state will be
state(Crossings, pair([],[a,b,c,d]), r, T0).
and initial state will be
state([], pair([a,b,c,d],[]), l, T) where T>=0
**/

time(a,1).
time(b,2).
time(c,7).
time(d,10).

state([],pair(_,[]),l,T):-
    T >= 0.

% when we move from Left to Right with 2 people
state(Crossings,pair(LB,RB),r,T):-
    member(X,RB),
    member(Y,RB),
    \=(X,Y), %to ensure that both elements are not same
    time(X,TX), time(Y,TY), TX<TY, %this would select one of a,b or b,a
     T1 = T- max(TX,TY), T1>=0, %updated T
    =(LB1,[X|[Y|LB]]), %updated left bank
    delete(RB,X,RB_), delete(RB_,Y,RB1), %updated right bank
    state(Crossings1,pair(LB1,RB1),l,T1),
    append(Crossings1,[pair([X,Y],l)],Crossings).

% when we move from Left to right with one person
state(Crossings,pair(LB,RB),r,T):-
    member(X,RB),
    time(X,TX),
    T1 = T-TX, T>=0,
    LB1=[X|LB],
    delete(RB,X,RB1),
    state(Crossings1,pair(LB1,RB1),l,T1),
    append(Crossings1,[pair([X],l)],Crossings).

% when we move from right to left with 2 people
state(Crossings,pair(LB,RB),l,T):-
    member(X,LB),
    member(Y,LB),
    \=(X,Y), %to ensure that both elements are not same
    time(X,TX), time(Y,TY), TX<TY, %this would select one of a,b or b,a
    T1 = T- max(TX,TY), T1>=0, %updated T
    =(RB1,[X|[Y|RB]]), %updated left bank
    delete(LB,X,LB_), delete(LB_,Y,LB1), %updated right bank
    state(Crossings1,pair(LB1,RB1),r,T1),
    append(Crossings1,[pair([X,Y],r)],Crossings).

% when we move from Right to Left with one person
state(Crossings,pair(LB,RB),l,T):-
    member(X,LB),
    time(X,TX),
    T1 = T-TX, T>=0,
    RB1=[X|RB],
    delete(LB,X,LB1),
    state(Crossings1,pair(LB1,RB1),r,T1),
    append(Crossings1,[pair([X],r)],Crossings).

goal(G):-
    state(G,pair([],[a,b,c,d]),r,17).
