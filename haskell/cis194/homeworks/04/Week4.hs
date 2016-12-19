module Week4 where

-- Rewrite the following functions in 
-- more idiomatic Haskell style
-- Break each function into a pipeline
-- of incremental transformations to an
-- entire data structure

fun1 :: [Integer] -> Integer
fun1 [] = 1
fun1 (x:xs)
  | even x    = (x - 2) * fun1 xs
  | otherwise = fun1 xs

fun1' :: [Integer] -> Integer
--fun1' a = product (map (\x -> x - 2) (filter even a))
fun1' = product 
      . map (subtract 2) 
      . filter even

-- Hint: use `iterate` and `takeWhile`
fun2 :: Integer -> Integer
fun2 1 = 0
fun2 n
  | even n    = n + fun2 (n `div` 2)
  | otherwise = fun2 (3 * n + 1)

fun2' :: Integer -> Integer
fun2' = sum
      . filter even
      . takeWhile (/=1)
      . iterate (\x -> if even x
                          then div x 2
                          else 3 * x + 1)

-- The height of a binary tree is the length of a path
-- from the root to the deepest node
-- A binary tree is balanced if the height of its left
-- and right subtrees differ by no more than 1
-- and its left and right subtrees are also balanced
data Tree a = Leaf
            | Node Integer (Tree a) a (Tree a)
            deriving (Show, Eq)

height :: Tree a -> Integer
height Leaf = -1
height (Node _ l _ r) = max (height l) (height r) + 1

-- generate a balanced binary tree from a list of values using
-- foldr
foldTree :: [a] -> Tree a
foldTree = foldr insert Leaf

insert :: a -> Tree a -> Tree a
insert d Leaf = Node 0 Leaf d Leaf
insert d (Node _ l a r) = let (ls, rs) =
                                if height l < height r
                                   then (insert d l, r)
                                   else (l, insert d r) in
                                let h = max (height ls) (height rs) + 1 in
                                    Node h ls a rs

-- implement a function
-- xor :: [Bool] -> Bool
-- which returns True iff there are an odd num of True values
-- in the input list
-- must implement with a fold

xor :: [Bool] -> Bool
xor = foldr (/=) False
--xor = odd . length . foldr (:) [] . filter (==True)
--xor = odd . length . filter (==True)

-- implement map using foldr
map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x y -> f x : y) []

-- implement foldl using foldr
myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f base = foldr (flip f) base

-- https://en.wikipedia.org/wiki/Sieve_of_Sundaram
sieveSundaram :: Integer -> [Integer]
sieveSundaram n = [ 2 * x + 1 | x <- filter (`notElem` [ i + j + 2 * i * j | i <- [1..n], j <- [i..n], i + j + 2 * i * j <= n ]) [1..n] ]
