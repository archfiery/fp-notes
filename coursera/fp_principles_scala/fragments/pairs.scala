object pairs {
  def scalarProduct(xs: List[Double], ys: List[Double]): Double =
    (for ((x, y) <- xs zip ys) yield x * y).sum

  def main(args: Array[String]): Unit = {
    val n = 7
    val x = (1 until n) map (i => (1 until i) map (j => (i, j)))
    x.flatten foreach println
  }
}
