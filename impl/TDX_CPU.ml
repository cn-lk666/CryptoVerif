open Base
open Crypto

type type_oracle_c16 = unit -> unit

let token = ref false

let init () =
  if !token then raise Bad_call;
  token := true;

  let var_mkey_0= exc_bad_file "Impl_mkey" (size_from 16) (input_string_from_file "Impl_mkey") in
  (
   begin
     let token_40 = ref true in
     fun () ->
       if (!token_40) then
       begin
         token_40 := false;
         let list_41 = get_from_table "mes_QE_CPU_12"
           (function
               | [tvar_42] -> begin
         
                 let var_rms_5fQE_5fto_5fCPU_0 = (exc_bad_file "mes_QE_CPU_12" id tvar_42) in (var_rms_5fQE_5fto_5fCPU_0)
                 end
               | _ -> raise (Bad_file "mes_QE_CPU_12")) in
         if list_41 = [] then begin 
           raise Match_fail
         end else begin
           let (var_rms_5fQE_5fto_5fCPU_0) = rand_list list_41 in
           try
             let bvar_43=var_rms_5fQE_5fto_5fCPU_0 in
             let (var_rms_5fwithout_5fmac_5fQE_5fto_5fCPU_0,var_mac_5fQE_5fto_5fCPU_0)=inv_rms_f bvar_43 in
             if true then begin 
               if ((mac_check Cryptokit.MAC.hmac_sha1) (rms_without_mac_t2bitstring var_rms_5fwithout_5fmac_5fQE_5fto_5fCPU_0) var_mkey_0 var_mac_5fQE_5fto_5fCPU_0) then
               begin
                 let var_rms_5fwithout_5fmac_5ffrom_5fCPU_1 = var_rms_5fwithout_5fmac_5fQE_5fto_5fCPU_0 in 
                 ()
               end
               else
               begin
                 raise Match_fail
               end
             end
             else
               raise Match_fail
           with Match_fail -> 
             raise Match_fail
         end
       end
       else raise Bad_call
   end)