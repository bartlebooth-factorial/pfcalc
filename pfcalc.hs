import Data.Foldable
import Data.Maybe (mapMaybe)
import System.Environment
import Text.Read (readMaybe)

opSum :: [Integer] -> Integer
opSum = foldl' (+) 0

opProduct :: [Integer] -> Integer
opProduct = foldl' (*) 1

opError :: String -> String -> IO ()
opError opName msg =
  putStrLn ("Error: operation \"" ++ opName ++ "\" " ++ msg)

main :: IO ()
main =
  do args <- getArgs
     case args of
       [] -> putStrLn "Error: no arguments given"
       [op] -> opError op "cannot be applied to no arguments"
       op : opArgs ->
         let numericArgs :: [Integer] = mapMaybe (readMaybe) opArgs
             opDo opFn = print (opFn numericArgs)
         in case op of
              "+" -> opDo opSum
              "x" -> opDo opProduct
              _ -> opError op "unknown"
