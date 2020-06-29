import Parser

import Data.Bits
import Data.Char

--- Functions to perform the bitwise operations that we need
flipSecondBit a = (a .&. 170) .|. ((a .&. 85) `xor` 85)

rotateOneBit a = (a `div` 2) + (128 * (a `mod` 2))

flipAndRotate a = rotateOneBit (flipSecondBit a)

--- We can use this function to convert on Ascii character into our appropriately modified byte and then converted it to the proper character
ascii85DoFlip :: Char -> Char
ascii85DoFlip c = chr ( flipAndRotate (ord c))
  

main = do
  encoded <- getLine
  let decoded = Parser.parseToString encoded
  let decodedApplyFlip = map ascii85DoFlip decoded
  putStrLn decodedApplyFlip
