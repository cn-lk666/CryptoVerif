jing@ubuntu:~/Desktop/CryptoVerif/Test$ ~/Downloads/cryptoverif2.04/cryptoverif test8.pcv 
File "/tmp/cv23d9e8.cv", line 313, character 5 - line 330, character 14:
Warning: Duplicate inputs on channel c22
(The second one is located under the return of the first one.).
This is an example (possibly among others) that contradicts the following recommendation:
Different inputs should use different channel names, except matching inputs in different branches of if, find, let, or get.
 - That guarantees that the adversary knows precisely to which input it sends messages.
 - That allows using the number of inputs on channels in probability results.
Furthermore, for the best precision, you should also make sure that replications use different bounds when they are above different inputs, except matching inputs in different branches of if, find, let, or get.
Doing expand get, insert... No change.
Doing simplify (non-expanded game)... No change.
Doing expand... Done.
Doing remove assignments of findcond... Done.
Doing simplify... Run simplify 2 time(s). Fixpoint reached.
Done.
Doing move all binders... Done.
Doing remove assignments of findcond... No change.
Doing merge branches... No change.
Please enter a command: show_game
     in(start, ());
     new r1: skeyseed;
     let spk1: spkey = spkgen(r1) in
     let ssk1: sskey = sskgen(r1) in
     new r2: keyseed;
     let pk2: pkey = pkgen(r2) in
     let sk2: skey = skgen(r2) in
     new r3: keyseed;
     let pk3: pkey = pkgen(r3) in
     new hk: key;
     new mkey: key;
     out(c1, ());
     ((
       ! i <= qChallenger
       in(c22[i], ());
       out(c23[i], ());
       in(c22[i], m2: bitstring);
       let injbot(quote_t2bitstring(quote_Ch: quote_t)) = dec(m2, sk2) in
       let quote_f(tdr_without_mac_Ch: tdr_without_mac_t, sig_Ch: signature) = quote_Ch in
       if verify(tdr_without_mac_t2bitstring(tdr_without_mac_Ch), spk1, sig_Ch) then
       let tdr_without_mac_f(smr_without_mac_Ch: smr_without_mac_t, res4_Ch: res_t, tdi_Ch: tdi_t) = tdr_without_mac_Ch in
       let smr_without_mac_f(rms_without_mac_Ch: rms_without_mac_t, tcbi_Ch: tcbi_t) = smr_without_mac_Ch in
       let rms_without_mac_f(rtyp_Ch: rtyp_t, res1_Ch: res_t, csvn_Ch: csvn_t, tcbh_Ch: hashoutput, tdih_Ch: hashoutput, rdata_Ch: rdata_t, res2_Ch: res_t) = rms_without_mac_Ch in
       let rdata_f(x1_Ch: pkey, y1_Ch: user_data_t) = rdata_Ch in
       event QuoteVerified(rtyp_Ch, res1_Ch, csvn_Ch, tcbh_Ch, tdih_Ch, rdata_Ch, res2_Ch);
       new session_key: key;
       let m_2: bitstring = key2bitstring(session_key) in
       new r_2: enc_seed;
       let m2_Ch: bitstring = enc_r(m_2, x1_Ch, r_2) in
       out(c23[i], m2_Ch)
     ) | (
       ! iH <= qH
       in(ch1[iH], x1_1: bitstring);
       out(ch2[iH], hash(hk, x1_1))
     ) | (
       ! i_1 <= qTD
       in(c4[i_1], ());
       new rdata_other: user_data_t;
       let rdata_TD: rdata_t = rdata_f(pk3, rdata_other) in
       out(c5[i_1], ());
       in(c12[i_1], ());
       find i_13 = i_2 <= qTDXM suchthat defined(tdr_TDXM[i_2]) then
       out(c13[i_1], tdr_TDXM[i_13])
     ) | (
       ! i_4 <= qTDXM
       in(c6[i_4], ());
       let tdi_TDXM: tdi_t = get_tdi in
       let tdih_TDXM: hashoutput = hash(hk, tdi_t2bitstring(tdi_TDXM)) in
       find i_14 = i_5 <= qTD suchthat defined(rdata_TD[i_5]) then
       (
         let rdata_TDXM: rdata_t = cst_rdata_t in
         let rtyp_TDXM: rtyp_t = get_rtyp in
         out(c7[i_4], ());
         in(c10[i_4], ());
         find j_4 = j <= qCPU suchthat defined(smr_CPU[j]) then
         let res4_TDXM: res_t = get_res in
         let tdr_TDXM: tdr_t = tdr_f(smr_CPU[j_4], res4_TDXM, tdi_TDXM) in
         event TDXMsentTDR_8(smr_CPU[j_4], tdi_TDXM);
         out(c11[i_4], ())
       )
       else
         let rtyp_TDXM: rtyp_t = get_rtyp
     ) | (
       ! i_7 <= qCPU
       in(c8[i_7], ());
       find i_15 = i_8 <= qTDXM suchthat defined(rdata_TD[i_14[i_8]], rdata_TDXM[i_8], rtyp_TDXM[i_8], tdih_TDXM[i_8]) then
       let csvn_CPU: csvn_t = get_csvn in
       let res1_CPU: res_t = get_res in
       let res2_CPU: res_t = get_res in
       let tcbi_CPU: tcbi_t = get_tcbi in
       let tcbh_CPU: hashoutput = hash(hk, tcbi_t2bitstring(tcbi_CPU)) in
       let rms_without_mac_CPU: rms_without_mac_t = rms_without_mac_f(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU) in
       let mac_CPU: macres_t = mac(rms_without_mac_t2bitstring(rms_without_mac_CPU), mkey) in
       let rms_CPU: rms_t = rms_f(rms_without_mac_CPU, mac_CPU) in
       let smr_CPU: smr_t = smr_f(rms_CPU, tcbi_CPU) in
       event CPUsentSMR(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU, mac_CPU, tcbi_CPU);
       out(c9[i_7], ());
       in(c18[i_7], ());
       find j_5 = j_2 <= qQE suchthat defined(rms_QE_to_CPU[j_2], rms_without_mac_QE[j_2], macres_QE[j_2]) then
       if check(rms_without_mac_t2bitstring(rms_without_mac_QE[j_5]), mkey, macres_QE[j_5]) then
       let rms_without_mac_from_CPU: rms_without_mac_t = cst_rms_without_mac_t in
       out(c19[i_7], ())
     ) | (
       ! i_10 <= qQE
       in(c16[i_10], tdr_QE: tdr_t);
       let tdr_f(smr_QE: smr_t, res4_QE: res_t, tdi_QE: tdi_t) = tdr_QE in
       let smr_f(rms_QE: rms_t, tcbi_QE: tcbi_t) = smr_QE in
       let rms_f(rms_without_mac_QE: rms_without_mac_t, macres_QE: macres_t) = rms_QE in
       let rms_without_mac_f(rtyp_QE: rtyp_t, res1_QE: res_t, csvn_QE: csvn_t, tcbh_QE: hashoutput, tdih_QE: hashoutput, rdata_QE: rdata_t, res2_QE: res_t) = rms_without_mac_QE in
       let rms_QE_to_CPU: rms_t = cst_rms_t in
       out(c17[i_10], ());
       in(c20[i_10], ());
       find i_16 = i_11 <= qCPU suchthat defined(rms_without_mac_from_CPU[i_11], rtyp_QE[j_5[i_11]], res1_QE[j_5[i_11]], csvn_QE[j_5[i_11]], tcbh_QE[j_5[i_11]], tdih_QE[j_5[i_11]], rdata_QE[j_5[i_11]], res2_QE[j_5[i_11]]) && (res2_QE = res2_QE[j_5[i_11]]) && (rdata_QE = rdata_QE[j_5[i_11]]) && (tdih_QE = tdih_QE[j_5[i_11]]) && (tcbh_QE = tcbh_QE[j_5[i_11]]) && (csvn_QE = csvn_QE[j_5[i_11]]) && (res1_QE = res1_QE[j_5[i_11]]) && (rtyp_QE = rtyp_QE[j_5[i_11]]) then
       event eve_QE(rtyp_QE, res1_QE, csvn_QE, tcbh_QE, tdih_QE, rdata_QE, res2_QE);
       event QEaccepted2_14(smr_QE, tdi_QE);
       let smr_without_mac_QE: smr_without_mac_t = smr_without_mac_f(rms_without_mac_QE, tcbi_QE) in
       let tdr_without_mac_QE: tdr_without_mac_t = tdr_without_mac_f(smr_without_mac_QE, res4_QE, tdi_QE) in
       let sig_QE: signature = sign(tdr_without_mac_t2bitstring(tdr_without_mac_QE), ssk1) in
       let quote_QE: quote_t = quote_f(tdr_without_mac_QE, sig_QE) in
       let m_3: bitstring = quote_t2bitstring(quote_QE) in
       new r_3: enc_seed;
       let m1: bitstring = enc_r(m_3, pk2, r_3) in
       out(c21[i_10], m1)
     ))

Please enter a command: show_equiv
1. equiv(ind_cca2_partial(enc))
  ! i <= N_3 new r: keyseed; (
    Opk() := return(pkgen(r)) |
    ! i2 <= N2_2 Odec(m: bitstring) := return(dec(m, skgen(r))) |
    ! i_1 <= N_2 new r1_1: enc_seed; Oenc(x1_2: bitstring) [useful_change] := return(enc_r(x1_2, pkgen(r), r1_1)))
