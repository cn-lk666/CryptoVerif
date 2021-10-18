open Base
open Crypto

type type_oracle_c4 = unit -> (type_oracle_c12)
 and type_oracle_c12 = unit -> (unit * string)

let token = ref false

let init () =
  if !token then raise Bad_call;
  token := true;

  (
   begin
     let token_10 = ref true in
     fun () ->
       if (!token_10) then
       begin
         token_10 := false;
         try
           let bvar_11=((pk_kgen 1024) ()) in
           let (var_pk_5fTD_0,var_sk_5fTD_0)=id bvar_11 in
           if true then begin 
              output_string_to_file "Impl_pk_TD" (pkey_to var_pk_5fTD_0);
              output_string_to_file "Impl_sk_TD" (skey_to var_sk_5fTD_0);
             let var_rdata_5fother_0 = (rand_string 128) () in
             let var_rdata_5fTD_0 = (rdata_f var_pk_5fTD_0 var_rdata_5fother_0) in 
             insert_in_table "mes_TD_TDXM_2" [(id (var_rdata_5fTD_0))];

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
           end
           else
             raise Match_fail
         with Match_fail -> 
           raise Match_fail
       end
       else raise Bad_call
   end)