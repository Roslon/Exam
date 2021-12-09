-- Copyright:       Roslon
-- Version:         0.0.202112091835
-- Project:         Marlowe Smart Contract - 
-- Licence:         ISC
--

{-# LANGUAGE OverloadedStrings #-}

module Marlowe.First where
import System.Random (randomRIO)

import  Language.Marlowe.Extended

main :: IO ()
main = print . pretty $ contract


szuler, gracz :: Party
szuler = "Szuler"
gracz   = "Gracz"

depositG :: Value
depositG = Constant 100

depositS :: Value
depositS = Constant 1000

blind :: Value
blind = Constant 1

bet :: Value
bet = Constant 5

rzutG :: ChoiceId
rzutG = ChoiceId "Rzut gracza" gracz

rzutS :: ChoiceId
rzutS = ChoiceId "Rzut szulera" szuler

contract :: Contract
contract = When
    [Case
        (Deposit
            gracz
            gracz
            ada
            depositG
        )
        (When
            [Case
                (Deposit
                    szuler
                    szuler
                    ada
                    depositS
                )
                (Pay
                    gracz
                    (Party szuler)
                    ada
                    blind
                    (When
                        [Case
                            (Choice rzutG [Bound 1 6] )
                            (Let
                                "Kostka gracza"
                                (ChoiceValue rzutG)
                                (When
                                    [Case
                                        (Choice rzutS [Bound 1 6] )
                                        (Let
                                            "Kostka szulera"
                                            (ChoiceValue rzutS)
                                            (If
                                                (ValueEQ (ChoiceValue rzutS) (ChoiceValue rzutG)
                                            )
                                                (Pay
                                                    szuler
                                                    (Party gracz)
                                                    ada (Scale (1%50) (AvailableMoney szuler ada )
                                                    )
                                                    Close 
                                                )
                                                (If
                                                    (ValueGT (ChoiceValue rzutG) (ChoiceValue rzutS) )
                                                    (Pay
                                                        szuler
                                                        (Party gracz)
                                                        ada
                                                        bet
                                                        Close 
                                                    )
                                                    (Pay
                                                        gracz
                                                        (Party szuler)
                                                        ada
                                                        bet
                                                        Close 
                                                    )
                                                )
                                            )
                                        )]
                                    15 Close 
                                )
                            )]
                        10 Close 
                    )
                )]
            6 Close 
        )]
    5 Close