<=(N_3 * N_2 * Penc(time + (N_3 - 1) * max((1 + N_2) * time(pkgen) + N2_2 * time(dec, maxlength(LHS: m)) + N2_2 * time(skgen) + N_2 * time(enc_r, maxlength(LHS: x1_2)), (1 + N_2) * time(pkgen) + N_2 * N2_2 * time(= bitstring, maxlength(RHS: m_1), maxlength(RHS: m1_1)) + N2_2 * time(dec, maxlength(RHS: m_1)) + N2_2 * time(skgen) + N2_2 * time(injbot, maxlength(RHS: x1_1)) + N_2 * time(enc_r2, length(Z, maxlength(RHS: x1_1))) + N_2 * time(Z, maxlength(RHS: x1_1))) + (N_2 - 1) * time(enc_r, maxlength(LHS: x1_2)), N2_2))=> [manual]
  ! i_3 <= N_3 new r: keyseed; (
    Opk() := return(pkgen(r)) |
    ! i2_1 <= N2_2 Odec(m_2: bitstring) := let m_1: bitstring = m_2 in find j_2 = j_1 <= N_2 suchthat defined(m1_1[j_1], x1_1[j_1]) && (m_1 = m1_1[j_1]) then return(injbot(x1_1[j_2])) else return(dec(m_1, skgen(r))) |
    ! i_2 <= N_2 new r1_1: enc_seed; Oenc(x1_3: bitstring) [useful_change] := let x1_1: bitstring = x1_3 in (let m1_1: bitstring = enc_r2(Z(x1_1), pkgen(r), r1_1) in return(m1_1)))

2. equiv(ind_cca2(enc))
  ! i3 <= N3_2 new r: keyseed; (
    Opk() [2] := return(pkgen(r)) |
    ! i2 <= N2_2 Odec(m: bitstring) := return(dec(m, skgen(r))) |
    ! i_1 <= N_2 new r1_1: enc_seed; Oenc(x1_2: bitstring) := return(enc_r(x1_2, pkgen(r), r1_1)))|
  ! i4 <= N4_1 new r2_1: enc_seed; Oenc2(x_1: bitstring, y_1: pkey) [3] := return(enc_r(x_1, y_1, r2_1)) [all]
<=(N3_2 * (N_2 + N4_1) * Penc(time + (N4_1 + N_2 - 1) * time(enc_r, max(maxlength(LHS: x_1), maxlength(LHS: x1_2))) + (N3_2 - 1) * (time(pkgen) + time(skgen) + N2_2 * time(dec, maxlength(LHS: m)) + N_2 * time(enc_r, max(maxlength(LHS: x_1), maxlength(LHS: x1_2)))), N2_2) + 0.5 * N3_2 * (N3_2 - 1) * Penccoll)=>
  ! i3_1 <= N3_2 new r: keyseed; (
    Opk() [2] := return(pkgen2_1(r)) |
    ! i2_1 <= N2_2 Odec(m_2: bitstring) := let m_1: bitstring = m_2 in find j_3 = j_1 <= N_2 suchthat defined(m1_1[j_1], x1_1[j_1]) && (m_1 = m1_1[j_1]) then return(injbot(x1_1[j_3])) orfind j_4 = j_2 <= N4_1 suchthat defined(m2_1[j_2], y_2[j_2], x_2[j_2]) && (y_2[j_2] = pkgen2_1(r)) && (m_1 = m2_1[j_2]) then return(injbot(x_2[j_4])) else return(dec2(m_1, skgen2_1(r))) |
    ! i_2 <= N_2 new r1_1: enc_seed; Oenc(x1_3: bitstring) := let x1_1: bitstring = x1_3 in (let m1_1: bitstring = enc_r2(Z(x1_1), pkgen2_1(r), r1_1) in return(m1_1)))|
  ! i4_1 <= N4_1 new r2_2: enc_seed; new r3_1: enc_seed; Oenc2(x_3: bitstring, y_3: pkey) [3] := let x_2: bitstring = x_3 in (let y_2: pkey = y_3 in find k_2 = k_1 <= N3_2 suchthat defined(r[k_1]) && (y_2 = pkgen2_1(r[k_1])) then (let m2_1: bitstring = enc_r2(Z(x_2), y_2, r2_2) in return(m2_1)) else return(enc_r(x_2, y_2, r3_1)))

3. equiv(uf_cma_corrupt_partial(sign))
  ! i <= N_3 new r: skeyseed; (
    Opk() := return(spkgen(r)) |
    ! i2 <= N2_1 Osign(x_1: bitstring) [useful_change] := return(sign(x_1, sskgen(r))) |
    ! i_1 <= N_1 Ocheck(m1_1: bitstring, si1: signature) [useful_change] := return(verify(m1_1, spkgen(r), si1)) |
    Ocorrupt() [10] := return(r))
<=(N_3 * Psign(time + (N_3 - 1) * ((1 + N_1) * time(spkgen) + N2_1 * time(sign, maxlength(LHS: x_1)) + N2_1 * time(sskgen) + N_1 * time(verify, maxlength(LHS: m1_1))) + (N_1 - 1) * time(verify, maxlength(LHS: m1_1)), N2_1, maxlength(LHS: x_1)))=> [manual, computational]
  ! i_3 <= N_3 new r: skeyseed [unchanged]; (
    Opk() := return(spkgen(r)) |
    ! i2_1 <= N2_1 Osign(x_3: bitstring) [useful_change] := let x_2: bitstring = x_3 in return(sign(x_2, sskgen(r))) |
    ! i_2 <= N_1 Ocheck(m1_3: bitstring, si1_2: signature) [useful_change] := let m1_2: bitstring = m1_3 in (let si1_1: signature = si1_2 in if defined(corrupt) then return(check2(m1_2, spkgen(r), si1_1)) else find j_2 = j_1 <= N2_1 suchthat defined(x_2[j_1]) && (m1_2 = x_2[j_1]) && check2(m1_2, spkgen(r), si1_1) then return(true) else return(false)) |
    Ocorrupt() [10] := let corrupt: bool = true in return(r))

4. equiv(uf_cma_corrupt(sign))
  ! i3 <= N3_1 new r: skeyseed; (
    Opk() [2] [useful_change] := return(spkgen(r)) |
    ! i2 <= N2_1 Osign(x_1: bitstring) [useful_change] := return(sign(x_1, sskgen(r))) |
    ! i_1 <= N_1 Ocheck(m1_1: bitstring, si1: signature) [useful_change] := return(verify(m1_1, spkgen(r), si1)) |
    Ocorrupt() [10] := return(r))|
  ! i4 <= N4 Ocheck2(m: bitstring, y_1: spkey, si: signature) [3] := return(verify(m, y_1, si)) [all]
<=(N3_1 * Psign(time + (N4 + N_1 - 1) * time(verify, max(maxlength(LHS: m1_1), maxlength(LHS: m))) + (N3_1 - 1) * (time(spkgen) + time(sskgen) + N2_1 * time(sign, maxlength(LHS: x_1)) + N_1 * time(verify, maxlength(LHS: m1_1))), N2_1, maxlength(LHS: x_1)))=> [manual, computational]
  ! i3_1 <= N3_1 new r: skeyseed [unchanged]; (
    Opk() [2] [useful_change] := return(pkgen2(r)) |
    ! i2_1 <= N2_1 Osign(x_3: bitstring) [useful_change] := let x_2: bitstring = x_3 in return(sign2(x_2, skgen2(r))) |
    ! i_2 <= N_1 Ocheck(m1_3: bitstring, si1_2: signature) [useful_change] := let m1_2: bitstring = m1_3 in (let si1_1: signature = si1_2 in if defined(corrupt) then return(check2(m1_2, pkgen2(r), si1_1)) else find j_3 = j_1 <= N2_1 suchthat defined(x_2[j_1]) && (m1_2 = x_2[j_1]) && check2(m1_2, pkgen2(r), si1_1) then return(true) else return(false)) |
    Ocorrupt() [10] := let corrupt: bool = true in return(r))|
  ! i4_1 <= N4 Ocheck2(m_2: bitstring, y_3: spkey, si_2: signature) [3] := let m_1: bitstring = m_2 in (let y_2: spkey = y_3 in (let si_1: signature = si_2 in find k_6 = k_3 <= N3_1 suchthat defined(r[k_3], corrupt[k_3]) && (y_2 = pkgen2(r[k_3])) then return(check2(m_1, y_2, si_1)) else find j_4 = j_2 <= N2_1, k_5 = k_2 <= N3_1 suchthat defined(x_2[j_2, k_2], r[k_2]) && (y_2 = pkgen2(r[k_2])) && (m_1 = x_2[j_2, k_2]) && check2(m_1, y_2, si_1) then return(true) else find k_4 = k_1 <= N3_1 suchthat defined(r[k_1]) && (y_2 = pkgen2(r[k_1])) then return(false) else return(verify(m_1, y_2, si_1))))

5. equiv(uf_cma(sign))
  ! i3 <= N3_1 new r: skeyseed; (
    Opk() [2] := return(spkgen(r)) |
    ! i2 <= N2_1 Osign(x_1: bitstring) := return(sign(x_1, sskgen(r))) |
    ! i_1 <= N_1 Ocheck(m1_1: bitstring, si1: signature) := return(verify(m1_1, spkgen(r), si1)))|
  ! i4 <= N4 Ocheck2(m: bitstring, y_1: spkey, si: signature) [3] := return(verify(m, y_1, si)) [all]
<=(N3_1 * Psign(time + (N4 + N_1 - 1) * time(verify, max(maxlength(LHS: m1_1), maxlength(LHS: m))) + (N3_1 - 1) * (time(spkgen) + time(sskgen) + N2_1 * time(sign, maxlength(LHS: x_1)) + N_1 * time(verify, maxlength(LHS: m1_1))), N2_1, maxlength(LHS: x_1)))=> [computational]
  ! i3_1 <= N3_1 new r: skeyseed [unchanged]; (
    Opk() [2] := return(pkgen2(r)) |
    ! i2_1 <= N2_1 Osign(x_3: bitstring) := let x_2: bitstring = x_3 in return(sign2(x_2, skgen2(r))) |
    ! i_2 <= N_1 Ocheck(m1_3: bitstring, si1_2: signature) := let m1_2: bitstring = m1_3 in (let si1_1: signature = si1_2 in find j_3 = j_1 <= N2_1 suchthat defined(x_2[j_1]) && (m1_2 = x_2[j_1]) && check2(m1_2, pkgen2(r), si1_1) then return(true) else return(false)))|
  ! i4_1 <= N4 Ocheck2(m_2: bitstring, y_3: spkey, si_2: signature) [3] := let m_1: bitstring = m_2 in (let y_2: spkey = y_3 in (let si_1: signature = si_2 in find j_4 = j_2 <= N2_1, k_4 = k_2 <= N3_1 suchthat defined(x_2[j_2, k_2], r[k_2]) && (y_2 = pkgen2(r[k_2])) && (m_1 = x_2[j_2, k_2]) && check2(m_1, y_2, si_1) then return(true) else find k_3 = k_1 <= N3_1 suchthat defined(r[k_1]) && (y_2 = pkgen2(r[k_1])) then return(false) else return(verify(m_1, y_2, si_1))))

