open Base
open Crypto

type type_oracle_c22 = (string) -> (unit * string)
 and type_oracle_c20 = unit -> (type_oracle_c22)
val init : unit -> (type_oracle_c20)
