// To parse this JSON data, do
//
//     final enachDetailsModel = enachDetailsModelFromJson(jsonString);

import 'dart:convert';

EnachDetailsModel enachDetailsModelFromJson(String str) =>
    EnachDetailsModel.fromJson(json.decode(str));

String enachDetailsModelToJson(EnachDetailsModel data) =>
    json.encode(data.toJson());

class EnachDetailsModel {
  EnachDetailsModel({
    this.d,
  });

  D? d;

  factory EnachDetailsModel.fromJson(Map<String, dynamic> json) =>
      EnachDetailsModel(
        d: D.fromJson(json["d"]),
      );

  Map<String, dynamic> toJson() => {
        "d": d?.toJson(),
      };
}

class D {
  D({
    this.type,
    this.acType,
    this.bankName,
    this.bankacNo,
    this.benficiaryName,
    this.branchCode,
    this.branchName,
    this.createdId,
    this.id,
    this.ifscCode,
    this.lan,
    this.maxEmi,
    this.mobileNumber,
  });

  String? type;
  String? acType;
  String? bankName;
  String? bankacNo;
  String? benficiaryName;
  String? branchCode;
  String? branchName;
  String? createdId;
  int? id;
  String? ifscCode;
  String? lan;
  String? maxEmi;
  String? mobileNumber;

  factory D.fromJson(Map<String, dynamic> json) => D(
        type: json["__type"],
        acType: json["AcType"],
        bankName: json["BankName"],
        bankacNo: json["BankacNo"],
        benficiaryName: json["BenficiaryName"],
        branchCode: json["BranchCode"],
        branchName: json["BranchName"],
        createdId: json["CreatedID"],
        id: json["ID"],
        ifscCode: json["IFSCCode"],
        lan: json["LAN"],
        maxEmi: json["MaxEMI"],
        mobileNumber: json["MobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "__type": type,
        "AcType": acType,
        "BankName": bankName,
        "BankacNo": bankacNo,
        "BenficiaryName": benficiaryName,
        "BranchCode": branchCode,
        "BranchName": branchName,
        "CreatedID": createdId,
        "ID": id,
        "IFSCCode": ifscCode,
        "LAN": lan,
        "MaxEMI": maxEmi,
        "MobileNumber": mobileNumber,
      };
}
// class EnachDetailsModel {
//   EnachDetailsModel({
//     required this.d,
//   });
//   late final D d;
//
//   EnachDetailsModel.fromJson(Map<String, dynamic> json){
//     d = D.fromJson(json['d']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['d'] = d.toJson();
//     return _data;
//   }
// }
//
// class D {
//   D({
//     required this.type,
//     required this.AcType,
//     required this.BankName,
//     required this.BankacNo,
//     required this.BenficiaryName,
//     required this.BranchCode,
//     required this.BranchName,
//     required this.CreatedID,
//     required this.ID,
//     required this.IFSCCode,
//     required this.LAN,
//     required this.MaxEMI,
//     required this.MobileNumber,
//   });
//   late final String type;
//   late final String AcType;
//   late final String BankName;
//   late final String BankacNo;
//   late final String BenficiaryName;
//   late final String BranchCode;
//   late final String BranchName;
//   late final String CreatedID;
//   late final int ID;
//   late final String IFSCCode;
//   late final String LAN;
//   late final String MaxEMI;
//   late final String MobileNumber;
//
//   D.fromJson(Map<String, dynamic> json){
//     type = json['__type'];
//     AcType = json['AcType'];
//     BankName = json['BankName'];
//     BankacNo = json['BankacNo'];
//     BenficiaryName = json['BenficiaryName'];
//     BranchCode = json['BranchCode'];
//     BranchName = json['BranchName'];
//     CreatedID = json['CreatedID'];
//     ID = json['ID'];
//     IFSCCode = json['IFSCCode'];
//     LAN = json['LAN'];
//     MaxEMI = json['MaxEMI'];
//     MobileNumber = json['MobileNumber'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['__type'] = type;
//     _data['AcType'] = AcType;
//     _data['BankName'] = BankName;
//     _data['BankacNo'] = BankacNo;
//     _data['BenficiaryName'] = BenficiaryName;
//     _data['BranchCode'] = BranchCode;
//     _data['BranchName'] = BranchName;
//     _data['CreatedID'] = CreatedID;
//     _data['ID'] = ID;
//     _data['IFSCCode'] = IFSCCode;
//     _data['LAN'] = LAN;
//     _data['MaxEMI'] = MaxEMI;
//     _data['MobileNumber'] = MobileNumber;
//     return _data;
//   }
// }
