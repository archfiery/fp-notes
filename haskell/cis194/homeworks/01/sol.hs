{-# OPTIONS_GHC -Wall #-}
module Sol where

{--
 - toDigits converts positive integers to a list of digits.
 - toDigitsRev should do the same, but with digits reversed.
 --}

toDigits :: Integer -> [Integer]
toDigits a
  | a < 10 = a:[]
  | otherwise = (toDigits (a `div` 10)) ++ (a `mod` 10):[]


toDigitsRev :: Integer -> [Integer]
toDigitsRev a
  | a < 10 = a:[]
  | otherwise = (a `mod` 10):[] ++ (toDigitsRev (a `div` 10))


doubleEveryOtherLeft :: [Integer] -> [Integer]
doubleEveryOtherLeft [] = []
doubleEveryOtherLeft [x] = [x]
doubleEveryOtherLeft (x:(y:xs)) = (x):(y * 2):doubleEveryOtherLeft xs

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther x = reverse (doubleEveryOtherLeft (reverse x))

sumDigits :: [Integer] -> Integer
sumDigits l = sum l

validate :: Integer -> Bool
validate num = if x == 0 then True else False
  where x = (sumDigits (doubleEveryOther (toDigits num))) `mod` 10

