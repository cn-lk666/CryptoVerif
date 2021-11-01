#!/bin/sh

CRYPTOKIT="-linkpkg -package cryptokit"

ocamlfind ocamlopt $CRYPTOKIT -I .. -o test base.mli base.ml  crypto.mli crypto.ml keygen.mli  keygen.ml TDX_Ch.mli TDX_Ch.ml TDX_CPU.mli TDX_CPU.ml TDX_QE.mli TDX_QE.ml TDX_TD.mli TDX_TD.ml TDX_TDXM.mli TDX_TDXM.ml test.ml
