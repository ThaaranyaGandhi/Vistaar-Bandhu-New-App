class WhatsappModel {
  MESSAGEACK? mESSAGEACK;

  WhatsappModel({this.mESSAGEACK});

  WhatsappModel.fromJson(Map<String, dynamic> json) {
    mESSAGEACK = json['MESSAGEACK'] != null
        ? new MESSAGEACK.fromJson(json['MESSAGEACK'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mESSAGEACK != null) {
      data['MESSAGEACK'] = this.mESSAGEACK!.toJson();
    }
    return data;
  }
}

class MESSAGEACK {
  GUID? gUID;

  MESSAGEACK({this.gUID});

  MESSAGEACK.fromJson(Map<String, dynamic> json) {
    gUID = json['GUID'] != null ? new GUID.fromJson(json['GUID']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gUID != null) {
      data['GUID'] = this.gUID!.toJson();
    }
    return data;
  }
}

class GUID {
  String? sUBMITDATE;
  String? gUID;
  ERROR? eRROR;
  int? iD;

  GUID({this.sUBMITDATE, this.gUID, this.eRROR, this.iD});

  GUID.fromJson(Map<String, dynamic> json) {
    sUBMITDATE = json['SUBMITDATE'];
    gUID = json['GUID'];
    eRROR = json['ERROR'] != null ? new ERROR.fromJson(json['ERROR']) : null;
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SUBMITDATE'] = this.sUBMITDATE;
    data['GUID'] = this.gUID;
    if (this.eRROR != null) {
      data['ERROR'] = this.eRROR!.toJson();
    }
    data['ID'] = this.iD;
    return data;
  }
}

class ERROR {
  int? cODE;
  String? sEQ;

  ERROR({this.cODE, this.sEQ});

  ERROR.fromJson(Map<String, dynamic> json) {
    cODE = json['CODE'];
    sEQ = json['SEQ'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CODE'] = this.cODE;
    data['SEQ'] = this.sEQ;
    return data;
  }
}