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


## References:
- [Cabal User Guide](https://www.haskell.org/cabal/users-guide/installing-packages.html)
- [An Introduction to Cabal sandboxes](coldwa.st/e/blog/2013-08-20-Cabal-sandbox.html)
- [Haskell Type](https://wiki.haskell.org/Type)
