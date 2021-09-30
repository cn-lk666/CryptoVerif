open Base
open Crypto

type type_oracle_c3 = unit -> unit

let token = ref false

let init () =
  if !token then raise Bad_call;
  token := true;

  (
   begin
     let token_5 = ref true in
     fun () ->
       if (!token_5) then
       begin
         token_5 := false;
         let var_session_5fkey_0 = (rand_string 16) () in
         insert_in_table "keytbl" [(id ((get_hostname ()))); (id (var_session_5fkey_0))];

         ()
       end
       else raise Bad_call
   end)