6. equiv(suf_cma_corrupt_partial(mac))
  ! i <= N_3 new k_1: key; (
    ! i_1 <= N Omac(x_1: bitstring) := return(mac(x_1, k_1)) |
    ! i2 <= N2' Ocheck_unchanged(m': bitstring, ma': macres_t) := return(check(m', k_1, ma')) |
    ! i2_1 <= N2 Ocheck(m: bitstring, ma: macres_t) [useful_change] := return(check(m, k_1, ma)) |
    Ocorrupt() [10] := return(k_1))
<=(N_3 * Pmac(time + (N_3 - 1) * (N * time(mac, maxlength(LHS: x_1)) + N2' * time(check, maxlength(LHS: m')) + N2 * time(check, maxlength(LHS: m))), N, N2, N2', max(maxlength(LHS: x_1), max(maxlength(LHS: m), maxlength(LHS: m')))))=> [manual, computational]
  ! i_3 <= N_3 new k_1: key [unchanged]; (
    ! i_2 <= N Omac(x_3: bitstring) := let x_2: bitstring = x_3 in (let ma2: macres_t = mac(x_2, k_1) in return(ma2)) |
    ! i2_2 <= N2' Ocheck_unchanged(m'_2: bitstring, ma'_2: macres_t) := let m'_1: bitstring = m'_2 in (let ma'_1: macres_t = ma'_2 in return(check(m'_1, k_1, ma'_1))) |
    ! i2_3 <= N2 Ocheck(m_2: bitstring, ma_2: macres_t) [useful_change] := let m_1: bitstring = m_2 in (let ma_1: macres_t = ma_2 in if defined(corrupt) then return(check(m_1, k_1, ma_1)) else find j_2 = j_1 <= N suchthat defined(x_2[j_1], ma2[j_1]) && (m_1 = x_2[j_1]) && (ma_1 = ma2[j_1]) then return(true) else return(false)) |
    Ocorrupt() [10] := let corrupt: bool = true in return(k_1))

7. equiv(suf_cma_corrupt(mac))
  ! i <= N_3 new k_1: key; (
    ! i_1 <= N Omac(x_1: bitstring) := return(mac(x_1, k_1)) |
    ! i2 <= N2 Ocheck(m: bitstring, ma: macres_t) [useful_change] := return(check(m, k_1, ma)) |
    Ocorrupt() [10] := return(k_1))
