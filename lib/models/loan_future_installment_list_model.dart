class FutureInstallmentModel {
  List<D>? d;

  FutureInstallmentModel({this.d});

  FutureInstallmentModel.fromJson(Map<String, dynamic> json) {
    if (json['d'] != null) {
      d = <D>[];
      json['d'].forEach((v) {
        d!.add(new D.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.d != null) {
      data['d'] = this.d!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class D {
  String? sType;
  int? eMIAmount;
  String? installmentdate;
  int? instlmntNo;
  String? lan;

  D(
      {this.sType,
      this.eMIAmount,
      this.installmentdate,
      this.instlmntNo,
      this.lan});

  D.fromJson(Map<String, dynamic> json) {
    sType = json['__type'];
    eMIAmount = json['EMIAmount'];
    installmentdate = json['Installmentdate'];
    instlmntNo = json['InstlmntNo'];
    lan = json['Lan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__type'] = this.sType;
    data['EMIAmount'] = this.eMIAmount;
    data['Installmentdate'] = this.installmentdate;
    data['InstlmntNo'] = this.instlmntNo;
    data['Lan'] = this.lan;
    return data;
  }
}
