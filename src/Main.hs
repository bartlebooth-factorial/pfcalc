module Main where

import Data.List.NonEmpty
import Data.Maybe (mapMaybe)
import System.Environment (getArgs)
import Text.Read (readMaybe)

import Ops

opError :: String -> String -> IO () =
  \opName msg ->
    putStrLn ("Error: operation \"" ++ opName ++ "\" " ++ msg)

main :: IO ()
main =
  do args <- getArgs
     case args of
       [] -> putStrLn "Error: no arguments given"
       op : opArgs ->
         let numericArgs :: [Integer] =
               mapMaybe (readMaybe) (opArgs)
         in case numericArgs of
           [] -> opError op "cannot be applied to no arguments"
           arg1 : argRest ->
             let args = arg1 :| argRest
                 opDo opFn = print (opFn args)
             in case op of
               "+" -> opDo opSum

               "x" -> opDo opProduct

               "/" -> opDo opDivide

               "%" -> opDo opModulus
               "mod" -> opDo opModulus

               "gcd" -> opDo opGCD

               _ -> opError op "unknown"
