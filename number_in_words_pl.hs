{-  
author:     Roslon
version:    202111051535
project:    Number in words
-}

-- -----------------------------------------
allNumber = 999999
-- -----------------------------------------

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


thAdd n | n  == 0 = ""
        | n  == 1 = "tysiąc "
        | n  == 2 = "tysiące "
        | otherwise = "tysięcy "

lastNumberO = if (rem allNumber 100) >= 19
        then rem allNumber 10
        else rem allNumber 100
firstNumberO = div allNumber 10
lastNumberT = if (rem firstNumberO 10) == 1 
        then 0
        else rem firstNumberO 10
firstNumberT = div firstNumberO 10 
lastNumberH = rem firstNumberT 10
firstNumberH = div firstNumberT 10
lastNumberTh = if (rem firstNumberH 100) >=19
        then rem firstNumberH 10
        else rem firstNumberH 100
firstNumberTh = div firstNumberH 10
lastNumberTTh = if (rem firstNumberTh 10) == 1 
     then 0
     else rem firstNumberTh 10
firstNumberTTh = div firstNumberTh 10


main :: IO ()

main = do 
     
    putStrLn $
        "\n"
        ++ hundreds !! firstNumberTTh
        ++ tens !! lastNumberTTh 
        ++ ones !! lastNumberTh  
        ++ thAdd (lastNumberTh)
        ++ hundreds !! lastNumberH 
        ++ tens !! lastNumberT 
        ++ ones !! lastNumberO
        ++ "\n"
    
