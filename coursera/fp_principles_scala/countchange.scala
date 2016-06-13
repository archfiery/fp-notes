object CountChange {
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
  def main(args: Array[String]): Unit = {
    println(countChange(10, List(2,5,3,6)))
  }
}
