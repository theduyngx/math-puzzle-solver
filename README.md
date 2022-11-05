# Prolog math puzzle solver
 Prolog program solving a specific n x n math puzzle.
 The puzzle consists of a header row, a header column, and the body (the body is n x n). The headers represent either the sum or product of
 that row / column. The diagonal of the puzzle's body must hold the same value as well. Here's an example of a puzzle:
 
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
  28 |    | 1  |    |
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
 (we can see that, say, for the third row, `28` is the sum - in fact for all rows in this puzzle actually - while
 the for the first and second columns, `14` and `10` are their respective sums instead).
 
 ### Usage
 To run the program, input the Puzzle with the same format as specified above (a list of sublists, with first sublist being
 the header row, and the head of the other sublists being the components of header column).
 
 And simply run it through the `puzzle_solution` predicate:
 ```
 1 ?- Puzzle = [[0,14,16,18],[189,_,_,_],[17,_,_,_],[60,_,_,_]], puzzle_solution(Puzzle).
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
