doubleEveryOther ::
  [Integer] -> [Integer]
doubleEveryOther = (\input -> case input of
                          [] -> []
                          [x] -> [x]
                          (x:(y:zs)) -> (x):(double y):doubleEveryOther zs)

double ::
  Integer -> Integer
double x = x * 2

rev ::
  String -> String
rev x = reverse x

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

toRevDigits :: Integer -> [Integer]
toRevDigits x
  | x <= 0 = []
  | otherwise = ((lastDigit x):[] ++ (toRevDigits (dropLastDigit x)))

toDigits :: Integer -> [Integer]
toDigits x = reverse (toRevDigits x)

sumDigit :: Integer -> Integer
sumDigit x
  | x <= 0 = 0
  | x < 10 = x
  | x >= 10 = ((lastDigit x) + (sumDigit (dropLastDigit x)))

sumDigits :: [Integer] -> Integer
sumDigits ([x]) = (sumDigit x)
sumDigits (x:xs) = ((sumDigit x) + (sumDigits xs))

main = do
  print (rev "hey")
  print (doubleEveryOther [4,9,5,5])
  print (doubleEveryOther [1])
  print (doubleEveryOther [])
  print (doubleEveryOther [0,0])
  print (double 100)
  print (lastDigit 155)
  print (divByTen 155)
  print (divByTen 5)
  print (dropLastDigit 5)
  print (dropLastDigit 0)
  print (toRevDigits 1234)
  print (toRevDigits (-17))
  print (toRevDigits 12340)
  print (sumDigit 1234)
  print (sumDigit (-1234))
  print (sumDigits [1,2,3])
  print ('h':'e':'h':'e':[] == "hehe")
