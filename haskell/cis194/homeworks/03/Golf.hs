module Golf where

-- given a list and the position n
-- return a list of elements for every n
iter :: [a] -> Int -> [a]
iter l n = [ l !! i | i <- [(n - 1), (2 * n - 1)..(length l) - 1 ]]

iter2 :: [a] -> Int -> [a]
iter2 l n = let len = length l in
                if n > len then [] else l!!(n - 1):[] ++ (iter2 (drop n l) n)

skips :: [a] -> [[a]]
  {-- skips l = [iter l i | i <- [1..length l]] --}
skips l = [iter2 l i | i <- [1..length l]]

-- works like a window
localMaxima :: [Integer] -> [Integer]
localMaxima l = [ l!!i | i <- [1..length l - 2], l!!i > l!!(i - 1) && l!!i > l!!(i + 1) ]

-- TODO: figure it out
histogram :: [Integer] -> String
histogram = undefined
