
exception PKU_Error (* error while unwrapping a signature *)
exception Message_too_long (* Message given to a RSA primitive longer than k.size/8-1 bytes*)
exception Encoding_error
exception Decoding_error
exception Mask_too_long
exception Sxor

(* Types for public key crypto *)
type pkey = 
    { 
      psize : int;
      pn : string;
      pe : string;
    }
type skey = Cryptokit.RSA.key

let time msg f =
  let t1 = Sys.time () in
  let result = f () in
  let t2 = Sys.time () in
  Printf.eprintf "Time elapsed (%s): %f" msg (t2 -. t1);
  result

let pkey_from s =
  let (pk:pkey) = Marshal.from_string s 0 in
    pk

let pkey_to p =
  Marshal.to_string p [] 


let skey_from s =
  let (sk:skey) = Marshal.from_string s 0 in
    sk

let skey_to s =
  Marshal.to_string s [] 

(* Non cryptographic functions *)

let injbot_inv= function
    None -> raise Base.Match_fail
  | Some x-> x

let injbot x = Some x

let get_rtyp()= "data_rtyp"

let get_tdi()="data_tdi"

let get_csvn()="data_csvn"

let get_tcbi()="data_tcbi"

let get_res()="data_res"

let get_user_data()="data_user"

let rdata_f a b=Base.compos[(pkey_to a);b]
let inv_rdata_f x=
  try 
    match (Base.decompos x) with 
        [a;b] -> ((pkey_from a),b) 
      | _ -> raise Base.Match_fail
  with 
      _ -> raise Base.Match_fail

let arg_TDXM_CPU_f a b c=Base.compos [a;b;c]
let inv_arg_TDXM_CPU_f x=
  try 
    match (Base.decompos x) with 
        [a;b;c] -> (a,b,c) 
      | _ -> raise Base.Match_fail
  with 
      _ -> raise Base.Match_fail

let smr_f a b=Base.compos [a;b]
let inv_smr_f x=
  try 
    match (Base.decompos x) with 
        [a;b] -> (a,b) 
      | _ -> raise Base.Match_fail
  with 
      _ -> raise Base.Match_fail

let rms_f a b=Base.compos [a;b]
let inv_rms_f x=
  try 
    match (Base.decompos x) with 
        [a;b] -> (a,b) 
      | _ -> raise Base.Match_fail
  with 
      _ -> raise Base.Match_fail

let tdr_f a b c=Base.compos [a;b;c]
let inv_tdr_f x=
  try 
    match (Base.decompos x) with 
        [a;b;c] -> (a,b,c) 
      | _ -> raise Base.Match_fail
  with 
      _ -> raise Base.Match_fail

let smr_without_mac_f a b= Base.compos [a;b]
let inv_smr_without_mac_f x=
  try 
    match (Base.decompos x) with 
        [a;b] -> (a,b) 
      | _ -> raise Base.Match_fail
  with 
      _ -> raise Base.Match_fail

let rms_without_mac_f a b c d e f g=Base.compos [a;b;c;d;e;f;g]
let inv_rms_without_mac_f x=
  try 
    match (Base.decompos x) with 
        [a;b;c;d;e;f;g] -> (a,b,c,d,e,f,g) 
      | _ -> raise Base.Match_fail
  with 
      _ -> raise Base.Match_fail

let tdr_without_mac_f a b c =Base.compos [a;b;c]
let inv_tdr_without_mac_f x=
  try 
    match (Base.decompos x) with 
        [a;b;c] -> (a,b,c) 
      | _ -> raise Base.Match_fail
  with 
      _ -> raise Base.Match_fail

let quote_f a b=Base.compos [a;b]
let inv_quote_f x=
  try 
    match (Base.decompos x) with 
        [a;b] -> (a,b) 
      | _ -> raise Base.Match_fail
  with 
      _ -> raise Base.Match_fail

let tcbi_t2bitstring x= Base.id x
let bitstring2tcbi_t x=Base.id x

let tdi_t2bitstring x= Base.id x
let bitstring2tdi_t x= Base.id x

let key2bitstring x= Base.id x
let bitstring2key x = Base.id x

let rms_without_mac_t2bitstring x = Base.id x
let bitstring2rms_without_mac_t x= Base.id x

let tdr_without_mac_t2bitstring x= Base.id x
let bitstring2tdr_without_mac_t x = Base.id x

let quote_t2bitstring x = Base.id x
let bitstring2quote_t x =Base.id x

(* Padding functions *)

let pad scheme size s =
  let buf = Bytes.create size in
  let size=String.length s in
  String.blit s 0 buf 0 size;
  Cryptokit.wipe_string s;
  scheme#pad buf size;
  Bytes.unsafe_to_string buf

