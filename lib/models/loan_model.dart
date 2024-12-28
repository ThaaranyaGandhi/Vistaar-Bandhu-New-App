class LoanModel {
  String? indexRt;
  String? cCustomerNo;
  String? cAddrSeq;
  String? loSzReststatus;
  String? restructureYn;
  String? nxtbillamnt;
  String? szLoanQual;
  String? szLoanQualCd;
  String? loIOthrchrg;
  String? preemiflg;
  String? loSzAddr1;
  String? provisionAmount;
  String? loSzAddr2;
  String? loILnamt;
  String? loDtDisburdt;
  String? loIPenalrt;
  String? loDtPaymentamt;
  String? cDobCAge;
  String? szOrgCode;
  String? loIDownpayment;
  String? indexRtFrq;
  String? loSzDelistr;
  String? loDtTenorstdt;
  String? fResidualAmt;
  String? loSzRepfrq;
  String? cAddress2;
  String? loSzEmail;
  String? loDtAssetVal;
  String? cAddress1;
  String? loDtTenorendt;
  String? mloIAdvemi;
  String? fSubprdDues;
  String? loIPurchacepz;
  String? loPdcRec;
  String? spreadRt;
  String? loDtDob;
  String? loIMarketpz;
  String? loISubprodchrg;
  String? cEmail;
  String? loIEmi;
  String? loIPrndue;
  String? loIOsprinciple;
  String? iNoofadvemi;
  String? iTrancheNo;
  String? loIPenalchrg;
  String? fDepositAmt;
  String? loSzAstStat;
  String? loIDepripz;
  String? iInsurOs;
  String? loIAdvemi;
  String? loSzContact;
  String? loDtPaymentdt;
  String? loITotdue;
  String? loIInstrt;
  String? cEmployerName;
  String? nextRevDt;
  String? iAdvEmi;
  String? loISubchrge;
  String? ovSzIntyp;
  String? loSzAstmodel;
  String? cPan;
  String? loDtClosedt;
  String? loSzTenor;
  String? loIExsamnt;
  String? loSzName;
  String? loSzPayment;
  String? accNo;
  String? bAddrSeq;
  String? szNpaStatus;
  String? iTotDueChgs;
  String? szDisbStat;
  String? bPan;
  String? loIMonthinst;
  String? loITenor;
  String? cNegativeAmortYn;
  String? iBaltenor;
  String? dtNextIdxReview;
  String? iDpd;
  String? offsetRt;
  String? fPremiumAmt;
  String? cSzName;
  String? loDtNxtdt;
  String? loIInstdue;
  String? cPreEmiOption;
  String? cMbl;
  String? bEmployerName;
  String? loIAssetVal;

  LoanModel(
      {this.indexRt,
      this.cCustomerNo,
      this.cAddrSeq,
      this.loSzReststatus,
      this.restructureYn,
      this.nxtbillamnt,
      this.szLoanQual,
      this.szLoanQualCd,
      this.loIOthrchrg,
      this.preemiflg,
      this.loSzAddr1,
      this.provisionAmount,
      this.loSzAddr2,
      this.loILnamt,
      this.loDtDisburdt,
      this.loIPenalrt,
      this.loDtPaymentamt,
      this.cDobCAge,
      this.szOrgCode,
      this.loIDownpayment,
      this.indexRtFrq,
      this.loSzDelistr,
      this.loDtTenorstdt,
      this.fResidualAmt,
      this.loSzRepfrq,
      this.cAddress2,
      this.loSzEmail,
      this.loDtAssetVal,
      this.cAddress1,
      this.loDtTenorendt,
      this.mloIAdvemi,
      this.fSubprdDues,
      this.loIPurchacepz,
      this.loPdcRec,
      this.spreadRt,
      this.loDtDob,
      this.loIMarketpz,
      this.loISubprodchrg,
      this.cEmail,
      this.loIEmi,
      this.loIPrndue,
      this.loIOsprinciple,
      this.iNoofadvemi,
      this.iTrancheNo,
      this.loIPenalchrg,
      this.fDepositAmt,
      this.loSzAstStat,
      this.loIDepripz,
      this.iInsurOs,
      this.loIAdvemi,
      this.loSzContact,
      this.loDtPaymentdt,
      this.loITotdue,
      this.loIInstrt,
      this.cEmployerName,
      this.nextRevDt,
      this.iAdvEmi,
      this.loISubchrge,
      this.ovSzIntyp,
      this.loSzAstmodel,
      this.cPan,
      this.loDtClosedt,
      this.loSzTenor,
      this.loIExsamnt,
      this.loSzName,
      this.loSzPayment,
      this.accNo,
      this.bAddrSeq,
      this.szNpaStatus,
      this.iTotDueChgs,
      this.szDisbStat,
      this.bPan,
      this.loIMonthinst,
      this.loITenor,
      this.cNegativeAmortYn,
      this.iBaltenor,
      this.dtNextIdxReview,
      this.iDpd,
      this.offsetRt,
      this.fPremiumAmt,
      this.cSzName,
      this.loDtNxtdt,
      this.loIInstdue,
      this.cPreEmiOption,
      this.cMbl,
      this.bEmployerName,
      this.loIAssetVal});

  LoanModel.fromJson(Map<String, dynamic> json) {
    indexRt = json['index_rt'];
    cCustomerNo = json['c_customer_no'];
    cAddrSeq = json['c_addr_seq'];
    loSzReststatus = json['lo_sz_reststatus'];
    restructureYn = json['restructure_yn'];
    nxtbillamnt = json['nxtbillamnt'];
    szLoanQual = json['sz_loan_qual'];
    szLoanQualCd = json['sz_loan_qual_cd'];
    loIOthrchrg = json['lo_i_othrchrg'];
    preemiflg = json['preemiflg'];
    loSzAddr1 = json['lo_sz_addr1'];
    provisionAmount = json['provision_amount'];
    loSzAddr2 = json['lo_sz_addr2'];
    loILnamt = json['lo_i_lnamt'];
    loDtDisburdt = json['lo_dt_disburdt'];
    loIPenalrt = json['lo_i_penalrt'];
    loDtPaymentamt = json['lo_dt_paymentamt'];
    cDobCAge = json['c_dob||/||c_age'];
    szOrgCode = json['sz_org_code'];
    loIDownpayment = json['lo_i_downpayment'];
    indexRtFrq = json['index_rt_frq'];
    loSzDelistr = json['lo_sz_delistr'];
    loDtTenorstdt = json['lo_dt_tenorstdt'];
    fResidualAmt = json['f_residual_amt'];
    loSzRepfrq = json['lo_sz_repfrq'];
    cAddress2 = json['c_address_2'];
    loSzEmail = json['lo_sz_email'];
    loDtAssetVal = json['lo_dt_asset_val'];
    cAddress1 = json['c_address_1'];
    loDtTenorendt = json['lo_dt_tenorendt'];
    mloIAdvemi = json['mlo_i_advemi'];
    fSubprdDues = json['f_subprd_dues'];
    loIPurchacepz = json['lo_i_purchacepz'];
    loPdcRec = json['lo_pdc_rec'];
    spreadRt = json['spread_rt'];
    loDtDob = json['lo_dt_dob'];
    loIMarketpz = json['lo_i_marketpz'];
    loISubprodchrg = json['lo_i_subprodchrg'];
    cEmail = json['c_email'];
    loIEmi = json['lo_i_emi'];
    loIPrndue = json['lo_i_prndue'];
    loIOsprinciple = json['lo_i_osprinciple'];
    iNoofadvemi = json['i_noofadvemi'];
    iTrancheNo = json['i_tranche_no'];
    loIPenalchrg = json['lo_i_penalchrg'];
    fDepositAmt = json['f_deposit_amt'];
    loSzAstStat = json['lo_sz_ast_stat'];
    loIDepripz = json['lo_i_depripz'];
    iInsurOs = json['i_insur_os'];
    loIAdvemi = json['lo_i_advemi'];
    loSzContact = json['lo_sz_contact'];
    loDtPaymentdt = json['lo_dt_paymentdt'];
    loITotdue = json['lo_i_totdue'];
    loIInstrt = json['lo_i_instrt'];
    cEmployerName = json['c_employer_name'];
    nextRevDt = json['next_rev_dt'];
    iAdvEmi = json['i_adv_emi'];
    loISubchrge = json['lo_i_subchrge'];
    ovSzIntyp = json['ov_sz_intyp'];
    loSzAstmodel = json['lo_sz_astmodel'];
    cPan = json['c_pan'];
    loDtClosedt = json['lo_dt_closedt'];
    loSzTenor = json['lo_sz_tenor'];
    loIExsamnt = json['lo_i_exsamnt'];
    loSzName = json['lo_sz_name'];
    loSzPayment = json['lo_sz_payment'];
    accNo = json['acc_no'];
    bAddrSeq = json['b_addr_seq'];
    szNpaStatus = json['sz_npa_status'];
    iTotDueChgs = json['i_tot_due_chgs'];
    szDisbStat = json['sz_disb_stat'];
    bPan = json['b_pan'];
    loIMonthinst = json['lo_i_monthinst'];
    loITenor = json['lo_i_tenor'];
    cNegativeAmortYn = json['c_negative_amort_yn'];
    iBaltenor = json['i_baltenor'];
    dtNextIdxReview = json['dt_next_idx_review'];
    iDpd = json['i_dpd'];
    offsetRt = json['offset_rt'];
    fPremiumAmt = json['f_premium_amt'];
    cSzName = json['c_sz_name'];
    loDtNxtdt = json['lo_dt_nxtdt'];
    loIInstdue = json['lo_i_instdue'];
    cPreEmiOption = json['c_pre_emi_option'];
    cMbl = json['c_mbl'];
    bEmployerName = json['b_employer_name'];
    loIAssetVal = json['lo_i_asset_val'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index_rt'] = this.indexRt;
    data['c_customer_no'] = this.cCustomerNo;
    data['c_addr_seq'] = this.cAddrSeq;
    data['lo_sz_reststatus'] = this.loSzReststatus;
    data['restructure_yn'] = this.restructureYn;
    data['nxtbillamnt'] = this.nxtbillamnt;
    data['sz_loan_qual'] = this.szLoanQual;
    data['sz_loan_qual_cd'] = this.szLoanQualCd;
    data['lo_i_othrchrg'] = this.loIOthrchrg;
    data['preemiflg'] = this.preemiflg;
    data['lo_sz_addr1'] = this.loSzAddr1;
    data['provision_amount'] = this.provisionAmount;
    data['lo_sz_addr2'] = this.loSzAddr2;
    data['lo_i_lnamt'] = this.loILnamt;
    data['lo_dt_disburdt'] = this.loDtDisburdt;
    data['lo_i_penalrt'] = this.loIPenalrt;
    data['lo_dt_paymentamt'] = this.loDtPaymentamt;
    data['c_dob||/||c_age'] = this.cDobCAge;
    data['sz_org_code'] = this.szOrgCode;
    data['lo_i_downpayment'] = this.loIDownpayment;
    data['index_rt_frq'] = this.indexRtFrq;
    data['lo_sz_delistr'] = this.loSzDelistr;
    data['lo_dt_tenorstdt'] = this.loDtTenorstdt;
    data['f_residual_amt'] = this.fResidualAmt;
    data['lo_sz_repfrq'] = this.loSzRepfrq;
    data['c_address_2'] = this.cAddress2;
    data['lo_sz_email'] = this.loSzEmail;
    data['lo_dt_asset_val'] = this.loDtAssetVal;
    data['c_address_1'] = this.cAddress1;
    data['lo_dt_tenorendt'] = this.loDtTenorendt;
    data['mlo_i_advemi'] = this.mloIAdvemi;
    data['f_subprd_dues'] = this.fSubprdDues;
    data['lo_i_purchacepz'] = this.loIPurchacepz;
    data['lo_pdc_rec'] = this.loPdcRec;
    data['spread_rt'] = this.spreadRt;
    data['lo_dt_dob'] = this.loDtDob;
    data['lo_i_marketpz'] = this.loIMarketpz;
    data['lo_i_subprodchrg'] = this.loISubprodchrg;
    data['c_email'] = this.cEmail;
    data['lo_i_emi'] = this.loIEmi;
    data['lo_i_prndue'] = this.loIPrndue;
    data['lo_i_osprinciple'] = this.loIOsprinciple;
    data['i_noofadvemi'] = this.iNoofadvemi;
    data['i_tranche_no'] = this.iTrancheNo;
    data['lo_i_penalchrg'] = this.loIPenalchrg;
    data['f_deposit_amt'] = this.fDepositAmt;
    data['lo_sz_ast_stat'] = this.loSzAstStat;
    data['lo_i_depripz'] = this.loIDepripz;
    data['i_insur_os'] = this.iInsurOs;
    data['lo_i_advemi'] = this.loIAdvemi;
    data['lo_sz_contact'] = this.loSzContact;
    data['lo_dt_paymentdt'] = this.loDtPaymentdt;
    data['lo_i_totdue'] = this.loITotdue;
    data['lo_i_instrt'] = this.loIInstrt;
    data['c_employer_name'] = this.cEmployerName;
    data['next_rev_dt'] = this.nextRevDt;
    data['i_adv_emi'] = this.iAdvEmi;
    data['lo_i_subchrge'] = this.loISubchrge;
    data['ov_sz_intyp'] = this.ovSzIntyp;
    data['lo_sz_astmodel'] = this.loSzAstmodel;
    data['c_pan'] = this.cPan;
    data['lo_dt_closedt'] = this.loDtClosedt;
    data['lo_sz_tenor'] = this.loSzTenor;
    data['lo_i_exsamnt'] = this.loIExsamnt;
    data['lo_sz_name'] = this.loSzName;
    data['lo_sz_payment'] = this.loSzPayment;
    data['acc_no'] = this.accNo;
    data['b_addr_seq'] = this.bAddrSeq;
    data['sz_npa_status'] = this.szNpaStatus;
    data['i_tot_due_chgs'] = this.iTotDueChgs;
    data['sz_disb_stat'] = this.szDisbStat;
    data['b_pan'] = this.bPan;
    data['lo_i_monthinst'] = this.loIMonthinst;
    data['lo_i_tenor'] = this.loITenor;
    data['c_negative_amort_yn'] = this.cNegativeAmortYn;
    data['i_baltenor'] = this.iBaltenor;
    data['dt_next_idx_review'] = this.dtNextIdxReview;
    data['i_dpd'] = this.iDpd;
    data['offset_rt'] = this.offsetRt;
    data['f_premium_amt'] = this.fPremiumAmt;
    data['c_sz_name'] = this.cSzName;
    data['lo_dt_nxtdt'] = this.loDtNxtdt;
    data['lo_i_instdue'] = this.loIInstdue;
    data['c_pre_emi_option'] = this.cPreEmiOption;
    data['c_mbl'] = this.cMbl;
    data['b_employer_name'] = this.bEmployerName;
    data['lo_i_asset_val'] = this.loIAssetVal;
    return data;
  }
}
