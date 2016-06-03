addOneToAll :: [Int] -> [Int]
addOneToAll [] = []
addOneToAll (x:xs) = (x + 1):[]++(addOneToAll xs)

addOneToAll2 :: [Int] -> [Int]
addOneToAll2 [] = []
addOneToAll2 (x:xs) = x * 2 : addOneToAll2 xs

main = do
    print (addOneToAll [1, 2, 3, 4])
    print (addOneToAll2 [1, 2, 3, 4])
