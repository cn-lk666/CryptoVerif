open Base
open Crypto

type type_oracle_c4 = unit -> unit

let token = ref false

let init () =
  if !token then raise Bad_call;
  token := true;

  (
   begin
     let token_4 = ref true in
     fun () ->
       if (!token_4) then
       begin
         token_4 := false;
         let var_rdata_5fother_0 = (rand_string 128) () in
         try
           let bvar_5=((pk_kgen 1024) ()) in
           let (var_pk_5fTD_0,var_sk_5fTD_0)=id bvar_5 in
           if true then begin 
              output_string_to_file "Impl_pk_TD" (pkey_to var_pk_5fTD_0);
              output_string_to_file "Impl_sk_TD" (skey_to var_sk_5fTD_0);
             let var_rdata_5fTD_0 = (rdata_f var_pk_5fTD_0 var_rdata_5fother_0) in 
             insert_in_table "mes_TD_TDXM_2" [(id (var_rdata_5fTD_0))];

             ()
           end
           else
             raise Match_fail
         with Match_fail -> 
           raise Match_fail
       end
       else raise Bad_call
   end)