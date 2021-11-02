{-  
Version:   202111021712
Project: FizzBuzz
-}
-- -----------------------------------------
fizz :: Int -> String
fizz n | rem n 15 == 0 = "FizzBuzz"
       | rem n 5 == 0  = "Fizz"
       | rem n 3 == 0 = "Buzz"
       | otherwise = show n

main :: IO ()

main = mapM_ putStrLn $ map fizz [1..20000]
