module Parser where
-- This file contains methods for the purpose of parsing a stream of ascii85 encrypted text from standard input into unencrypted ascii text

import Data.Char (ord, chr)

-- Data Types and Functions representing encoded 5-tuples of data
toBase256Digits :: Int -> (Int, Int, Int, Int)
toBase256Digits n = ( n `div` (256^3), (n `mod` (256 ^ 3)) `div` (256^2), (n `mod` (256^2)) `div` 256, n `mod` 256)

coallesceBase85 :: (Int, Int, Int, Int, Int) -> Int
coallesceBase85 (a, b, c, d, e) = (a * (85 ^ 4)) + (b * (85 ^ 3)) + (c * (85^2)) + (d * 85) + e

base85To256 :: (Int, Int, Int, Int, Int) -> (Int, Int, Int, Int)
base85To256 digits = toBase256Digits (coallesceBase85 digits)

charToBase85Digit :: Char -> Int
charToBase85Digit c = (ord c) - 33

map5Tuple :: (a -> b) -> (a, a, a, a, a) -> (b, b, b, b, b)
map5Tuple f (a1, a2, a3, a4, a5) = (f a1, f a2, f a3, f a4, f a5)

ascii85CharsToDigits :: (Char, Char, Char, Char, Char) -> (Int, Int, Int, Int, Int)
ascii85CharsToDigits chars = map5Tuple charToBase85Digit chars

map4Tuple :: (a -> b) -> (a, a, a, a) -> (b, b, b, b)
map4Tuple f (a1, a2, a3, a4) = (f a1, f a2, f a3, f a4)

base256DigitsToChars :: (Int, Int, Int, Int) -> (Char, Char, Char, Char)
base256DigitsToChars ints = map4Tuple chr ints

ascii85DecodeSet :: (Char, Char, Char, Char, Char) -> (Char, Char, Char, Char)
ascii85DecodeSet ascii85Digits = base256DigitsToChars (base85To256 (ascii85CharsToDigits ascii85Digits))

-- Now, we will deal with converting a string into a list of ascii char 5tuples so that they can be processed
parseTo5Tuples :: [Char] -> [(Char, Char, Char, Char, Char)]
parseTo5Tuples s = case s of
  [] -> []
  -- The character z is shorthand for all zero bytes
  'z' : xs -> ('!', '!', '!', '!', '!') : (parseTo5Tuples xs)
  c1 : c2 : c3 : c4 : c5 : xs -> (c1, c2, c3, c4, c5) : (parseTo5Tuples xs)
  -- Any extra bytes are padded out with u's
  c1 : c2 : c3 : c4 : [] -> (c1, c2, c3, c4, 'u') : []
  c1 : c2 : c3 : [] -> (c1, c2, c3, 'u', 'u') : []
  c1 : c2 : [] -> (c1, c2, 'u', 'u', 'u') : []
  c1 : [] -> (c1, 'u', 'u', 'u', 'u') : []

ascii85ToNormalAsciiWithPadding :: [Char] -> [(Char, Char, Char, Char)]
ascii85ToNormalAsciiWithPadding s = map ascii85DecodeSet (parseTo5Tuples s)

ascii4TuplesToString :: [(Char, Char, Char, Char)] -> [Char]
ascii4TuplesToString s = case s of
  [] -> []
  (c1, c2, c3, c4) : xs -> c1 : c2 : c3 : c4 : (ascii4TuplesToString xs)

parseToString :: [Char] -> [Char]
parseToString s = ascii4TuplesToString (ascii85ToNormalAsciiWithPadding s)

