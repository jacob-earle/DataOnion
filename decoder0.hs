import Parser

main = do
  encoded <- getLine
  let decoded = Parser.parseToString encoded
  putStrLn decoded
