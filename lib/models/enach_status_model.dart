class EnachStatusModel {
    EnachStatus? d;

    EnachStatusModel({this.d});

    factory EnachStatusModel.fromJson(Map<String, dynamic> json) {
        return EnachStatusModel(
            d: json['d'] != null ? EnachStatus.fromJson(json['d']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.d != null) {
            data['d'] = this.d!.toJson();
        }
        return data;
    }
}

class EnachStatus {
    String? type;
    int? amount;
    String? createdID;
    String? createddate;
    String? env;
    int? iD;
    String? indusCustId;
    String? modifiedByID;
    String? modifieddate;
    String? rPCustId;
    String? rPErrorCode;
    String? rPErrorDesc;
    String? rPOrderId;
    String? rPPaymentID;
    String? rPResString;
    String? rPSignature;
    String? rPTransStatus;
    String? visCustId;
    String? visOrderId;
    String? visReceiptNo;
    String? visReqString;

    EnachStatus({this.type, this.amount, this.createdID, this.createddate, this.env, this.iD, this.indusCustId, this.modifiedByID, this.modifieddate, this.rPCustId, this.rPErrorCode, this.rPErrorDesc, this.rPOrderId, this.rPPaymentID, this.rPResString, this.rPSignature, this.rPTransStatus, this.visCustId, this.visOrderId, this.visReceiptNo, this.visReqString});

    factory EnachStatus.fromJson(Map<String, dynamic> json) {
        return EnachStatus(
            type: json['__type'],
            amount: json['Amount'],
            createdID: json['CreatedID'],
            createddate: json['Createddate'],
            env: json['Env'],
            iD: json['ID'],
            indusCustId: json['IndusCustId'],
            modifiedByID: json['ModifiedByID'],
            modifieddate: json['Modifieddate'],
            rPCustId: json['RPCustId'],
            rPErrorCode: json['RPErrorCode'],
            rPErrorDesc: json['RPErrorDesc'],
            rPOrderId: json['RPOrderId'],
            rPPaymentID: json['RPPaymentID'],
            rPResString: json['RPResString'],
            rPSignature: json['RPSignature'],
            rPTransStatus: json['RPTransStatus'],
            visCustId: json['VisCustId'],
            visOrderId: json['VisOrderId'],
            visReceiptNo: json['VisReceiptNo'],
            visReqString: json['visReqString'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['__type'] = this.type;
        data['Amount'] = this.amount;
        data['CreatedID'] = this.createdID;
        data['Createddate'] = this.createddate;
        data['Env'] = this.env;
        data['ID'] = this.iD;
        data['IndusCustId'] = this.indusCustId;
        data['ModifiedByID'] = this.modifiedByID;
        data['Modifieddate'] = this.modifieddate;
        data['RPCustId'] = this.rPCustId;
        data['RPErrorCode'] = this.rPErrorCode;
        data['RPErrorDesc'] = this.rPErrorDesc;
        data['RPOrderId'] = this.rPOrderId;
        data['RPPaymentID'] = this.rPPaymentID;
        data['RPResString'] = this.rPResString;
        data['RPSignature'] = this.rPSignature;
        data['RPTransStatus'] = this.rPTransStatus;
        data['VisCustId'] = this.visCustId;
        data['VisOrderId'] = this.visOrderId;
        data['VisReceiptNo'] = this.visReceiptNo;
        data['VisReqString'] = this.visReqString;

        return data;
    }
}