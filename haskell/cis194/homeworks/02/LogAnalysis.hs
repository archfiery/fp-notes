{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where

import Log

parseMessage :: String -> LogMessage
parseMessage str = let tokens = words str in
                    case tokens of
                      ("I":ts:payload) -> LogMessage Info (read ts) (unwords payload)
                      ("W":ts:payload) -> LogMessage Warning (read ts) (unwords payload)
                      ("E":ec:ts:payload) -> LogMessage (Error (read ec)) (read ts) (unwords payload)
                      _ -> Unknown (unwords tokens)

parse :: String -> [LogMessage]
parse str = map (\a -> parseMessage a) (lines str)

insert :: LogMessage -> MessageTree -> MessageTree
insert m Leaf = Node Leaf m Leaf
insert m@(LogMessage _ ts _) (Node left v@(LogMessage _ ts1 _) right)
  | ts > ts1  = Node left v (insert m right)
  | otherwise = Node (insert m left) v right
insert _ t = t

build :: [LogMessage] -> MessageTree
build logs = foldr insert Leaf logs

inOrder :: MessageTree -> [LogMessage]
inOrder (Node l v r)  = inOrder(l) ++ v:[] ++ inOrder(r)
inOrder Leaf = []

relevant :: [LogMessage] -> [LogMessage]
relevant l = filter (\(LogMessage t _ _) -> case t of
                                              (Error ec) -> ec >= 50
                                              _          -> False) l

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong l = let messages = relevant (inOrder (build l)) in
                    map (\(LogMessage _ _ payload) -> payload) messages
