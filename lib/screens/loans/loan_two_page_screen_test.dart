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
import 'package:vistaar_bandhu_new_version/providers/loan_provider.dart';
import 'package:vistaar_bandhu_new_version/screens/loans/loan_future_installment_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/loans/loan_payment_list_screen.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_enum.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../multilanguage.dart';
import '../home_screen.dart';

class LoanTwoPageTest extends BasePage {
  @override
  State<LoanTwoPageTest> createState() => _LoanTwoPageTestState();
}

class _LoanTwoPageTestState extends BaseState<LoanTwoPageTest> {
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
    final data = Get.arguments;
    setState(() {
      _loanModel = data["loanModel"];
      applicationNumber = data["applicationNumber"];
    });
    super.initState();
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
            const Text(
              "Loan Details",
              style: TextStyle(color: goldColor),
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
                //    radius: const Radius.circular(3),
               //     backgroundColor: Colors.grey.shade300,
              //      indicatorColor: Colors.blue.shade900,
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
                        label: 'ACCOUNT',
                        color: Colors.blue.shade900,
                      ),
                      const SegmentTab(
                        label: 'TRANSACTIONS',
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
                                        columnWidths: const{
                                          0:  FractionColumnWidth(.4)
                                        },
                                        border: TableBorder.all(
                                            color: Colors.transparent),
                                        children: [
                                          TableRow(children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "Name : ",
                                                style: TextStyle(
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
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "LAN : ",
                                                style: TextStyle(
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
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "Loan Amt : ",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "Rs ${_loanModel!.loILnamt ?? ""}/-",
                                                style: const TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "EMI : ",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "Rs ${_loanModel!.loIEmi ?? ""}/-",
                                                style: const TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "Status : ",
                                                style: TextStyle(
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
                                                          "OverDue"
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "Payment Due : ",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                "Rs ${_loanModel!.loITotdue ?? ""}/-",
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
                                      const Text("(Including All Charges)",
                                          style: TextStyle(color: Colors.grey)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text("Select an option to make payment",
                                          style: TextStyle(
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
                                          child: new Text(
                                              PaymentTypeHelper.getTitle(
                                                  PaymentType.payEMI, context)),
                                          alignment: const Alignment(-1.2, 0),
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
                                        title:  Align(
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
                                          child: new Text(
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
                                      Center(
                                        child: Text(
                                          _paymentType == PaymentType.payEMI
                                              ? "Rs ${_loanModel!.loIEmi ?? ""}/-"
                                              : _paymentType ==
                                                      PaymentType.payDueAmount
                                                  ? "Rs ${_loanModel!.loITotdue ?? ""}/-"
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
                                    MultiLanguage.of(context)!
                                        .translate("pay_now"),
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
                        label: 'TRANSACTIONS',
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
        return "OverDue";
      }
    }
    return "Regular";
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

//TODO: Add notes in body which take array of strings
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
    showSuccessToast("Payment Successful");
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
          .then((value) {});
    }
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => HomeScreen(),
      ),
      (route) => false, //if you want to disable back feature set to false
    );
    setState(() {});
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showErrorToast("Payment was not processed please try again.");
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
        .then((value) {});
    setState(() {});
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showSuccessToast("EXTERNAL_WALLET: " + response.walletName!);
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
      showErrorToast("Something went wrong. Please try later");
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
      {"title": "Payments", "image": "assets/images/soa_vist.png"},
      {"title": "Future Installments", "image": "assets/images/loan_close.png"},
    ];
    return Container(
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          var option = options[index];
          return Card(
            margin: const EdgeInsets.all(10.0),
            elevation: 8,
            child: InkWell(
                child: Container(
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
      ),
    );
  }
}
