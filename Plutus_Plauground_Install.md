# Plutus Playground installation in Windows 10/11

## In Windows 10/11 we run WSL first.
We choose Ubuntu 20.4 and follow the instructions:

https://docs.microsoft.com/en-us/windows/wsl/install

We make:
```
Ubuntu update
Ubuntu upgrade
```

Next steps:
```
sudo apt install cabal-install
curl -L  https://nixos.org/nix/install |sh
```
WSL restart

If there is not (or probably not) we create the file:

> /etc/nix/nix.conf

and enter:

*substituters = https://hydra.iohk.io https://iohk.cachix.org https://cache.nixos.org/
trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= iohk.cachix.org-1: DpRUyj7h7V830dp / i6Nti + NEO2 / nhbl. nixos.org-1: 6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY =*

If someone is unfamiliar with Unix then:
```
sudo vim nix.conf
```
> : wq - save and exit

> : q! - goes out without writing

### And we come to the point:
```
git clone https://github.com/input-output-hk/plutus-apps
git clone https://github.com/input-output-hk/plutus-pioneer-program
```
We are looking for the 

> cabal.project 

file, and in it:

> source-repository-package

> type: git

> location: https://github.com/input-output-hk/plutus-apps.git

> tag: 41149926c108c71831cfe8d244c83b0ee4bf5c8a*

The tag value is important. 

We copy this value.

We make:
```
git checkout 41149926c108c71831cfe8d244c83b0ee4bf5c8a
nix-shell 
```
(first run about 20 minutes)

We go to the directory:

> /plutus-pioneer-program//code/week01
> 
We make:
```
cabal update
cabal build 
```
(may take more than 20 minutes)
```
build-and-serve-docs 
```
(a few minutes, but not as long as the previous command)

And we have documentation on the local server at:

http://127.0.0.1:8002/haddock

We open a new console

We make 
```
nix-shell
```
We go to the directory:

> plutus-playground-client/
> 
We make:
```
plutus-playground-server
```

We open a new console

We make 
```
nix-shell
```
We go to the directory:

> plutus-playground-client/

We make:
```
npm start 
```
And if everything goes according to plan, we have a working Plutus Palyground server at:

https://127.0.0.1:8009
