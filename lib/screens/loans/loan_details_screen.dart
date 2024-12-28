import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/environment.dart';
import 'package:vistaar_bandhu_new_version/models/loan_model.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/providers/loan_provider.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_enum.dart';
import 'package:vistaar_bandhu_new_version/util/app_helper.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../home_screen.dart';
import 'loan_future_installment_screen.dart';
import 'loan_payment_list_screen.dart';

class LoanDetailScreen extends BasePage {
  static const routeName = '/LoanDetailScreen';

  @override
  _LoanDetailScreenState createState() => _LoanDetailScreenState();
}

class _LoanDetailScreenState extends BaseState<LoanDetailScreen> {
  LoanModel? _loanModel;
  String? applicationNumber;
  bool isLoanClosed = false;
  PaymentType? _paymentType;
  TextEditingController _amountController = TextEditingController();
  late Razorpay _razorPay;
  double amountPayable = 0;
  String orderID = '';
  int tabIndex = 0;
  String? _lss = "";

  @override
  void initState() {
    super.initState();
    _amountController.text = "0";
    // applicationNumber = Get.arguments;
    //
    // Future.delayed(Duration(milliseconds: 50)).then((value) {
    //   getLoanDetails();
    // });

    final data = Get.arguments;

    if (data is Map<String, dynamic>) {
      setState(() {
        isLoanClosed = data["isLoanClosed"] ?? false;
        _loanModel = data["loanModel"];
        applicationNumber = data["applicationNumber"];
      });
    }

    //  _razorPay.open(options);
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

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

  @override
  void dispose() {
    _razorPay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Provide the [TabController]
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
            Text(
              MultiLanguage.of(context)!.translate("loan_details"),
              style: const TextStyle(color: goldColor),
            ),
            const SizedBox(
              width: 60,
            ),
          ],
        ),
        centerTitle: true,
        actions: [],
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SegmentedTabControl(
                    // Customization of widget
                    //       radius: const Radius.circular(3),
                    //     backgroundColor: Colors.grey.shade300,
                    //   indicatorColor: Colors.blue.shade900,
                    indicatorDecoration: BoxDecoration(
                      color: Colors.blue.shade900,
                    ),
                    tabTextColor: Colors.black45,
                    selectedTabTextColor: Colors.white,
                    squeezeIntensity: 2,
                    height: 45,
                    tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                    tabs: [
                      SegmentTab(
                        label: MultiLanguage.of(context)!.translate("account"),
                        color: Colors.blue.shade900,
                      ),
                      SegmentTab(
                        label: MultiLanguage.of(context)!
                            .translate("transactions"),
                      ),
                    ],
                  ),
                ),
                // Sample pages
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Table(
                                        columnWidths: const {
                                          0: FractionColumnWidth(.4)
                                        },
                                        border: TableBorder.all(
                                            color: Colors.transparent),
                                        children: [
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "${MultiLanguage.of(context)!.translate("name")} : ",
                                                style: const TextStyle(
                                                    color: Colors.grey),
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
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "${MultiLanguage.of(context)!.translate("lan")} : ",
                                                style: const TextStyle(
                                                    color: Colors.grey),
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
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "${MultiLanguage.of(context)!.translate("loan_amount")} : ",
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "${AppHelper().getCurrencyFormat(double.parse(_loanModel!.loILnamt!)) ?? ""}/-",
                                                style: const TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "${MultiLanguage.of(context)!.translate("emi")} : ",
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                " ${AppHelper().getCurrencyFormat(double.parse(_loanModel!.loIEmi!)) ?? ""}/-",
                                                style: const TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "${MultiLanguage.of(context)!.translate("status")} : ",
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                getLoanStatus(),
                                                style: TextStyle(
                                                  color: getLoanStatus() ==
                                                          MultiLanguage.of(
                                                                  context)!
                                                              .translate(
                                                                  "overdue")
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "${MultiLanguage.of(context)!.translate("payment_due")} : ",
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "${AppHelper().getCurrencyFormat(double.parse(_loanModel!.loITotdue!)) ?? ""}/-",
                                                style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ])
                                        ],
                                      ),
                                      Text(
                                          "(${MultiLanguage.of(context)!.translate("including_all_charges")})",
                                          style: const TextStyle(color: Colors.grey)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          MultiLanguage.of(context)!.translate("select_an_option_to_make_payment"),
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ListTile(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 0.0, vertical: 0.0),
                                        visualDensity: const VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        title: Align(
                                          alignment: const Alignment(-1.2, 0),
                                          child:  Text(
                                              PaymentTypeHelper.getTitle(
                                                  PaymentType.payEMI, context)),
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
                                      ),
                                      ListTile(
                                        title: Align(
                                          alignment: const Alignment(-1.2, 0),
                                          child:  Text(
                                              PaymentTypeHelper.getTitle(
                                                  PaymentType.payDueAmount,
                                                  context)),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 0.0, vertical: 0.0),
                                        visualDensity: const VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        leading: Radio<PaymentType>(
                                          value: PaymentType.payDueAmount,
                                          groupValue: _paymentType,
                                          onChanged: (PaymentType? value) {
                                            setState(() {
                                              _paymentType = value;
                                            });
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: Align(
                                          alignment: const Alignment(-1.2, 0),
                                          child:  Text(
                                              PaymentTypeHelper.getTitle(
                                                  PaymentType.payOtherAmount,
                                                  context)),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 0.0, vertical: 0.0),
                                        visualDensity: const VisualDensity(
                                            horizontal: 0, vertical: -4),
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
                                      Container(
                                        child: Center(
                                          child: Text(
                                            _paymentType == PaymentType.payEMI
                                                ? " ${AppHelper().getCurrencyFormat(double.parse(_loanModel!.loIEmi!)) ?? ""}/-"
                                                : _paymentType ==
                                                        PaymentType.payDueAmount
                                                    ? " ${AppHelper().getCurrencyFormat(double.parse(_loanModel!.loITotdue!)) ?? ""}/-"
                                                    : "",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      _paymentType == PaymentType.payOtherAmount
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(children: [
                                                TextField(
                                                  controller: _amountController,
                                                  keyboardType: const TextInputType
                                                      .numberWithOptions(
                                                          signed: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                  "(Please enter Amount more than or equal to Rs 100/-)",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ]))
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                width: double.maxFinite,
                                height: 55,
                                child: CupertinoButton(
                                  color: primaryColor,
                                  child: Text(
                                    MultiLanguage.of(context)!.translate("pay_now"),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onPressed: () async {
                                    onPayNowTapped();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      PaymentAndFuturePayment(
                        label:
                            MultiLanguage.of(context)!.translate("transactions"),
                        color: Colors.blue.shade100,
                        applicationNumber: applicationNumber!,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

  onPayNowTapped() {
    if (_paymentType == null) {
      showErrorToast("Please select an option to make payment");
    } else if (_paymentType == PaymentType.payOtherAmount &&
        _amountController.text == "") {
      showErrorToast("Please enter amount");
    } else if (_paymentType == PaymentType.payOtherAmount &&
        _amountController.text != "" &&
        double.tryParse(_amountController.text) != null &&
        double.parse(_amountController.text) < 100) {
      showErrorToast(
          "Please make sure the entered amount is more than or equal to Rs 100/-");
    } else {
      if (_paymentType == PaymentType.payEMI) {
        amountPayable = double.tryParse(_loanModel!.loIEmi!) ?? 0;
      } else if (_paymentType == PaymentType.payDueAmount) {
        amountPayable = double.tryParse(_loanModel!.loITotdue!) ?? 0;
      } else {
        amountPayable = double.tryParse(_amountController.text) ?? 0;
      }
      amountPayable = amountPayable * 100; // convert to cents

      if (amountPayable > 0) {
        generateReceipt();
      } else {
        showErrorToast("Invalid EMI amount");
      }
    }
  }

  //
  generateReceipt() async {
    Map<String, dynamic> params = Map();
    params["Lan"] = applicationNumber;
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
      showErrorToast("Something went wrong. Please try later.");
    });
  }

  insertPaymentDetailsIntoInternalServer(
      String orderId, String receiptNo) async {
    var param = {
      'VisCustID': applicationNumber,
      'RPCustID': "",
      'IndCustId': _loanModel!.cCustomerNo,
      'VisOrderID': applicationNumber,
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
        showErrorToast('Something went wrong. Please try later.');
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
      'name': _loanModel!.loSzName ?? "",
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
    showSuccessToast(
        MultiLanguage.of(context)!.translate("payment_successful"));
    // appLogger(" emi status ${response.paymentId}");
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
    // setState(() {});
    // Get.to(() => LoanPaymentCompletedPage(
    //       paymentCompleteStatus: "success",
    //       paymentCompleteResponse: response,
    //     ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showErrorToast(
        MultiLanguage.of(context)!.translate("payment_was_not_processed"));
    var param = {
      'RPOrderID': orderID,
      'RPTransStatus': "failed",
      'RPResString': "$response",
      'RPPaymentID': "",
      'RPSignature': "",
      'RPErrorCode': response.code,
      'RPErrorDesc': "{Error code: ${response.code}, Desc: ${response.message}",
      'Token': API_TOKEN,
      'Env': Environment().config?.envParam,
    };
    Provider.of<LoanProvider>(context, listen: false)
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
    showSuccessToast("EXTERNAL_WALLET: " + response.walletName!);
    // Get.to(() => LoanPaymentCompletedPage(
    //       orderId: orderID,
    //       paymentCompleteStatus: "external",
    //       paymentExternalWallet: response,
    //     ));
  }

  _navigateToScreens() {
    if (tabIndex == 0) {
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => HomeScreen(),
        ),
        (route) => false, //if you want to disable back feature set to false
      );
      setState(() {});
    } else {
      tabIndex = 0;
      _makePhoneCall("tel:08030088494");
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showErrorToast(
          MultiLanguage.of(context)!.translate("something_went_wrong"));
    }
  }
}

class PaymentAndFuturePayment extends StatelessWidget {
  const PaymentAndFuturePayment(
      {Key? key,
      required this.label,
      required this.color,
      required this.applicationNumber})
      : super(key: key);

  final String label;
  final Color color;
  final String applicationNumber;

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> options = [
      {
        "title": "${MultiLanguage.of(context)!.translate("payments")}",
        "image": "assets/images/soa_vist.png"
      },
      {
        "title":
            MultiLanguage.of(context)!.translate("future_installments"),
        "image": "assets/images/loan_close.png"
      },
    ];
    return ListView.builder(
      itemBuilder: (ctx, index) {
        var option = options[index];
        return Card(
          margin: const EdgeInsets.all(10.0),
          elevation: 8,
          child: InkWell(
              child: SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                      child: Image.asset(
                        option["image"]!,
                      ),
                    ),
                    Text(
                      option["title"] ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: primaryColor),
                    )
                  ],
                ),
              ),
              onTap: () {
                if (index == 0) {
                  Get.toNamed(LoanPaymentListScreen.routeName,
                      arguments: {"applicationNumber": applicationNumber});
                } else if (index == 1) {
                  Get.toNamed(LoanFutureInstallmentListScreen.routeName,
                      arguments: {"applicationNumber": applicationNumber});
                }
              }),
        );
      },
      itemCount: options.length,
    );
  }
}
