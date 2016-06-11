mysqrt :: Float -> Float
mysqrt x = sqrtIter 1.0 x

improve :: Float -> Float -> Float
improve g x = (g + (x / g)) / 2.0

goodEnough :: Float -> Float -> Bool
goodEnough x y = (abs((x * x) - y) / x) < 0.001

sqrtIter :: Float -> Float -> Float
sqrtIter g x
  | goodEnough g x = g
  | otherwise = sqrtIter (improve g x) x

main = do
  print((mysqrt 10.0))
  print((mysqrt 10000000.0))
