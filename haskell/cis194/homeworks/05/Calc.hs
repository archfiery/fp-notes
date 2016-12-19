{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE TypeSynonymInstances #-}

module Calc (Expr) where

import           ExprT
import           Parser
import qualified StackVM as StackVM

-- Ex 1
eval :: ExprT -> Integer
eval expr = case expr of
              Lit a   -> a
              Add a b -> eval a + eval b
              Mul a b -> eval a * eval b

-- Ex 2
evalStr :: String -> Maybe Integer
evalStr str = let x = parseExp Lit Add Mul str in
                  case x of
                    Just expr -> Just (eval expr)
                    Nothing   -> Nothing

-- Ex 3, 4
class Expr a where
  lit :: Integer -> a
  add :: a -> a -> a
  mul :: a -> a -> a

instance Expr Integer where
  lit = id
  add = (+)
  mul = (*)

instance Expr Bool where
  lit = (>0)
  add = (||)
  mul = (&&)

newtype MinMax = MinMax Integer
  deriving (Show, Eq)

instance Expr MinMax where
  lit = MinMax
  add (MinMax a) (MinMax b) = MinMax (max a b)
  mul (MinMax a) (MinMax b) = MinMax (min a b)

newtype Mod7 = Mod7 Integer
  deriving (Show, Eq)

instance Expr Mod7 where
  lit a = Mod7 (mod a 7)
  add (Mod7 a) (Mod7 b) = Mod7 (mod (a + b) 7)
  mul (Mod7 a) (Mod7 b) = Mod7 (mod (a * b) 7)

testExp :: Expr a => Maybe a
testExp = parseExp lit add mul "(3 * -4) + 5"

testInteger = testExp :: Maybe Integer
testBool    = testExp :: Maybe Bool
testMM      = testExp :: Maybe MinMax
testSat     = testExp :: Maybe Mod7

-- Ex 5
instance Expr StackVM.Program where
  lit x = [StackVM.PushI x]
  add x y = x ++ y ++ [StackVM.Add]
  mul x y = x ++ y ++ [StackVM.Mul]

compile :: String -> Maybe StackVM.Program
compile = parseExp lit add mul

