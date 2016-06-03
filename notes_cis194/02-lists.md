# Note 02

## Defining Local Variables, `let` and `where`

There are some more syntax to learn:

### `let`: to define a local variable scoped over an expression

```hs
strLen :: String -> Int
strLen [] = 0
strLen (_:xs) = let len_rest = strLen xs in
                len_rest + 1
```

Don't forget the `in` after defining the variable.

### `where`: to define a local variable scoped over multiple guarded branches

```hs
frob :: Stirng -> Char
frob [] = 'a'
frob str
    | len > 5 = 'x'
    | len < 3 = 'y'
    | otherwise = 'z'
    where
        len = strLen str
```

In idiomatic haskell code, `where` is more common than `let`, becahse using `where` allows the programmer to get right to the point in defining what a function does, instead of setting up lots of local variables first.

## White space sensitive 

Haskell shares the whitespace-sensitive trait with Python.

## Accumulators
Sometimes problem does not match haskell's structure exactly, and therefore, we use `accumulator` to help.

Example: sum the `[Int]` until sum is greater than 20, after that, the rest of the numbers will be ignored.

```hs
sumTo20 :: [Int] -> Int
sumTo20 nums = go 0 nums
    where go :: Int -> [Int] -> Int
        go acc [] = acc
        go acc (x:xs)
            | acc >= 20 = acc
            | otherwise = go (acc + x) xs
```

## Parametric polymorphism
A polymorphic function must work for every possible input type.
iA function can't do one thing when the parameter is of type `Int` or a different thing when if of type `Bool`.
Haskell does not provide the facility for writing such an operation -- it is called *parametricity*.

As Haskell does not make decision based on the type information, all the type information can be dropped during compilation.

## Total and partial functions
- Functions which have certain inputs that will make them recurse infinitely are called *partial*
- Functions which will crash on certain inputs are called *partial*
- Functions which are well-defined on all possible inputs are known as *total functions*

### Recursion Patterns
Some common possibilities that we might do things for `[a]`.
- Perform some operations on every element of the list
- Keep only some elements of the list, and throws others away, based on a test
- "Summarise" the elements of the list somehow
- Others

#### Map

