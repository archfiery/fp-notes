{-# OPTIONS_GHC -Wall #-}
module HW02 where

-- Mastermind -----------------------------------------

-- A peg can be one of six colors
data Peg = Red | Green | Blue | Yellow | Orange | Purple
         deriving (Show, Eq, Ord)

-- A code is defined to simply be a list of Pegs
type Code = [Peg]

-- A move is constructed using a Code and two integers; the number of
-- exact matches and the number of regular matches
data Move = Move Code Int Int
          deriving (Show, Eq)

-- List containing all of the different Pegs
colors :: [Peg]
colors = [Red, Green, Blue, Yellow, Orange, Purple]

-- Exercise 1 -----------------------------------------

-- Get the number of exact matches between the actual code and the guess
exactMatches :: Code -> Code -> Int
exactMatches [] [] = 0
exactMatches x y = ((eq (head x) (head y)) + (exactMatches (tail x) (tail y)))

eq :: Peg -> Peg -> Int
eq x y
    | (x == y) = 1
    | otherwise = 0

-- Exercise 2 -----------------------------------------

-- For each peg in xs, count how many times is occurs in ys
countColors :: Code -> [Int]
countColors [] = [0, 0, 0, 0, 0, 0]
countColors (c:cs)
    | c == Red = (mergeList [1, 0, 0, 0, 0, 0] (countColors cs))
    | c == Green = (mergeList [0, 1, 0, 0, 0, 0] (countColors cs))
    | c == Blue = (mergeList [0, 0, 1, 0, 0, 0] (countColors cs))
    | c == Yellow = (mergeList [0, 0, 0, 1, 0, 0] (countColors cs))
    | c == Orange = (mergeList [0, 0, 0, 0, 1, 0] (countColors cs))
    | c == Purple = (mergeList [0, 0, 0, 0, 0, 1] (countColors cs))
    | otherwise = (mergeList [0, 0, 0, 0, 0, 0] (countColors cs))

mergeList :: [Int] -> [Int] -> [Int]
mergeList [] [] = []
mergeList x y = (((head x) + (head y)):[] ++ (mergeList (tail x) (tail y)))

-- Count number of matches between the actual code and the guess
matches :: Code -> Code -> Int
matches x y = sum(mergeByMin (countColors x) (countColors y))

mergeByMin :: [Int] -> [Int] -> [Int]
mergeByMin [] [] = []
mergeByMin (_:_) [] = []
mergeByMin [] (_:_) = []
mergeByMin (x:xs) (y:ys) = (min x y):[] ++ (mergeByMin xs ys)

-- Exercise 3 -----------------------------------------

-- Construct a Move from a guess given the actual code
getMove :: Code -> Code -> Move
getMove = undefined

-- Exercise 4 -----------------------------------------

isConsistent :: Move -> Code -> Bool
isConsistent = undefined

-- Exercise 5 -----------------------------------------

filterCodes :: Move -> [Code] -> [Code]
filterCodes = undefined

-- Exercise 6 -----------------------------------------

allCodes :: Int -> [Code]
allCodes = undefined

-- Exercise 7 -----------------------------------------

solve :: Code -> [Move]
solve = undefined

-- Bonus ----------------------------------------------

fiveGuess :: Code -> [Move]
fiveGuess = undefined
