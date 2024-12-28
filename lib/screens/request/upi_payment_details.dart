import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/models/enach_detail_model.dart';
import 'package:vistaar_bandhu_new_version/models/enach_status_model.dart';
import 'package:vistaar_bandhu_new_version/models/loan_model.dart';
import 'package:vistaar_bandhu_new_version/providers/auth_provider.dart';
import 'package:vistaar_bandhu_new_version/providers/enach_provider.dart';
import 'package:vistaar_bandhu_new_version/providers/loan_provider.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_helper.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:vistaar_bandhu_new_version/util/empty_message.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../environment.dart';
import '../../multilanguage.dart';

class UPIDetails extends BasePage {
  static const routeName = '/UPIDetails';

  @override
  _UPIDetails createState() => _UPIDetails();
}

class _UPIDetails extends BaseState<UPIDetails> {
  LoanModel? _loanModel;
  D? enachDetailsModel;
  String? applicationNumber;
  bool isLoanClosed = false;
  late Razorpay _razorPay;
  double amountPayable = 0;
  String orderID = '';
  String customerID = '';
  EnachStatus? enachStatus;
  bool status = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      getEnachDetail();
      getEnachStatus();
      getLoanDetails();
      createCustomer();
    });
    applicationNumber = Get.arguments;

    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // appLogger("preference ${pref.emandateStatus}");
  }

  @override
  void dispose() {
    _razorPay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MultiLanguage multilanguange = MultiLanguage.of(context)!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
              child: Image.asset(
                "assets/images/vistaar_logo.png",
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                MultiLanguage.of(context)!.translate("upi_details"),
                style: const TextStyle(color: goldColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 60,
            ),
          ],
        ),
        centerTitle: true,
        actions: [],
      ),
      body: SafeArea(
        child: _loanModel == null
            ? EmptyMessage(multilanguange.translate(
                "loan_details_not_found")) //"Loan details not found")
            : isLoanClosed == true
                ? EmptyMessage(
                    "${multilanguange.translate("this_particular_loan")} ${applicationNumber ?? ""} ${multilanguange.translate("is_closed")}")
                : GestureDetector(
                    onTap: () {
                      hideKeyboard();
                    },
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Table(
                                      columnWidths: const{
                                        0:  FractionColumnWidth(.4)
                                      },
                                      border: TableBorder.all(
                                          color: Colors.transparent),
                                      children: [
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              "${multilanguange.translate("name")} : ",
                                              style:
                                                  const TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              _loanModel!.loSzName ?? "",
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              "${multilanguange.translate("lan")} : ",
                                              //lan
                                              style:
                                                  const TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              _loanModel!.accNo ?? "",
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              "${multilanguange.translate("loan_amount")} : ", //loan amount
                                              style:
                                                  const TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              "Rs ${double.parse(_loanModel!.loILnamt!)}/-",
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              "${multilanguange.translate("emi")} : ",
                                              style:
                                                  const TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              AppHelper().getCurrencyFormat(
                                                  double.parse(
                                                      _loanModel!.loIEmi!)),
                                              //"₹ ${double.parse(_loanModel!.loIEmi!) ?? ""}/-",
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ]),
                                      ]),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  buttonSection(applicationNumber!)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
      ),
    );
  }

  String getLoanStatus() {
    if (_loanModel != null) {
      if (_loanModel!.iDpd != null && int.parse(_loanModel!.iDpd!) > 0) {
        return MultiLanguage.of(context)!.translate("overdue");
      }
    }
    return MultiLanguage.of(context)!.translate("regular");
  }

  /// generateReceipt
  generateReceipt(String custId) async {
    Map<String, dynamic> params = Map();
    params["Lan"] = applicationNumber;
    params["Token"] = API_TOKEN;
    params["Env"] = Environment().config?.envParam;
    customerID = custId;
    var amount = int.parse(enachDetailsModel?.maxEmi ?? "0");
    // assert(amount is int);
    amount = amount * 100;
    showLoadingDialog(
        context: context,
        hint: "${MultiLanguage.of(context)!.translate("loading")}...");
    await Provider.of<LoanProvider>(context, listen: false)
        .generateReceiptForLoan(params)
        .then((receiptNum) async {
      if (receiptNum != null) {
        var body = {
          "amount": 100,
          "currency": "INR",
          "customer_id": customerID,
          "method": "upi",
          "receipt": "VISCA009000045918", //receiptNum,
          "notes": {
            "notes_key_1": "$applicationNumber-${pref.userMobile}"
            // "notes_key_2": "$applicationNumber-${pref.userMobile}"
          },
          "token": {
            "max_amount": amount,
            "expire_at": 2619368999,
            "frequency": "as_presented",
            "recurring_value": DateTime.now().day,
            "recurring_type": "on",
          },
        };

        await Provider.of<LoanProvider>(context, listen: false)
            .createRazorPayOrder(body)
            .then((orderJson) {
          if (orderJson != null && orderJson["id"] != null) {
            insertPaymentDetailsIntoInternalServer(
                customerID, orderJson["id"], receiptNum);
          }
        });
      }
      //hide loading dialog
      Navigator.pop(context);
    }, onError: (error) {
      //hide loading dialog
      Navigator.pop(context);
      showErrorToast(
          "${MultiLanguage.of(context)!.translate("something_went_wrong")}"); //"Something went wrong. Please try later.");
    });
  }

  createCustomer() async {
    var param = {
      "name": _loanModel?.cSzName,
      "email": "vistaar@gmail.com",
      "contact": pref.userMobile,
      "fail_existing": "0",
      "notes": {"note_key_1": "September", "note_key_2": "Make it so."}
    };

    await Provider.of<LoanProvider>(context, listen: false)
        .createCustomer(param)
        .then((value) {
      if (value != null) {
        customerID = value["id"];
        //   appLogger("cust id ${value["id"]}");
      } else {
        showErrorToast(
            MultiLanguage.of(context)!.translate("something_went_wrong"));
      }
    });
  }

  /// insertPaymentDetailsIntoInternalServer
  insertPaymentDetailsIntoInternalServer(
      String custId, String orderId, String receiptNo) async {
    var param = {
      'VisCustID': applicationNumber,
      'RPCustID': customerID,
      'IndCustId': _loanModel!.cCustomerNo,
      'VisOrderID': applicationNumber,
      'RPOrderID': orderId,
      'Amount': double.parse(enachDetailsModel!.maxEmi!),
      'VisReqString': "E-NACH",
      'VisReceiptNo':"VISCA009000045918", // receiptNo,
      'RPTransStatus': 'Initiated',
      'CreatedID': pref.userMobile,
      'Token': API_TOKEN,
      'Env': Environment().config?.envParam,
    };

    orderID = orderId;

    await Provider.of<LoanProvider>(context, listen: false)
        .insertPaymentDetails(param)
        .then((value) {
      if (value != null) {
        openCheckout(orderId);
      } else {
        showErrorToast(
            MultiLanguage.of(context)!.translate("something_went_wrong"));
      }
    });
  }

  /// openCheckout
  void openCheckout(String orderId) async {
    var options = {
      // "key": "rzp_live_wttpRiUPLjNEWp",
      "key": razorpayKey,
      "order_id": orderID,
      "customer_id": customerID,
      "recurring": 1,
      /*    "handler": (response) {
        log(response.razorpay_payment_id);
        log(response.razorpay_order_id);
        log(response.razorpay_signature);
      },
      "notes": {
        "note_key 1": "Beam me up Scotty",
        "note_key 2": "Tea. Earl Gray. Hot."
      },
      "theme": {"color": "#F37254"},*/
    };
    try {
      _razorPay.open(options);
    } catch (e) {
      print(e);
    }
  }

