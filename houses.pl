% There are five consecutive houses, each of a different
% color and inhabited by men of different nationalities. They each
% own a different pet, have a different favorite drink and drive a
% different vehicle.
%   1. The Englishman lives in the red house.
%   2. The Spaniard owns a dog.
%   3. Coffee is drunk in the green house.
%   4. The Ukrainian drinks tea.
%   5. The green house is immediately to the right of the ivory house.
%   6. The motor cycle owner keeps snails.
%   7. Bike is driven by the man who lives in the yellow house.
%   8. Milk is drunk in the middle house.
%   9. The Norwegian lives in the first house on the left.
%  10. The man rides a skateboard lives in the house next to the man
%      who owns a  fox.
%  11. The man who rides  bike lives next to the man who owns a horse.
%  12. The man with the boat drinks orange juice.
%  13. The Japanese has a car
%  14. The Norwegian lives next to the blue house.
%Who owns the zebra, who drinks water.

% predicate to check if two eleents in the list are in left or right
left_right(L,R,List):-
    ((List=[L,R,_,_,_]);
     (List=[_,L,R,_,_]);
     (List=[_,_,L,R,_]);
     (List=[_,_,_,L,R])).

% prdeicate to check if the 2 elements in list are next to each other
nextto(A,B,L):-
    left_right(A,B,L);
    left_right(B,A,L).

% [color, nationality, drink, pet, vehicle]
arrangements(S):-
    S=[[_,norwegian,_,_,_], [blue,_,_,_,_], [_,_,milk,_,_],_,_],
    member([red, englishman,_,_,_],S),
    member([_,spaniard,_,dog,_],S),
    member([green,_,coffee,_,_],S),
    member([_,ukranian,tea,_,_],S),
    member([_,_,_,snail,motorcycle],S),
    member([yellow,_,_,_,bike],S),
    member([_,_,orange-juice,_,boat],S),
    member([_,japanese,_,_,car],S),
    member([_,_,_,zebra,_],S),
    member([_,_,water,_,_],S),
    left_right([ivory,_,_,_,_],[green,_,_,_,_],S),
    nextto([_,_,_,_,skateboard],[_,_,_,fox,_],S),
    nextto([_,_,_,_,bike],[_,_,_,horse,_],S).

goal(Who1,Who2):-
    arrangements(S),
    member([_,Who1,_,zebra,_],S),
    member([_,Who2,water,_,_],S).
