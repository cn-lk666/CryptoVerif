open Base
open Crypto

type type_oracle_c8 = unit -> (type_oracle_c16)
 and type_oracle_c16 = unit -> unit

let token = ref false

let init () =
  if !token then raise Bad_call;
  token := true;

  let var_hk2_0= exc_bad_file "Impl_hk2" (fun _ -> ()) (input_string_from_file "Impl_hk2") in
  let var_mkey_0= exc_bad_file "Impl_mkey" (size_from 8) (input_string_from_file "Impl_mkey") in
  (
   begin
     let token_34 = ref true in
     fun () ->
       if (!token_34) then
       begin
         token_34 := false;
         let list_35 = get_from_table "mes_TDXM_CPU_4"
           (function
               | [tvar_36] -> begin
         
                 let var_arg_5fTDXM_5fCPU_2 = (exc_bad_file "mes_TDXM_CPU_4" id tvar_36) in (var_arg_5fTDXM_5fCPU_2)
                 end
               | _ -> raise (Bad_file "mes_TDXM_CPU_4")) in
         if list_35 = [] then begin 
           raise Match_fail
         end else begin
           let (var_arg_5fTDXM_5fCPU_2) = rand_list list_35 in
           try
             let bvar_37=var_arg_5fTDXM_5fCPU_2 in
             let (var_rdata_5fCPU_0,var_rtyp_5fCPU_0,var_tdih_5fCPU_0)=inv_arg_TDXM_CPU_f bvar_37 in
             if true then begin 
               let var_res1_5fCPU_0 = (get_res ()) in 
               let var_csvn_5fCPU_0 = (get_csvn ()) in 
               let var_tcbi_5fCPU_0 = (get_tcbi ()) in 
               let var_res2_5fCPU_0 = (get_res ()) in 
               let var_tcbh_5fCPU_0 = (Crypto.hash var_hk2_0 (tcbi_t2bitstring var_tcbi_5fCPU_0)) in 
               let var_rms_5fwithout_5fmac_5fCPU_0 = (rms_without_mac_f var_rtyp_5fCPU_0 var_res1_5fCPU_0 var_csvn_5fCPU_0 var_tdih_5fCPU_0 var_tcbh_5fCPU_0 var_rdata_5fCPU_0 var_res2_5fCPU_0) in 
               let var_mac_5fCPU_0 = ((mac Cryptokit.MAC.hmac_sha1) (rms_without_mac_t2bitstring var_rms_5fwithout_5fmac_5fCPU_0) var_mkey_0) in 
               let var_rms_5fCPU_0 = (rms_f var_rms_5fwithout_5fmac_5fCPU_0 var_mac_5fCPU_0) in 
               let var_smr_5fCPU_0 = (smr_f var_rms_5fCPU_0 var_tcbi_5fCPU_0) in 
               
               insert_in_table "mes_CPU_TDXM_6" [(id (var_smr_5fCPU_0))];

               (
                begin
                  let token_38 = ref true in
                  fun () ->
                    if (!token_38) then
                    begin
                      token_38 := false;
                      let list_39 = get_from_table "mes_QE_CPU_12"
                        (function
                            | [tvar_40] -> begin
                      
                              let var_rms_5fQE_5fto_5fCPU_0 = (exc_bad_file "mes_QE_CPU_12" id tvar_40) in (var_rms_5fQE_5fto_5fCPU_0)
                              end
                            | _ -> raise (Bad_file "mes_QE_CPU_12")) in
                      if list_39 = [] then begin 
                        raise Match_fail
                      end else begin
                        let (var_rms_5fQE_5fto_5fCPU_0) = rand_list list_39 in
                        try
                          let bvar_41=var_rms_5fQE_5fto_5fCPU_0 in
                          let (var_rms_5fwithout_5fmac_5fQE_5fto_5fCPU_0,var_mac_5fQE_5fto_5fCPU_0)=inv_rms_f bvar_41 in
                          if true then begin 
                            if ((mac_check Cryptokit.MAC.hmac_sha1) (rms_without_mac_t2bitstring var_rms_5fwithout_5fmac_5fQE_5fto_5fCPU_0) var_mkey_0 var_mac_5fQE_5fto_5fCPU_0) then
                            begin
                              insert_in_table "mes_CPU_QE_14" [(id (var_rms_5fwithout_5fmac_5fQE_5fto_5fCPU_0))];

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
             end
             else
               raise Match_fail
           with Match_fail -> 
             raise Match_fail
         end
       end
       else raise Bad_call
   end)