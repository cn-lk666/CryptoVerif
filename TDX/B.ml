open Base
open Crypto

type type_oracle_c5 = unit -> unit

let token = ref false

let init () =
  if !token then raise Bad_call;
  token := true;

  (
   begin
     let token_1 = ref true in
     fun () ->
       if (!token_1) then
       begin
         token_1 := false;
         if exists_in_table "keytbl"
           (function
               | [tvar_4; tvar_3] -> begin
         
                 let var_x_0 = (exc_bad_file "keytbl" id tvar_4) in 
                 let var_y_0 = (exc_bad_file "keytbl" (size_from 16) tvar_3) in 
                 if (((=) var_x_0 (get_hostname ()))) then () else raise Match_fail
                 end
               | _ -> raise (Bad_file "keytbl")) then begin 
           ()
         end else begin 
           raise Match_fail
         end
       end
       else raise Bad_call
   end)