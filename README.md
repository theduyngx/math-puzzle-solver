# Prolog math puzzle solver
### About
 Prolog program solving a specific n x n math puzzle, in which the puzzle consists of a header row, a header column,
 and the body (the body is n x n). The headers represent either the sum or product of that column / row. Every cell
 in each column / row must be distinct from one another. The diagonal of the puzzle's body must hold the same value 
 as well.
 
 If either of these specifications are not met, the program will simply return `false` (the puzzle isn't 
 square, the diagonal values are specified to not match, there is no viable solution, etc.).
 Here's an example of a puzzle:
 
 ```
 Puzzle = [[0,14,10,35],[14,_,_,_],[15,_,_,_],[28,_,1,_]]
 ```

 which is equivalent to:
 ```diff
     | 14 | 10 | 35 |
 ----+----+----+----+
  14 |    |    |    |
 ----+----+----+----+
  15 |    |    |    |
 ----+----+----+----+
  28 |    |  1 |    |
 ----+----+----+----+
 ```
 where `14, 10, 35` is the header row, and `14, 15, 28` is the header column. The solution to this puzzle would be:
 
 ```
 Puzzle = [[0, 14, 10, 35], [14, 7, 2, 1], [15, 3, 7, 5], [28, 4, 1, 7]]
 ```
 which is equivalent to:
 ```diff
     | 14 | 10 | 35 |
 ----+----+----+----+
  14 |  7 |  2 |  1 |
 ----+----+----+----+
  15 |  3 |  7 |  5 |
 ----+----+----+----+
  28 |  4 |  1 |  7 |
 ----+----+----+----+
 ```
 We can see that, say, for the third row, `28` is the sum - in fact for all rows in this puzzle actually - while
 the for the first and second columns, `14` and `10` are their respective sums instead. Also, the diagonal cells all hold
 the same value 7.
 
### Usage
 To run the program, go into the correct directory in terminal, and enter command `swipl`, and then run the file solve:
 ```
 ?- [solve].
 true.
 ```
 After successfully loading up `solve.pl`, simply input the Puzzle with the same format as specified above (a list of
 sublists, with first sublist being the header row, and the head of the other sublists being the components of header
 column).
 
 And run it through the `puzzle_solution` predicate:
 ```
 1 ?-  Puzzle = [[0,14,16,18],[189,_,_,_],[17,_,_,_],[60,_,_,_]],
   |   puzzle_solution(Puzzle).
      | 14 | 16 | 18 |
 -----+----+----+----+
  189 |  3 |  9 |  7 |
 -----+----+----+----+
   17 |  6 |  3 |  8 |
 -----+----+----+----+
   60 |  5 |  4 |  3 |
 -----+----+----+----+
 Puzzle = [[0, 14, 16, 18], [189, 3, 9, 7], [17, 6, 3, 8], [60, 5, 4, 3]] ;
 false.
 ```
