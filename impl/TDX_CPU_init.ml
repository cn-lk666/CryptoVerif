open Base
open Crypto

type type_oracle_c8 = unit -> unit

let token = ref false

let init () =
  if !token then raise Bad_call;
  token := true;

  let var_hk2_0= exc_bad_file "Impl_hk2" (size_from 16) (input_string_from_file "Impl_hk2") in
  let var_mkey_0= exc_bad_file "Impl_mkey" (size_from 16) (input_string_from_file "Impl_mkey") in
  (
   begin
     let token_36 = ref true in
     fun () ->
       if (!token_36) then
       begin
         token_36 := false;
         let list_37 = get_from_table "mes_TDXM_CPU_4"
           (function
               | [tvar_38] -> begin
         
                 let var_arg_5fTDXM_5fCPU_2 = (exc_bad_file "mes_TDXM_CPU_4" id tvar_38) in (var_arg_5fTDXM_5fCPU_2)
                 end
               | _ -> raise (Bad_file "mes_TDXM_CPU_4")) in
         if list_37 = [] then begin 
           raise Match_fail
         end else begin
           let (var_arg_5fTDXM_5fCPU_2) = rand_list list_37 in
           try
             let bvar_39=var_arg_5fTDXM_5fCPU_2 in
             let (var_rdata_5fCPU_0,var_rtyp_5fCPU_0,var_tdih_5fCPU_0)=inv_arg_TDXM_CPU_f bvar_39 in
             if true then begin 
               let var_res1_5fCPU_0 = (get_res ()) in 
               let var_csvn_5fCPU_0 = (get_csvn ()) in 
               let var_tcbi_5fCPU_0 = (get_tcbi ()) in 
               let var_res2_5fCPU_0 = (get_res ()) in 
               let var_tcbh_5fCPU_0 = (Ssh_crypto.hash var_hk2_0 (tcbi_t2bitstring var_tcbi_5fCPU_0)) in 
               let var_rms_5fwithout_5fmac_5fCPU_0 = (rms_without_mac_f var_rtyp_5fCPU_0 var_res1_5fCPU_0 var_csvn_5fCPU_0 var_tdih_5fCPU_0 var_tcbh_5fCPU_0 var_rdata_5fCPU_0 var_res2_5fCPU_0) in 
               let var_mac_5fCPU_0 = ((mac Cryptokit.MAC.hmac_sha1) (rms_without_mac_t2bitstring var_rms_5fwithout_5fmac_5fCPU_0) var_mkey_0) in 
               let var_rms_5fCPU_0 = (rms_f var_rms_5fwithout_5fmac_5fCPU_0 var_mac_5fCPU_0) in 
               let var_smr_5fCPU_0 = (smr_F var_rms_5fCPU_0 var_tcbi_5fCPU_0) in 
               
               insert_in_table "mes_CPU_TDXM_6" [(id (var_smr_5fCPU_0))];

               ()
             end
             else
               raise Match_fail
           with Match_fail -> 
             raise Match_fail
         end
       end
       else raise Bad_call
   end)