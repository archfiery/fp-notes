object rationals {
    val x = new Rational(1, 2)
    val y = new Rational(2, 3)
    x.add(y)
}

class Rational(x: Int, y: Int) {
    def this(x: Int) = this(x, 1)
    def numer = x
    def denom = y

    def add(that: Rational) = 
        new Rational(numer * that.denom + that.numer * denom,
                    denom * that.denom)

    def neg(): Rational = 
        new Rational(-numer, denom)

    // DRY principle
    def sub(that: Rational) = add(that.neg)

    override def toString = numer + "/" + denom
}
