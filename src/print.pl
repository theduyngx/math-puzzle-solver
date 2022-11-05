/*
  Author  :  The Duy Nguyen <theduyn@student.unimelb.edu.au>
  Purpose :  Print the puzzle solution.
*/

:- module(print, [print/1]).

%!  print_list(+Puzzle:list)
%
%   The main, exported print predicate that will print the solved puzzle.
print([]).
print(Puzzle) :-
    transpose(Puzzle, PT),
    maxcol_list(PT, MaxList, []),
    print_aux(Puzzle, MaxList).


%!  maxcol_list(+Transposed:list, ?MaxList:list, +ListAccum:list)
%
%   Predicate that finds the number with highest number of digits of
%   each column to print columns neatly
maxcol_list([], M, RM) :- reverse(RM, M).
maxcol_list([HC|Rest], MaxList, ListAccum) :-
    max_list(HC, Max), MaxDigit is floor(log10(Max)) + 1,
    maxcol_list(Rest, MaxList, [MaxDigit|ListAccum]).

%!  print_aux(+Puzzle:list, +MaxList:list)
%
%   Helper predicate for print, essentially prints each row recursively
%   with a row separator.
print_aux([], _).
print_aux([HR|Rest], MaxList) :-
    print_row(HR, MaxList), nl,
    print_separator(MaxList), nl,
    print_aux(Rest, MaxList).

%!  print_row(+Row:list, +MaxList:list)
%
%   Predicate prints individual row.
print_row([], []).
print_row([R|Rs], [MaxDigit|MaxRest]) :-
    (R \= 0 ->
         Digit is floor(log10(R)) + 1, RStr = R;
         RStr = '  ', Digit is MaxDigit-1),
    Rep is MaxDigit - Digit,
    loop(0, Rep, ' '),
    write(' '), write(RStr), write(' |'),
    print_row(Rs, MaxRest).

%!  print_separator(+MaxList:list)
%
%   Helper predicate prints row separator.
print_separator([]).
print_separator([MaxDigit|MaxRest]) :-
    MStr is MaxDigit + 2,
    loop(0, MStr, -),
    write(+),
    print_separator(MaxRest).

%!  loop(+Index:int, +Max:int, +Obj:compound)
%
%   A loop that loops the index till it reaches the maximal value while
%   each iteration will print out the compound Obj.
loop(M, M, _).
loop(N, M, X) :-
    between(0, M, N),
    write(X),
    Ns is N+1,
    loop(Ns, M, X).