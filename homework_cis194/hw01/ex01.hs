doubleEven ::
  [Integer] -> [Integer]
doubleEven = (\input -> case input of
                          [] -> []
                          [x] -> [x * 2]
                          (x:(y:zs)) -> (x * 2):y:doubleEven zs)

double ::
  Integer -> Integer
double x = x * 2

rev ::
  String -> String
rev x = reverse x

main = do
  print (rev "hey")
  print (doubleEven [1,2,3,4])
  print (doubleEven [1])
  print (doubleEven [])
  print (double 100)
