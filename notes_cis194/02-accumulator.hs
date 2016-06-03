sumTo20 :: [Int] -> Int

sumTo20 nums = go 0 nums
    where go :: Int -> [Int] -> Int
          go acc [] = acc
          go acc (x:xs) 
            | acc >= 20 = acc
            | otherwise = go (acc + x) xs

main = do
    print (sumTo20 [3,4,5,6,7,8,9,10])
    print (sumTo20 [4,9,10,2,8])
