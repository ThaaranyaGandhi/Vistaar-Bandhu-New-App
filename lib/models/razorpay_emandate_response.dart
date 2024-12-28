// To parse this JSON data, do
//
//     final razorpayEmandateResponse = razorpayEmandateResponseFromJson(jsonString);

import 'dart:convert';

class RazorpayEmandateResponse {
  RazorpayEmandateResponse({
    this.id,
    this.entity,
    this.receipt,
    this.invoiceNumber,
    this.customerId,
    this.customerDetails,
    this.orderId,
    this.lineItems,
    this.paymentId,
    this.status,
    this.expireBy,
    this.issuedAt,
    this.paidAt,
    this.cancelledAt,
    this.expiredAt,
    this.smsStatus,
    this.emailStatus,
    this.date,
    this.terms,
    this.partialPayment,
    this.grossAmount,
    this.taxAmount,
    this.taxableAmount,
    this.amount,
    this.amountPaid,
    this.amountDue,
    this.currency,
    this.currencySymbol,
    this.description,
    this.notes,
    this.comment,
    this.shortUrl,
    this.viewLess,
    this.billingStart,
    this.billingEnd,
    this.type,
    this.groupTaxesDiscounts,
    this.createdAt,
    this.idempotencyKey,
  });

  String? id;
  String? entity;
  String? receipt;
  String? invoiceNumber;
  String? customerId;
  CustomerDetails? customerDetails;
  String? orderId;
  List<dynamic>? lineItems;
  dynamic paymentId;
  String? status;
  int? expireBy;
  int? issuedAt;
  dynamic paidAt;
  dynamic cancelledAt;
  dynamic expiredAt;
  String? smsStatus;
  String? emailStatus;
  int? date;
  dynamic terms;
  bool? partialPayment;
  int? grossAmount;
  int? taxAmount;
  int? taxableAmount;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  String? currencySymbol;
  String? description;
  Notes? notes;
  dynamic comment;
  String? shortUrl;
  bool? viewLess;
  dynamic billingStart;
  dynamic billingEnd;
  String? type;
  bool? groupTaxesDiscounts;
  int? createdAt;
  dynamic idempotencyKey;

  factory RazorpayEmandateResponse.fromRawJson(String str) => RazorpayEmandateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RazorpayEmandateResponse.fromJson(Map<String, dynamic> json) => RazorpayEmandateResponse(
    id: json["id"],
    entity: json["entity"],
    receipt: json["receipt"],
    invoiceNumber: json["invoice_number"],
    customerId: json["customer_id"],
    customerDetails: CustomerDetails.fromJson(json["customer_details"]),
    orderId: json["order_id"],
    lineItems: List<dynamic>.from(json["line_items"].map((x) => x)),
    paymentId: json["payment_id"],
    status: json["status"],
    expireBy: json["expire_by"],
    issuedAt: json["issued_at"],
    paidAt: json["paid_at"],
    cancelledAt: json["cancelled_at"],
    expiredAt: json["expired_at"],
    smsStatus: json["sms_status"],
    emailStatus: json["email_status"],
    date: json["date"],
    terms: json["terms"],
    partialPayment: json["partial_payment"],
    grossAmount: json["gross_amount"],
    taxAmount: json["tax_amount"],
    taxableAmount: json["taxable_amount"],
    amount: json["amount"],
    amountPaid: json["amount_paid"],
    amountDue: json["amount_due"],
    currency: json["currency"],
    currencySymbol: json["currency_symbol"],
    description: json["description"],
    notes: Notes.fromJson(json["notes"]),
    comment: json["comment"],
    shortUrl: json["short_url"],
    viewLess: json["view_less"],
    billingStart: json["billing_start"],
    billingEnd: json["billing_end"],
    type: json["type"],
    groupTaxesDiscounts: json["group_taxes_discounts"],
    createdAt: json["created_at"],
    idempotencyKey: json["idempotency_key"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "entity": entity,
    "receipt": receipt,
    "invoice_number": invoiceNumber,
    "customer_id": customerId,
    "customer_details": customerDetails!.toJson(),
    "order_id": orderId,
    "line_items": List<dynamic>.from(lineItems!.map((x) => x)),
    "payment_id": paymentId,
    "status": status,
    "expire_by": expireBy,
    "issued_at": issuedAt,
    "paid_at": paidAt,
    "cancelled_at": cancelledAt,
    "expired_at": expiredAt,
    "sms_status": smsStatus,
    "email_status": emailStatus,
    "date": date,
    "terms": terms,
    "partial_payment": partialPayment,
    "gross_amount": grossAmount,
    "tax_amount": taxAmount,
    "taxable_amount": taxableAmount,
    "amount": amount,
    "amount_paid": amountPaid,
    "amount_due": amountDue,
    "currency": currency,
    "currency_symbol": currencySymbol,
    "description": description,
    "notes": notes!.toJson(),
    "comment": comment,
    "short_url": shortUrl,
    "view_less": viewLess,
    "billing_start": billingStart,
    "billing_end": billingEnd,
    "type": type,
    "group_taxes_discounts": groupTaxesDiscounts,
    "created_at": createdAt,
    "idempotency_key": idempotencyKey,
  };
}

class CustomerDetails {
  CustomerDetails({
    this.id,
    this.name,
    this.email,
    this.contact,
    this.gstin,
    this.billingAddress,
    this.shippingAddress,
    this.customerName,
    this.customerEmail,
    this.customerContact,
  });

  String? id;
  String? name;
  String? email;
  String? contact;
  dynamic gstin;
  dynamic billingAddress;
  dynamic shippingAddress;
  String? customerName;
  String? customerEmail;
  String? customerContact;

  factory CustomerDetails.fromRawJson(String str) => CustomerDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerDetails.fromJson(Map<String, dynamic> json) => CustomerDetails(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    contact: json["contact"],
    gstin: json["gstin"],
    billingAddress: json["billing_address"],
    shippingAddress: json["shipping_address"],
    customerName: json["customer_name"],
    customerEmail: json["customer_email"],
    customerContact: json["customer_contact"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "contact": contact,
    "gstin": gstin,
    "billing_address": billingAddress,
    "shipping_address": shippingAddress,
    "customer_name": customerName,
    "customer_email": customerEmail,
    "customer_contact": customerContact,
  };
}

class Notes {
  Notes({
    this.noteKey1,
    this.noteKey2,
  });

  String? noteKey1;
  String? noteKey2;

  factory Notes.fromRawJson(String str) => Notes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    noteKey1: json["note_key 1"],
    noteKey2: json["note_key 2"],
  );

  Map<String, dynamic> toJson() => {
    "note_key 1": noteKey1,
    "note_key 2": noteKey2,
  };
}
