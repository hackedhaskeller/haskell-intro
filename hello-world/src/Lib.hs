module Lib
    ( helloWorld
    , helloName
    , helloNameNoSugar
    ) where

helloWorld :: IO ()
helloWorld = putStrLn "Hello World"

helloName :: IO ()
helloName = do
  putStrLn "What is your name?"
  name <- getLine
  putStrLn ("Hello " ++ name)


helloNameNoSugar :: IO ()
helloNameNoSugar =
  putStrLn "What is your name?" >>= \_ ->
  getLine >>= \name ->
  putStrLn ("Hello " ++ name)
