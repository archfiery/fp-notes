import Math._

object newton {
  def mysqrt(x:Double):Double = {
    def improve(g:Double):Double = {
      (g + (x / g)) / 2.0
    }

    def goodEnough(g:Double):Boolean = {
      abs((g * g) - x) / g < 0.001
    }

    def sqrtIter(g:Double):Double = {
      if (goodEnough(g)) g else sqrtIter(improve(g))
    }

    sqrtIter(1.0)
  
  }

  def main(args: Array[String]) = {
    println(mysqrt(10.0))
  }
}

// goodEnough is not precise enough for small numbers 
// and can lead to non-termination for very large numbers
//
// the guess could jump around the final value
