import Parser

import Data.Char
import Data.Bits

-- function to convert an integer to its binary bit representation
nthBit a n = (a .&. (2 ^ n)) `div` (2 ^ n) 

toBits :: Int ->  [Int]
toBits x = do
  let digits_pre = [7, 6, 5, 4, 3, 2, 1, 0]
  map (nthBit x) digits_pre

-- function to check the proper parity of a byte
-- the parity bit of a bit ensures that the number of 1's is even, so we must simply check that the number of ones in the byte is zero

properParity :: Int -> Bool
properParity x = do
  let numberOfOnes = length (filter (\x -> x==1) (toBits x))
  (numberOfOnes `mod` 2) == 0
