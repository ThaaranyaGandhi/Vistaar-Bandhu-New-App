import 'dart:convert';

MyCustomerModel myCustomerModelFromJson(String str) =>
    MyCustomerModel.fromJson(json.decode(str));

String myCustomerModelToJson(MyCustomerModel data) =>
    json.encode(data.toJson());

class MyCustomerModel {
  MyCustomerModel({
    this.applicationReference,
    this.lanReference,
  });

  List<String>? applicationReference;
  List<String>? lanReference;

  factory MyCustomerModel.fromJson(Map<String, dynamic> json) => MyCustomerModel(
    applicationReference: json["applicationReference"] == null ? null : json["applicationReference"] is List ? List<String>.from(json["applicationReference"].map((x) => x)) : [],
    lanReference: json["lanReference"] == null ? null : json["lanReference"] is List ? List<String>.from(json["lanReference"].map((x) => x)) : [],
  );

  Map<String, dynamic> toJson() => {
    "applicationReference": applicationReference == null ? null : List<dynamic>.from(applicationReference!.map((x) => x)),
    "lanReference": lanReference == null ? null : List<dynamic>.from(lanReference!.map((x) => x)),
  };
}
