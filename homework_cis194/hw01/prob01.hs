-- Ex 01
lastDigit ::
  Integer -> Integer
lastDigit x
  | x < 10 = x
  | otherwise = x `mod` 10

divByTen :: 
  Integer -> Integer
divByTen x = x `div` 10

dropLastDigit ::
  Integer -> Integer
dropLastDigit x = divByTen (x - lastDigit x)

-- Ex 02
toRevDigits :: Integer -> [Integer]
toRevDigits x
  | x <= 0 = []
  | otherwise = ((lastDigit x):[] ++ (toRevDigits (dropLastDigit x)))

toDigits :: Integer -> [Integer]
toDigits x = reverse (toRevDigits x)

-- Ex 03
double ::
  Integer -> Integer
double x = x * 2

doubleEveryOther ::
  [Integer] -> [Integer]
doubleEveryOther = (\input -> case input of
                          [] -> []
                          [x] -> [x]
                          (x:(y:zs)) -> (x):(double y):doubleEveryOther zs)

-- Ex 04
sumDigit :: Integer -> Integer
sumDigit x
  | x <= 0 = 0
  | x < 10 = x
  | x >= 10 = ((lastDigit x) + (sumDigit (dropLastDigit x)))

sumDigits :: [Integer] -> Integer
sumDigits ([x]) = (sumDigit x)
sumDigits (x:xs) = ((sumDigit x) + (sumDigits xs))

-- Ex 05
luhn :: Integer -> Bool
luhn x
  | ((lastDigit (sumDigits (doubleEveryOther (toRevDigits x)))) == 0) = True
  | otherwise = False


main = do
  print ((doubleEveryOther [4,9,5,5]) == [4,18,5,10])
  print ((doubleEveryOther [1]) == [1])
  print ((doubleEveryOther []) == [])
  print ((doubleEveryOther [0,0]) == [0,0])
  print ((double 100) == 200)
  print ((lastDigit 155) == 5)
  print ((divByTen 155) == 15)
  print ((divByTen 5) == 0)
  print ((dropLastDigit 5) == 0)
  print ((dropLastDigit 0) == 0)
  print ((toRevDigits 1234) == [4,3,2,1])
  print ((toRevDigits (-17)) == [])
  print ((toRevDigits 12340) == [0,4,3,2,1])
  print ((sumDigit 1234) == 10)
  print ((sumDigit (-1234)) == 0)
  print (sumDigits [10,22,3] == 8)
  print ((luhn 5594589764218858) == True)
  print ((luhn 1234567898765432) == False)
