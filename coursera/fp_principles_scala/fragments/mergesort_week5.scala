import math.Ordering

object mergesort {
  def msort(xs: List[Int]): List[Int] = {
    val n = xs.length / 2
    if (n == 0) xs
    else {
      def merge(left: List[Int], right: List[Int]): List[Int] = (left, right) match {
        case (Nil, right) => right
        case (left, Nil) => left
        case (x :: xs, y :: ys) => 
          if (x < y) x :: merge(xs, right)
          else y :: merge(left, ys)
      }
      val (fst, snd) = xs splitAt n
      merge(msort(fst), msort(snd))
    }
  }

  def main(args: Array[String]): Unit = {
    val list = List(3,42,4,6,89,1,2,0)
    println(msort(list))
  }
}
