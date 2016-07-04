
object MyList {
  def myInit[T](xs: List[T]): List[T] = xs match {
    case List() => throw new Error("empty list")
    case List(x) => List()
    case y :: ys => y :: myInit(ys)
  }

  def myConcat[T](xs: List[T], ys: List[T]): List[T] = xs match {
    case List() => ys
    case z :: zs => z :: myConcat(zs, ys)
  }

  def myReverse[T](xs: List[T]): List[T] = xs match {
    case List() => xs
    case y :: ys => myReverse(ys) ::: List(y)
  }
  
  // I give a LOL on this one....
  def myRemoveAt[T](xs: List[T], n: Int) = {
    (xs take n) ::: (xs drop n + 1)
  }

  def main(args: Array[String]): Unit = {
    val list = List(1,2,3,4,5)
    val list2 = List(6,7,8)
    println(myReverse(list))
    println(myConcat(list, list2))
  }
}
