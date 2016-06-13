object Pascal {

  def pascal(c:Int, r:Int):Int = {
    if (c == 0 || c == r) 1 else pascal(c - 1, r - 1) + pascal(c, r - 1)
  }

  def main(args: Array[String]) = {
    println(pascal(0, 2) == 1)
    println(pascal(1, 2) == 2)
    println(pascal(1, 3) == 3)
  }
}
