object Exercise2 {
    // example sum
    def sum(f: Int => Int)(a: Int, b: Int): Int = {
        if (a > b) 0
        else f(a) + sum(f)(a + 1, b)
    }

    // write a product function that calculates the product of the
    // values of a function for the points on a given interval
    def product(f: Int => Int)(a: Int, b: Int): Int = {
        if (a > b) 1
        else f(a) * product(f)(a + 1, b)
    }

    // write factorial in terms of product
    def fact(n: Int): Int = product(Int => Int)(1, n)

    // generalise sum and product function
    def gen(g: (Int, Int) => Int, base: Int)(f: Int => Int)(a: Int, b: Int): Int = {
        if (a > b) base
        else g(f(a), gen(g, base)(f)(a + 1, b))
    }

    // their solution
    def mapReduce(f: Int => Int, combine: (Int, Int) => Int, zero: Int) (a: Int, b: Int): Int = {
        if (a > b) zero
        else combine(f(a), mapReduce(f, combine, zero)(a + 1, b))
    }

    val tolerance = 0.0001
    def abs(a: Double): Double = 
        if (a < 0) -a else a
    def isCloseEnough(x: Double, y: Double): Boolean =
        abs((x - y) / x) / x < tolerance
    def fixedPoint(f: Double => Double)(firstGuess: Double): Double = {
        def iterate(guess: Double): Double = {
            val next = f(guess)
            if (isCloseEnough(guess, next)) next
            else iterate(next)
        }
        iterate(firstGuess)
    }

    def averageDamp(f: Double => Double)(x: Double): Double = (x + f(x))/2

    def newsqrt(x: Double): Double = {
        fixedPoint(averageDamp(y => x / y))(1)
    }
    def main(args: Array[String]):Unit = {
        println(sum(x => x * x * x)(1, 5))
        println(sum(x => x)(1, 5))
        println(product(x => x)(1, 5))
        println(fact(5))
        println(mapReduce(x => x, (x, y) => x * y, 1)(1, 5) == product(x => x)(1, 5))
        println(mapReduce(x => x, (x, y) => x + y, 0)(1, 5) == sum(x => x)(1, 5))
        println(mapReduce(x => x, (x, y) => x + y, 0)(1, 5) == gen((x, y) => x + y, 0)(x => x)(1, 5))
        println(newsqrt(16))
    }
}

