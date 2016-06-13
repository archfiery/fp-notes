object Balance {
  def balance(chars: List[Char]): Boolean = {
    def balanceHelper(l: List[Char], opened: Int): Boolean = {
      if (opened < 0)
        false
      else if (l.isEmpty) 
        opened == 0
      else {
        if (l.head == '(')
          balanceHelper(l.tail, opened + 1)
        else if (l.head == ')')
          balanceHelper(l.tail, opened - 1)
        else
          balanceHelper(l.tail, opened)
      }
    }
    balanceHelper(chars, 0)
  }

  def main(args: Array[String]):Unit = {
    println(balance("".toList))
    println(balance("hello".toList))
    println(balance("(if (zero? x) max (/ 1 x))".toList))
    println(balance("I told him (that it’s not (yet) done). (But he wasn’t listening)".toList))
    println(balance(":-)".toList))
    println(balance("())(".toList))
    println(balance(")(())".toList))
    println(balance("))".toList))
  }
}
