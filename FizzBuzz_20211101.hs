{-  
Version:   2021110111943
Project: FizzBuzz
-}

fizz :: Int -> String
fizz n | n `rem` 15 == 0 = "FizzBuzz"
       | n `rem` 5 == 0  = "Fizz"
       | n `rem` 3 == 0 = "Buzz"
       | otherwise = show n

main :: IO ()

main = mapM_ putStrLn $ map fizz [1..20]
