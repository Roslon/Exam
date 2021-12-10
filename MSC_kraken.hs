-- Copyright:       Roslon
-- Version:         0.0.202112102100
-- Project:         Exchange - Kraken USD/ADA
-- Licence:         ISC

-- inv-adausdt USD/ADA
-- dir-adausdt ADA/USD

{-# LANGUAGE OverloadedStrings #-}
module Example where

import           Language.Marlowe.Extended

main :: IO ()
main = print . pretty $ contract

kraken, exchange, client :: Party
kraken = "kraken"
exchange = "Exchange"
client = "Client"

adaUsd, amount :: ChoiceId
adaUsd = ChoiceId "inv-adausdt" kraken
amount = ChoiceId "Amount" client

usd :: Token
usd = Token "0000" "85bb65ff"

contract :: Contract
contract = When
    [Case
        (Choice amount  [Bound 10 1000000] )
        (When
            [Case
                (Deposit
                    client
                    client
                    usd
                    (ChoiceValue amount )
                )
                (Pay
                    client
                    (Party exchange)
                    usd
                    (Cond
                        (ValueLT
                            (Scale (1%100) (AvailableMoney client usd ) )
                            (Constant 1)
                        )
                        (Constant 1)
                        (Scale (1%100) (AvailableMoney client usd ) )
                    )
                    (When
                        [Case
                            (Choice adaUsd [Bound 1000000 10000000000] )
                            (When
                                [Case
                                    (Deposit
                                        exchange
                                        exchange
                                        ada
                                        (Scale
                                            (1%100000000)
                                            (MulValue
                                                (ChoiceValue adaUsd)
                                                (AvailableMoney client usd )
                                            )
                                        )
                                    )
                                    (Pay
                                        client
                                        (Party exchange)
                                        usd
                                        (AvailableMoney client usd )
                                        (Pay
                                            exchange
                                            (Party client)
                                            ada
                                            (AvailableMoney exchange ada )
                                            Close 
                                        )
                                    )]
                                12 Close 
                            )]
                        11 Close 
                    )
                )]
            10 Close 
        )]
    5 Close 
