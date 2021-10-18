open Base
open Crypto

type type_oracle_c4 = unit -> (type_oracle_c12)
 and type_oracle_c12 = unit -> (unit * string)
val init : unit -> (type_oracle_c4)
