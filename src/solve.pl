/*
  Author  :  The Duy Nguyen <theduyn@student.unimelb.edu.au>
  Purpose :  To solve an n x n maths puzzle by filling up all the squares

Each square (or cell) is to be filled with single digit 1-9; each row/column
contains no duplicates; squares on diagonal must have same value; and the
header row/column (given) holds either the sum or product of that row/column.
The program first makes sure the diagonal holds same value. Then, values in
each cell row/column are distinct. Finally, it solves multiple equations,
given the headers.
*/

:- use_module(library(clpfd)).
:- use_module(print).

%!  product_list(?List:list, -Prod:compound)
%
%   Prod will be the compound term of */2 terms of all elements in List.
%   product_list(-List, -Prod) is nondet.
%   For example:
%       ?- product_list([A,B,3,4,5], X).
%       X = A* (B* (3* (4* (5*1)))).
product_list([], 1).
product_list([Head|Tail], Prod) :-
    Prod = Head * Rest,
    product_list(Tail, Rest).

%!  tail(?List:list, -Tail:list)
%
%   The output - Tail - is the list with its head removed.
tail([], []).
tail([_|TA], TA).

%!  diagonal(?RList:list, +Index:int, -Value:int)
%!  diagonal_unity(?Puzzle:list)
%
%   diagonal/3 inputs RList, a list of rows, checking if every Value at
%   position Index of row, also at position Index of RList, is the same.
%
%   diagonal_unity/1 inputs Puzzle, removes header row and initializes Index,
%   then calls diagonal/3. Succeeds if Puzzle's diagonal holds the same value.
diagonal([],_,_).
diagonal([Head|Tail], Index, Val) :-
    nth0(Index, Head, Val),
    IndexN is Index+1,
    diagonal(Tail, IndexN, Val).
diagonal_unity([_|Rest]) :-
    maplist(tail, Rest, Cells),
    diagonal(Cells, 0, _).

%!  puzzle_numerical(?Puzzle:list)
%
%   Checking other Puzzle's numerical validity criteria:
%   firstly makes sure all cell's values must be from 1 to 9;
%   then each row/column has distinct values;
%   and finally extracts headers to then solve multiple equations.
puzzle_numerical(Puzzle) :-
    [[_|Row_Head] | Rows] = Puzzle,
    maplist(tail, Rows, Row_Cells), append(Row_Cells, Vs), Vs ins 1..9,
    maplist(all_distinct, Row_Cells), transpose(Row_Cells, Col_Cells),
    maplist(all_distinct, Col_Cells),
    transpose(Puzzle, [[_|Col_Head] | _]),
    solve_equations(Row_Head, Col_Head, Row_Cells, Col_Cells).

%!  solve_equations(+Row_Head:list,  +Col_Head:list,
%                   ?Row_Cells:list, ?Col_Cells:list)
%
%   First two inputs are headers, last two are cells. The predicate solves
%   multiple equations by making values in all cells ground.
solve_equations([], [], [], []).
solve_equations([Row_H|RHs], [Col_H|CHs], [Row_Cells|RCs], [Col_Cells|CCs]) :-
    product_list(Row_Cells, ProdR),
    product_list(Col_Cells, ProdC),
    (sum(Row_Cells, #=, Col_H); ProdR #= Col_H),
    (sum(Col_Cells, #=, Row_H); ProdC #= Row_H),
    solve_equations(RHs, CHs, RCs, CCs).

%!  puzzle_solution(?Puzzle:list)
%
%   Solving the entire Puzzle.
puzzle_solution(Puzzle) :-
    diagonal_unity(Puzzle),
    puzzle_numerical(Puzzle),
    append(Puzzle, Vs), label(Vs),
    print(Puzzle).