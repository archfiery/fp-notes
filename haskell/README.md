# Haskell Notes

All notes should be put into this file.
It is also an experiments to see if the *one file* notes can survive.

## Cabal
Cabal is a package system for Haskell software.
It enables software to be easily distribute, use and reuse software.
Cabal packages can depend on other Cabal packages, and the tool provides automated package management.

```sh
  cabal [command] [option...]
```


To get help:
```sh
  cabal help
```

Alternatively, you can use the `Setup.hs` or `Setup.lhs`:
```sh  
  runhaskell Setup.hs [command] [option...]
```

```sh
runhaskell Setup.hs configure --ghc
runhaskell Setup.hs build
runhaskell Setup.hs install
```

### Cabal sandbox
Cabal sandbox is a self-contained environment that Haskell packages will be stored seprately.

To create a new Cabal sandbox
```sh
cabal sandbox init
```

and to tear down a Cabal sandbox
```sh
cabal sandbox delete
```

### `.cabal` file
There are two main entry points: *library* and *executable*.
Many executables can be defined but only one library.
`Test-Suite` defines an interface for invoking unit tests from `cabal`.

Example Cabal

```cabal
name:               mylibrary
version:            0.1
cabal-version:      >= 1.10
author:             Paul Atreides
license:            MIT
license-file:       LICENSE
synopsis:           The code must flow.
category:           Math
tested-with:        GHC
build-type:         Simple

library
    exposed-modules:
      Library.ExampleModule1
      Library.ExampleModule2

    build-depends:
      base >= 4 && < 5

    default-language: Haskell2010

    ghc-options: -O2 -Wall -fwarn-tabs

executable "example"
    build-depends:
        base >= 4 && < 5,
        mylibrary == 0.1
    default-language: Haskell2010
    main-is: Main.hs

Test-Suite test
  type: exitcode-stdio-1.0
  main-is: Test.hs
  default-language: Haskell2010
  build-depends:
      base >= 4 && < 5,
      mylibrary == 0.1
```

To run an `executable` for a project, use

```sh
# run the executable
cabal run

# run the executable <name>
cabal run <name>

# build the project under ./dist/build folder
cabal build

# get the ghci
cabal repl
cabal repl <name>

cabal install --only-dependencies --enable-tests
cabal configure --enable-test
cabal test
cabal test <name>
```

