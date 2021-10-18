open Base
open Crypto

type type_oracle_c6 = unit -> (type_oracle_c10)
 and type_oracle_c10 = unit -> unit
val init : unit -> (type_oracle_c6)
