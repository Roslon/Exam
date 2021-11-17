{-  
author:     Roslon
version:    202111141922
project:    Number in words
-}

import System.Environment

-- -----------------------------------------
allNumber :: Int
allNumber = 123456
-- -----------------------------------------

ones :: [String]
ones = [""
        , "jeden "
        , "dwa "
        , "trzy "
        , "cztery "
        , "pięć "
        , "sześć "
        , "siedem "
        , "osiem "
        , "dziewięć "
        , "dziesięc "
        , "jedenaście " 
        , "dwanaście " 
        , "trzynaście "
        , "czternaście "
        , "piętnaście "
        , "szesnaście "
        , "siedemnaście "
        , "osiemanaście "
        , "dziewiętnaście "]

tens :: [String] 
tens = [""
        , "dziesięć "
        , "dwadzieścia "
        , "trzydzieści "
        , "czterdzieści "
        , "pięćdziesiąt "
        , "sześćdziesiąt "
        , "siedemdziesiąt "
        , "osiemdziesiąt "
        , "dziewięćdziesiąt "]

hundreds :: [String]   
hundreds = [""
        , "sto "
        , "dwieście "
        , "trzysta "
        , "czterysta "
        , "piećset "
        , "sześćset "
        , "siedemset "
        , "osiemset "
        , "dziewięćset "]

thAdd :: (Eq a, Num a) => a -> String
thAdd n | n  == 0 = ""
        | n  == 1 = "tysiąc "
        | n  == 2 = "tysiące "
        | n  == 3 = "tysiące "
        | n  == 4 = "tysiące "
        | otherwise = "tysięcy "

-- jedności i naście
lastNumberO :: Int
lastNumberO = if (rem allNumber 100) > 19
        then rem allNumber 10
        else rem allNumber 100

-- część bez jedności
firstNumberO :: Int
firstNumberO = div allNumber 10

-- liczba dziesiątek
lastNumberT :: Int
lastNumberT = if (rem firstNumberO 10) == 1 
        then 0
        else rem firstNumberO 10

-- liczba bez dziesiątek
firstNumberT :: Int
firstNumberT = div firstNumberO 10 

-- liczba setek
lastNumberH :: Int
lastNumberH = rem firstNumberT 10

-- liczba bez setek
firstNumberH :: Int
firstNumberH = div firstNumberT 10

--liczba pojedynczych tysięcy
lastNumberTh :: Int
lastNumberTh = if (rem firstNumberH 100) >=19
        then rem firstNumberH 10
        else rem firstNumberH 100

-- dziesiątki tysięcy
firstNumberTh :: Int
firstNumberTh = div firstNumberH 10

-- dzisiątki tysięcy
lastNumberTTh :: Int
lastNumberTTh = if (rem firstNumberTh 10) == 1 
     then 0
     else rem firstNumberTh 10

-- setki tysięcy
firstNumberTTh :: Int  
firstNumberTTh = div firstNumberTh 10


main :: IO ()
main = do 
  
       putStrLn $
        "\n"
        ++ hundreds !! firstNumberTTh
        ++ tens !! lastNumberTTh 
        ++ ones !! lastNumberTh  
        ++ thAdd (if lastNumberTh == 0
                then lastNumberTTh + firstNumberTTh
                else lastNumberTh)
        ++ hundreds !! lastNumberH 
        ++ tens !! lastNumberT 
        ++ ones !! lastNumberO
        ++ "\n"   
  
   