### Miscellaneous
- A little bit more usage can be found over [HERE](http://dev.stephendiehl.com/hask/#cabal).
- Stack is a new approach to Haskell package structure.
    - More about Stack: http://dev.stephendiehl.com/hask/#stack
    - The `stack` command is very similar to `cabal`

## Stack
Stack is a modern build tool for Haskell.
Stack uses curated package sets called `snapshots`.

### Stack commands example

```sh
stack new helloworld new-template
```
It creates a new stack project `helloworld` against template `new-template`.

---

```sh
stack setup
```
Stack will install the right version of GHC at the global stack root directory `/home/$USER/.stack/`.

---

```sh
stack build
```

It should be invoked after `stack setup`.

---

```sh
stack exec
```

Use stack to run the executables.
The executables are saved into the `./stack-work` directory.

---

```sh
stack test
```

It is equivalent to `stack build --test`.


## Constructors
Constructor means either *Type Constructor* or *Data Constructor*.
Haskell requires type names and constructor names to begin with an uppercase letter.
A `data` declaration introduces one or more *type* constructors and one or more *value* constructors foreach fo the type constructors.
*Types* are how we describe the program.

An example of *nullary* type constructor:
```haskell
data Bool = True | False
```

An example of *unary* type constructor:
```haskell
data Tree a = Tip | Node a (Tree a) (Tree a)
```

A more interesting article about the constructors:
```haskell
data Maybe a = Just a | Nothing
```

Type `Maybe` has one type variable, represented by `a` and two constructors `Just` and `Nothing`.
`a` can be considered as a generic type parameter.
- `Maybe` is a type constructor that returns a concrete type.
-  `Just` is a data constructor that returns a value.
- `Nothing` is a data constructor that contains a value.[stackoverflow](http://stackoverflow.com/questions/18204308/haskell-type-vs-data-constructor)

Types can be introduces into Haskell program by `type` and `newtype` statements.
When use the `type` declaration, we declare the synonym.

For example:
```haskell
type Name = String
```
indicates that the `String` and `Name` are interchangeble almost everywhere in the program.

`newtype` declaration creates a new type in much the same way as `data`.
Replacing `newtype` by `data` would not make the program corrupt, hoever the converse is not true.
`data` can only be replaced with `newtype` IF the type has *exactly one constructor* with *exactly one field* inside it.[NewType](https://wiki.haskell.org/Newtype) 
<!--
There are some subtle differences need further reading and experiments. 
TODO: `newtype`
-->

## Typeclass
A typeclass is equivalent to an interface from Java.
It defines some behaviours.
If a type is part of a typeclass, it means that it supports and implements the behaviour the typeclass describes.

Example type signature `==`
```haskell
(==) :: (Eq a) => a -> a -> Bool
```

Everything before `=>` symbol is called a *class constraint*.
The type of those two values must be a member of the `Eq` class.

```haskell
elem :: (Eq a) => a -> [a] -> Bool
```

There are several basic type classes that would be good to know.

### `Eq`
`Eq` is used for types that support equality testing.
The functions its member implement are `==` and `/=`.

### `Ord`
`Ord` is for types that have an ordering.
`Ord` covers all the standard comparing functions such as `>`, `<`, `>=` and `<=`.
The `compare` functions takes two `Ord` members of the same type and returns an `Ordering`.
`Ordering` is a type that can be `GT`, `LT`, or `EQ`.

### `Show`
Members of `Show` can be presented as strings.
The most used function that deals with the `Show` typeclass is `show`.

### `Read`
`read` function from `Read` takes a string and returns a type which is a member of `Read`.

Example:
```haskell
read "True" || False
--True

read "8.2" + 3.8
--12.0
```

GHC must know which type to return from reading a string.
Therefore, just by calling `read "8.2"` does not make sense to the compiler.
However we can add annotation to it

```haskell
read "5" :: Int
-- 5

read "5" :: Float
-- 5.0
```

### `Enum`
`Enum` members are sequentially ordered types and they can be enumerated.

```haskell
['a'..'e']
-- "abcde"
```

### `Bounded`
`Bounded` members have an upper and a lower bound

```haskell
minBound :: Int
-- -2147483648
```

### `Num`
`Num` is a numeric typeclass.
Its members have the property of being act like numbers.

```haskell
ghci>:t 20
20 :: (Num t) => t
```

### `Integer` and `Floating`
These two type classes can be considered as `BigInt` and `Double` respectively.

Some related topics about constructors:
- [Smart Constructors](https://wiki.haskell.org/Smart_constructors)
- [Abstract Data Type](https://wiki.haskell.org/Abstract_data_type)
- [Concrete Data Type](https://wiki.haskell.org/Concrete_data_type)
- [Polymorphism](https://wiki.haskell.org/Polymorphism)

## Algebraic Data Types
**Algebraic** refers to the property that an Algebraic Data Type is created by "algebraic" operations.
The "algebra" means *sum* and *products*:

- "sum" is alternation `A | B`
- "product" is combination `A B`

Example:

```haskell
data BST v = Leaf | Node (BST v) v (BST v)
```

It is a definition of a binary tree.
The **BST** followed by `data` keyword means a type constructor for **BST**.
Then it has two data constructors `Leaf` and `Node`.
`Leaf` takes no argument and `Leaf` itself is also a value in the type of BST.
`Node` has 3 arguments, left and right children of the type BST and a value.

It could be translate in Scala like:

```scala
sealed trait BST[A]
case class Leaf[A] extends BST[A]
case class Node[A] (left: BST[A], val: A, right: BST[A]) extends BST[A]
```

### Pattern Matching
Pattern matching is about finding the correct constructor to build the data.

#### Case Expression

```
case exp of
  pat1 -> expr1
  pat2 -> expr2
```

For example

```haskell
-- name, age, gender
data Person = Person String Int Char

-- return True if the name is Carl
carl :: Person -> Bool
carl p@Person(n _ _) = case n of
                        "Carl" -> True
                        _      -> False

```

Note that `_` will also match the pattern, however if the name is "Carl", `_` will not be reached.

## Higher Order Functions
Notes from [learnyouahaskell.com](http://learnyouahaskell.com/higher-order-functions).
Every function in Haskell **officially** takes only **one parameter**.
All functions that accpeted *several parameters* are **curried functions**.

For example:
```haskell
max :: (Ord a) => a -> a -> a

-- can also be written as 
max :: (Ord a) => a -> (a -> a)
```

Another example:
```haskell
multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z

-- in fact if we invoke 
-- multThree 1 2
-- in ghci, it does not know how to print 
-- because (a -> a) function is not an instance of `Show` typeclass

a = multThree 1 2
b = a 3 -- b = 6
c = a 4 -- c = 8
```

The `->` is naturally right associative, 
but it is mandatory if we need to pass a function as parameter.

For example:
```haskell
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)
```

`filter` function takes a `f` as operation in and then returns the filtered result.
A mergesort can be easily implemented by using `filter`.

For example:

```haskell
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = quicksort(smaller) ++ [x] ++ quicksort(larger)
  where smaller = quicksort (filter (<=x) xs)
        larger = quicksort (filter (>x) xs)
```

### Fold
A fold takes a binary function, an accumulator and a list to fold up.
The binary function takes two parameters, the accumulator and the first (or last) 
element from the list to produce a new accumulator.
`sum` function can be implemented using `foldl`.

```haskell
sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs

reverse' :: [a] -> [a]
reverse' [] = []
reverse' xs = foldl (\x acc -> acc : x) [] xs

```




## References:
- [Cabal User Guide](https://www.haskell.org/cabal/users-guide/installing-packages.html)
- [An Introduction to Cabal sandboxes](coldwa.st/e/blog/2013-08-20-Cabal-sandbox.html)
- [Haskell Type](https://wiki.haskell.org/Type)
- [Learn You A Haskell](http://learnyouahaskell.com/chapters)
