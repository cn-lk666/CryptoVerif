open Base
open Crypto

type type_oracle_c12 = unit -> (unit * string)

let token = ref false

let init () =
  if !token then raise Bad_call;
  token := true;

  (
   begin
     let token_12 = ref true in
     fun () ->
       if (!token_12) then
       begin
         token_12 := false;
         let list_13 = get_from_table "mes_TDXM_TD_8"
           (function
               | [tvar_14] -> begin
         
                 let var_tdr_5fTD_0 = (exc_bad_file "mes_TDXM_TD_8" id tvar_14) in (var_tdr_5fTD_0)
                 end
               | _ -> raise (Bad_file "mes_TDXM_TD_8")) in
         if list_13 = [] then begin 
           raise Match_fail
         end else begin
           let (var_tdr_5fTD_0) = rand_list list_13 in
           (
             ()
             ,var_tdr_5fTD_0
           )
         end
       end
       else raise Bad_call
   end)