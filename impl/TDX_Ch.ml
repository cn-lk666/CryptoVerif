open Base
open Crypto

type type_oracle_c22 = (string) -> (unit * string)
 and type_oracle_c20 = unit -> (type_oracle_c22)

let token = ref false

let init () =
  if !token then raise Bad_call;
  token := true;

  let var_sk2_0= exc_bad_file "Impl_sk2" skey_from (input_string_from_file "Impl_sk2") in
  let var_spk1_0= exc_bad_file "Impl_spk1" pkey_from (input_string_from_file "Impl_spk1") in
  (
   begin
     let token_24 = ref true in
     fun () ->
       if (!token_24) then
       begin
         token_24 := false;
         (
          begin
            let token_26 = ref true in
            fun (input_25) ->
              if (!token_26) then
              begin
                token_26 := false;let var_m2_0 = input_25 in 
                try
                  let bvar_27=(pk_dec var_m2_0 var_sk2_0) in
                  let (bvar_28)=injbot_inv bvar_27 in
                  let (var_quote_5fCh_0)=bitstring2quote_t bvar_28 in
                  if true then begin 
                    try
                      let bvar_29=var_quote_5fCh_0 in
                      let (var_tdr_5fwithout_5fmac_5fCh_0,var_sig_5fCh_0)=inv_quote_f bvar_29 in
                      if true then begin 
                        if ((rsassa_pss_verify 8) (tdr_without_mac_t2bitstring var_tdr_5fwithout_5fmac_5fCh_0) var_spk1_0 var_sig_5fCh_0) then
                        begin
                          try
                            let bvar_30=var_tdr_5fwithout_5fmac_5fCh_0 in
                            let (var_smr_5fwithout_5fmac_5fCh_0,var_res4_5fCh_0,var_tdi_5fCh_0)=inv_tdr_without_mac_f bvar_30 in
                            if true then begin 
                              try
                                let bvar_31=var_smr_5fwithout_5fmac_5fCh_0 in
                                let (var_rms_5fwithout_5fmac_5fCh_0,var_tcbi_5fCh_0)=inv_smr_without_mac_f bvar_31 in
                                if true then begin 
                                  try
                                    let bvar_32=var_rms_5fwithout_5fmac_5fCh_0 in
                                    let (var_rtyp_5fCh_0,var_res1_5fCh_0,var_csvn_5fCh_0,var_tdih_5fCh_0,var_tcbh_5fCH_0,var_rdata_5fCh_0,var_res2_5fCh_0)=inv_rms_without_mac_f bvar_32 in
                                    if true then begin 
                                      try
                                        let bvar_33=var_rdata_5fCh_0 in
                                        let (var_x1_5fCh_0,var_y1_5fCh_0)=inv_rdata_f bvar_33 in
                                        if true then begin 
                                          
                                          let var_session_5fkey_0 = (rand_string 16) () in
                                          let var_m2_5fCh_0 = (pk_enc (key2bitstring var_session_5fkey_0) var_x1_5fCh_0) in 
                                          (
                                            ()
                                            ,var_m2_5fCh_0
                                          )
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
              else raise Bad_call
          end)
       end
       else raise Bad_call
   end)