{-# OPTIONS_GHC -Wall #-}
module HW01 where

-- Exercise 1 -----------------------------------------

-- Get the last digit from a number
lastDigit :: Integer -> Integer
lastDigit x
    | x < 10 = x
    | otherwise = x `mod` 10

-- Drop the last digit from a number
dropLastDigit :: Integer -> Integer
dropLastDigit x = (x - lastDigit x) `div` 10

-- Exercise 2 -----------------------------------------

toRevDigits :: Integer -> [Integer]
toRevDigits x
    | x <= 0 = []
    | otherwise = ((lastDigit x):[] ++ (toRevDigits (dropLastDigit x)))

-- Exercise 3 -----------------------------------------

-- Double every second number in a list starting on the left.
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther [x] = [x]
doubleEveryOther (x:(y:xs)) = (x):(y * 2):doubleEveryOther xs

-- Exercise 4 -----------------------------------------

-- Calculate the sum of all the digits in every Integer.
sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits [x] = (sumDigit x)
sumDigits (x:xs) = ((sumDigit x) + (sumDigits xs))

sumDigit :: Integer -> Integer
sumDigit x
    | x <= 0 = 0
    | (x < 10 && x > 0) = x
    | x >= 10 = ((lastDigit x) + (sumDigit (dropLastDigit x)))

-- Exercise 5 -----------------------------------------

-- Validate a credit card number using the above functions.
luhn :: Integer -> Bool
luhn x
  | ((lastDigit (sumDigits (doubleEveryOther (toRevDigits x)))) == 0) = True
  | otherwise = False

-- Exercise 6 -----------------------------------------

-- Towers of Hanoi for three pegs
type Peg = String
type Move = (Peg, Peg)

{- given the number of discs and names for the three pegs 
   hanoi should return a list of moves to be performed to 
   move the stack of discs from the first peg to the second
-}
hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi n from to with
  | n > 0 =
        (hanoi (n - 1) from with to)++((from,to):[])++(hanoi (n - 1) with to from)
  | otherwise = []

