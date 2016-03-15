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
