open Base
open Crypto

type type_oracle_c18 = unit -> (unit * string)
 and type_oracle_c14 = (string) -> (type_oracle_c18)
val init : unit -> (type_oracle_c14)
