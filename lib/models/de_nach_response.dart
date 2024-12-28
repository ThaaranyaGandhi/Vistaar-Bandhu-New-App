// To parse this JSON data, do
//
//     final deNachResponse = deNachResponseFromJson(jsonString);

import 'dart:convert';

DeNachResponse deNachResponseFromJson(String str) => DeNachResponse.fromJson(json.decode(str));

String deNachResponseToJson(DeNachResponse data) => json.encode(data.toJson());

class DeNachResponse {
  DeNachResponse({
    this.d,
  });

  List<DeNachData>? d;

  factory DeNachResponse.fromJson(Map<String, dynamic> json) => DeNachResponse(
    d: json["d"] == null ? null : List<DeNachData>.from(json["d"].map((x) => DeNachData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "d": d == null ? null : List<dynamic>.from(d!.map((x) => x.toJson())),
  };
}

class DeNachData {
  DeNachData({
    this.type,
    this.custId,
    this.disbAmount,
    this.errorDesc,
    this.id,
    this.lan,
    this.lastUpdatedBy,
    this.mobileNo,
    this.nachList,
    this.reqStatus,
    this.sanctionAmount,
    this.custFname,
  });

  String? type;
  String? custId;
  String? disbAmount;
  String? errorDesc;
  int? id;
  String? lan;
  String? lastUpdatedBy;
  String? mobileNo;
  List<NachModel>? nachList;
  String? reqStatus;
  String? sanctionAmount;
  String? custFname;

  factory DeNachData.fromJson(Map<String, dynamic> json) => DeNachData(
    type: json["__type"] == null ? null : json["__type"],
    custId: json["CustId"] == null ? null : json["CustId"],
    disbAmount: json["DisbAmount"] == null ? null : json["DisbAmount"],
    errorDesc: json["ErrorDesc"] == null ? null : json["ErrorDesc"],
    id: json["ID"] == null ? null : json["ID"],
    lan: json["Lan"] == null ? null : json["Lan"],
    lastUpdatedBy: json["LastUpdatedBy"] == null ? null : json["LastUpdatedBy"],
    mobileNo: json["MobileNo"] == null ? null : json["MobileNo"],
    nachList: json["NachList"] == null ? null : List<NachModel>.from(json["NachList"].map((x) => NachModel.fromJson(x))),
    reqStatus: json["ReqStatus"] == null ? null : json["ReqStatus"],
    sanctionAmount: json["SanctionAmount"] == null ? null : json["SanctionAmount"],
    custFname: json["custFname"] == null ? null : json["custFname"],
  );

  Map<String, dynamic> toJson() => {
    "__type": type == null ? null : type,
    "CustId": custId == null ? null : custId,
    "DisbAmount": disbAmount == null ? null : disbAmount,
    "ErrorDesc": errorDesc == null ? null : errorDesc,
    "ID": id == null ? null : id,
    "Lan": lan == null ? null : lan,
    "LastUpdatedBy": lastUpdatedBy == null ? null : lastUpdatedBy,
    "MobileNo": mobileNo == null ? null : mobileNo,
    "NachList": nachList == null ? null : List<dynamic>.from(nachList!.map((x) => x.toJson())),
    "ReqStatus": reqStatus == null ? null : reqStatus,
    "SanctionAmount": sanctionAmount == null ? null : sanctionAmount,
    "custFname": custFname == null ? null : custFname,
  };
}

class NachModel {
  NachModel({
    this.type,
    this.acNumber,
    this.appId,
    this.bankname,
    this.custname,
    this.emiAmount,
    this.id,
    this.ifscCode,
    this.lan,
    this.lanId,
    this.maxNachRegAmount,
    this.nachDeActvreqRaiseBy,
    this.nachDeActvreqRaisedate,
    this.nachRegdate,
    this.nachRejctCode,
    this.nachRejctReason,
    this.nachReqUpdatedDt,
    this.nachStatus,
    this.sourceIp,
    this.umrn,
  });

  String? type;
  String? acNumber;
  String? appId;
  String? bankname;
  String? custname;
  String? emiAmount;
  String? id;
  String? ifscCode;
  String? lan;
  String? lanId;
  String? maxNachRegAmount;
  String? nachDeActvreqRaiseBy;
  String? nachDeActvreqRaisedate;
  String? nachRegdate;
  String? nachRejctCode;
  String? nachRejctReason;
  String? nachReqUpdatedDt;
  String? nachStatus;
  String? sourceIp;
  String? umrn;

  factory NachModel.fromJson(Map<String, dynamic> json) => NachModel(
    type: json["__type"] == null ? null : json["__type"],
    acNumber: json["ACNumber"] == null ? null : json["ACNumber"],
    appId: json["AppId"] == null ? null : json["AppId"],
    bankname: json["Bankname"] == null ? null : json["Bankname"],
    custname: json["Custname"] == null ? null : json["Custname"],
    emiAmount: json["EMIAmount"] == null ? null : json["EMIAmount"],
    id: json["ID"] == null ? null : json["ID"],
    ifscCode: json["IFSCCode"] == null ? null : json["IFSCCode"],
    lan: json["Lan"] == null ? null : json["Lan"],
    lanId: json["LanId"] == null ? null : json["LanId"],
    maxNachRegAmount: json["MaxNachRegAmount"] == null ? null : json["MaxNachRegAmount"],
    nachDeActvreqRaiseBy: json["NachDeActvreqRaiseBy"] == null ? null : json["NachDeActvreqRaiseBy"],
    nachDeActvreqRaisedate: json["NachDeActvreqRaisedate"] == null ? null : json["NachDeActvreqRaisedate"],
    nachRegdate: json["NachRegdate"] == null ? null : json["NachRegdate"],
    nachRejctCode: json["NachRejctCode"] == null ? null : json["NachRejctCode"],
    nachRejctReason: json["NachRejctReason"] == null ? null : json["NachRejctReason"],
    nachReqUpdatedDt: json["NachReqUpdatedDt"] == null ? null : json["NachReqUpdatedDt"],
    nachStatus: json["NachStatus"] == null ? null : json["NachStatus"],
    sourceIp: json["SourceIP"] == null ? null : json["SourceIP"],
    umrn: json["UMRN"] == null ? null : json["UMRN"],
  );

  Map<String, dynamic> toJson() => {
    "__type": type == null ? null : type,
    "ACNumber": acNumber == null ? null : acNumber,
    "AppId": appId == null ? null : appId,
    "Bankname": bankname == null ? null : bankname,
    "Custname": custname == null ? null : custname,
    "EMIAmount": emiAmount == null ? null : emiAmount,
    "ID": id == null ? null : id,
    "IFSCCode": ifscCode == null ? null : ifscCode,
    "Lan": lan == null ? null : lan,
    "LanId": lanId == null ? null : lanId,
    "MaxNachRegAmount": maxNachRegAmount == null ? null : maxNachRegAmount,
    "NachDeActvreqRaiseBy": nachDeActvreqRaiseBy == null ? null : nachDeActvreqRaiseBy,
    "NachDeActvreqRaisedate": nachDeActvreqRaisedate == null ? null : nachDeActvreqRaisedate,
    "NachRegdate": nachRegdate == null ? null : nachRegdate,
    "NachRejctCode": nachRejctCode == null ? null : nachRejctCode,
    "NachRejctReason": nachRejctReason == null ? null : nachRejctReason,
    "NachReqUpdatedDt": nachReqUpdatedDt == null ? null : nachReqUpdatedDt,
    "NachStatus": nachStatus == null ? null : nachStatus,
    "SourceIP": sourceIp == null ? null : sourceIp,
    "UMRN": umrn == null ? null : umrn,
  };
}
