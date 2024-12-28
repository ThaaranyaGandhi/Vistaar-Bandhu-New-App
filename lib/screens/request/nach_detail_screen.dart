import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/models/de_nach_response.dart';
import 'package:vistaar_bandhu_new_version/providers/loan_provider.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

import '../../multilanguage.dart';

class NACHDetailsScreen extends BasePage {
  static const routeName = '/NACHDetailsScreen';

  @override
  _NACHDetailsScreenState createState() => _NACHDetailsScreenState();
}

class _NACHDetailsScreenState extends BaseState<NACHDetailsScreen> {
  DeNachData? nachData;
  NachModel? nachModel;
  bool isSubmitted = false;

  @override
  void initState() {
    nachData = Get.arguments["nachData"];
    nachModel = Get.arguments["nachModel"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            const Text(
              "NACH Details",
              style: TextStyle(color: goldColor),
            ),
            const SizedBox(
              width: 50,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "You are about to raise request for mandate cancellation, please review the details and confirm",
                        style: TextStyle(color: primaryColor, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Table(
                        columnWidths: const{0:  FractionColumnWidth(.4)},
                        border: TableBorder.all(color: Colors.transparent),
                        children: [
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "LAN : ",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                nachData?.lan ?? "",
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "Name : ",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                nachData?.custFname ?? "",
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "URMN : ",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                nachModel?.umrn ?? "",
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "Bank Name : ",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                nachModel?.bankname ?? "",
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "Account Number : ",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                nachModel?.acNumber ?? "",
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "NACH Status : ",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                nachModel?.nachStatus ?? "",
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isSubmitted
                          ? const Text(
                              "Your mandate cancellation request has been accepted and sent to respective team.",
                              style:
                                  TextStyle(color: primaryColor, fontSize: 18),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
              isSubmitted
                  ? Container()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.maxFinite,
                        height: 70,
                        child: CupertinoButton(
                          color: primaryColor,
                          child: const Center(
                            child: Text(
                              "CONFIRM MANDATE CANCELLATION",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          onPressed: () async {
                            showAdaptiveAlertDialog(
                                context: context,
                                title: "De-Activate",
                                content:
                                    "Are you sure you want to De-Activate NACH?",
                                defaultActionText: "Yes",
                                cancelActionText: "No",
                                defaultAction: () {
                                  _onSubmit();
                                });
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmit() async {
    var param = {
      'LanId': nachData?.lan,
      'UMRN': nachModel?.umrn,
      'AppId': nachData?.lan,
      'Reqdt': DateFormat("dd-MM-yyyy hh:mm:ss a").format(DateTime.now()),
      'MobileNo': pref.userMobile
    };

    showLoadingDialog(
        context: context,
        hint: "${MultiLanguage.of(context)!.translate("loading")}...");
    await Provider.of<LoanProvider>(context, listen: false)
        .deActivateNACH(param)
        .then((value) {
      Navigator.pop(context);
      if (value == "Sucess") {
        isSubmitted = true;
        setState(() {});
      } else {
        showErrorToast("Request Not Submitted");
      }
    });
  }
}
