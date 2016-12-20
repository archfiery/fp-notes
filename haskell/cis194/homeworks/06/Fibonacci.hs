module Fibnacci where

import Data.Foldable

fib :: Integer -> Integer
fib n
  | n < 2     = n
  | otherwise = fib (n - 1) + fib (n - 2)

fibs1 :: [Integer]
fibs1 = fib <$> [0..]

fibs2 :: [Integer]
-- it seems never collapse with fold
--fibs2 = foldr' (\_ b -> b ++ [(b!!(length b - 1) + b!!(length b - 2))]) [0, 1] [0..]

-- OKAY, it was taken from some smart people...
fibs2 = 0 : 1 : zipWith (+) fibs2 (tail fibs2)


