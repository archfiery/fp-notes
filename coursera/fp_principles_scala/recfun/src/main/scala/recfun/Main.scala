package recfun

object Main {
  def main(args: Array[String]) {
    println("Pascal's Triangle")
    for (row <- 0 to 10) {
      for (col <- 0 to row)
        print(pascal(col, row) + " ")
      println()
    }
  }

  /**
    * Exercise 1
    */
  def pascal(c: Int, r: Int): Int = {
    if (c == 0 || c == r) 1 else pascal(c - 1, r - 1) + pascal(c, r - 1)
  }

  /**
    * Exercise 2
    */
  def balance(chars: List[Char]): Boolean = {
    def balanceHelper(l: List[Char], opened: Int): Boolean = {
      if (opened < 0)
        false
      else if (l.isEmpty)
        opened == 0
      else {
        if (l.head == '(')
          balanceHelper(l.tail, opened + 1)
        else if (l.head == ')')
          balanceHelper(l.tail, opened - 1)
        else
          balanceHelper(l.tail, opened)
      }
    }
    balanceHelper(chars, 0)
  }

  /**
    * Exercise 3
    */
  def countChange(money: Int, coins: List[Int]): Int = {
    var possible = new Array[Int](money + 1)

    possible(0) = 1

    for (i <- 0 to coins.length - 1) {
      for (j <- coins(i) to money) {
        possible(j) += possible(j - coins(i))
      }
    }

    possible(money)

  }
}