let pad_inv scheme s =
  String.sub s 0 (scheme#strip (Bytes.unsafe_of_string s))

        
(* MAC handling *)

(*f should be of the form, for example,
  Cryptokit.MAC.hmac_sha1
  for a MAC based on SHA1 *)
let mac f msg key =
  let h=f key in
  Cryptokit.hash_string h msg

let mac_check f msg key mac =
  let h=f key in
  (mac = Cryptokit.hash_string h msg)


(* Public key crypto : RSA *)

let key_to_pkey k = 
  {psize = k.Cryptokit.RSA.size; 
   pn = k.Cryptokit.RSA.n; 
   pe = k.Cryptokit.RSA.e}

let pkey_to_key pk = 
  { Cryptokit.RSA.size = pk.psize; 
    Cryptokit.RSA.n = pk.pn; 
    Cryptokit.RSA.e = pk.pe;
    Cryptokit.RSA.d = "";
    Cryptokit.RSA.p = "";
    Cryptokit.RSA.q = "";
    Cryptokit.RSA.dp = "";
    Cryptokit.RSA.dq = "";
    Cryptokit.RSA.qinv = ""}

let pk_kgen size () =
  let k = Cryptokit.RSA.new_key ~rng: (Base.rng()) size in
    (key_to_pkey k, k)

(* RSA-OEAP encryption scheme *)

let mgf z l =
  let hLen = 20 in
  if (Sys.word_size > 32) then
    if l > hLen * (1 lsl 32) then
      raise Mask_too_long;
  let t = Buffer.create 80 in
  let m = (Base.ceildiv l hLen) - 1 in
    for counter = 0 to m do
      let c = Base.i2osp counter 4 in
        Buffer.add_string t (Cryptokit.hash_string (Cryptokit.Hash.sha1 ()) (z^c));
    done;
    Buffer.sub t 0 l
          

let byte_sxor s1 s2 =
  if String.length s1 <> String.length s2 then
    raise Sxor
  else
    let s = Bytes.create (String.length s1) in
    for i = 0 to ((String.length s1)-1) do
      Bytes.set s i (char_of_int ((int_of_char s1.[i]) lxor (int_of_char s2.[i])))
    done;
    s
    
let sxor s1 s2 =
  Bytes.unsafe_to_string (byte_sxor s1 s2)

let eme_oaep_encode m p emLen =
  (*step1 :P<=2**61-1. OCaml strings can have at most 2**57 octets *)
  let hLen = 20 in (*sha1 output size*)
    if (String.length m > emLen - 2* hLen -1) then
      raise Message_too_long
    else
      let ps = String.make (emLen - (String.length m) - 2*hLen -1) '\000' in
      let pHash = Cryptokit.hash_string (Cryptokit.Hash.sha1 ()) p in
      let db = pHash^ps^"\001"^m in
      let seed = Base.rand_string hLen () in
      let dbMask = mgf seed (emLen-hLen) in
      let maskedDB = sxor db dbMask in
      let seedMask = mgf maskedDB hLen in
      let maskedSeed = sxor seed seedMask in
        maskedSeed^maskedDB 


let eme_oaep_decode em p =
  let hLen = 20 in
    if String.length em < 2*hLen +1 then
      raise Decoding_error
    else
      let maskedSeed = String.sub em 0 hLen in
      let maskedDB = String.sub em hLen ((String.length em)-hLen) in
      let seedMask = mgf maskedDB hLen in
      let seed = sxor maskedSeed seedMask in
      let dbMask = mgf seed ((String.length em) - hLen) in
      let db = sxor maskedDB dbMask in
      let pHash =  Cryptokit.hash_string (Cryptokit.Hash.sha1 ()) p in
      let pHash' = String.sub db 0 hLen in
      let i = ref hLen in
      let dbl = String.length db in
      while !i < dbl && db.[!i] = '\000' do incr i done;
        if !i = dbl then raise Decoding_error
        else if db.[!i] <> '\001' then raise Decoding_error
        else if pHash <> pHash' then raise Decoding_error 
        else
          let i' = !i+1 in
          let m = String.sub db i' (dbl - i') in
            m

let rsaes_oaep_encrypt msg pk p =
  let k = Base.ceildiv pk.psize 8 in
  let em = eme_oaep_encode msg p (k-1) in
    Cryptokit.RSA.encrypt (pkey_to_key pk) em
      
let rsaes_oaep_decrypt msg sk p =
  try 
    let k = Base.ceildiv sk.Cryptokit.RSA.size 8 in
      if String.length msg <> k then
        None
      else
        let m=Cryptokit.RSA.decrypt_CRT sk msg in
          if m.[0] <> '\000' then
            None
          else
            let em = String.sub m 1 ((String.length m)-1) in
            Some (eme_oaep_decode em p)
  with 
      _ -> None


