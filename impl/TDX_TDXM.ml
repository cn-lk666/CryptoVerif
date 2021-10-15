open Base
open Crypto

type type_oracle_c10 = unit -> unit

let token = ref false

let init () =
  if !token then raise Bad_call;
  token := true;

  let var_res4_5fTDXM_0= exc_bad_file "Impl_res4_TDXM" id (input_string_from_file "Impl_res4_TDXM") in
  let var_tdi_5fTDXM_0= exc_bad_file "Impl_tdi_TDXM" id (input_string_from_file "Impl_tdi_TDXM") in
  (
   begin
     let token_9 = ref true in
     fun () ->
       if (!token_9) then
       begin
         token_9 := false;
         let list_10 = get_from_table "mes_CPU_TDXM_6"
           (function
               | [tvar_11] -> begin
         
                 let var_smr_5fTDXM_0 = (exc_bad_file "mes_CPU_TDXM_6" id tvar_11) in (var_smr_5fTDXM_0)
                 end
               | _ -> raise (Bad_file "mes_CPU_TDXM_6")) in
         if list_10 = [] then begin 
           raise Match_fail
         end else begin
           let (var_smr_5fTDXM_0) = rand_list list_10 in
           
           let var_tdr_5fTDXM_1 = (tdr_f var_smr_5fTDXM_0 var_res4_5fTDXM_0 var_tdi_5fTDXM_0) in 
           
           insert_in_table "mes_TDXM_TD_8" [(id (var_tdr_5fTDXM_1))];

           ()
         end
       end
       else raise Bad_call
   end)