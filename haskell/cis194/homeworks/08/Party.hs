module Party where

import           Data.Tree
import           Employee

glCons :: Employee -> GuestList -> GuestList
glCons e@(Emp n f) (GL l tf) = GL (e:l) (tf + f)

moreFun :: GuestList -> GuestList -> GuestList
moreFun l@(GL _ a) r@(GL _ b) = if a > b then l else r

-- Node :: a -> Forest a -> Tree a
treeFold :: (a -> [b] -> b) -> b -> Tree a -> b
treeFold f init (Node e sub) = f e (map (treeFold f init) sub)

combineGLs :: Employee -> [GuestList] -> GuestList
combineGLs = undefined

nextLevel :: Employee -> [(GuestList, GuestList)]
             -> (GuestList, GuestList)
nextLevel = undefined


