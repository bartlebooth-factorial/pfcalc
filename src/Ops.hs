module Ops where

import Data.Foldable (foldl', foldr')
import Data.List
import Data.List.NonEmpty

type Op = NonEmpty Integer -> Integer

opSum :: Op =
  foldl' (+) 0

opSubtract :: Op =
  \nums ->
    case nums of
      a :| [] -> a
      a :| b : cs ->
        opSubtract $! ((a - b) :| cs)
        -- need strict eval with "$!" so that subtractions don't cancel into
        -- additions

opProduct :: Op =
  foldl' (*) 1

opDivide :: Op =
  foldr' div 1

opModulus :: Op =
  \nums ->
    case nums of
      a :| [] -> a
      a :| b : cs ->
        opModulus $ (a `mod` b) :| cs
    
opGCD :: Op =
  foldl' euc 0
  where
    euc a b =
 -- euclidean algorithm
      if b == 0 then a
      else euc b (a `mod` b)


opsDescription :: String =
  "Valid operations are:\n\
  \  + (sum)\n\

  \  - (subtraction)\n\

  \  x (product)\n\

  \  / (integer division)\n\

  \  % (modulus)\n\
  \  mod (modulus)\n\

  \  gcd (greatest common divisor)"

opError :: String -> String -> IO () =
  \opName msg ->
    putStrLn ("Error: operation \"" ++ opName ++ "\" " ++ msg)
