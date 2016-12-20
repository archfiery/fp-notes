{-# LANGUAGE FlexibleInstances #-}

module VarExprT where

import           Calc
import           Control.Applicative
import           Data.Map            (Map)
import qualified Data.Map            as M

data VarExprT = VarExprT String Integer
  deriving (Show, Eq)

class HasVars a where
  var :: String -> a

instance Expr VarExprT where
  lit = VarExprT ""
  add (VarExprT _ x) (VarExprT _ y) = VarExprT "" (x + y)
  mul (VarExprT _ x) (VarExprT _ y) = VarExprT "" (x * y)

instance HasVars VarExprT  where
  var x = VarExprT x 0

instance HasVars (M.Map String Integer -> Maybe Integer) where
  var = M.lookup

instance Expr (M.Map String Integer -> Maybe Integer) where
  lit a = \_ -> Just a
  add a b = \k -> (+) <$> (a k) <*> (b k)
  mul a b = \k -> (*) <$> (a k) <*> (b k)

withVars ::[(String, Integer)]
         -> (M.Map String Integer -> Maybe Integer)
         -> Maybe Integer
withVars vs exp = exp $ M.fromList vs

