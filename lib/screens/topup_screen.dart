import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/providers/loan_provider.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_enum.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

import '../environment.dart';

class TopUpScreen extends BasePage {
  static const routeName = '/TopUpScreen';

  @override
  _TopUpScreenState createState() => _TopUpScreenState();
}

class _TopUpScreenState extends BaseState<TopUpScreen> {
  TextEditingController _amountController = TextEditingController();
  LastLoanType? _lastLoanType;
  bool visibility = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
              child: Image.asset(
                "assets/images/vistaar_logo.png",
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                MultiLanguage.of(context)!.translate("top_up_new_loans"),
                style: TextStyle(color: goldColor),
                overflow: TextOverflow.fade,
              ),
            ),
            SizedBox(
              width: 50,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          hideKeyboard();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    MultiLanguage.of(context)!.translate("top_up"),
                    style: TextStyle(fontSize: 20, color: primaryColor),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 3.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${MultiLanguage.of(context)!.translate("name")}",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            pref.userName,
                            style: TextStyle(color: primaryColor, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${MultiLanguage.of(context)!.translate("mobile_number")}",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            pref.userMobile,
                            style: TextStyle(color: primaryColor, fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            MultiLanguage.of(context)!
                                .translate("did_you_take_loan"),
                            style: TextStyle(color: primaryColor, fontSize: 15),
                          ),
                          RadioListTile<LastLoanType>(
                            contentPadding: EdgeInsets.all(0),
                            title: Text(
                              LastLoanTypeHelper.getTitle(
                                  LastLoanType.moreThan12Month, context),
                            ),
                            value: LastLoanType.moreThan12Month,
                            groupValue: _lastLoanType,
                            onChanged: (LastLoanType? value) {
                              setState(() {
                                _lastLoanType = value;
                              });
                              visibility = true;
                            },
                          ),
                          RadioListTile<LastLoanType>(
                            contentPadding: EdgeInsets.all(0),
                            title: Text(
                              LastLoanTypeHelper.getTitle(
                                  LastLoanType.lessThan12Month, context),
                            ),
                            value: LastLoanType.lessThan12Month,
                            groupValue: _lastLoanType,
                            onChanged: (LastLoanType? value) {
                              setState(() {
                                _lastLoanType = value;
                              });
                              visibility = false;
                              showErrorToast(MultiLanguage.of(context)!
                                  .translate("top_up_loan_can_be_processed"));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          if (visibility)
                            Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      MultiLanguage.of(context)!
                                          .translate("amount"),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextField(
                                      controller: _amountController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        hintText:
                                            "${MultiLanguage.of(context)!.translate("enter_the_amount_here")}", //Enter the amount here...",
                                      ),
                                    ),
                                  ]),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 55,
                    child: CupertinoButton(
                      color: primaryColor,
                      child: Text(
                        "${MultiLanguage.of(context)!.translate("apply")}", //APPLY
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () async {
                        _onSubmit();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onSubmit() {
    if (_amountController.text.trim().isEmpty || _lastLoanType == null) {
      showErrorToast(
          MultiLanguage.of(context)!.translate("please_enter_values"));
    } else if (int.tryParse(_amountController.text.trim()) != null &&
        (int.parse(_amountController.text.trim()) > 5000000 ||
            int.parse(_amountController.text.trim()) <= 0)) {
      showErrorToast(MultiLanguage.of(context)!
          .translate("please_enter_amount_less_than_50"));
      //"Please enter the amount less than Rs 50,00,000/- and not Rs 0/-");
    } else if (_lastLoanType != null &&
        _lastLoanType == LastLoanType.lessThan12Month) {
      showErrorToast(MultiLanguage.of(context)!
          .translate("top_up_loan_can_be_processed_after_12"));
      //"Top-up loan can be processed only after 12 months of your current loan disbursed");
    } else {
      hideKeyboard();
      showTopUpRequestDialog();
    }
    setState(() {});
  }

  showTopUpRequestDialog() {
    showAdaptiveAlertDialog(
        context: context,
        title: MultiLanguage.of(context)!
            .translate("top_up_loans"), //"Top-up Loans",
        content: MultiLanguage.of(context)!.translate(
            "would_you_request_top_up"), //"Would you like to request top up on your loan?",
        defaultActionText: MultiLanguage.of(context)!.translate("ok"),
        cancelActionText:
            MultiLanguage.of(context)!.translate("cancel"), //"Cancel",
        defaultAction: () {
          sendTopUpRequest();
        });
  }

  sendTopUpRequest() async {
    Map<String, dynamic> params = Map();
    params["CustName"] = pref.userName;
    params["RequestType"] = "TOPUP";
    params["Amount"] = _amountController.text.trim();
    params["CreatedBy"] = pref.userMobile;
    params["Token"] = API_TOKEN;
    params["Env"] = Environment().config?.envParam;

    showLoadingDialog(
        context: context,
        hint: "${MultiLanguage.of(context)!.translate("loading")}...");
    await Provider.of<LoanProvider>(context, listen: false)
        .topUpLoanRequest(params)
        .then((value) {
      //hide loading indicator
      Navigator.pop(context);
      if (value != null) {
        showSuccessToast(
          MultiLanguage.of(context)!.translate("top_up_request_successful"),
        );
        Get.back();
      }
    });
    setState(() {});
  }
}
