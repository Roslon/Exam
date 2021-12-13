-- Copyright:       Roslon
-- Version:         0.0.202112131858
-- Project:         Investment - short version

{-# LANGUAGE OverloadedStrings #-}

module Example where

import       Language.Marlowe.Extended

main :: IO ()
main = print . pretty $ contract

inv, fund, kraken :: Party
inv = "Investor"
fund = "Fund"
kraken ="kraken"

toInv, autoAdaUsd :: ChoiceName
toInv = "Total to be invested"
autoAdaUsd = "inv-adausdt"

adaUsd, amount :: ChoiceId
adaUsd = ChoiceId autoAdaUsd kraken
amount = ChoiceId toInv inv

choiceAdaUsd, choiceAmount :: Value
choiceAdaUsd = ChoiceValue (adaUsd)
choiceAmount = ChoiceValue (amount)

usd :: Token
usd = Token "0000" "85bb65ff"

range :: Bound
range = Bound 100 10000000000000

contract :: Contract
contract = When
    [Case
        (Choice amount [range] )
        (When
            [Case
                (Deposit
                    inv
                    inv
                    usd
                    choiceAmount
                )
                (When
                    [Case
                        (Choice adaUsd [range] )
                        (Let
                            "Total ADA invested"
                            -- information to investor
                            (Scale (1%100000000) (MulValue choiceAmount choiceAdaUsd )
                            )
                            (Pay
                                inv
                                (Party fund)
                                usd
                                choiceAmount
                                Close 
                            )
                        )]
                    30 Close 
                )]
            20 Close 
        )]
    10 Close 
