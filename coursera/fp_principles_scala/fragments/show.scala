// lecture 4.6 - Pattern Matching

trait Expr

case class Number(n: Int) extends Expr
case class Var(s: String) extends Expr
case class Sum(e1: Expr, e2: Expr) extends Expr
case class Prod(e1: Expr, e2: Expr) extends Expr
case class Sub(e1: Expr, e2: Expr) extends Expr
case class Div(e1: Expr, e2: Expr) extends Expr

object exprs {
  def show(e: Expr): String = e match {
    case Number(x) => x.toString
    case Var(x) => x
    case Sum(l, r) => show(l) + " + " + show(r)
    case Prod(l, r) => {
      val left = extraMatchDiv(l) 
      val right = extraMatchDiv(r)
      left + " * " + right
    }
    case Sub(l, r) => show(l) + " - " + show(r)
    case Div(l, r) => {
      val left = extraMatchProd(l) 
      val right = extraMatchProd(r)
      left + " / " + right
    }
  }

  def extraMatch(e: Expr): String = e match {
    case Sum(a, b) => "(" + show(a) + " + " + show(b) + ")"
    case Sub(a, b) => "(" + show(a) + " - " + show(b) + ")"
    case _ => show(e)
  }

  def extraMatchProd(e: Expr): String = e match {
    case Prod(a, b) => "(" + show(a) + " * " + show(b) + ")"
    case _ => extraMatch(e)
  }

  def extraMatchDiv(e: Expr): String = e match {
    case Div(a, b) => "(" + show(a) + " / " + show(b) + ")"
    case _ => extraMatch(e)
  }

  def disp(): Unit = {
    println(show(Sum(Number(1), Prod(Number(2), Number(44)))))
    println(show(Sum(Prod(Number(2), Var("x")), Var("y"))))
    println(show(Prod(Sum(Number(2), Var("x")), Var("y"))))
    println(show(Prod(Div(Number(2), Var("x")), Sum(Number(5), Var("z")))))
  }
}
