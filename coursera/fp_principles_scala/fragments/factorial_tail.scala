object fac {
  def factorial(n:Int):Int = {
    def loop(x:Int, n:Int):Int = {
      if (n == 0) x
      else loop(x * n, n - 1)
    }
    loop(1, n)
  }

  def main(args: Array[String]) = {
    println(factorial(10))
    println(factorial(4))
  }
}
