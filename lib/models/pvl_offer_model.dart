class PvlOfferModel {
  List<PvlList>? d;

  PvlOfferModel({this.d});

  factory PvlOfferModel.fromJson(Map<String, dynamic> json) {
    return PvlOfferModel(
      d: json['d'] != null
          ? (json['d'] as List).map((i) => PvlList.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.d != null) {
      data['d'] = this.d!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PvlList {
  String? type;
  String? aDHAR_CARD;
  int? aGE;
  String? aGEASON;
  double? aPPLIEDAMOUNT;
  String? branchcode;
  String? branchname;
  String? cUSTOMER_ID;
  String? cUSTOMER_NAME;
  String? customerConsent;
  double? dISBURSE_AMT;
  String? dISB_DT;
  String? dRIVING_LICENCE;
  int? fIRSTINSTAMT;
  int? iD;
  String? iNSTALLMENTSTARTDATE;
  double? iNTEREST_RATE;
  String? imagePath;
  int? lASTINSTAMT;
  String? lOAN_PRODUCT_TYPE_ID;
  String? mATURITYDATE;
  int? offeredEMI;
  double? offeredLoanAmount;
  String? offeredProduct;
  String? offeredProductdesc;
  double? offeredROI;
  int? offeredTenure;
  String? pAN_CARD;
  String? pRODUCTCD;
  String? rATIONCARD;
  String? sZ_EDUCATION;
  String? sZ_LAND_LINE_NO;
  String? sZ_LOAN_ACCOUNT_NO;
  String? sZ_MSTATUS;
  String? sZ_SPOUSE_NAME;
  String? sZ_VOTERSID;
  String? source;
  String? sourceID;
  int? tENURE;
  int? tOT_NET_INC;

  PvlList({
    this.type,
    this.aDHAR_CARD,
    this.aGE,
    this.aGEASON,
    this.aPPLIEDAMOUNT,
    this.branchcode,
    this.branchname,
    this.cUSTOMER_ID,
    this.cUSTOMER_NAME,
    this.customerConsent,
    this.dISBURSE_AMT,
    this.dISB_DT,
    this.dRIVING_LICENCE,
    this.fIRSTINSTAMT,
    this.iD,
    this.iNSTALLMENTSTARTDATE,
    this.iNTEREST_RATE,
    this.imagePath,
    this.lASTINSTAMT,
    this.lOAN_PRODUCT_TYPE_ID,
    this.mATURITYDATE,
    this.offeredEMI,
    this.offeredLoanAmount,
    this.offeredProduct,
    this.offeredProductdesc,
    this.offeredROI,
    this.offeredTenure,
    this.pAN_CARD,
    this.pRODUCTCD,
    this.rATIONCARD,
    this.sZ_EDUCATION,
    this.sZ_LAND_LINE_NO,
    this.sZ_LOAN_ACCOUNT_NO,
    this.sZ_MSTATUS,
    this.sZ_SPOUSE_NAME,
    this.sZ_VOTERSID,
    this.source,
    this.sourceID,
    this.tENURE,
    this.tOT_NET_INC,
  });

  factory PvlList.fromJson(Map<String, dynamic> json) {
    return PvlList(
      type: json['__type'],
      aDHAR_CARD: json['ADHAR_CARD'],
      aGE: json['AGE'],
      aGEASON: json['AGEASON'],
      aPPLIEDAMOUNT: json['APPLIEDAMOUNT'],
      branchcode: json['Branchcode'],
      branchname: json['Branchname'],
      cUSTOMER_ID: json['CUSTOMER_ID'],
      cUSTOMER_NAME: json['CUSTOMER_NAME'],
      customerConsent: json['CustomerConsent'],
      dISBURSE_AMT: json['DISBURSE_AMT'],
      dISB_DT: json['DISB_DT'],
      dRIVING_LICENCE: json['DRIVING_LICENCE'],
      fIRSTINSTAMT: json['FIRSTINSTAMT'],
      iD: json['ID'],
      iNSTALLMENTSTARTDATE: json['INSTALLMENTSTARTDATE'],
      iNTEREST_RATE: json['INTEREST_RATE'],
      imagePath: json['imagePath'],
      lASTINSTAMT: json['LASTINSTAMT'],
      lOAN_PRODUCT_TYPE_ID: json['LOAN_PRODUCT_TYPE_ID'],
      mATURITYDATE: json['MATURITYDATE'],
      offeredEMI: json['OfferedEMI'],
      offeredLoanAmount: json['OfferedLoanAmount'],
      offeredProduct: json['OfferedProduct'],
      offeredProductdesc: json['OfferedProductdesc'],
      offeredROI: json['OfferedROI'],
      offeredTenure: json['OfferedTenure'],
      pAN_CARD: json['PAN_CARD'],
      pRODUCTCD: json['PRODUCTCD'],
      rATIONCARD: json['RATIONCARD'],
      sZ_EDUCATION: json['SZ_EDUCATION'],
      sZ_LAND_LINE_NO: json['SZ_LAND_LINE_NO'],
      sZ_LOAN_ACCOUNT_NO: json['SZ_LOAN_ACCOUNT_NO'],
      sZ_MSTATUS: json['SZ_MSTATUS'],
      sZ_SPOUSE_NAME: json['SZ_SPOUSE_NAME'],
      sZ_VOTERSID: json['SZ_VOTERSID'],
      source: json['Source'],
      sourceID: json['SourceID'],
      tENURE: json['TENURE'],
      tOT_NET_INC: json['TOT_NET_INC'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__type'] = this.type;
    data['ADHAR_CARD'] = this.aDHAR_CARD;
    data['AGE'] = this.aGE;
    data['AGEASON'] = this.aGEASON;
    data['APPLIEDAMOUNT'] = this.aPPLIEDAMOUNT;
    data['Branchcode'] = this.branchcode;
    data['Branchname'] = this.branchname;
    data['CUSTOMER_ID'] = this.cUSTOMER_ID;
    data['CUSTOMER_NAME'] = this.cUSTOMER_NAME;
    data['CustomerConsent'] = this.customerConsent;
    data['DISBURSE_AMT'] = this.dISBURSE_AMT;
    data['DISB_DT'] = this.dISB_DT;
    data['DRIVING_LICENCE'] = this.dRIVING_LICENCE;
    data['FIRSTINSTAMT'] = this.fIRSTINSTAMT;
    data['ID'] = this.iD;
    data['INTEREST_RATE'] = this.iNTEREST_RATE;
    data['imagePath'] = this.imagePath;
    data['LASTINSTAMT'] = this.lASTINSTAMT;
    data['LOAN_PRODUCT_TYPE_ID'] = this.lOAN_PRODUCT_TYPE_ID;
    data['mMATURITYDATE'] = this.mATURITYDATE;
    data['OfferedEMI'] = this.offeredEMI;
    data['OfferedLoanAmount'] = this.offeredLoanAmount;
    data['OfferedProduct'] = this.offeredProduct;
    data['OfferedProductdesc'] = this.offeredProductdesc;
    data['OfferedROI'] = this.offeredROI;
    data['OfferedTenure'] = this.offeredTenure;
    data['PAN_CARD'] = this.pAN_CARD;
    data['PRODUCTCD'] = this.pRODUCTCD;
    data['RATIONCARD'] = this.rATIONCARD;
    data['SZ_EDUCATION'] = this.sZ_EDUCATION;
    data['SZ_LAND_LINE_NO'] = this.sZ_LAND_LINE_NO;
    data['SZ_LOAN_ACCOUNT_NO'] = this.sZ_LOAN_ACCOUNT_NO;
    data['SZ_MSTATUS'] = this.sZ_MSTATUS;
    data['SZ_SPOUSE_NAME'] = this.sZ_SPOUSE_NAME;
    data['SZ_VOTERSID'] = this.sZ_VOTERSID;
    data['Source'] = this.source;
    data['SourceID'] = this.sourceID;
    data['TENURE'] = this.tENURE;
    data['TOT_NET_INC'] = this.tOT_NET_INC;
    return data;
  }
}
