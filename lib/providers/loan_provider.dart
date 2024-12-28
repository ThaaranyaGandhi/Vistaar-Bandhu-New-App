import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vistaar_bandhu_new_version/base/base_provider.dart';
import 'package:vistaar_bandhu_new_version/models/de_nach_response.dart';
import 'package:vistaar_bandhu_new_version/models/razorpay_create_order_model.dart';
import 'package:vistaar_bandhu_new_version/models/razorpay_emandate_response.dart';
import 'package:vistaar_bandhu_new_version/models/welcomekit_model.dart';
import 'package:vistaar_bandhu_new_version/service/api_methods.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';

import '../environment.dart';
import '../models/loan_agreement_form_model.dart';
import '../models/loan_future_installment_list_model.dart';
import '../models/loan_model_payment_list.dart';
import '../models/policy_insurance_model.dart';

class LoanProvider extends BaseProvider {
  Future<dynamic> topUpLoanRequest(Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiTopUpLoans, method: ApiMethod.POST, body: body);
    return response.fold((l) {
      showErrorToast(l);
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        return response["d"];
      }
      return null;
    });
  }

  Future<dynamic> placeSOARequest(Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiSOARequest, method: ApiMethod.POST, body: body);
    return response.fold((l) {
      showErrorToast(l);
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        return response["d"];
      }
      return null;
    });
  }

  Future<String?> generateReceiptForLoan(Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiGetReceipt, method: ApiMethod.POST, body: body);

    return response.fold((l) {
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        return response["d"];
      }
      return null;
    });
  }

  Future<int?> insertPaymentDetails(Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiAddCustomerPaymentInformation,
        method: ApiMethod.POST,
        body: body);
    return response.fold((l) {
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);

      appLogger(Environment().config?.envParam, response.toString());
      if (response != null) {
        return response["d"];
      }
      return null;
    });
  }

  Future<int?> updatePaymentDetails(Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiUpdateCustomerPaymentDetails,
        method: ApiMethod.POST,
        body: body);
    return response.fold((l) {
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      debugPrint("response = $response");
      if (response != null) {
        return response["d"];
      }
      return null;
    });
  }

  Future<DeNachResponse?> getNACHDetails(Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiGetNATCHdetails, method: ApiMethod.POST, body: body);
    return response.fold((l) {
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        return DeNachResponse.fromJson(response);
      }
      return null;
    });
  }

  Future<dynamic> deActivateNACH(Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiDeactivateNACH, method: ApiMethod.POST, body: body);
    return response.fold((l) {
      showErrorToast(l);
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        return response["d"];
      }
      return null;
    });
  }

  Future<dynamic> createRazorPayOrder(Map<String, dynamic> body) async {
    String username = razorpayKey!;
    String password = razorpaySecretKey!;

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': basicAuth
    };

    final response = await apiClient.apiClient(
        path: API_RAZOR_PAY_ORDER,
        method: ApiMethod.POST,
        body: body,
        header: headers);
    return response.fold((l) {
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      return response;
    });
  }

  /// refund amount
  Future<dynamic> refundUPIAmount(Map<String, dynamic> body,
      {required String paymentId}) async {
    String username = razorpayKey!;
    String password = razorpaySecretKey!;

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': basicAuth
    };
    final response = await apiClient.apiClient(
        path: "https://api.razorpay.com/v1/payments/$paymentId/refund",
        method: ApiMethod.POST,
        body: body,
        header: headers);
    return response.fold((l) {
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      return response;
    });
  }

  Future<RazorpayEmandateResponse?> createEnach(
      Map<String, dynamic> body) async {
    String username = razorpayKey!;
    String password = razorpaySecretKey!;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': basicAuth
    };

    final response = await apiClient.apiClient(
        path: razorPayEmandateApi,
        method: ApiMethod.POST,
        body: body,
        header: headers);
    return response.fold((l) {
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        return RazorpayEmandateResponse.fromJson(response);
      }
      return null;
    });
  }

  Future<dynamic> createCustomer(Map<String, dynamic> body) async {
    String username = razorpayKey!;
    String password = razorpaySecretKey!;

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': basicAuth
    };

    final response = await apiClient.apiClient(
        path: razorPayCreateCustomerApi,
        method: ApiMethod.POST,
        body: body,
        header: headers);
    return response.fold((l) {
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      return response;
    });
  }

  Future<RazorpayCreateOrder?> createOrder(Map<String, dynamic> body) async {
    String username = razorpayKey!;
    String password = razorpaySecretKey!;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': basicAuth
    };

    final response = await apiClient.apiClient(
        path: razorPayCreateOrderApi,
        method: ApiMethod.POST,
        body: body,
        header: headers);
    return response.fold((l) {
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      appLogger(Environment().config?.envParam, response);
      if (response != null) {
        return RazorpayCreateOrder.fromJson(response);
      }
      return null;
    });
  }

  Future<WelcomeKitModel?> getWelcomeKit(Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiGetWelcomekit, method: ApiMethod.POST, body: body);
    return response.fold((l) {
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        return WelcomeKitModel.fromJson(response);
      }
      return null;
    });
  }

  Future<FutureInstallmentModel?> getFuturePaymentList(

      Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiGetFuturePayment, method: ApiMethod.POST, body: body);
    return response.fold((l) {
      super.isLoading = false;
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        return FutureInstallmentModel.fromJson(response);
      }
      return null;
    });
  }

  Future<LoanPaymentListModel?> getLoanPaymentList(
      Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiGetPaymentList, method: ApiMethod.POST, body: body);
    return response.fold((l) {
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        super.isLoading = false;
        return LoanPaymentListModel.fromJson(response);
      }
      return null;
    });
  }

  Future getPolicyInsurance(Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiGetInsurance, method: ApiMethod.POST, body: body);
    return response.fold((l) {
      showErrorToast(l);
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        return PolicyInsuranceModel.fromJson(response);
      }
      return null;
    });
  }

  Future getLotexUpdatedLeadIdByLan(Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiGetLotexUpdatedLeadIdByLan,
        method: ApiMethod.POST,
        body: body);
    return response.fold((l) {
      showErrorToast(l);
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        return GetLotexUpdatedLeadIdByLanModel.fromJson(response);
      }
      return null;
    });
  }

  Future LAFAuth() async {
    Map<String, String> header = {
      "service": "ValidateUser",
      "username": "DMSAPIUserVistaar",
      "password": "4PKBP",
      "APIKey": "660D6D52-AE61-4A6C-9F53-F5AEFBA24103",
      "content-type": "application/json",
    };
    final response = await apiClient.apiClient(
      path: apiGetLoanAgreementDocumentAuth,
      method: ApiMethod.GET,
      header: header,
    );
    return response.fold((l) {
      showErrorToast(l);
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        return LAFAuthModel.fromJson(response);
      }
      return null;
    });
  }

  Future LAFDoc(
    String token,
    String refId,
    String updateRefNo,
  ) async {
    Map<String, String> header = {
      "service": "DocumentDetails",
      "Token": token,
      "APIKey": "660D6D52-AE61-4A6C-9F53-F5AEFBA24103",
      "RepoName": "DoqScan project type",
      "RefId": refId,
      "Category": "Report",
      "SubCategory": "Application Form",
      "UpdateReferenceNo": updateRefNo,
      "content-type": "application/json",
    };
    final response = await apiClient.apiClient(
      path: apiGetLoanAgreementDocumentAuth,
      method: ApiMethod.GET,
      header: header,
    );
    return response.fold((l) {
      showErrorToast(l);
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        return LAFModel.fromJson(response);
      }
      return null;
    });
  }
}
