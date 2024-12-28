import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/models/loan_model.dart';
import 'package:vistaar_bandhu_new_version/providers/auth_provider.dart';
import 'package:vistaar_bandhu_new_version/providers/loan_provider.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:vistaar_bandhu_new_version/util/empty_message.dart';

import '../../environment.dart';
import '../../multilanguage.dart';

class ForceClosureRequestScreen extends BasePage {
  static const routeName = '/ForceClosureRequestScreen';

  @override
  _ForceClosureRequestScreenState createState() =>
      _ForceClosureRequestScreenState();
}

class _ForceClosureRequestScreenState
    extends BaseState<ForceClosureRequestScreen> {
  List<String> listLoans = [];
  int? selectedIndex;
  List<String> filteredLoans = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      getLoanList();
    });
  }

  Future getLoanList() async {
    showLoadingDialog(
        context: context,
        hint: MultiLanguage.of(context)!.translate("fetching_loans"));
    await Provider.of<AuthProvider>(context, listen: false)
        .userLogin(pref.userMobile)
        .then((value) async {
      if (value != null) {
        if (value.applicationReference != null &&
            value.applicationReference!.isNotEmpty) {
          List<String> applicationNum =
              value.applicationReference!.where((element) {
            if (element.contains("Application Number")) {
              return true;
            }
            return false;
          }).toList();

          for (var app in applicationNum) {
            final newApp = app.replaceAll("Application Number :", "");
            listLoans.add(newApp);
          }
          //
          for (var lanNo in listLoans) {
            await checkLoanClosed(lanNo).then((isClosed) {});
          }
          listLoans = filteredLoans;
          appPrint(Environment().config?.envParam, filteredLoans);
        }
        setState(() {});
      }
      //hide loading dialog
      Navigator.pop(context);
    });
  }

  Future<bool?> checkLoanClosed(String? applicationNumber) async {
    LoanModel? _loanModel;
    bool isLoanClosed = false;
    // showLoadingDialog(hint: "Fetching Loan Details");
    await Provider.of<AuthProvider>(context, listen: false)
        .getLoanDetail(applicationNumber ?? "")
        .then((value) {
      //hide loading dialog
      // Navigator.pop(context);
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
          isLoanClosed = true;
        }

        if (!isLoanClosed) {
          filteredLoans.add(applicationNumber ?? "");
        }
      }
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    MultiLanguage multiLanguage = MultiLanguage.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        // status bar brightness
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
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                multiLanguage.translate("foreclosure_requests"),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: goldColor),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: listLoans.isEmpty
            ? EmptyMessage(multiLanguage.translate("no_loans"))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        return Card(
                          margin: const EdgeInsets.all(10.0),
                          child: InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              height: 50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Expanded(
                                  //   child: Text(
                                  //     "Loan Account Number",
                                  //     textAlign: TextAlign.start,
                                  //   ),
                                  // ),

                                  selectedIndex != null &&
                                          selectedIndex == index
                                      ? const Icon(
                                          Icons.radio_button_checked,
                                          color: primaryColor,
                                        )
                                      : const Icon(
                                          Icons.radio_button_off,
                                          color: primaryColor,
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      listLoans[index],
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              selectedIndex = index;
                              setState(() {});
                            },
                          ),
                        );
                      },
                      itemCount: listLoans.length,
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
                          multiLanguage.translate("place_request"),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () async {
                          if (selectedIndex == null) {
                            showErrorToast(multiLanguage
                                .translate("please_select_lan_account"));
                          } else {
                            showSOARequestDialog();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  showSOARequestDialog() {
    showAdaptiveAlertDialog(
        context: context,
        title: MultiLanguage.of(context)!.translate("foreclosure_requests"),
        content:
            "${MultiLanguage.of(context)!.translate("foreclosure_request_confirm")} ?",
        defaultActionText: MultiLanguage.of(context)!.translate("ok"),
        cancelActionText: MultiLanguage.of(context)!.translate("cancel"),
        defaultAction: () {
          sendFCRequest();
        });
  }

  sendFCRequest() async {
    Map<String, dynamic> params = Map();
    params["CustName"] = pref.userName;
    params["RequestType"] = "FORECLOSURE";
    params["CreatedBy"] = pref.userMobile;
    params["LAN"] = listLoans[selectedIndex!];
    params["Token"] = API_TOKEN;
    params["Env"] = Environment().config?.envParam;
    // params["Env"] = "PROD";

    showLoadingDialog(
        context: context,
        hint: "${MultiLanguage.of(context)!.translate("loading")}...");
    await Provider.of<LoanProvider>(context, listen: false)
        .placeSOARequest(params)
        .then((value) {
      //hide loading indicator
      Navigator.pop(context);
      if (value != null) {
        showSuccessToast(
            MultiLanguage.of(context)!.translate("request_placed"));
        //"Your Request is placed , Please collect the same from your Relationship manager");
        Get.back();
      } else {
        showErrorToast(MultiLanguage.of(context)!.translate(
            "something_went_wrong")); //("Something went wrong. Please try later");
      }
    });
  }
}
