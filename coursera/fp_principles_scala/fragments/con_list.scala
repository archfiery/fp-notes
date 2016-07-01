import java.util.NoSuchElementException;

trait MyList[T] {
  def isEmpty: Boolean
  def head: T
  def tail: MyList[T]
}

class Cons[T](val head: T, val tail: MyList[T]) extends MyList[T] {
  def isEmpty = false
}

class Nil[T] extends MyList[T] {
  def isEmpty = true
  def head: Nothing = throw new NoSuchElementException("Nil.head")
  def tail: Nothing = throw new NoSuchElementException("Nil.tail")
}

