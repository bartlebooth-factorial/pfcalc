module Ops where

import Data.Foldable (foldr, foldl')
import Data.List
import Data.List.NonEmpty

type Op = NonEmpty Integer -> Integer

opSum :: Op =
  foldl' (+) 0

opProduct :: Op =
  foldl' (*) 1

opDivide :: Op =
  foldr div 1

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

  \  x (product)\n\

  \  / (integer division)\n\

  \  % (modulus)\n\
  \  mod (modulus)\n\

  \  gcd (greatest common divisor)"

opError :: String -> String -> IO () =
  \opName msg ->
    putStrLn ("Error: operation \"" ++ opName ++ "\" " ++ msg)
