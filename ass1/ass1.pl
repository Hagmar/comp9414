% Magnus Hagmar
% z5088131
% Assignment 1 - Prolog Programming


% TODO Solve without cut?
% Sums the squares of only even numbers in a list of numbers
sumsq_even([], 0).
sumsq_even([Head|Tail], Sum) :-
    0 is Head mod 2,
    !,
    sumsq_even(Tail, RestSum),
    Sum is Head*Head + RestSum.
sumsq_even([_|Tail], Sum) :-
    sumsq_even(Tail, Sum).


% TODO Remove these
% Temporary facts
likes(mary, apple).
likes(mary, pear).
likes(mary, grapes).
likes(tim, mango).
likes(tim, apple).
likes(jane, apple).
likes(jane, mango).

% TODO Add comments
all_like(_, []).
all_like(What, [Person|Tail]) :-
    likes(Person, What),
    all_like(What, Tail).


% TODO Add comments
% TODO Causes an error after finding solution
sqrt_table(N, N, [[N, Result]]) :-
    Result is sqrt(N).
sqrt_table(N, M, [[N, NResult] | Result]) :-
    NResult is sqrt(N),
    NewN is N-1,
    sqrt_table(NewN, M, Result).


% TODO Causes an error after finding solution
function_table(N, N, Function, [[N, Result]]) :-
    Temp =.. [Function, N],
    Result is Temp.
function_table(N, M, Function, [[N, Result]|RestResult]) :-
    Temp =.. [Function, N],
    Result is Temp,
    NewN is N-1,
    function_table(NewN, M, Function, RestResult).


% TODO Add comments
chop_down([], []).
chop_down([N | [M | Tail]], Result) :-
    M is N-1,
    !,
    chop_down([M | Tail], Result).
chop_down([N| Tail], [N | Result]) :-
    chop_down(Tail, Result).