<=(N_3 * Pmac(time + (N_3 - 1) * (N * time(mac, maxlength(LHS: x_1)) + N2 * time(check, maxlength(LHS: m))), N, N2, 0, max(maxlength(LHS: x_1), maxlength(LHS: m))))=> [manual, computational]
  ! i_3 <= N_3 new k_1: key [unchanged]; (
    ! i_2 <= N Omac(x_3: bitstring) := let x_2: bitstring = x_3 in (let ma2: macres_t = mac'(x_2, k_1) in return(ma2)) |
    ! i2_1 <= N2 Ocheck(m_2: bitstring, ma_2: macres_t) [useful_change] := let m_1: bitstring = m_2 in (let ma_1: macres_t = ma_2 in if defined(corrupt) then return(check(m_1, k_1, ma_1)) else find j_2 = j_1 <= N suchthat defined(x_2[j_1], ma2[j_1]) && (m_1 = x_2[j_1]) && (ma_1 = ma2[j_1]) then return(true) else return(false)) |
    Ocorrupt() [10] := let corrupt: bool = true in return(k_1))

8. equiv(suf_cma(mac))
  ! i <= N_3 new k_1: key; (
    ! i_1 <= N Omac(x_1: bitstring) := return(mac(x_1, k_1)) |
    ! i2 <= N2 Ocheck(m: bitstring, ma: macres_t) [useful_change] := return(check(m, k_1, ma)))
<=(N_3 * Pmac(time + (N_3 - 1) * (N * time(mac, maxlength(LHS: x_1)) + N2 * time(check, maxlength(LHS: m))), N, N2, 0, max(maxlength(LHS: x_1), maxlength(LHS: m))))=> [computational]
  ! i_3 <= N_3 new k_1: key [unchanged]; (
    ! i_2 <= N Omac(x_3: bitstring) := let x_2: bitstring = x_3 in (let ma2: macres_t = mac'(x_2, k_1) in return(ma2)) |
    ! i2_1 <= N2 Ocheck(m_2: bitstring, ma_2: macres_t) [useful_change] := let m_1: bitstring = m_2 in (let ma_1: macres_t = ma_2 in find j_2 = j_1 <= N suchthat defined(x_2[j_1], ma2[j_1]) && (m_1 = x_2[j_1]) && (ma_1 = ma2[j_1]) then return(true) else return(false)))

9. equiv(rom_partial(hash)) special rom_partial("key_first", hash, (hk_1, r, x_1, y_1, z_1, u), ("large"))

10. equiv(rom(hash)) special rom("key_first", hash, (hk_1, r, x_1, y_1, z_1, u), ("large"))

Please enter number of equivalence to consider: 8
equiv(suf_cma(mac))
  ! i <= N_3 new k_1: key; (
    ! i_1 <= N Omac(x_1: bitstring) := return(mac(x_1, k_1)) |
    ! i2 <= N2 Ocheck(m: bitstring, ma: macres_t) [useful_change] := return(check(m, k_1, ma)))
<=(N_3 * Pmac(time + (N_3 - 1) * (N * time(mac, maxlength(LHS: x_1)) + N2 * time(check, maxlength(LHS: m))), N, N2, 0, max(maxlength(LHS: x_1), maxlength(LHS: m))))=> [computational]
  ! i_3 <= N_3 new k_1: key [unchanged]; (
    ! i_2 <= N Omac(x_3: bitstring) := let x_2: bitstring = x_3 in (let ma2: macres_t = mac'(x_2, k_1) in return(ma2)) |
    ! i2_1 <= N2 Ocheck(m_2: bitstring, ma_2: macres_t) [useful_change] := let m_1: bitstring = m_2 in (let ma_1: macres_t = ma_2 in find j_2 = j_1 <= N suchthat defined(x_2[j_1], ma2[j_1]) && (m_1 = x_2[j_1]) && (ma_1 = ma2[j_1]) then return(true) else return(false)))
Please enter a command: show_game
     in(start, ());
     new r1: skeyseed;
     let spk1: spkey = spkgen(r1) in
     let ssk1: sskey = sskgen(r1) in
     new r2: keyseed;
     let pk2: pkey = pkgen(r2) in
     let sk2: skey = skgen(r2) in
     new r3: keyseed;
     let pk3: pkey = pkgen(r3) in
     new hk: key;
     new mkey: key;
     out(c1, ());
     ((
       ! i <= qChallenger
       in(c22[i], ());
       out(c23[i], ());
       in(c22[i], m2: bitstring);
       let injbot(quote_t2bitstring(quote_Ch: quote_t)) = dec(m2, sk2) in
       let quote_f(tdr_without_mac_Ch: tdr_without_mac_t, sig_Ch: signature) = quote_Ch in
       if verify(tdr_without_mac_t2bitstring(tdr_without_mac_Ch), spk1, sig_Ch) then
       let tdr_without_mac_f(smr_without_mac_Ch: smr_without_mac_t, res4_Ch: res_t, tdi_Ch: tdi_t) = tdr_without_mac_Ch in
       let smr_without_mac_f(rms_without_mac_Ch: rms_without_mac_t, tcbi_Ch: tcbi_t) = smr_without_mac_Ch in
       let rms_without_mac_f(rtyp_Ch: rtyp_t, res1_Ch: res_t, csvn_Ch: csvn_t, tcbh_Ch: hashoutput, tdih_Ch: hashoutput, rdata_Ch: rdata_t, res2_Ch: res_t) = rms_without_mac_Ch in
       let rdata_f(x1_Ch: pkey, y1_Ch: user_data_t) = rdata_Ch in
       event QuoteVerified(rtyp_Ch, res1_Ch, csvn_Ch, tcbh_Ch, tdih_Ch, rdata_Ch, res2_Ch);
       new session_key: key;
       let m_2: bitstring = key2bitstring(session_key) in
       new r_2: enc_seed;
       let m2_Ch: bitstring = enc_r(m_2, x1_Ch, r_2) in
       out(c23[i], m2_Ch)
     ) | (
       ! iH <= qH
       in(ch1[iH], x1_1: bitstring);
       out(ch2[iH], hash(hk, x1_1))
     ) | (
       ! i_1 <= qTD
       in(c4[i_1], ());
       new rdata_other: user_data_t;
       let rdata_TD: rdata_t = rdata_f(pk3, rdata_other) in
       out(c5[i_1], ());
       in(c12[i_1], ());
       find i_13 = i_2 <= qTDXM suchthat defined(tdr_TDXM[i_2]) then
       out(c13[i_1], tdr_TDXM[i_13])
     ) | (
       ! i_4 <= qTDXM
       in(c6[i_4], ());
       let tdi_TDXM: tdi_t = get_tdi in
       let tdih_TDXM: hashoutput = hash(hk, tdi_t2bitstring(tdi_TDXM)) in
       find i_14 = i_5 <= qTD suchthat defined(rdata_TD[i_5]) then
       (
         let rdata_TDXM: rdata_t = cst_rdata_t in
         let rtyp_TDXM: rtyp_t = get_rtyp in
         out(c7[i_4], ());
         in(c10[i_4], ());
         find j_4 = j <= qCPU suchthat defined(smr_CPU[j]) then
         let res4_TDXM: res_t = get_res in
         let tdr_TDXM: tdr_t = tdr_f(smr_CPU[j_4], res4_TDXM, tdi_TDXM) in
         event TDXMsentTDR_8(smr_CPU[j_4], tdi_TDXM);
         out(c11[i_4], ())
       )
       else
         let rtyp_TDXM: rtyp_t = get_rtyp
     ) | (
       ! i_7 <= qCPU
       in(c8[i_7], ());
       find i_15 = i_8 <= qTDXM suchthat defined(rdata_TD[i_14[i_8]], rdata_TDXM[i_8], rtyp_TDXM[i_8], tdih_TDXM[i_8]) then
       let csvn_CPU: csvn_t = get_csvn in
       let res1_CPU: res_t = get_res in
       let res2_CPU: res_t = get_res in
       let tcbi_CPU: tcbi_t = get_tcbi in
       let tcbh_CPU: hashoutput = hash(hk, tcbi_t2bitstring(tcbi_CPU)) in
       let rms_without_mac_CPU: rms_without_mac_t = rms_without_mac_f(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU) in
       let mac_CPU: macres_t = mac(rms_without_mac_t2bitstring(rms_without_mac_CPU), mkey) in
       let rms_CPU: rms_t = rms_f(rms_without_mac_CPU, mac_CPU) in
       let smr_CPU: smr_t = smr_f(rms_CPU, tcbi_CPU) in
       event CPUsentSMR(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU, mac_CPU, tcbi_CPU);
       out(c9[i_7], ());
       in(c18[i_7], ());
       find j_5 = j_2 <= qQE suchthat defined(rms_QE_to_CPU[j_2], rms_without_mac_QE[j_2], macres_QE[j_2]) then
       if check(rms_without_mac_t2bitstring(rms_without_mac_QE[j_5]), mkey, macres_QE[j_5]) then
       let rms_without_mac_from_CPU: rms_without_mac_t = cst_rms_without_mac_t in
       out(c19[i_7], ())
     ) | (
       ! i_10 <= qQE
       in(c16[i_10], tdr_QE: tdr_t);
       let tdr_f(smr_QE: smr_t, res4_QE: res_t, tdi_QE: tdi_t) = tdr_QE in
       let smr_f(rms_QE: rms_t, tcbi_QE: tcbi_t) = smr_QE in
       let rms_f(rms_without_mac_QE: rms_without_mac_t, macres_QE: macres_t) = rms_QE in
       let rms_without_mac_f(rtyp_QE: rtyp_t, res1_QE: res_t, csvn_QE: csvn_t, tcbh_QE: hashoutput, tdih_QE: hashoutput, rdata_QE: rdata_t, res2_QE: res_t) = rms_without_mac_QE in
       let rms_QE_to_CPU: rms_t = cst_rms_t in
       out(c17[i_10], ());
       in(c20[i_10], ());
       find i_16 = i_11 <= qCPU suchthat defined(rms_without_mac_from_CPU[i_11], rtyp_QE[j_5[i_11]], res1_QE[j_5[i_11]], csvn_QE[j_5[i_11]], tcbh_QE[j_5[i_11]], tdih_QE[j_5[i_11]], rdata_QE[j_5[i_11]], res2_QE[j_5[i_11]]) && (res2_QE = res2_QE[j_5[i_11]]) && (rdata_QE = rdata_QE[j_5[i_11]]) && (tdih_QE = tdih_QE[j_5[i_11]]) && (tcbh_QE = tcbh_QE[j_5[i_11]]) && (csvn_QE = csvn_QE[j_5[i_11]]) && (res1_QE = res1_QE[j_5[i_11]]) && (rtyp_QE = rtyp_QE[j_5[i_11]]) then
       event eve_QE(rtyp_QE, res1_QE, csvn_QE, tcbh_QE, tdih_QE, rdata_QE, res2_QE);
       event QEaccepted2_14(smr_QE, tdi_QE);
       let smr_without_mac_QE: smr_without_mac_t = smr_without_mac_f(rms_without_mac_QE, tcbi_QE) in
       let tdr_without_mac_QE: tdr_without_mac_t = tdr_without_mac_f(smr_without_mac_QE, res4_QE, tdi_QE) in
       let sig_QE: signature = sign(tdr_without_mac_t2bitstring(tdr_without_mac_QE), ssk1) in
       let quote_QE: quote_t = quote_f(tdr_without_mac_QE, sig_QE) in
       let m_3: bitstring = quote_t2bitstring(quote_QE) in
       new r_3: enc_seed;
       let m1: bitstring = enc_r(m_3, pk2, r_3) in
       out(c21[i_10], m1)
     ))

Please enter a command: crypto suf_cma(mac)
Trying equivalence suf_cma(mac)... Transf. OK Transf. done Succeeded.
Doing simplify (non-expanded game)... No change.
Doing expand... Done.
Doing remove assignments of findcond... Done.
Doing simplify... Run simplify 2 time(s). Fixpoint reached.
Done.
Doing move all binders... Done.
Doing remove assignments of findcond... No change.
Doing merge branches... No change.
Please enter a command: show_game
     in(start, ());
     new r1: skeyseed;
     let spk1: spkey = spkgen(r1) in
     let ssk1: sskey = sskgen(r1) in
     new r2: keyseed;
     let pk2: pkey = pkgen(r2) in
     let sk2: skey = skgen(r2) in
     new r3: keyseed;
     let pk3: pkey = pkgen(r3) in
     new hk: key;
     new mkey: key;
     out(c1, ());
     ((
       ! i <= qChallenger
       in(c22[i], ());
       out(c23[i], ());
       in(c22[i], m2: bitstring);
       let injbot(quote_t2bitstring(quote_Ch: quote_t)) = dec(m2, sk2) in
       let quote_f(tdr_without_mac_Ch: tdr_without_mac_t, sig_Ch: signature) = quote_Ch in
       if verify(tdr_without_mac_t2bitstring(tdr_without_mac_Ch), spk1, sig_Ch) then
       let tdr_without_mac_f(smr_without_mac_Ch: smr_without_mac_t, res4_Ch: res_t, tdi_Ch: tdi_t) = tdr_without_mac_Ch in
       let smr_without_mac_f(rms_without_mac_Ch: rms_without_mac_t, tcbi_Ch: tcbi_t) = smr_without_mac_Ch in
       let rms_without_mac_f(rtyp_Ch: rtyp_t, res1_Ch: res_t, csvn_Ch: csvn_t, tcbh_Ch: hashoutput, tdih_Ch: hashoutput, rdata_Ch: rdata_t, res2_Ch: res_t) = rms_without_mac_Ch in
       let rdata_f(x1_Ch: pkey, y1_Ch: user_data_t) = rdata_Ch in
       event QuoteVerified(rtyp_Ch, res1_Ch, csvn_Ch, tcbh_Ch, tdih_Ch, rdata_Ch, res2_Ch);
       new session_key: key;
       let m_2: bitstring = key2bitstring(session_key) in
       new r_2: enc_seed;
       let m2_Ch: bitstring = enc_r(m_2, x1_Ch, r_2) in
       out(c23[i], m2_Ch)
     ) | (
       ! iH <= qH
       in(ch1[iH], x1_1: bitstring);
       out(ch2[iH], hash(hk, x1_1))
     ) | (
       ! i_1 <= qTD
       in(c4[i_1], ());
       new rdata_other: user_data_t;
       let rdata_TD: rdata_t = rdata_f(pk3, rdata_other) in
       out(c5[i_1], ());
       in(c12[i_1], ());
       find i_13 = i_2 <= qTDXM suchthat defined(tdr_TDXM[i_2]) then
       out(c13[i_1], tdr_TDXM[i_13])
     ) | (
       ! i_4 <= qTDXM
       in(c6[i_4], ());
       let tdi_TDXM: tdi_t = get_tdi in
       let tdih_TDXM: hashoutput = hash(hk, tdi_t2bitstring(tdi_TDXM)) in
       find i_14 = i_5 <= qTD suchthat defined(rdata_TD[i_5]) then
       (
         let rtyp_TDXM: rtyp_t = get_rtyp in
         out(c7[i_4], ());
         in(c10[i_4], ());
         find j_4 = j <= qCPU suchthat defined(smr_CPU[j]) then
         let res4_TDXM: res_t = get_res in
         let tdr_TDXM: tdr_t = tdr_f(smr_CPU[j_4], res4_TDXM, tdi_TDXM) in
         event TDXMsentTDR_8(smr_CPU[j_4], tdi_TDXM);
         out(c11[i_4], ())
       )
       else
         let rtyp_TDXM: rtyp_t = get_rtyp
     ) | (
       ! i_7 <= qCPU
       in(c8[i_7], ());
       find i_15 = i_8 <= qTDXM suchthat defined(rdata_TD[i_14[i_8]], tdih_TDXM[i_8], rtyp_TDXM[i_8]) then
       let csvn_CPU: csvn_t = get_csvn in
       let res1_CPU: res_t = get_res in
       let res2_CPU: res_t = get_res in
       let tcbi_CPU: tcbi_t = get_tcbi in
       let tcbh_CPU: hashoutput = hash(hk, tcbi_t2bitstring(tcbi_CPU)) in
       let rms_without_mac_CPU: rms_without_mac_t = rms_without_mac_f(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU) in
       let x: bitstring = rms_without_mac_t2bitstring(rms_without_mac_CPU) in
       let ma2: macres_t = mac'(x, mkey) in
       let rms_CPU: rms_t = rms_f(rms_without_mac_CPU, ma2) in
       let smr_CPU: smr_t = smr_f(rms_CPU, tcbi_CPU) in
       event CPUsentSMR(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU, ma2, tcbi_CPU);
       out(c9[i_7], ());
       in(c18[i_7], ());
       find j_5 = j_2 <= qQE suchthat defined(rms_QE_to_CPU[j_2], macres_QE[j_2], rtyp_QE[j_2], res1_QE[j_2], csvn_QE[j_2], tcbh_QE[j_2], tdih_QE[j_2], rdata_QE[j_2], res2_QE[j_2], rms_without_mac_QE[j_2]) then
       find u = ri <= qCPU suchthat defined(ma2[ri], rtyp_TDXM[i_15[ri]], res1_CPU[ri], csvn_CPU[ri], tcbh_CPU[ri], tdih_TDXM[i_15[ri]], rdata_TD[i_14[i_15[ri]]], res2_CPU[ri]) && (res2_QE[j_5] = res2_CPU[ri]) && (rdata_QE[j_5] = rdata_TD[i_14[i_15[ri]]]) && (tdih_QE[j_5] = tdih_TDXM[i_15[ri]]) && (tcbh_QE[j_5] = tcbh_CPU[ri]) && (csvn_QE[j_5] = csvn_CPU[ri]) && (res1_QE[j_5] = res1_CPU[ri]) && (rtyp_QE[j_5] = rtyp_TDXM[i_15[ri]]) && (macres_QE[j_5] = ma2[ri]) then
       let rms_without_mac_from_CPU: rms_without_mac_t = cst_rms_without_mac_t in
       out(c19[i_7], ())
     ) | (
       ! i_10 <= qQE
       in(c16[i_10], tdr_QE: tdr_t);
       let tdr_f(smr_QE: smr_t, res4_QE: res_t, tdi_QE: tdi_t) = tdr_QE in
       let smr_f(rms_QE: rms_t, tcbi_QE: tcbi_t) = smr_QE in
       let rms_f(rms_without_mac_QE: rms_without_mac_t, macres_QE: macres_t) = rms_QE in
       let rms_without_mac_f(rtyp_QE: rtyp_t, res1_QE: res_t, csvn_QE: csvn_t, tcbh_QE: hashoutput, tdih_QE: hashoutput, rdata_QE: rdata_t, res2_QE: res_t) = rms_without_mac_QE in
       let rms_QE_to_CPU: rms_t = cst_rms_t in
       out(c17[i_10], ());
       in(c20[i_10], ());
       find i_16 = i_11 <= qCPU suchthat defined(rms_without_mac_from_CPU[i_11], rtyp_QE[j_5[i_11]], res1_QE[j_5[i_11]], csvn_QE[j_5[i_11]], tcbh_QE[j_5[i_11]], tdih_QE[j_5[i_11]], rdata_QE[j_5[i_11]], res2_QE[j_5[i_11]]) && (res2_QE = res2_QE[j_5[i_11]]) && (rdata_QE = rdata_QE[j_5[i_11]]) && (tdih_QE = tdih_QE[j_5[i_11]]) && (tcbh_QE = tcbh_QE[j_5[i_11]]) && (csvn_QE = csvn_QE[j_5[i_11]]) && (res1_QE = res1_QE[j_5[i_11]]) && (rtyp_QE = rtyp_QE[j_5[i_11]]) then
       event eve_QE(rtyp_QE, res1_QE, csvn_QE, tcbh_QE, tdih_QE, rdata_QE, res2_QE);
       event QEaccepted2_14(smr_QE, tdi_QE);
       let smr_without_mac_QE: smr_without_mac_t = smr_without_mac_f(rms_without_mac_QE, tcbi_QE) in
       let tdr_without_mac_QE: tdr_without_mac_t = tdr_without_mac_f(smr_without_mac_QE, res4_QE, tdi_QE) in
       let sig_QE: signature = sign(tdr_without_mac_t2bitstring(tdr_without_mac_QE), ssk1) in
       let quote_QE: quote_t = quote_f(tdr_without_mac_QE, sig_QE) in
       let m_3: bitstring = quote_t2bitstring(quote_QE) in
       new r_3: enc_seed;
       let m1: bitstring = enc_r(m_3, pk2, r_3) in
       out(c21[i_10], m1)
     ))

Please enter a command: crypto ind_cca2(enc)
Trying equivalence ind_cca2(enc)... Failed.
Doing remove assignments of binder x1_Ch... No change.
Doing remove assignments of binder pk2... Done.
Doing remove assignments of binder sk2... Done.
Trying equivalence ind_cca2(enc) with r_3, r_2, r2... Transf. OK Transf. done Succeeded.
Doing simplify (non-expanded game)... No change.
Doing expand... Applied collision new r1_1: keyseed; new r2_1: keyseed; return((pkgen(r1_1) = pkgen2_1(r2_1))) <=(Penccoll)=> return(false) with r2_1 -> r2_1, r1_1 -> r3 Probability: Penccoll
Done.
Doing remove assignments of findcond... Done.
Doing simplify... Doing global dependency analysis on session_key inside simplify... The variable session_key depends on session_key and occurs in a query.
No change
Doing global dependency analysis on session_key inside simplify... The variable session_key depends on session_key and occurs in a query.
No change
Run simplify 2 time(s). Fixpoint reached.
Done.
Doing move all binders... Done.
Doing remove assignments of findcond... Done.
Doing merge branches... No change.
Please enter a command: show_game
     in(start, ());
     new r1: skeyseed;
     let spk1: spkey = spkgen(r1) in
     new r2_1: keyseed;
     new r3: keyseed;
     let pk3: pkey = pkgen(r3) in
     new hk: key;
     new mkey: key;
     out(c1, ());
     ((
       ! i <= qChallenger
       in(c22[i], ());
       out(c23[i], ());
       in(c22[i], m2: bitstring);
       find u_2 = ri_2 <= qChallenger suchthat defined(session_key[ri_2], m2_1[ri_2]) && (m2 = m2_1[ri_2]) then
       (
         let quote_t2bitstring(quote_Ch: quote_t) = key2bitstring(session_key[u_2]) in
         let quote_f(tdr_without_mac_Ch: tdr_without_mac_t, sig_Ch: signature) = quote_Ch in
         if verify(tdr_without_mac_t2bitstring(tdr_without_mac_Ch), spk1, sig_Ch) then
         let tdr_without_mac_f(smr_without_mac_Ch: smr_without_mac_t, res4_Ch: res_t, tdi_Ch: tdi_t) = tdr_without_mac_Ch in
         let smr_without_mac_f(rms_without_mac_Ch: rms_without_mac_t, tcbi_Ch: tcbi_t) = smr_without_mac_Ch in
         let rms_without_mac_f(rtyp_Ch: rtyp_t, res1_Ch: res_t, csvn_Ch: csvn_t, tcbh_Ch: hashoutput, tdih_Ch: hashoutput, rdata_Ch: rdata_t, res2_Ch: res_t) = rms_without_mac_Ch in
         let rdata_f(x1_Ch: pkey, y1_Ch: user_data_t) = rdata_Ch in
         event QuoteVerified(rtyp_Ch, res1_Ch, csvn_Ch, tcbh_Ch, tdih_Ch, rdata_Ch, res2_Ch);
         if x1_Ch = pkgen2_1(r2_1) then
         (
           new r2_4: enc_seed;
           let m2_1: bitstring = enc_r2(Zkey, x1_Ch, r2_4) in
           new session_key: key;
           out(c23[i], m2_1)
         )
         else
           new r3_3: enc_seed;
           new session_key: key;
           let m_2: bitstring = key2bitstring(session_key) in
           let m2_Ch: bitstring = enc_r(m_2, x1_Ch, r3_3) in
           out(c23[i], m2_Ch)
       )
       orfind u_1 = ri_1 <= qQE suchthat defined(res2_QE[ri_1], rdata_QE[ri_1], tdih_QE[ri_1], tcbh_QE[ri_1], csvn_QE[ri_1], res1_QE[ri_1], rtyp_QE[ri_1], m1_1[ri_1]) && (m2 = m1_1[ri_1]) then
       (
         event QuoteVerified(rtyp_QE[u_1], res1_QE[u_1], csvn_QE[u_1], tcbh_QE[u_1], tdih_QE[u_1], rdata_QE[u_1], res2_QE[u_1]);
         new session_key: key;
         let m_2: bitstring = key2bitstring(session_key) in
         new r3_4: enc_seed;
         let m2_Ch: bitstring = enc_r(m_2, pk3, r3_4) in
         out(c23[i], m2_Ch)
       )
       else
         let injbot(quote_t2bitstring(quote_Ch: quote_t)) = dec2(m2, skgen2_1(r2_1)) in
         let quote_f(tdr_without_mac_Ch: tdr_without_mac_t, sig_Ch: signature) = quote_Ch in
         if verify(tdr_without_mac_t2bitstring(tdr_without_mac_Ch), spk1, sig_Ch) then
         let tdr_without_mac_f(smr_without_mac_Ch: smr_without_mac_t, res4_Ch: res_t, tdi_Ch: tdi_t) = tdr_without_mac_Ch in
         let smr_without_mac_f(rms_without_mac_Ch: rms_without_mac_t, tcbi_Ch: tcbi_t) = smr_without_mac_Ch in
         let rms_without_mac_f(rtyp_Ch: rtyp_t, res1_Ch: res_t, csvn_Ch: csvn_t, tcbh_Ch: hashoutput, tdih_Ch: hashoutput, rdata_Ch: rdata_t, res2_Ch: res_t) = rms_without_mac_Ch in
         let rdata_f(x1_Ch: pkey, y1_Ch: user_data_t) = rdata_Ch in
         event QuoteVerified(rtyp_Ch, res1_Ch, csvn_Ch, tcbh_Ch, tdih_Ch, rdata_Ch, res2_Ch);
         if x1_Ch = pkgen2_1(r2_1) then
         (
           new r2_3: enc_seed;
           let m2_1: bitstring = enc_r2(Zkey, x1_Ch, r2_3) in
           new session_key: key;
           out(c23[i], m2_1)
         )
         else
           new r3_2: enc_seed;
           new session_key: key;
           let m_2: bitstring = key2bitstring(session_key) in
           let m2_Ch: bitstring = enc_r(m_2, x1_Ch, r3_2) in
           out(c23[i], m2_Ch)
     ) | (
       ! iH <= qH
       in(ch1[iH], x1_1: bitstring);
       out(ch2[iH], hash(hk, x1_1))
     ) | (
       ! i_1 <= qTD
       in(c4[i_1], ());
       new rdata_other: user_data_t;
       let rdata_TD: rdata_t = rdata_f(pk3, rdata_other) in
       out(c5[i_1], ());
       in(c12[i_1], ());
       find i_13 = i_2 <= qTDXM suchthat defined(tdr_TDXM[i_2]) then
       out(c13[i_1], tdr_TDXM[i_13])
     ) | (
       ! i_4 <= qTDXM
       in(c6[i_4], ());
       let tdi_TDXM: tdi_t = get_tdi in
       let tdih_TDXM: hashoutput = hash(hk, tdi_t2bitstring(tdi_TDXM)) in
       find i_14 = i_5 <= qTD suchthat defined(rdata_TD[i_5]) then
       (
         let rtyp_TDXM: rtyp_t = get_rtyp in
         out(c7[i_4], ());
         in(c10[i_4], ());
         find j_4 = j <= qCPU suchthat defined(smr_CPU[j]) then
         let res4_TDXM: res_t = get_res in
         let tdr_TDXM: tdr_t = tdr_f(smr_CPU[j_4], res4_TDXM, tdi_TDXM) in
         event TDXMsentTDR_8(smr_CPU[j_4], tdi_TDXM);
         out(c11[i_4], ())
       )
       else
         let rtyp_TDXM: rtyp_t = get_rtyp
     ) | (
       ! i_7 <= qCPU
       in(c8[i_7], ());
       find i_15 = i_8 <= qTDXM suchthat defined(rdata_TD[i_14[i_8]], tdih_TDXM[i_8], rtyp_TDXM[i_8]) then
       let csvn_CPU: csvn_t = get_csvn in
       let res1_CPU: res_t = get_res in
       let res2_CPU: res_t = get_res in
       let tcbi_CPU: tcbi_t = get_tcbi in
       let tcbh_CPU: hashoutput = hash(hk, tcbi_t2bitstring(tcbi_CPU)) in
       let rms_without_mac_CPU: rms_without_mac_t = rms_without_mac_f(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU) in
       let x: bitstring = rms_without_mac_t2bitstring(rms_without_mac_CPU) in
       let ma2: macres_t = mac'(x, mkey) in
       let rms_CPU: rms_t = rms_f(rms_without_mac_CPU, ma2) in
       let smr_CPU: smr_t = smr_f(rms_CPU, tcbi_CPU) in
       event CPUsentSMR(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU, ma2, tcbi_CPU);
       out(c9[i_7], ());
       in(c18[i_7], ());
       find j_5 = j_2 <= qQE suchthat defined(rms_QE_to_CPU[j_2], macres_QE[j_2], rtyp_QE[j_2], res1_QE[j_2], csvn_QE[j_2], tcbh_QE[j_2], tdih_QE[j_2], rdata_QE[j_2], res2_QE[j_2]) then
       find u = ri <= qCPU suchthat defined(ma2[ri], rtyp_TDXM[i_15[ri]], res1_CPU[ri], csvn_CPU[ri], tcbh_CPU[ri], tdih_TDXM[i_15[ri]], rdata_TD[i_14[i_15[ri]]], res2_CPU[ri]) && (res2_QE[j_5] = res2_CPU[ri]) && (rdata_QE[j_5] = rdata_TD[i_14[i_15[ri]]]) && (tdih_QE[j_5] = tdih_TDXM[i_15[ri]]) && (tcbh_QE[j_5] = tcbh_CPU[ri]) && (csvn_QE[j_5] = csvn_CPU[ri]) && (res1_QE[j_5] = res1_CPU[ri]) && (rtyp_QE[j_5] = rtyp_TDXM[i_15[ri]]) && (macres_QE[j_5] = ma2[ri]) then
       let rms_without_mac_from_CPU: rms_without_mac_t = cst_rms_without_mac_t in
       out(c19[i_7], ())
     ) | (
       ! i_10 <= qQE
       in(c16[i_10], tdr_QE: tdr_t);
       let tdr_f(smr_QE: smr_t, res4_QE: res_t, tdi_QE: tdi_t) = tdr_QE in
       let smr_f(rms_QE: rms_t, tcbi_QE: tcbi_t) = smr_QE in
       let rms_f(rms_without_mac_QE: rms_without_mac_t, macres_QE: macres_t) = rms_QE in
       let rms_without_mac_f(rtyp_QE: rtyp_t, res1_QE: res_t, csvn_QE: csvn_t, tcbh_QE: hashoutput, tdih_QE: hashoutput, rdata_QE: rdata_t, res2_QE: res_t) = rms_without_mac_QE in
       let rms_QE_to_CPU: rms_t = cst_rms_t in
       out(c17[i_10], ());
       in(c20[i_10], ());
       find i_16 = i_11 <= qCPU suchthat defined(rms_without_mac_from_CPU[i_11], rtyp_QE[j_5[i_11]], res1_QE[j_5[i_11]], csvn_QE[j_5[i_11]], tcbh_QE[j_5[i_11]], tdih_QE[j_5[i_11]], rdata_QE[j_5[i_11]], res2_QE[j_5[i_11]]) && (res2_QE = res2_QE[j_5[i_11]]) && (rdata_QE = rdata_QE[j_5[i_11]]) && (tdih_QE = tdih_QE[j_5[i_11]]) && (tcbh_QE = tcbh_QE[j_5[i_11]]) && (csvn_QE = csvn_QE[j_5[i_11]]) && (res1_QE = res1_QE[j_5[i_11]]) && (rtyp_QE = rtyp_QE[j_5[i_11]]) then
       event eve_QE(rtyp_QE, res1_QE, csvn_QE, tcbh_QE, tdih_QE, rdata_QE, res2_QE);
       event QEaccepted2_14(smr_QE, tdi_QE);
       new r_4: enc_seed;
       let m1_1: bitstring = enc_r2(Zkey, pkgen2_1(r2_1), r_4) in
       out(c21[i_10], m1_1)
     ))

Please enter a command: crypto uf_cma(sign)
Trying equivalence uf_cma(sign)... Failed.
Doing remove assignments of binder spk1... Done.
Trying equivalence uf_cma(sign) with r1... Transf. OK Transf. done Succeeded.
Doing simplify (non-expanded game)... Done.
Doing expand... Done.
Doing remove assignments of findcond... No change.
Doing simplify... Run simplify 2 time(s). Fixpoint reached.
Done.
Doing move all binders... No change.
Doing remove assignments of findcond... No change.
Doing merge branches... No change.
Please enter a command: show_game
     in(start, ());
     new r2_1: keyseed;
     new r3: keyseed;
     let pk3: pkey = pkgen(r3) in
     new hk: key;
     new mkey: key;
     out(c1, ());
     ((
       ! i <= qChallenger
       in(c22[i], ());
       out(c23[i], ());
       in(c22[i], m2: bitstring);
       find u_1 = ri_1 <= qQE suchthat defined(res2_QE[ri_1], rdata_QE[ri_1], tdih_QE[ri_1], tcbh_QE[ri_1], csvn_QE[ri_1], res1_QE[ri_1], rtyp_QE[ri_1], m1_1[ri_1]) && (m2 = m1_1[ri_1]) then
       event QuoteVerified(rtyp_QE[u_1], res1_QE[u_1], csvn_QE[u_1], tcbh_QE[u_1], tdih_QE[u_1], rdata_QE[u_1], res2_QE[u_1]);
       new session_key: key;
       let m_2: bitstring = key2bitstring(session_key) in
       new r3_4: enc_seed;
       let m2_Ch: bitstring = enc_r(m_2, pk3, r3_4) in
       out(c23[i], m2_Ch)
     ) | (
       ! iH <= qH
       in(ch1[iH], x1_1: bitstring);
       out(ch2[iH], hash(hk, x1_1))
     ) | (
       ! i_1 <= qTD
       in(c4[i_1], ());
       new rdata_other: user_data_t;
       let rdata_TD: rdata_t = rdata_f(pk3, rdata_other) in
       out(c5[i_1], ());
       in(c12[i_1], ());
       find i_13 = i_2 <= qTDXM suchthat defined(tdr_TDXM[i_2]) then
       out(c13[i_1], tdr_TDXM[i_13])
     ) | (
       ! i_4 <= qTDXM
       in(c6[i_4], ());
       let tdi_TDXM: tdi_t = get_tdi in
       let tdih_TDXM: hashoutput = hash(hk, tdi_t2bitstring(tdi_TDXM)) in
       find i_14 = i_5 <= qTD suchthat defined(rdata_TD[i_5]) then
       (
         let rtyp_TDXM: rtyp_t = get_rtyp in
         out(c7[i_4], ());
         in(c10[i_4], ());
         find j_4 = j <= qCPU suchthat defined(smr_CPU[j]) then
         let res4_TDXM: res_t = get_res in
         let tdr_TDXM: tdr_t = tdr_f(smr_CPU[j_4], res4_TDXM, tdi_TDXM) in
         event TDXMsentTDR_8(smr_CPU[j_4], tdi_TDXM);
         out(c11[i_4], ())
       )
       else
         let rtyp_TDXM: rtyp_t = get_rtyp
     ) | (
       ! i_7 <= qCPU
       in(c8[i_7], ());
       find i_15 = i_8 <= qTDXM suchthat defined(rdata_TD[i_14[i_8]], tdih_TDXM[i_8], rtyp_TDXM[i_8]) then
       let csvn_CPU: csvn_t = get_csvn in
       let res1_CPU: res_t = get_res in
       let res2_CPU: res_t = get_res in
       let tcbi_CPU: tcbi_t = get_tcbi in
       let tcbh_CPU: hashoutput = hash(hk, tcbi_t2bitstring(tcbi_CPU)) in
       let rms_without_mac_CPU: rms_without_mac_t = rms_without_mac_f(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU) in
       let x: bitstring = rms_without_mac_t2bitstring(rms_without_mac_CPU) in
       let ma2: macres_t = mac'(x, mkey) in
       let rms_CPU: rms_t = rms_f(rms_without_mac_CPU, ma2) in
       let smr_CPU: smr_t = smr_f(rms_CPU, tcbi_CPU) in
       event CPUsentSMR(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU, ma2, tcbi_CPU);
       out(c9[i_7], ());
       in(c18[i_7], ());
       find j_5 = j_2 <= qQE suchthat defined(rms_QE_to_CPU[j_2], macres_QE[j_2], rtyp_QE[j_2], res1_QE[j_2], csvn_QE[j_2], tcbh_QE[j_2], tdih_QE[j_2], rdata_QE[j_2], res2_QE[j_2]) then
       find u = ri <= qCPU suchthat defined(ma2[ri], rtyp_TDXM[i_15[ri]], res1_CPU[ri], csvn_CPU[ri], tcbh_CPU[ri], tdih_TDXM[i_15[ri]], rdata_TD[i_14[i_15[ri]]], res2_CPU[ri]) && (res2_QE[j_5] = res2_CPU[ri]) && (rdata_QE[j_5] = rdata_TD[i_14[i_15[ri]]]) && (tdih_QE[j_5] = tdih_TDXM[i_15[ri]]) && (tcbh_QE[j_5] = tcbh_CPU[ri]) && (csvn_QE[j_5] = csvn_CPU[ri]) && (res1_QE[j_5] = res1_CPU[ri]) && (rtyp_QE[j_5] = rtyp_TDXM[i_15[ri]]) && (macres_QE[j_5] = ma2[ri]) then
       let rms_without_mac_from_CPU: rms_without_mac_t = cst_rms_without_mac_t in
       out(c19[i_7], ())
     ) | (
       ! i_10 <= qQE
       in(c16[i_10], tdr_QE: tdr_t);
       let tdr_f(smr_QE: smr_t, res4_QE: res_t, tdi_QE: tdi_t) = tdr_QE in
       let smr_f(rms_QE: rms_t, tcbi_QE: tcbi_t) = smr_QE in
       let rms_f(rms_without_mac_QE: rms_without_mac_t, macres_QE: macres_t) = rms_QE in
       let rms_without_mac_f(rtyp_QE: rtyp_t, res1_QE: res_t, csvn_QE: csvn_t, tcbh_QE: hashoutput, tdih_QE: hashoutput, rdata_QE: rdata_t, res2_QE: res_t) = rms_without_mac_QE in
       let rms_QE_to_CPU: rms_t = cst_rms_t in
       out(c17[i_10], ());
       in(c20[i_10], ());
       find i_16 = i_11 <= qCPU suchthat defined(rms_without_mac_from_CPU[i_11], rtyp_QE[j_5[i_11]], res1_QE[j_5[i_11]], csvn_QE[j_5[i_11]], tcbh_QE[j_5[i_11]], tdih_QE[j_5[i_11]], rdata_QE[j_5[i_11]], res2_QE[j_5[i_11]]) && (res2_QE = res2_QE[j_5[i_11]]) && (rdata_QE = rdata_QE[j_5[i_11]]) && (tdih_QE = tdih_QE[j_5[i_11]]) && (tcbh_QE = tcbh_QE[j_5[i_11]]) && (csvn_QE = csvn_QE[j_5[i_11]]) && (res1_QE = res1_QE[j_5[i_11]]) && (rtyp_QE = rtyp_QE[j_5[i_11]]) then
       event eve_QE(rtyp_QE, res1_QE, csvn_QE, tcbh_QE, tdih_QE, rdata_QE, res2_QE);
       event QEaccepted2_14(smr_QE, tdi_QE);
       new r_4: enc_seed;
       let m1_1: bitstring = enc_r2(Zkey, pkgen2_1(r2_1), r_4) in
       out(c21[i_10], m1_1)
     ))

Please enter a command: crypto ind_cca2(enc)
Trying equivalence ind_cca2(enc)... Failed.
Doing remove assignments of binder pk3... Done.
Trying equivalence ind_cca2(enc) with r3_4, r3... Transf. OK Transf. done Succeeded.
Doing simplify (non-expanded game)... No change.
Doing expand... Done.
Doing remove assignments of findcond... Done.
Doing simplify... Run simplify 2 time(s). Fixpoint reached.
Done.
Doing move all binders... No change.
Doing remove assignments of findcond... Done.
Doing merge branches... No change.
Please enter a command: show_game
     in(start, ());
     new r2_1: keyseed;
     new r3_6: keyseed;
     new hk: key;
     new mkey: key;
     out(c1, ());
     ((
       ! i <= qChallenger
       in(c22[i], ());
       out(c23[i], ());
       in(c22[i], m2: bitstring);
       find u_1 = ri_1 <= qQE suchthat defined(res2_QE[ri_1], rdata_QE[ri_1], tdih_QE[ri_1], tcbh_QE[ri_1], csvn_QE[ri_1], res1_QE[ri_1], rtyp_QE[ri_1], m1_1[ri_1]) && (m2 = m1_1[ri_1]) then
       event QuoteVerified(rtyp_QE[u_1], res1_QE[u_1], csvn_QE[u_1], tcbh_QE[u_1], tdih_QE[u_1], rdata_QE[u_1], res2_QE[u_1]);
       new session_key: key;
       new r3_5: enc_seed;
       let m1_4: bitstring = enc_r2(Zkey, pkgen2_1(r3_6), r3_5) in
       out(c23[i], m1_4)
     ) | (
       ! iH <= qH
       in(ch1[iH], x1_1: bitstring);
       out(ch2[iH], hash(hk, x1_1))
     ) | (
       ! i_1 <= qTD
       in(c4[i_1], ());
       new rdata_other: user_data_t;
       let rdata_TD: rdata_t = rdata_f(pkgen2_1(r3_6), rdata_other) in
       out(c5[i_1], ());
       in(c12[i_1], ());
       find i_13 = i_2 <= qTDXM suchthat defined(tdr_TDXM[i_2]) then
       out(c13[i_1], tdr_TDXM[i_13])
     ) | (
       ! i_4 <= qTDXM
       in(c6[i_4], ());
       let tdi_TDXM: tdi_t = get_tdi in
       let tdih_TDXM: hashoutput = hash(hk, tdi_t2bitstring(tdi_TDXM)) in
       find i_14 = i_5 <= qTD suchthat defined(rdata_TD[i_5]) then
       (
         let rtyp_TDXM: rtyp_t = get_rtyp in
         out(c7[i_4], ());
         in(c10[i_4], ());
         find j_4 = j <= qCPU suchthat defined(smr_CPU[j]) then
         let res4_TDXM: res_t = get_res in
         let tdr_TDXM: tdr_t = tdr_f(smr_CPU[j_4], res4_TDXM, tdi_TDXM) in
         event TDXMsentTDR_8(smr_CPU[j_4], tdi_TDXM);
         out(c11[i_4], ())
       )
       else
         let rtyp_TDXM: rtyp_t = get_rtyp
     ) | (
       ! i_7 <= qCPU
       in(c8[i_7], ());
       find i_15 = i_8 <= qTDXM suchthat defined(rdata_TD[i_14[i_8]], tdih_TDXM[i_8], rtyp_TDXM[i_8]) then
       let csvn_CPU: csvn_t = get_csvn in
       let res1_CPU: res_t = get_res in
       let res2_CPU: res_t = get_res in
       let tcbi_CPU: tcbi_t = get_tcbi in
       let tcbh_CPU: hashoutput = hash(hk, tcbi_t2bitstring(tcbi_CPU)) in
       let rms_without_mac_CPU: rms_without_mac_t = rms_without_mac_f(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU) in
       let x: bitstring = rms_without_mac_t2bitstring(rms_without_mac_CPU) in
       let ma2: macres_t = mac'(x, mkey) in
       let rms_CPU: rms_t = rms_f(rms_without_mac_CPU, ma2) in
       let smr_CPU: smr_t = smr_f(rms_CPU, tcbi_CPU) in
       event CPUsentSMR(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU, ma2, tcbi_CPU);
       out(c9[i_7], ());
       in(c18[i_7], ());
       find j_5 = j_2 <= qQE suchthat defined(rms_QE_to_CPU[j_2], macres_QE[j_2], rtyp_QE[j_2], res1_QE[j_2], csvn_QE[j_2], tcbh_QE[j_2], tdih_QE[j_2], rdata_QE[j_2], res2_QE[j_2]) then
       find u = ri <= qCPU suchthat defined(ma2[ri], rtyp_TDXM[i_15[ri]], res1_CPU[ri], csvn_CPU[ri], tcbh_CPU[ri], tdih_TDXM[i_15[ri]], rdata_TD[i_14[i_15[ri]]], res2_CPU[ri]) && (res2_QE[j_5] = res2_CPU[ri]) && (rdata_QE[j_5] = rdata_TD[i_14[i_15[ri]]]) && (tdih_QE[j_5] = tdih_TDXM[i_15[ri]]) && (tcbh_QE[j_5] = tcbh_CPU[ri]) && (csvn_QE[j_5] = csvn_CPU[ri]) && (res1_QE[j_5] = res1_CPU[ri]) && (rtyp_QE[j_5] = rtyp_TDXM[i_15[ri]]) && (macres_QE[j_5] = ma2[ri]) then
       let rms_without_mac_from_CPU: rms_without_mac_t = cst_rms_without_mac_t in
       out(c19[i_7], ())
     ) | (
       ! i_10 <= qQE
       in(c16[i_10], tdr_QE: tdr_t);
       let tdr_f(smr_QE: smr_t, res4_QE: res_t, tdi_QE: tdi_t) = tdr_QE in
       let smr_f(rms_QE: rms_t, tcbi_QE: tcbi_t) = smr_QE in
       let rms_f(rms_without_mac_QE: rms_without_mac_t, macres_QE: macres_t) = rms_QE in
       let rms_without_mac_f(rtyp_QE: rtyp_t, res1_QE: res_t, csvn_QE: csvn_t, tcbh_QE: hashoutput, tdih_QE: hashoutput, rdata_QE: rdata_t, res2_QE: res_t) = rms_without_mac_QE in
       let rms_QE_to_CPU: rms_t = cst_rms_t in
       out(c17[i_10], ());
       in(c20[i_10], ());
       find i_16 = i_11 <= qCPU suchthat defined(rms_without_mac_from_CPU[i_11], rtyp_QE[j_5[i_11]], res1_QE[j_5[i_11]], csvn_QE[j_5[i_11]], tcbh_QE[j_5[i_11]], tdih_QE[j_5[i_11]], rdata_QE[j_5[i_11]], res2_QE[j_5[i_11]]) && (res2_QE = res2_QE[j_5[i_11]]) && (rdata_QE = rdata_QE[j_5[i_11]]) && (tdih_QE = tdih_QE[j_5[i_11]]) && (tcbh_QE = tcbh_QE[j_5[i_11]]) && (csvn_QE = csvn_QE[j_5[i_11]]) && (res1_QE = res1_QE[j_5[i_11]]) && (rtyp_QE = rtyp_QE[j_5[i_11]]) then
       event eve_QE(rtyp_QE, res1_QE, csvn_QE, tcbh_QE, tdih_QE, rdata_QE, res2_QE);
       event QEaccepted2_14(smr_QE, tdi_QE);
       new r_4: enc_seed;
       let m1_1: bitstring = enc_r2(Zkey, pkgen2_1(r2_1), r_4) in
       out(c21[i_10], m1_1)
     ))

Please enter a command: success
Proved query event(QuoteVerified(x1, x2, x3, x4, x5, x6, x7)) ==> event(eve_QE(x1, x2, x3, x4, x5, x6, x7))
Proved query event(eve_QE(x1, x2, x3, x4, x5, x6, x7)) ==> event(CPUsentSMR(x1, x2, x3, x4, x5, x6, x7, x8, x9))
Proved query event(QuoteVerified(x1, x2, x3, x4, x5, x6, x7)) ==> event(CPUsentSMR(x1, x2, x3, x4, x5, x6, x7, x8, x9))
Proof of event(QEaccepted2_14(x1, x2)) ==> event(TDXMsentTDR_8(x1, x2)) failed:
  Found QEaccepted2_14(smr_QE, tdi_QE) at 473
  but could not prove event(TDXMsentTDR_8(x1, x2))
Proved one-session secrecy of session_key
Proved secrecy of session_key
Sorry, the following queries remain unproved:
- event(QEaccepted2_14(x1, x2)) ==> event(TDXMsentTDR_8(x1, x2))
Please enter a command: ^CStopped. Restarting from the state before the last command.
Please enter a command: show_game
     in(start, ());
     new r2_1: keyseed;
     new r3_6: keyseed;
     new hk: key;
     new mkey: key;
     out(c1, ());
     ((
       ! i <= qChallenger
       in(c22[i], ());
       out(c23[i], ());
       in(c22[i], m2: bitstring);
       find u_1 = ri_1 <= qQE suchthat defined(res2_QE[ri_1], rdata_QE[ri_1], tdih_QE[ri_1], tcbh_QE[ri_1], csvn_QE[ri_1], res1_QE[ri_1], rtyp_QE[ri_1], m1_1[ri_1]) && (m2 = m1_1[ri_1]) then
       event QuoteVerified(rtyp_QE[u_1], res1_QE[u_1], csvn_QE[u_1], tcbh_QE[u_1], tdih_QE[u_1], rdata_QE[u_1], res2_QE[u_1]);
       new session_key: key;
       new r3_5: enc_seed;
       let m1_4: bitstring = enc_r2(Zkey, pkgen2_1(r3_6), r3_5) in
       out(c23[i], m1_4)
     ) | (
       ! iH <= qH
       in(ch1[iH], x1_1: bitstring);
       out(ch2[iH], hash(hk, x1_1))
     ) | (
       ! i_1 <= qTD
       in(c4[i_1], ());
       new rdata_other: user_data_t;
       let rdata_TD: rdata_t = rdata_f(pkgen2_1(r3_6), rdata_other) in
       out(c5[i_1], ());
       in(c12[i_1], ());
       find i_13 = i_2 <= qTDXM suchthat defined(tdr_TDXM[i_2]) then
       out(c13[i_1], tdr_TDXM[i_13])
     ) | (
       ! i_4 <= qTDXM
       in(c6[i_4], ());
       let tdi_TDXM: tdi_t = get_tdi in
       let tdih_TDXM: hashoutput = hash(hk, tdi_t2bitstring(tdi_TDXM)) in
       find i_14 = i_5 <= qTD suchthat defined(rdata_TD[i_5]) then
       (
         let rtyp_TDXM: rtyp_t = get_rtyp in
         out(c7[i_4], ());
         in(c10[i_4], ());
         find j_4 = j <= qCPU suchthat defined(smr_CPU[j]) then
         let res4_TDXM: res_t = get_res in
         let tdr_TDXM: tdr_t = tdr_f(smr_CPU[j_4], res4_TDXM, tdi_TDXM) in
         event TDXMsentTDR_8(smr_CPU[j_4], tdi_TDXM);
         out(c11[i_4], ())
       )
       else
         let rtyp_TDXM: rtyp_t = get_rtyp
     ) | (
       ! i_7 <= qCPU
       in(c8[i_7], ());
       find i_15 = i_8 <= qTDXM suchthat defined(rdata_TD[i_14[i_8]], tdih_TDXM[i_8], rtyp_TDXM[i_8]) then
       let csvn_CPU: csvn_t = get_csvn in
       let res1_CPU: res_t = get_res in
       let res2_CPU: res_t = get_res in
       let tcbi_CPU: tcbi_t = get_tcbi in
       let tcbh_CPU: hashoutput = hash(hk, tcbi_t2bitstring(tcbi_CPU)) in
       let rms_without_mac_CPU: rms_without_mac_t = rms_without_mac_f(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU) in
       let x: bitstring = rms_without_mac_t2bitstring(rms_without_mac_CPU) in
       let ma2: macres_t = mac'(x, mkey) in
       let rms_CPU: rms_t = rms_f(rms_without_mac_CPU, ma2) in
       let smr_CPU: smr_t = smr_f(rms_CPU, tcbi_CPU) in
       event CPUsentSMR(rtyp_TDXM[i_15], res1_CPU, csvn_CPU, tcbh_CPU, tdih_TDXM[i_15], rdata_TD[i_14[i_15]], res2_CPU, ma2, tcbi_CPU);
       out(c9[i_7], ());
       in(c18[i_7], ());
       find j_5 = j_2 <= qQE suchthat defined(rms_QE_to_CPU[j_2], macres_QE[j_2], rtyp_QE[j_2], res1_QE[j_2], csvn_QE[j_2], tcbh_QE[j_2], tdih_QE[j_2], rdata_QE[j_2], res2_QE[j_2]) then
       find u = ri <= qCPU suchthat defined(ma2[ri], rtyp_TDXM[i_15[ri]], res1_CPU[ri], csvn_CPU[ri], tcbh_CPU[ri], tdih_TDXM[i_15[ri]], rdata_TD[i_14[i_15[ri]]], res2_CPU[ri]) && (res2_QE[j_5] = res2_CPU[ri]) && (rdata_QE[j_5] = rdata_TD[i_14[i_15[ri]]]) && (tdih_QE[j_5] = tdih_TDXM[i_15[ri]]) && (tcbh_QE[j_5] = tcbh_CPU[ri]) && (csvn_QE[j_5] = csvn_CPU[ri]) && (res1_QE[j_5] = res1_CPU[ri]) && (rtyp_QE[j_5] = rtyp_TDXM[i_15[ri]]) && (macres_QE[j_5] = ma2[ri]) then
       let rms_without_mac_from_CPU: rms_without_mac_t = cst_rms_without_mac_t in
       out(c19[i_7], ())
     ) | (
       ! i_10 <= qQE
       in(c16[i_10], tdr_QE: tdr_t);
       let tdr_f(smr_QE: smr_t, res4_QE: res_t, tdi_QE: tdi_t) = tdr_QE in
       let smr_f(rms_QE: rms_t, tcbi_QE: tcbi_t) = smr_QE in
       let rms_f(rms_without_mac_QE: rms_without_mac_t, macres_QE: macres_t) = rms_QE in
       let rms_without_mac_f(rtyp_QE: rtyp_t, res1_QE: res_t, csvn_QE: csvn_t, tcbh_QE: hashoutput, tdih_QE: hashoutput, rdata_QE: rdata_t, res2_QE: res_t) = rms_without_mac_QE in
       let rms_QE_to_CPU: rms_t = cst_rms_t in
       out(c17[i_10], ());
       in(c20[i_10], ());
       find i_16 = i_11 <= qCPU suchthat defined(rms_without_mac_from_CPU[i_11], rtyp_QE[j_5[i_11]], res1_QE[j_5[i_11]], csvn_QE[j_5[i_11]], tcbh_QE[j_5[i_11]], tdih_QE[j_5[i_11]], rdata_QE[j_5[i_11]], res2_QE[j_5[i_11]]) && (res2_QE = res2_QE[j_5[i_11]]) && (rdata_QE = rdata_QE[j_5[i_11]]) && (tdih_QE = tdih_QE[j_5[i_11]]) && (tcbh_QE = tcbh_QE[j_5[i_11]]) && (csvn_QE = csvn_QE[j_5[i_11]]) && (res1_QE = res1_QE[j_5[i_11]]) && (rtyp_QE = rtyp_QE[j_5[i_11]]) then
       event eve_QE(rtyp_QE, res1_QE, csvn_QE, tcbh_QE, tdih_QE, rdata_QE, res2_QE);
       event QEaccepted2_14(smr_QE, tdi_QE);
       new r_4: enc_seed;
       let m1_1: bitstring = enc_r2(Zkey, pkgen2_1(r2_1), r_4) in
       out(c21[i_10], m1_1)
     ))

Please enter a command: ^A
