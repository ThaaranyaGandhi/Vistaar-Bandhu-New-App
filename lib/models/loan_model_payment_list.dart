class LoanPaymentListModel {
  List<D>? d;

  LoanPaymentListModel({this.d});

  LoanPaymentListModel.fromJson(Map<String, dynamic> json) {
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
  int? amount;
  String? lan;
  String? paidOndate;
  String? paymentMode;

  D({this.sType, this.amount, this.lan, this.paidOndate, this.paymentMode});

  D.fromJson(Map<String, dynamic> json) {
    sType = json['__type'];
    amount = json['Amount'];
    lan = json['Lan'];
    paidOndate = json['PaidOndate'];
    paymentMode = json['PaymentMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__type'] = this.sType;
    data['Amount'] = this.amount;
    data['Lan'] = this.lan;
    data['PaidOndate'] = this.paidOndate;
    data['PaymentMode'] = this.paymentMode;
    return data;
  }
}
