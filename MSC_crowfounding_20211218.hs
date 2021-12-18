-- Author:       Roslon
-- Version:      0.0.202112181240
-- Project:      Crowfounding - first version

{-# LANGUAGE OverloadedStrings #-}

module Example where

import       Language.Marlowe.Extended

main :: IO ()
main = print . pretty $ contract

invOne, invTwo, manager :: Party
invOne = "Participant 1"
invTwo = "Participant 2"
manager = "Fund"

pOne, pTwo :: ChoiceName
pOne = "Payment 1"
pTwo = "Payment 2"

expectedAmount, collectedSum :: ValueId
expectedAmount = "Plan"
collectedSum = "Collected"

pay :: ChoiceName -> Party -> ChoiceId
pay name party = ChoiceId name party

payment :: ChoiceName -> Party -> Value
payment name party  = ChoiceValue (pay name party)

choice :: ChoiceId -> Action
choice choiceCase = Choice choiceCase range

range :: [Bound]
range = [Bound 100 1000]

fundSum :: Value
fundSum = Constant 1000

deposit :: Party -> Value -> Action
deposit party value = Deposit party party ada value 

contract :: Contract
contract = Let expectedAmount fundSum
    (When
        [Case
            (choice (pay pOne invOne))
            (When
                [Case
                    (deposit invOne (payment pOne invOne))
                    (Pay
                        invOne
                        (Party manager)
                        ada
                        (AvailableMoney invOne ada )
                        (If
                            (ValueGE (payment pOne invOne) (UseValue expectedAmount) )
                            (Let collectedSum (payment pOne invOne) Close )
                            (Let collectedSum (payment pOne invOne)
                                (When
                                    [Case
                                        (choice (pay pTwo invTwo))
                                        (When
                                            [Case
                                                (deposit invTwo (payment pTwo invTwo))
                                                (Pay
                                                    invTwo
                                                    (Party manager)
                                                    ada
                                                    (AvailableMoney invTwo ada )
                                                    (Let collectedSum (AddValue (payment pOne invOne) (payment pTwo invTwo)) Close )
                                                )]
                                            15 Close 
                                        )]
                                    10 Close 
                                )
                            )
                        )
                    )]
                5 Close 
            )]
        1 Close 
    )
