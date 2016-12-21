module Fibnacci where

import           Data.Foldable

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

data Stream a = Cons a (Stream a)

streamToList :: Stream a -> [a]
streamToList (Cons x y) = x : (streamToList y)

instance Show a => Show (Stream a) where
  show = show . take 20 . streamToList

streamRepeat :: a -> Stream a
streamRepeat x = Cons x (streamRepeat x)

streamMap :: (a -> b) -> Stream a -> Stream b
streamMap f (Cons x y) = Cons (f x) (streamMap f y)

streamFromSeed :: (a -> a) -> a -> Stream a
streamFromSeed f x = Cons x (streamFromSeed f (f x))

nats :: Stream Integer
nats = streamFromSeed (+1) 0

interleaveStream :: Stream a -> Stream a -> Stream a
interleaveStream (Cons x y) z = Cons x (interleaveStream z y)

ruler :: Stream Integer
ruler = ruler' 0

-- observation: the numbers can be repeatedly reduced
-- https://oeis.org/A001511
ruler' :: Integer -> Stream Integer
ruler' y = interleaveStream (streamRepeat y) (ruler' (y + 1))

