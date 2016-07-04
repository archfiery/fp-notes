object Pack {
  val list = List('a', 'a', 'a', 'b', 'c', 'c', 'a')

  def myPack[T](l: List[T]): List[List[T]] = l match {
    case Nil => Nil
    case x :: xs => 
      val (fst, rest) = l span (y => y == x)
      fst :: myPack(rest)
  }

  def encode[T](l: List[T]): List[(T, Int)] = {
    myPack(l) map (ys => (ys.head, ys.size))
  }

  def main(args: Array[String]): Unit = {
    println(encode(list))
  }
}
