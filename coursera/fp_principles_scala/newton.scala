import Math._

object newton {
  def mysqrt(x:Double):Double = {
    sqrtIter(1.0, x)
  }

  def improve(g:Double, x:Double):Double = {
    (g + (x / g)) / 2.0
  }

  def goodEnough(x:Double, y:Double):Boolean = {
    abs((x * x) - y) / x < 0.001
  }

  def sqrtIter(g:Double, x:Double):Double = {
    if (goodEnough(g, x)) g else sqrtIter(improve(g, x), x)
  }

  def main(args: Array[String]) = {
    println(mysqrt(10.0))
    println(mysqrt(1e60))
  }
}

// goodEnough is not precise enough for small numbers 
// and can lead to non-termination for very large numbers
//
// the guess could jump around the final value
