/*
 * from 6-4 slides
 * n queens problems
 * using a recursive algorithm
 * 
 * 1) we have already generated all the solutions consisting of placing
 * k-1 queens on a board of size n
 * 2) each solution is repr by a list (of length k-1) containing the 
 * numbers of columns (between 0 and n-1)
 * 3) the column number of the queen in the k-1th row comes first in the
 * list, followed by the column number of the queen in row k-2, etc.
 * 4) the solution set is thus repr as a set of lists, with one elem
 * for each solution
 * 5) now, to place kth queen, we generate all possible extensions of 
 * each solution preceded by a new queen
 *
 */

import scala.math

object nqueens {
  def queens(n: Int): Set[List[Int]] = {
    def placeQueens(k: Int): Set[List[Int]] =
      if (k == 0) Set(List())
      else 
        for {
          queens <- placeQueens(k - 1)
          col <- 0 until n
          if isSafe(col, queens)
        } yield col :: queens
    placeQueens(n)
  }

  def isSafe(col: Int, queens: List[Int]): Boolean = {
    val row = queens.length
    val queensWithRow = (row - 1 to 0 by -1) zip queens
    queensWithRow forall {
      case (r, c) => col != c && math.abs(col - c) != row - r
    }
  }

  def show(queens: List[Int]) = {
    val lines = 
      for (col <- queens.reverse)
      yield Vector.fill(queens.length)("* ").updated(col, "X ").mkString

    println(lines mkString "\n")
    println
  }

  def main(args: Array[String]): Unit =
    queens(8) map show
 
}
