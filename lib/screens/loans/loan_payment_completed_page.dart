import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../environment.dart';
import '../../multilanguage.dart';
import '../../providers/loan_provider.dart';
import '../../service/url_constants.dart';
import '../../util/app_message.dart';
import '../home_screen.dart';

class LoanPaymentCompletedPage extends StatefulWidget {
  const LoanPaymentCompletedPage({
    Key? key,
    required this.paymentCompleteStatus,
    this.paymentCompleteResponse,
    this.paymentFailureResponse,
    this.paymentExternalWallet,
    this.orderId,
  }) : super(key: key);
  final String paymentCompleteStatus;
  final PaymentSuccessResponse? paymentCompleteResponse;
  final PaymentFailureResponse? paymentFailureResponse;
  final ExternalWalletResponse? paymentExternalWallet;
  final String? orderId;

  @override
  State<LoanPaymentCompletedPage> createState() =>
      _LoanPaymentCompletedPageState();
}

class _LoanPaymentCompletedPageState extends State<LoanPaymentCompletedPage> {
  int count = 5;
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    updatePaymentData();
  }

  void updatePaymentData() {
    switch (widget.paymentCompleteStatus) {
      case "success":
        _handlePaymentSuccess(widget.paymentCompleteResponse!);
        break;
      case "failed":
        _handlePaymentError(widget.paymentFailureResponse!);
        break;
      case "external":
        _handleExternalWallet(widget.paymentExternalWallet!);
        break;
      default:
        debugPrint("404: Error");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // showSuccessToast(
    //     MultiLanguage.of(context)!.translate("payment_successful"));
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
      // Provider.of<LoanProvider>(context, listen: false)
      //     .updatePaymentDetails(param)
      //     .then((value) {
      // });

      try {
        Provider.of<LoanProvider>(context, listen: false)
            .updatePaymentDetails(param)
            .then((value) {
          countDown();
        });
      } catch (e) {
        debugPrint("exception is => $e");
      }
    }

    // Navigator.pushAndRemoveUntil<dynamic>(
    //   context,
    //   MaterialPageRoute<dynamic>(
    //     builder: (BuildContext context) => HomeScreen(),
    //   ),
    //   (route) => false, //if you want to disable back feature set to false
    // );
    setState(() {});
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showErrorToast(
          MultiLanguage.of(context)!.translate("payment_was_not_processed"));
    });

    var param = {
      'RPOrderID': widget.orderId,
      'RPTransStatus': "failed",
      'RPResString': "${response.message}",
      'RPPaymentID': "",
      'RPSignature': "",
      'RPErrorCode': response.code,
      'RPErrorDesc': "{Error code: ${response.code}, Desc: ${response.message}",
      'Token': API_TOKEN,
      'Env': Environment().config?.envParam,
    };
    try {
      Provider.of<LoanProvider>(context, listen: false)
          .updatePaymentDetails(param)
          .then((value) {});
    } catch (e) {
      debugPrint("exception is => $e");
    }

    countDown();

    setState(() {});
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // showSuccessToast("EXTERNAL_WALLET: " + response.walletName!);
    Get.snackbar("Alert", "EXTERNAL_WALLET: " + response.walletName!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
    countDown();
  }

  void countDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (count > 0) {
        if (mounted) {
          setState(() {
            count--;
          });
        }
      } else {
        timer.cancel();
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => HomeScreen(),
          ),
          (route) => false, //if you want to disable back feature set to false
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
            "Your payment is currently being processed. Please wait a moment. You will be automatically redirected to the home screen shortly."),
      )),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
