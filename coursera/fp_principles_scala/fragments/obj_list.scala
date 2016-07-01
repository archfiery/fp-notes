trait List[T] {
  def isEmpty: Boolean
  def head: T
  def tail: List[T]
}

class Cons[T](val head: T, val tail: List[T]) extends List[T] {
  def isEmpty = false
}

class Nil[T] extends List[T] {
  def isEmpty: Boolean = true
  def head: Nothing = throw new NoSuchElementException("Nil.head")
  def tail: Nothing = throw new NoSuchElementException("Nil.tail")
}

object List {
  // List(1, 2) = List.apply(1, 2)
  def apply[T](x: T, y: T): List[T] = {
    new Cons(x, new Cons(y, new Nil))
  }
  // List(1)
  def apply[T](x: T): List[T] = {
    new Cons(x, new Nil)
  }
  // List()
  def apply[T](): List[T] = {
    new Nil
  }
}

object objlist {

  def main(args: Array[String]): Unit = {
    assert(List(2, 3).head == 2)
    assert(List(1).head == 1)
  }
}