let pk_enc msg pk =
  rsaes_oaep_encrypt msg pk ""

let pk_dec msg sk = 
  rsaes_oaep_decrypt msg sk ""

(* Full domain hash (FDH) signature scheme *)

let pk_sign h ps msg sk = 
  let size = (Base.ceildiv sk.Cryptokit.RSA.size 8)-1 in
  let msg' = pad ps size (Cryptokit.hash_string (h ()) msg) in
    Cryptokit.RSA.sign_CRT sk msg'

let pk_unwrap ps s pk =
  let mp=Cryptokit.RSA.unwrap_signature (pkey_to_key pk) s in
    if mp.[0] <> '\000' then
      raise PKU_Error
    else
      pad_inv ps (String.sub mp 1 ((String.length mp)-1))

let pk_check_sign h ps msg pk s = 
  try
    let msg' = Cryptokit.hash_string (h ()) msg in
      pk_unwrap ps s pk = msg'
  with
      _ -> false

(* PSS signature scheme *)

let set_leftmost_n_bits_to_zero c n =
  let x = int_of_char c in
  let mask = (1 lsl(8-n))-1 in (* = 0..01..1 with n 0 and (8-n) 1 *)
    char_of_int (x land mask)

(* 8hLen + 8sLen + 9 <= emBits *)
let emsa_pss_encode sLen msg emBits =
  let hLen = 20 in (*sha1 output size*) 
  let emLen = Base.ceildiv emBits 8 in
  let mHash = Cryptokit.hash_string (Cryptokit.Hash.sha1 ()) msg in
    if emLen < hLen + sLen +2 then
      raise Encoding_error
    else
      let salt = Base.rand_string sLen () in
      let m' = "\000\000\000\000\000\000\000\000"^mHash^salt in
      let h = Cryptokit.hash_string (Cryptokit.Hash.sha1 ()) m' in
      let ps = String.make (emLen - sLen - hLen - 2) '\000' in
      let db = ps^"\001"^salt in
      let dbMask = mgf h (emLen - hLen -1) in
      let maskedDB = byte_sxor db dbMask in
      Bytes.set maskedDB 0  (set_leftmost_n_bits_to_zero (Bytes.get maskedDB 0) (8*emLen-emBits));
      (Bytes.unsafe_to_string maskedDB)^h^"\xbc"

let emsa_pss_verify sLen m em emBits =
  let hLen = 20 in
  let emLen = Base.ceildiv emBits 8 in
    if String.length em <> emLen then
      false
    else
      let mHash =  Cryptokit.hash_string (Cryptokit.Hash.sha1 ()) m in
        if emLen < hLen + sLen + 2 then false
        else
          if em.[emLen - 1] <> '\xbc' then
            false
          else
            let maskedDB = String.sub em 0 (emLen - hLen - 1) in
            let h = String.sub em (emLen - hLen - 1) hLen in
              if set_leftmost_n_bits_to_zero maskedDB.[0] (8*emLen-emBits) <> maskedDB.[0] then
                false
              else
                let dbMask = mgf h (emLen - hLen - 1) in
                let db = byte_sxor maskedDB dbMask in
                Bytes.set db 0 (set_leftmost_n_bits_to_zero (Bytes.get db 0) (8*emLen-emBits));
		let db = Bytes.unsafe_to_string db in
                let i = ref 0 in
                let b = ref true in
                while !b && !i < emLen - hLen - sLen - 2 do
                  b := db.[!i] = '\000';
                  incr i;
                done;
                if not !b then
                  false
                else
                  let salt = String.sub db (String.length db - sLen) sLen in
                  let m' = "\000\000\000\000\000\000\000\000"^mHash^salt in
                  let h' = Cryptokit.hash_string (Cryptokit.Hash.sha1 ()) m' in
                  h = h'

let rsassa_pss_sign sLen m sk =
  let em = emsa_pss_encode sLen m (sk.Cryptokit.RSA.size - 1) in
  let s = Cryptokit.RSA.sign_CRT sk em in
    s

let rsassa_pss_verify sLen m pk s =
  let k = Base.ceildiv pk.psize 8 in
  if (String.length s) <> k then 
    false
  else
    try 
      let em = Cryptokit.RSA.unwrap_signature (pkey_to_key pk) s in
        emsa_pss_verify sLen m em (pk.psize - 1)
    with 
        _ -> false

(* hash *)
let hash () = Cryptokit.hash_string (Cryptokit.Hash.sha1 ())
