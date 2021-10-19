let is_alphabetic c=
  (c>='A' && c <='Z') || (c>='a' && c <='z') || (c>='0' && c <='9')

let hex_of_char c=
  Printf.sprintf "%02x" (int_of_char c)

let rec string_fold f s r=
  match s with 
      "" -> r
    | s -> (f s.[0] (string_fold f (String.sub s 1 ((String.length s)-1)) r))

let alphabetize_string (s:string) =
  string_fold 
    (
      fun (c:char) (s:string) -> 
        if is_alphabetic c then 
          (String.make 1 c)^s 
        else 
          ("_"^(hex_of_char c)^s)
    ) s ""

let rec heuristic_decompos (s:string) =
  if String.length s>=4 && s.[0] = '\000' && s.[1] = '\000' && s.[2] = '\000' && s.[3] <> '\000' && s.[3] <= '\004' then
    let l = Base.decompos s in
      print_string "(";
      heuristic_decompos_list l;
      print_string ")";
  else
    print_string (alphabetize_string s)

and heuristic_decompos_list = function
  | [] -> ()
  | [x] -> heuristic_decompos x
  | x::l -> heuristic_decompos x;print_string ",";heuristic_decompos_list l

and heuristic_decompos_list_list = function
  | [] -> ()
  | [x] -> heuristic_decompos_list x
  | x::l -> heuristic_decompos_list x;print_string ";";heuristic_decompos_list_list l

let _ =
print_string "start...";print_newline ();
let start = keygen.init () in
start ();
print_string "enc_key=";heuristic_decompos (Base.input_string_from_file "Impl_pk2");
print_string ",mac_key=";heuristic_decompos (Base.input_string_from_file "Impl_mkey");
print_newline ();
print_string "Challenger...";print_newline ();
let Ch=TDX_Ch.init () in
let Ch_1=Ch() in
print_string "TD...";print_newline ();
let TD=TDX_TD.init () in
let TD_1=TD() in
print_string "TDXM...";print_newline ();
let TDXM=TDX_TDXM.init () in
let TDXM_1=TDXM () in
print_string "CPU...";print_newline ();
let CPU=TDX_CPU.init () in
let CPU_1=CPU() in
print_string "CPU sent SMR to TDXM";print_newline ();
let TDXM_2=TDXM_1() in
print_string "TDXM sent TDR to TDXM";print_newline ();
let tdr=TD_1() in
print_string "TD forward the TDR to QE";print_newline ();
let QE=TDX_QE.init() in
let QE_1=QE(tdr) in
print_string "QE forward the RMS to CPU to verify the mac";print_newline ();
let CPU_2=CPU_1() in
print_string "QE sign and enc the quote";print_newline ();
let m1=QE_1() in
print_string "Ch receive the quote";print_newline ();
let m2=Ch_1(m1) in ()

