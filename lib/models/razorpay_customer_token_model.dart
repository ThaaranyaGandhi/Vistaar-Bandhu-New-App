// To parse this JSON data, do
//
//     final razorpayCreateCustomer = razorpayCreateCustomerFromMap(jsonString);

import 'dart:convert';

class RazorpayCreateCustomer {
  RazorpayCreateCustomer({
    this.id,
    this.entity,
    this.name,
    this.email,
    this.contact,
    this.gstin,
    this.notes,
    this.createdAt,
  });

  String? id;
  String? entity;
  String? name;
  String? email;
  String? contact;
  String? gstin;
  List<String>? notes;
  int? createdAt;

  factory RazorpayCreateCustomer.fromJson(dynamic str) => RazorpayCreateCustomer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RazorpayCreateCustomer.fromMap(Map<String, dynamic> json) => RazorpayCreateCustomer(
    id: json["id"],
    entity: json["entity"],
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
    gstin: json["gstin"],
    notes: List<String>.from(json["notes"].map((x) => x)),
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "entity": entity,
    "name": name,
    "email": email,
    "contact": contact,
    "gstin": gstin,
    "notes": List<String>.from(notes!.map((x) => x)),
    "created_at": createdAt,
  };
}
