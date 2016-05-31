-- a nice algorithm to reference
-- http://interactivepython.org/runestone/static/pythonds/Recursion/TowerofHanoi.html

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

main = do
    print ((hanoi 2 "a" "b" "c") == [("a","c"),("a","b"),("c","b")])
    print ((hanoi 3 "a" "b" "c") == [("a","b"),("a","c"),("b","c"),("a","b"),("c","a"),("c","b"),("a","b")])
