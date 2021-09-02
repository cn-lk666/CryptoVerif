# Symbolic and Computational Analysis for TDX
***
## Symbolic Analysis with Tamarin
***
### Installation
http://tamarin-prover.github.io/"Download Tamarin from the Tamarin website"
We can download binaries directly from GitHub and manually install dependencies.
#### Manually install dependencies
Tamarin requires Haskell Stack to build and GraphViz and Maude 2.7.1 (or newer) to run. The easiest way to install these is
    :brew install tamarin-prover/tap/maude graphviz haskell-stack
#### Download binaries and install
We can download binaries directly from https://github.com/tamarin-prover/tamarin-prover/releases"here"
    :wget https://github.com/tamarin-prover/tamarin-prover/releases/download/1.6.0/tamarin-prover-1.6.0-linux64-ubuntu.tar.gz
    :tar -zxf tamarin-prover-1.6.0-linux64-ubuntu.tar.gz
    :cd tamarin-prover-1.6.0-linux64-ubuntu
    :./build
### Tamarin Models for TDX

### Understanding the results

## Computational Analysis with CryptoVerif
***
### Installation
https://prosecco.gforge.inria.fr/personal/bblanche/cryptoverif/ "Download CryptoVerif  from the CryptoVerif website"
We can download CryptoVerif from "https://prosecco.gforge.inria.fr/personal/bblanche/cryptoverif/cryptoverif.html"here.
When we download the sources and cd the file, we can build it.
    :tar -zxf cryptoverif2.04.tar.gz
    :cd cryptoverif2.04
    :./build
### CryptoVerif Models for TDX

### Understanding the results

## Generation of Implementation from the formally verified model
***
## Symbolic and Computational Analysis with F*
***