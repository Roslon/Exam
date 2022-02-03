# Restart the environment

#### When we have the environment installed and only turned it off, we can shorten the start-up procedure to a minimum.

## Documentation:
The first Ubuntu console:

We run:
```
nix-shell
```
in the folder:
> / plutus-pioneer-program / code / week0X
> 
we run:
```
cabal update
```
and then
```
cabal build
```
In the folder:
> /myplutus/plutus-apps/
> 
We run:
```
build-and-serve-docs
```
we should find working documentation at:
> http://127.0.0.1:8002/haddock


## Plutus Playground:
Second console:

We run :
```
nix-shell
```
In the folder:
> /plutus-apps/plutus-playground-client/

we run:
```
plutus-playground-server
```
in the third console we run :
```
nix-shell
```
In the folder:
> /plutus-apps/plutus-playground-client/
> 
we run:
```
npm start
```
We should working Plutus Playground at:
> http://127.0.0.1:8009/