/*  void openCheckout(String orderId) async {
    var options = {
      "key": razorpayKey,
      "order_id": orderID,
      "customer_id": customerID,
      "recurring": 1,
      "amount": "0",
      "contact": pref.userMobile,
      "email": "vistaar@gmail.com",
      "method": "upi",
      "bank": enachDetailsModel!.bankName,
      "bank_account[name]": _loanModel!.cSzName,
      "bank_account[account_number]": enachDetailsModel!.bankacNo,
      "bank_account[ifsc]": enachDetailsModel!.ifscCode,
      "auth_type": ""
    };

    try {
      _razorPay.open(options);
    } catch (e) {
      print(e);
    }
  }*/

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    showSuccessToast(MultiLanguage.of(context)!
        .translate("payment_successful")); //"Payment Successful");
    pref.emandateStatus = applicationNumber!;
    // appLogger("success preference ${response.signature} ${response.paymentId}");
    if (response.signature != null || response.orderId != null) {
      var body = {"amount": 100};
      Provider.of<LoanProvider>(context, listen: false)
          .refundUPIAmount(body, paymentId: response.paymentId!)
          .then((value) {
        if (value['status' == 'processed']) {
          showSuccessToast(
              MultiLanguage.of(context)!.translate("Refund successful"));
        }
      });

      var param = {
        'RPOrderID': response.orderId,
        'RPResString':
            "{rp_paymentId: ${response.paymentId}, Signature: ${response.signature}, OrderId: ${response.orderId}",
        'RPTransStatus': "success",
        'RPPaymentID': response.paymentId,
        'RPSignature': response.signature,
        'RPErrorCode': "",
        'RPErrorDesc': "",
        'Token': API_TOKEN,
        'Env': Environment().config?.envParam,
      };
      Provider.of<LoanProvider>(context, listen: false)
          .updatePaymentDetails(param)
          .then((value) {});
    }
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      getEnachStatus();
    });
  }

  ///_handlePaymentError
  void _handlePaymentError(PaymentFailureResponse response) {
    showErrorToast(
        MultiLanguage.of(context)!.translate("registration_not_processed"));
    // appLogger("success preference ${response.message}");
    // appLogger(" rp failure${response.message}");
    // appLogger("preference ${pref.emandateStatus}");
    var param = {
      'RPOrderID': orderID,
      'RPTransStatus': "failed",
      'RPResString': "Error code: ${response.code}, Desc: ${response.message}",
      'RPPaymentID': "",
      'RPSignature': "",
      'RPErrorCode': response.code,
      'RPErrorDesc': "${response.message}",
      'Token': API_TOKEN,
      'Env': Environment().config?.envParam,
    };

    Provider.of<LoanProvider>(context, listen: false)
        .updatePaymentDetails(param)
        .then((value) {});

    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      getEnachDetail();
      getEnachStatus();
    });
  }

  /// getEnachDetail
  Future getEnachDetail() async {
    showLoadingDialog(
        context: context,
        hint: "${MultiLanguage.of(context)!.translate("loading")}...");
    var param = {
      'Lan': applicationNumber,
      'Token': API_TOKEN,
      'Env': Environment().config?.envParam
    };

    await Provider.of<EnachProvider>(context, listen: false)
        .getEnachDetails(param)
        .then((value) {
      if (value != null) {
        enachDetailsModel = value.d;
        setState(() {});
      } else {
        showSuccessToast(
            "${MultiLanguage.of(context)!.translate("you_do_not_have_offers")}");
      }

      Navigator.of(context).pop();
    }, onError: (error) {
      Navigator.of(context).pop();
    });
    // log('log pvl: ${enachDetailsModel?.ifscCode}');
  }

  Future getEnachStatus() async {
    showLoadingDialog(
        context: context,
        hint: "${MultiLanguage.of(context)!.translate("loading")}...");
    var param = {
      'Lan': applicationNumber,
      'Token': API_TOKEN,
      'Env': Environment().config?.envParam
    };

    await Provider.of<EnachProvider>(context, listen: false)
        .getEnachStatus(param)
        .then((value) {
      if (value!.d != null) {
        enachStatus = value.d;
        setState(() {});
      } else {
        showSuccessToast(
            "${MultiLanguage.of(context)!.translate("you_do_not_have_offers")}");
      }

      Navigator.of(context).pop();
    }, onError: (error) {
      Navigator.of(context).pop();
    });
    //   log('${MultiLanguage.of(context)!.translate("log_enach_status")}: ${enachStatus?.rPTransStatus}');
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("UPI Activation"),
          content: new Text(
              "${MultiLanguage.of(context)!.translate("dear_customer")},"
              "${MultiLanguage.of(context)!.translate("would_you_like_to_continue")}?"),
          actions: <Widget>[
            new TextButton(
              child: new Text(
                  MultiLanguage.of(context)!.translate("cancel")), //cancel
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new TextButton(
              child: new Text(MultiLanguage.of(context)!.translate("continue")),
              onPressed: () {
                Navigator.pop(context);
                generateReceipt(customerID);
              },
            ),
          ],
        );
      },
    );
  }

  Future getLoanDetails() async {
    showLoadingDialog(
        context: context,
        hint:
            MultiLanguage.of(context)!.translate("fetching_loan_details"));
    await Provider.of<AuthProvider>(context, listen: false)
        .getLoanDetail(applicationNumber ?? "")
        .then((value) {
      //hide loading dialog
      Navigator.pop(context);
      if (value != null) {
        if (value.isNotEmpty) {
          final responseJson = value.first;
          final applicationJson = responseJson["search"]["data"];
          appPrint(Environment().config?.envParam, applicationJson);
          if (applicationJson != null) {
            _loanModel = LoanModel.fromJson(applicationJson);
          }
          if (_loanModel != null && _loanModel!.loDtClosedt != "") {
            isLoanClosed = true;
          } else {
            isLoanClosed = false;
          }
        } else {
          isLoanClosed = false;
        }
        setState(() {});
      }
    });
  }

  Widget buttonSection(String appNum) => Column(children: [
        if (pref.emandateStatus == applicationNumber ||
            enachStatus?.rPTransStatus == "success")
          Center(
              child: Text(
            MultiLanguage.of(context)!.translate("emandate_is_active"),
            style: const TextStyle(
              color: Colors.lightGreen,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ))
        else if (_loanModel != null)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.maxFinite,
              height: 55,
              child: CupertinoButton(
                color: primaryColor,
                child: Text(
                  MultiLanguage.of(context)!.translate("activate_emandate"),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                onPressed: () async {
                  _showDialog(context);
                },
              ),
            ),
          )
        else
          EmptyMessage(MultiLanguage.of(context)!
              .translate("contact_relationship_manager"))
      ]);

// Future getLoanDetails() async {
//   showLoadingDialog(hint: "Fetching Loan Details");
//   await Provider.of<AuthProvider>(context, listen: false)
//       .getLoanDetail(applicationNumber ?? "")
//       .then((value) {
//     //hide loading dialog
//     Navigator.pop(context);
//     if (value != null) {
//       if (value.isNotEmpty) {
//         final responseJson = value.first;
//         final applicationJson = responseJson["search"]["data"];
//         print(applicationJson);
//         if (applicationJson != null) {
//           _loanModel = LoanModel.fromJson(applicationJson);
//         }
//         if (_loanModel != null && _loanModel!.loDtClosedt != "") {
//           isLoanClosed = true;
//         } else {
//           isLoanClosed = false;
//         }
//       } else {
//         Get.toNamed(LoanStatusScreen.routeName);
//       }
//       setState(() {});
//     }
//   });
// }
// @override
//   void didUpdateWidget(covariant EmandateDetails oldWidget) {
//     getEnachDetail();
//     super.didUpdateWidget(oldWidget);
//   }
//   @override
//   void didChangeDependencies() {
//     getEnachStatus();
//     appLogger("in did dependency change");
//     super.didChangeDependencies();
//   }
}
