open Base
open Crypto

type type_oracle_c6 = unit -> unit

let token = ref false

let init () =
  if !token then raise Bad_call;
  token := true;

  let var_hk1_0= exc_bad_file "Impl_hk1" (size_from 16) (input_string_from_file "Impl_hk1") in
  (
   begin
     let token_6 = ref true in
     fun () ->
       if (!token_6) then
       begin
         token_6 := false;
         let var_rtyp_5fTDXM_0 = (get_rtyp ()) in 
         let var_tdi_5fTDXM_0 = (get_tdi ()) in 
           output_string_to_file "Impl_tdi_TDXM" (id var_tdi_5fTDXM_0);
         let var_tdih_5fTDXM_0 = (Ssh_crypto.hash var_hk1_0 (tdi_t2bitstring var_tdi_5fTDXM_0)) in 
         let list_7 = get_from_table "mes_TD_TDXM_2"
           (function
               | [tvar_8] -> begin
         
                 let var_rdata_5fTDXM_0 = (exc_bad_file "mes_TD_TDXM_2" id tvar_8) in (var_rdata_5fTDXM_0)
                 end
               | _ -> raise (Bad_file "mes_TD_TDXM_2")) in
         if list_7 = [] then begin 
           raise Match_fail
         end else begin
           let (var_rdata_5fTDXM_0) = rand_list list_7 in
           let var_arg_5fTDXM_5fCPU_1 = (arg_TDXM_CPU_f var_rdata_5fTDXM_0 var_rtyp_5fTDXM_0 var_tdih_5fTDXM_0) in 
           let var_res4_5fTDXM_0 = (get_res ()) in 
             output_string_to_file "Impl_res4_TDXM" (id var_res4_5fTDXM_0);
           ()
         end
       end
       else raise Bad_call
   end)