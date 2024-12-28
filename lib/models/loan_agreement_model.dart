// Loan Agreement Model for token

class LoanAgreementModel {
  List<Status>? status;
  List<AuthData>? authData;

  LoanAgreementModel({this.status, this.authData});

  LoanAgreementModel.fromJson(Map<String, dynamic> json) {
    if (json['Status'] != null) {
      status = <Status>[];
      json['Status'].forEach((v) {
        status!.add(new Status.fromJson(v));
      });
    }
    if (json['AuthData'] != null) {
      authData = <AuthData>[];
      json['AuthData'].forEach((v) {
        authData!.add(new AuthData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['Status'] = this.status!.map((v) => v.toJson()).toList();
    }
    if (this.authData != null) {
      data['AuthData'] = this.authData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  String? errorState;
  String? errorSeverity;
  String? msg;

  Status({this.errorState, this.errorSeverity, this.msg});

  Status.fromJson(Map<String, dynamic> json) {
    errorState = json['ErrorState'];
    errorSeverity = json['ErrorSeverity'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorState'] = this.errorState;
    data['ErrorSeverity'] = this.errorSeverity;
    data['Msg'] = this.msg;
    return data;
  }
}

class AuthData {
  String? authDateTime;
  String? authToken;

  AuthData({this.authDateTime, this.authToken});

  AuthData.fromJson(Map<String, dynamic> json) {
    authDateTime = json['AuthDateTime'];
    authToken = json['AuthToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AuthDateTime'] = this.authDateTime;
    data['AuthToken'] = this.authToken;
    return data;
  }
}

//Loan Agreement Detail model
class LoanAgreementDetailModel {
  List<Status>? status;
  List<DocDetails>? docDetails;

  LoanAgreementDetailModel({this.status, this.docDetails});

  LoanAgreementDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['Status'] != null) {
      status = <Status>[];
      json['Status'].forEach((v) {
        status!.add(new Status.fromJson(v));
      });
    }
    if (json['DocDetails'] != null) {
      docDetails = <DocDetails>[];
      json['DocDetails'].forEach((v) {
        docDetails!.add(new DocDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['Status'] = this.status!.map((v) => v.toJson()).toList();
    }
    if (this.docDetails != null) {
      data['DocDetails'] = this.docDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusDet {
  String? errorState;
  String? errorSeverity;
  String? msg;

  StatusDet({this.errorState, this.errorSeverity, this.msg});

  StatusDet.fromJson(Map<String, dynamic> json) {
    errorState = json['ErrorState'];
    errorSeverity = json['ErrorSeverity'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorState'] = this.errorState;
    data['ErrorSeverity'] = this.errorSeverity;
    data['Msg'] = this.msg;
    return data;
  }
}

class DocDetails {
  String? documentID;
  String? pages;
  String? version;
  String? lastUpdateDateTime;
  String? refID;
  List<Metadata>? metadata;
  List<Imagedata>? imagedata;

  DocDetails(
      {this.documentID,
      this.pages,
      this.version,
      this.lastUpdateDateTime,
      this.refID,
      this.metadata,
      this.imagedata});

  DocDetails.fromJson(Map<String, dynamic> json) {
    documentID = json['DocumentID'];
    pages = json['Pages'];
    version = json['Version'];
    lastUpdateDateTime = json['LastUpdateDateTime'];
    refID = json['RefID'];
    if (json['Metadata'] != null) {
      metadata = <Metadata>[];
      json['Metadata'].forEach((v) {
        metadata!.add(new Metadata.fromJson(v));
      });
    }
    if (json['Imagedata'] != null) {
      imagedata = <Imagedata>[];
      json['Imagedata'].forEach((v) {
        imagedata!.add(new Imagedata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentID'] = this.documentID;
    data['Pages'] = this.pages;
    data['Version'] = this.version;
    data['LastUpdateDateTime'] = this.lastUpdateDateTime;
    data['RefID'] = this.refID;
    if (this.metadata != null) {
      data['Metadata'] = this.metadata!.map((v) => v.toJson()).toList();
    }
    if (this.imagedata != null) {
      data['Imagedata'] = this.imagedata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Metadata {
  String? name;
  String? value;

  Metadata({this.name, this.value});

  Metadata.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Value'] = this.value;
    return data;
  }
}

class Imagedata {
  Null? pageNo;
  String? tag;
  String? subTag;
  String? imgb64;

  Imagedata({this.pageNo, this.tag, this.subTag, this.imgb64});

  Imagedata.fromJson(Map<String, dynamic> json) {
    pageNo = json['PageNo'];
    tag = json['Tag'];
    subTag = json['SubTag'];
    imgb64 = json['Imgb64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PageNo'] = this.pageNo;
    data['Tag'] = this.tag;
    data['SubTag'] = this.subTag;
    data['Imgb64'] = this.imgb64;
    return data;
  }
}
