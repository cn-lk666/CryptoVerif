# Symbolic and Computational Analysis for TDX
## Symbolic Analysis with Tamarin
### 1. Installation
We can manually install dependencies and compile from source.
Tamarin requires Haskell Stack to build and GraphViz and Maude 2.7.1 (or newer) to run. The easiest way to install these is
```
brew install tamarin-prover/tap/maude graphviz haskell-stack
```
Compile from [source](https://github.com/tamarin-prover/tamarin-prover/releases)
```
wget https://github.com/tamarin-prover/tamarin-prover/archive/refs/tags/1.6.0.tar.gz
tar -zxvf 1.6.0.tar.gz
cd tamarin-prover-1.6.0
make
```
But there some failed informations sometimes, we can use the easiet way to install tamarin:
```
brew install tamarin-prover/tap/tamarin-prover
```
We need to add a path in the $PATH
```
PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
```
### 2. Tamarin Models for TDX

### 3. Understanding the results

## Computational Analysis with CryptoVerif
***
### 1. Installation
We can download CryptoVerif from [here]("https://prosecco.gforge.inria.fr/personal/bblanche/cryptoverif/cryptoverif.html").
When we download the sources and go into the file, we can build it.
```
tar -zxvf cryptoverif2.04.tar.gz
cd cryptoverif2.04
./build
```
### 2. CryptoVerif Models for TDX

### 3. Understanding the results

## Generation of Implementation from the formally verified model
***
## Symbolic and Computational Analysis with F*
***