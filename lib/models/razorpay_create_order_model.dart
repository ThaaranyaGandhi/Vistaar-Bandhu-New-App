// To parse this JSON data, do
//
//     final razorpayCreateOrder = razorpayCreateOrderFromMap(jsonString);

import 'dart:convert';

class RazorpayCreateOrder {
  RazorpayCreateOrder({
    this.id,
    this.entity,
    this.amount,
    this.amountPaid,
    this.amountDue,
    this.currency,
    this.receipt,
    this.offerId,
    this.status,
    this.attempts,
    this.notes,
    this.createdAt,
    this.token,
  });

  String? id;
  String? entity;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  String? receipt;
  dynamic offerId;
  String? status;
  int? attempts;
  Notes? notes;
  int? createdAt;
  Token? token;

  factory RazorpayCreateOrder.fromJson(String str) => RazorpayCreateOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RazorpayCreateOrder.fromMap(Map<String, dynamic> json) => RazorpayCreateOrder(
    id: json["id"],
    entity: json["entity"],
    amount: json["amount"],
    amountPaid: json["amount_paid"],
    amountDue: json["amount_due"],
    currency: json["currency"],
    receipt: json["receipt"],
    offerId: json["offer_id"],
    status: json["status"],
    attempts: json["attempts"],
    notes: Notes.fromMap(json["notes"]),
    createdAt: json["created_at"],
    token: Token.fromMap(json["token"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "entity": entity,
    "amount": amount,
    "amount_paid": amountPaid,
    "amount_due": amountDue,
    "currency": currency,
    "receipt": receipt,
    "offer_id": offerId,
    "status": status,
    "attempts": attempts,
    "notes": notes?.toMap(),
    "created_at": createdAt,
    "token": token?.toMap(),
  };
}

class Notes {
  Notes({
    this.notesKey1,
    this.notesKey2,
  });

  String? notesKey1;
  String? notesKey2;

  factory Notes.fromJson(String str) => Notes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Notes.fromMap(Map<String, dynamic> json) => Notes(
    notesKey1: json["notes_key_1"],
    notesKey2: json["notes_key_2"],
  );

  Map<String, dynamic> toMap() => {
    "notes_key_1": notesKey1,
    "notes_key_2": notesKey2,
  };
}

class Token {
  Token({
    this.method,
    this.notes,
    this.recurringStatus,
    this.failureReason,
    this.currency,
    this.maxAmount,
    this.authType,
    this.expireAt,
    this.bankAccount,
    this.firstPaymentAmount,
  });

  String? method;
  Notes? notes;
  dynamic recurringStatus;
  dynamic failureReason;
  String? currency;
  int? maxAmount;
  String? authType;
  int? expireAt;
  BankAccount? bankAccount;
  int? firstPaymentAmount;

  factory Token.fromJson(String str) => Token.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Token.fromMap(Map<String, dynamic> json) => Token(
    method: json["method"],
    notes: Notes.fromMap(json["notes"]),
    recurringStatus: json["recurring_status"],
    failureReason: json["failure_reason"],
    currency: json["currency"],
    maxAmount: json["max_amount"],
    authType: json["auth_type"],
    expireAt: json["expire_at"],
    bankAccount: BankAccount.fromMap(json["bank_account"]),
    firstPaymentAmount: json["first_payment_amount"],
  );

  Map<String, dynamic> toMap() => {
    "method": method,
    "notes": notes?.toMap(),
    "recurring_status": recurringStatus,
    "failure_reason": failureReason,
    "currency": currency,
    "max_amount": maxAmount,
    "auth_type": authType,
    "expire_at": expireAt,
    "bank_account": bankAccount!.toMap(),
    "first_payment_amount": firstPaymentAmount,
  };
}

class BankAccount {
  BankAccount({
    this.ifsc,
    this.bankName,
    this.name,
    this.accountNumber,
    this.accountType,
    this.beneficiaryEmail,
    this.beneficiaryMobile,
  });

  String? ifsc;
  String? bankName;
  String? name;
  String? accountNumber;
  String? accountType;
  String? beneficiaryEmail;
  String? beneficiaryMobile;

  factory BankAccount.fromJson(String str) => BankAccount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BankAccount.fromMap(Map<String, dynamic> json) => BankAccount(
    ifsc: json["ifsc"],
    bankName: json["bank_name"],
    name: json["name"],
    accountNumber: json["account_number"],
    accountType: json["account_type"],
    beneficiaryEmail: json["beneficiary_email"],
    beneficiaryMobile: json["beneficiary_mobile"],
  );

  Map<String, dynamic> toMap() => {
    "ifsc": ifsc,
    "bank_name": bankName,
    "name": name,
    "account_number": accountNumber,
    "account_type": accountType,
    "beneficiary_email": beneficiaryEmail,
    "beneficiary_mobile": beneficiaryMobile,
  };
}
