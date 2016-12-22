module Scrabble where

import           Data.Char
import           Data.Foldable
import           Data.Monoid
import           JoinList

data Score = Score Integer
  deriving (Show, Eq)

instance Monoid Score where
  mempty                      = Score 0
  mappend (Score x) (Score y) = Score (x + y)

scorePlus :: Score -> Score -> Score
scorePlus (Score x) (Score y) = Score (x + y)

-- score rules:
-- http://thepixiepit.co.uk/scrabble/rules.html
score :: Char -> Score
score c
  | elem lc "aeilnorstu" = Score 1
  | elem lc "dg"         = Score 2
  | elem lc "bcmp"       = Score 3
  | elem lc "fhvwy"      = Score 4
  | elem lc "k"          = Score 5
  | elem lc "jx"         = Score 8
  | elem lc "qz"         = Score 10
  | otherwise            = Score 0
  where lc = toLower c

scoreString :: String -> Score
scoreString [] = Score 0
scoreString (x:xs) = scorePlus (score x) (scoreString xs)

scoreLine :: String -> JoinList Score String
scoreLine s = Single (scoreString s) s

getScore :: Score -> Integer
getScore (Score x) = x
