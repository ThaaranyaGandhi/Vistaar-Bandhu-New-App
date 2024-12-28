class WelcomeKitModel {
  String? d;

  WelcomeKitModel({this.d});

  WelcomeKitModel.fromJson(Map<String, dynamic> json) {
    d = json['d'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['d'] = this.d;
    return data;
  }
}