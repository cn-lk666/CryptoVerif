open Base
open Crypto

type type_oracle_c18 = unit -> (unit * string)
 and type_oracle_c14 = (string) -> (type_oracle_c18)

let token = ref false

let init () =
  if !token then raise Bad_call;
  token := true;

  let var_hk1_0= exc_bad_file "Impl_hk1" (size_from 16) (input_string_from_file "Impl_hk1") in
  let var_hk2_0= exc_bad_file "Impl_hk2" (size_from 16) (input_string_from_file "Impl_hk2") in
  let var_pk2_0= exc_bad_file "Impl_pk2" pkey_from (input_string_from_file "Impl_pk2") in
  let var_ssk1_0= exc_bad_file "Impl_ssk1" skey_from (input_string_from_file "Impl_ssk1") in
  (
   begin
     let token_16 = ref true in
     fun (input_15) ->
       if (!token_16) then
       begin
         token_16 := false;let var_tdr_5fQE_0 = input_15 in 
         try
           let bvar_17=var_tdr_5fQE_0 in
           let (var_smr_5fQE_0,var_res4_5fQE_0,var_tdi_5fQE_0)=inv_tdr_f bvar_17 in
           if true then begin 
             try
               let bvar_18=var_smr_5fQE_0 in
               let (var_rms_5fQE_0,var_tcbi_5fQE_0)=inv_smr_f bvar_18 in
               if true then begin 
                 try
                   let bvar_19=var_rms_5fQE_0 in
                   let (var_rms_5fwithout_5fmac_5fQE_0,var_macres_5fQE_0)=inv_rms_f bvar_19 in
                   if true then begin 
                     try
                       let bvar_20=var_rms_5fwithout_5fmac_5fQE_0 in
                       let (var_rtyp_5fQE_0,var_res1_5fQE_0,var_csvn_5fQE_0,var_tdih_5fQE_0,var_tcbh_5fQE_0,var_rdata_5fQE_0,var_res2_5fQE_0)=inv_rms_without_mac_f bvar_20 in
                       if true then begin 
                         insert_in_table "mes_QE_CPU_12" [(id (var_rms_5fQE_0))];

                         if ((&&) ((=) var_tdih_5fQE_0 (hash var_hk1_0 (tdi_t2bitstring var_tdi_5fQE_0))) ((=) var_tcbh_5fQE_0 (hash var_hk2_0 (tcbi_t2bitstring var_tcbi_5fQE_0)))) then
                         begin
                           (
                            begin
                              let token_21 = ref true in
                              fun () ->
                                if (!token_21) then
                                begin
                                  token_21 := false;
                                  if exists_in_table "mes_CPU_QE_14"
                                    (function
                                        | [tvar_23] -> begin
                                  
                                          let var_rms_5fwithout_5fmac_5ffrom_5fCPU_2 = (exc_bad_file "mes_CPU_QE_14" id tvar_23) in 
                                          if (((=) var_rms_5fwithout_5fmac_5ffrom_5fCPU_2 var_rms_5fwithout_5fmac_5fQE_0)) then () else raise Match_fail
                                          end
                                        | _ -> raise (Bad_file "mes_CPU_QE_14")) then begin 
                                    
                                    
                                    let var_smr_5fwithout_5fmac_5fQE_0 = (smr_without_mac_f var_rms_5fwithout_5fmac_5fQE_0 var_tcbi_5fQE_0) in 
                                    let var_tdr_5fwithout_5fmac_5fQE_0 = (tdr_without_mac_f var_smr_5fwithout_5fmac_5fQE_0 var_res4_5fQE_0 var_tdi_5fQE_0) in 
                                    let var_sig_5fQE_0 = ((rsassa_pss_sign 8) (tdr_without_mac_t2bitstring var_tdr_5fwithout_5fmac_5fQE_0) var_ssk1_0) in 
                                    let var_quote_5fQE_0 = (quote_f var_tdr_5fwithout_5fmac_5fQE_0 var_sig_5fQE_0) in 
                                    let var_m1_0 = (pk_enc (quote_t2bitstring var_quote_5fQE_0) var_pk2_0) in 
                                    (
                                      ()
                                      ,var_m1_0
                                    )
                                  end else begin 
                                    raise Match_fail
                                  end
                                end
                                else raise Bad_call
                            end)
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
                   else
                     raise Match_fail
                 with Match_fail -> 
                   raise Match_fail
               end
               else
                 raise Match_fail
             with Match_fail -> 
               raise Match_fail
           end
           else
             raise Match_fail
         with Match_fail -> 
           raise Match_fail
       end
       else raise Bad_call
   end)