module Main where

import Data.List.NonEmpty
import Data.Maybe (mapMaybe)
import System.Environment (getArgs)
import Text.Read (readMaybe)

import Ops

main :: IO ()
main =
  do args <- getArgs
     case args of
       [] -> do putStrLn "Error: no arguments given"
                putStrLn opsDescription
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

               "-" -> opDo opSubtract

               "x" -> opDo opProduct

               "/" -> opDo opDivide

               "%" -> opDo opModulus
               "mod" -> opDo opModulus

               "gcd" -> opDo opGCD

               _ -> do opError op "unknown"
                       putStrLn opsDescription
