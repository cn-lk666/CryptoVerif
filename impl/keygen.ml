open Base
open Crypto

type type_oracle_start = unit -> unit

let token = ref false

let init () =
  if !token then raise Bad_call;
  token := true;

  (
   begin
     let token_1 = ref true in
     fun () ->
       if (!token_1) then
       begin
         token_1 := false;
         try
           let bvar_2=((pk_kgen 1024) ()) in
           let (var_spk1_0,var_ssk1_0)=id bvar_2 in
           if true then begin 
              output_string_to_file "Impl_spk1" (pkey_to var_spk1_0);
              output_string_to_file "Impl_ssk1" (skey_to var_ssk1_0);
             try
               let bvar_3=((pk_kgen 1024) ()) in
               let (var_pk2_0,var_sk2_0)=id bvar_3 in
               if true then begin 
                  output_string_to_file "Impl_pk2" (pkey_to var_pk2_0);
                  output_string_to_file "Impl_sk2" (skey_to var_sk2_0);
                 let var_hk1_0 = (rand_string 16) () in
                 output_string_to_file "Impl_hk1" (id var_hk1_0);
                 let var_hk2_0 = (rand_string 16) () in
                 output_string_to_file "Impl_hk2" (id var_hk2_0);
                 let var_mkey_0 = (rand_string 16) () in
                 output_string_to_file "Impl_mkey" (id var_mkey_0);
                 ()
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