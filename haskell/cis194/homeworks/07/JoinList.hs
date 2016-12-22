module JoinList where

import           Data.Monoid

import           Sized

{-
data JoinListBasic a = Empty
                     | Single a
                     | Append (JoinListBasic a) (JoinListBasic a)

jlbToList :: JoinListBasic a -> [a]
jlbToList x = case x of
                Empty      -> []
                Single a   -> [a]
                Append a b -> jlbToList a ++ jlbToList b
-}

data JoinList m a = Empty
                  | Single m a
                  | Append m (JoinList m a) (JoinList m a)
                  deriving (Show, Eq)

tag :: Monoid m => JoinList m a -> m
tag x = case x of
          Empty        -> mempty
          Single m _   -> m
          Append m _ _ -> m


(!!?) :: [a] -> Int -> Maybe a
[]     !!? _         = Nothing
_      !!? i | i < 0 = Nothing
(x:xs) !!? 0         = Just x
(x:xs) !!? i         = xs !!? (i - 1)

jlToList :: JoinList m a -> [a]
jlToList x = case x of
               Empty          -> []
               (Single _ a)   -> [a]
               (Append _ a b) -> jlToList a ++ jlToList b

(+++) :: Monoid m => JoinList m a -> JoinList m a -> JoinList m a
(+++) a b = Append (mappend (tag a) (tag b)) a b

indexJ :: (Sized m, Monoid m) => Int -> JoinList m a -> Maybe a
indexJ _ Empty = Nothing
indexJ n (Single _ a) = case n of
                          0 -> Just a
                          _ -> Nothing
indexJ n (Append m a b)
  | n >= sizef || n < 0 = Nothing
  | n < sizea           = indexJ n a
  | otherwise           = indexJ (n - sizea) b
  where sizef = getSize . size $ m
        sizea = getSize . size . tag $ a
--indexJ n a = (jlToList a) !!? n -- O(n)
-- the size is determined in binary fashion

dropJ :: (Sized m, Monoid m) => Int -> JoinList m a -> JoinList m a
dropJ _ Empty               = Empty
dropJ n s@(Single _ _)      = if n <= 0 then s else Empty
dropJ n s@(Append m a b)
  | n <= 0                  = s
  | n >= sizef              = Empty
  | n >= sizea && n < sizef = dropJ (n - sizea) b
  | otherwise               = (dropJ n a) +++ b
  where sizef = getSize . size $ m
        sizea = getSize . size . tag $ a

-- some
testA = Append (Size 5)
          (Append (Size 4)
            (Append (Size 2)
              (Single (Size 1) "hello")
              (Single (Size 1) "world")
            )
            (Append (Size 2)
              (Single (Size 1) "merry")
              (Single (Size 1) "xmas")
            )
          )
          (Single (Size 1) "new year")

testB = Append (Size 2)
          (Single (Size 1) "hey")
          (Single (Size 1) "jude")

testC = Single (Size 1) "haskell"

testD = Empty
