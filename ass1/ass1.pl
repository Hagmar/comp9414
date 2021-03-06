% Magnus Hagmar
% z5088131
% Assignment 1 - Prolog Programming


% sumsq_even(+Numbers, -Sum)
% Binds Sum to the sum of all even numbers in the list.
% Numbers must be a list only containing integers.
%
% Assignment comment:
% I would have prefered to include a cut after the check whether Head is even
% or not, as this would remove the need for confirming that it is odd in the
% other case.
sumsq_even([], 0).
sumsq_even([Head|Tail], Sum) :-
    0 is Head mod 2,
    sumsq_even(Tail, RestSum),
    Sum is Head*Head + RestSum.
sumsq_even([Head|Tail], Sum) :-
    1 is Head mod 2,
    sumsq_even(Tail, Sum).


% all_like(+What, +List)
% Succeeds if every person in the list List likes the item What.
% "Liking" an item is represented by the predicate likes(Person, Item).
all_like(_, []).
all_like(What, [Person|Tail]) :-
    likes(Person, What),
    all_like(What, Tail).


% sqrt_table(+N, +M, -Result)
% Binds Result to a list containing elements of the form [X, Y] where Y is
% the square root of X. The Xs in the list start at N and decrease by one
% until they reach M.
% M is required to be less than or equal to N.
%
% Assignment comment:
% Again, I would prefer to use a cut as the first goal when N and M are the
% same, as this would prevent unnecessary backtracking and remove the need
% for the N =\= M check.
sqrt_table(N, N, [[N, Result]]) :-
    Result is sqrt(N).
sqrt_table(N, M, [[N, NResult] | Result]) :-
    N =\= M,
    NResult is sqrt(N),
    NewN is N-1,
    sqrt_table(NewN, M, Result).


% function_table(+N, +M, +Function, -Result)
% Binds Result to a list containing elements of the form [X, Y] where Y is
% Function(X). The Xs in the list start at N and decrease by one until they
% Reach M.
% M is required to be less than or equal to N.
%
% Assignment comment:
% I am not in COMP9814 but wanted to attempt the question anyway.
% A cut in the N, N case would be better than the N=\=M check in the other.
function_table(N, N, Function, [[N, Result]]) :-
    Temp =.. [Function, N],
    Result is Temp.
function_table(N, M, Function, [[N, Result]|RestResult]) :-
    N =\= M,
    Temp =.. [Function, N],
    Result is Temp,
    NewN is N-1,
    function_table(NewN, M, Function, RestResult).


% chop_down(+List, -NewList)
% Binds NewList to List with all sequences of successive decreasing numbers
% removed.
% List should only contain integers.
%
% Assignment comment:
% A cut after "M is N-1" would mean that the second case with [X] is
% unnecessary, as well as the inequality check in the last case. That would
% be a much cleaner solution, as the last case could be implemented as simply
% chop_down([N | Tail], [N | Result]) :-
%     chop_down(Tail, Result).

chop_down([], []).
chop_down([X], [X]).
chop_down([N | [M | Tail]], Result) :-
    M is N-1,
    chop_down([M | Tail], Result).
chop_down([N | [M | Tail]], [N | Result]) :-
    M =\= N-1,
    chop_down([M | Tail], Result).


% tree_eval(+Value, +Tree, -Eval)
% Takes a tree representing a mathematical formula, possibly containing
% variables, assigns the value Value to the variables, and evaluates the
% tree mathematically.
% Value must be a numerical value
% Tree needs to be a valid tree in one of the following forms:
%   - tree(empty, Num, empty), where Num is a number
%   - tree(empty, z, empty), which is a variable
%   - tree(L, Op, R), where L and R are other trees, and Op is an arithmetic
% operator
%
% Assignment comment:
% By adding a cut to the first two cases, it would remove the need for all
% not-statements below. For the variable-leaves it would prevent two steps
% of unnecessary backtracking, and for the numeric leaves it would prevent
% one. In this case I would personally consider it more readable than the
% non-cut solution as well.
tree_eval(Value, tree(empty, z, empty), Value).
tree_eval(_, tree(empty, Eval, empty), Eval) :-
    not(Eval = z).
tree_eval(Value, tree(L, Op, R), Eval) :-
    not(L = empty),
    not(R = empty),
    tree_eval(Value, L, EvalLeft),
    tree_eval(Value, R, EvalRight),
    Expr =.. [Op, EvalLeft, EvalRight],
    Eval is Expr.

% height_if_balanced(+Tree, -HiB)
% Takes a binary tree Tree and binds HiB to the height of the tree if it's
% balanced and -1 if it isn't.
% Tree needs to be a valid tree of the form tree(L, D, R) where L and R are
% trees and D is data.
%
% Assignment comment:
% I am not in COMP9814 but wanted to attempt the question anyway.
% Inserting a cut after "Diff =< 1" in the second case would remove the need
% for any goals in the third case. height_if_balanced(_, -1) would be enough.
% I would be interested in knowing if there is a better solution to this.
height_if_balanced(empty, 0).
height_if_balanced(tree(L, _, R), HiB) :-
    height_if_balanced(L, HL),
    height_if_balanced(R, HR),
    sort(HL, HR, Max, Min),
    Diff is Max-Min,
    Diff =< 1,
    HiB is Max+1.
height_if_balanced(tree(L, _, R), -1) :-
    height_if_balanced(L, HL),
    height_if_balanced(R, HR),
    sort(HL, HR, Max, Min),
    Diff is Max-Min,
    Diff > 1.

% sort(A, B, Max, Min) binds Max and Min to the larger and smaller of A and B,
% respectively.
sort(A, B, A, B) :-
    A > B.
sort(A, B, B, A) :-
    A =< B.
