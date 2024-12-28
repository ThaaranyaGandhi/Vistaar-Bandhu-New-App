

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/models/loan_model.dart';
import 'package:vistaar_bandhu_new_version/providers/loan_provider.dart';
import 'package:vistaar_bandhu_new_version/screens/home_screen.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_enum.dart';
import 'package:vistaar_bandhu_new_version/util/app_helper.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

import '../../environment.dart';
import '../../multilanguage.dart';
import '../loans/loan_payment_completed_page.dart';

class EMIOptionScreen extends BasePage {
  final LoanModel loanModel;

  EMIOptionScreen({required this.loanModel});

  @override
  _EMIOptionScreenState createState() => _EMIOptionScreenState();
}

class _EMIOptionScreenState extends BaseState<EMIOptionScreen> {
  PaymentType? _paymentType;
  final TextEditingController _amountController = TextEditingController();
  late Razorpay _razorPay;
  double amountPayable = 0;
  String orderID = '';

  @override
  void initState() {
    super.initState();
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
                MultiLanguage.of(context)!.translate(
                    "select_an_option_to_make_payment"), //"Select an option to make payment",
                style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 17)),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: Align(
                alignment: const Alignment(-1.2, 0),
                child:  Text(
                    PaymentTypeHelper.getTitle(PaymentType.payEMI, context)),
              ),
              leading: Radio<PaymentType>(
                value: PaymentType.payEMI,
                groupValue: _paymentType,
                onChanged: (PaymentType? value) {
                  setState(() {
                    _paymentType = value;
                  });
                },
              ),
              trailing: Text(
                  AppHelper().getCurrencyFormat(
                      double.parse(widget.loanModel.loIEmi ?? "0.0")),
                  style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 17)),
            ),
            ListTile(
                title: Align(
                  alignment: const Alignment(-1.2, 0),
                  child:  Text(PaymentTypeHelper.getTitle(
                      PaymentType.payDueAmount, context)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                leading: Radio<PaymentType>(
                  value: PaymentType.payDueAmount,
                  groupValue: _paymentType,
                  onChanged: (PaymentType? value) {
                    setState(() {
                      _paymentType = value;
                    });
                  },
                ),
                trailing: Text(
                    AppHelper().getCurrencyFormat(
                      (double.parse(widget.loanModel.loITotdue ?? "0.0")),
                    ),
                    style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 17))),
            ListTile(
              title: Align(
                alignment: const Alignment(-1.2, 0),
                child: Text(PaymentTypeHelper.getTitle(
                    PaymentType.payOtherAmount, context)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              leading: Radio<PaymentType>(
                value: PaymentType.payOtherAmount,
                groupValue: _paymentType,
                onChanged: (PaymentType? value) {
                  setState(() {
                    _paymentType = value;
                  });
                },
              ),
            ),
            Center(
              child: Text(
                _paymentType == PaymentType.payEMI
                    ? "${AppHelper().getCurrencyFormat(double.parse(widget.loanModel.loIEmi ?? "0.0"))}/-"
                    : _paymentType == PaymentType.payDueAmount
                        ? "${AppHelper().getCurrencyFormat(double.parse(widget.loanModel.loITotdue ?? "0.0"))}/-"
                        : "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            _paymentType == PaymentType.payOtherAmount
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(children: [
                      TextField(
                        controller: _amountController,
                        // keyboardType: TextInputType.number,
                        keyboardType:
                            const TextInputType.numberWithOptions(signed: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        // decoration: InputDecoration(
                        //   hintText: "Enter the amount"
                        // ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                     const Text(
                        "Please enter Amount more than or equal to Rs 100/-)",
                        style:  TextStyle(fontSize: 15),
                      ),
                    ]))
                : Container(),
            Expanded(child: Container()),
            SizedBox(
              width: double.maxFinite,
              height: 55,
              child: CupertinoButton(
                color: primaryColor,
                child: Text(
                  MultiLanguage.of(context)!.translate("pay_now"), // "PAY NOW",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  onPayNowTapped();
                },
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        hideKeyboard();
      },
    );
  }

  onPayNowTapped() {
    if (_paymentType == null) {
      Get.snackbar(
          MultiLanguage.of(context)!.translate("alert"),
          MultiLanguage.of(context)!.translate(
              "please_select_option"), //"Please select an option to make payment",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else if (_paymentType == PaymentType.payOtherAmount &&
        _amountController.text == "") {
      Get.snackbar(
          MultiLanguage.of(context)!.translate("alert"),
          MultiLanguage.of(context)!
              .translate("please_enter_amout"), //"Please enter amount",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else if (_paymentType == PaymentType.payOtherAmount &&
        _amountController.text != "" &&
        double.tryParse(_amountController.text) != null &&
        double.parse(_amountController.text) < 100) {
      Get.snackbar(
          MultiLanguage.of(context)!.translate("alert"),
          MultiLanguage.of(context)!.translate(
              "make_sure_amount_more_or_equal"), //"Please make sure the entered amount is more than or equal to Rs 100/-",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else {
      if (_paymentType == PaymentType.payEMI) {
        amountPayable = double.tryParse(widget.loanModel.loIEmi!) ?? 0;
      } else if (_paymentType == PaymentType.payDueAmount) {
        amountPayable = double.tryParse(widget.loanModel.loITotdue!) ?? 0;
      } else {
        amountPayable = double.tryParse(_amountController.text) ?? 0;
      }
      amountPayable = amountPayable * 100; // convert to cents
      if (amountPayable > 0) {
        generateReceipt();
      } else {
        // Get.snackbar("Alert", "Invalid EMI amount",
        Get.snackbar(MultiLanguage.of(context)!.translate("alert"),
            MultiLanguage.of(context)!.translate("invalid_emi_amount"),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    }
  }

  //
  generateReceipt() async {
    Map<String, dynamic> params = Map();
    params["Lan"] = widget.loanModel.accNo;
    params["Token"] = API_TOKEN;
    params["Env"] = Environment().config?.envParam;

    showLoadingDialog(
        context: context,
        hint: "${MultiLanguage.of(context)!.translate("loading")}...");
    await Provider.of<LoanProvider>(context, listen: false)
        .generateReceiptForLoan(params)
        .then((receiptNum) async {
      if (receiptNum != null) {
        var body = {
          "currency": "INR",
          'amount': amountPayable,
          'receipt': receiptNum,
          'notes': {"policy_name": "vistaar_bandhu"}
        };
        await Provider.of<LoanProvider>(context, listen: false)
            .createRazorPayOrder(body)
            .then((orderJson) {
          if (orderJson != null && orderJson["id"] != null) {
            insertPaymentDetailsIntoInternalServer(orderJson["id"], receiptNum);
          }
        });
      }
      //hide loading dialog
      Navigator.pop(context);
    }, onError: (error) {
      //hide loading dialog
      Navigator.pop(context);
      Get.snackbar("Alert", "Something went wrong. Please try later.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    });
  }

  insertPaymentDetailsIntoInternalServer(
      String orderId, String receiptNo) async {
    var param = {
      'VisCustID': widget.loanModel.accNo,
      'RPCustID': "",
      'IndCustId': widget.loanModel.cCustomerNo,
      'VisOrderID': widget.loanModel.accNo,
      'RPOrderID': orderId,
      'Amount': amountPayable / 100,
      'VisReqString': "",
      'VisReceiptNo': receiptNo,
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
        Get.snackbar("Alert", "Something went wrong. Please try later.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    });
  }

  void openCheckout(String orderId) async {
    var options = {
      // 'key': 'rzp_live_ILgsfZCZoFIKMb',
      'key': razorpayKey,
      'amount': amountPayable,
      'currency': 'INR',
      'order_id': orderId, // Generate order_id using Orders API
      'name': widget.loanModel.loSzName ?? "",
      // 'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': pref.userMobile, 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorPay.open(options);
    } catch (e) {
      appPrint(Environment().config?.envParam, e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar("Alert", "Payment Successful",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
    if (response.signature != null || response.orderId != null) {
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
          .then((value) {
        debugPrint("updatePaymentDetails value = $value");
      });
    }
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => HomeScreen(),
      ),
      (route) => false, //if you want to disable back feature set to false
    );
    setState(() {});
    // Get.to(() => LoanPaymentCompletedPage(
    //       paymentCompleteStatus: "success",
    //       paymentCompleteResponse: response,
    //     ));
  }

  Future<void> _handlePaymentError(PaymentFailureResponse response) async {
    // Get.snackbar("Alert", "Payment was not processed please try again.",

    Get.snackbar(MultiLanguage.of(context)!.translate("alert"),
        MultiLanguage.of(context)!.translate("payment_was_not_processed"),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white);
    var param = {
      'RPOrderID': orderID,
      'RPResString': "$response",
      'RPTransStatus': "failed",
      'RPPaymentID': "",
      'RPSignature': "",
      'RPErrorCode': response.code,
      'RPErrorDesc': "{Error code: ${response.code}, Desc: ${response.message}",
      'Token': API_TOKEN,
      'Env': Environment().config?.envParam,
    };
   await Provider.of<LoanProvider>(context, listen: false)
        .updatePaymentDetails(param)
        .then((value) {
      debugPrint("updatePaymentDetails value = $value");
    });
    setState(() {});
    // Get.to(() => LoanPaymentCompletedPage(
    //       orderId: orderID,
    //       paymentCompleteStatus: "failed",
    //       paymentFailureResponse: response,
    //     ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("Alert", "EXTERNAL_WALLET: ${response.walletName!}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
    // Get.to(() => LoanPaymentCompletedPage(
    //       orderId: orderID,
    //       paymentCompleteStatus: "external",
    //       paymentExternalWallet: response,
    //     ));
  }
}
