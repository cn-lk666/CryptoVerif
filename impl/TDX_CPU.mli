open Base
open Crypto

type type_oracle_c8 = unit -> (type_oracle_c16)
 and type_oracle_c16 = unit -> unit
val init : unit -> (type_oracle_c8)
