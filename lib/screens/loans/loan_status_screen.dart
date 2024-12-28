import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vistaar_bandhu_new_version/models/loan_activity_model.dart';
import 'package:vistaar_bandhu_new_version/providers/auth_provider.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

import '../../environment.dart';
import '../../multilanguage.dart';

class LoanStatusScreen extends StatefulWidget {
  static const routeName = '/LoanStatusScreen';

  @override
  _LoanStatusScreenState createState() => _LoanStatusScreenState();
}

class _LoanStatusScreenState extends State<LoanStatusScreen> {
  String? applicationNumber;
  bool appLoggedIn = false;
  bool underCreditAssessment = false;
  bool sanctionPending = false;
  bool loanSanctioned = false;
  bool disbPending = false;
  bool disbReleaseInitiated = false;
  bool disburbed = false;
  List<LoanActivityModel> listActivity = [];
  List<LoanActivityModel> activeListActivity = [];

  void initState() {
    super.initState();
    applicationNumber = Get.arguments;
    // loadDefaultData();
    Future.delayed(Duration(milliseconds: 50)).then((value) {
      getLoanStatus();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadDefaultData();
  }

  loadDefaultData() {
    final loginActivity = LoanActivityModel(
        name: MultiLanguage.of(context)!
            .translate("app_logged_in") //"APP LOGGED IN"
        ,
        date: "",
        status: "",
        enabled: false);
    listActivity.add(loginActivity);
    //
    final creditActivity = LoanActivityModel(
        name: MultiLanguage.of(context)!
            .translate("under_credit_assessment"), //"UNDER CREDIT ASSESSMENT"
        date: "",
        status: "",
        enabled: false);
    listActivity.add(creditActivity);
    //
    final loanPendingActivity = LoanActivityModel(
        name: MultiLanguage.of(context)!
            .translate("loan_saction_pending"), // "LOAN SANCTION PENDING",
        date: "",
        status: "",
        enabled: false);
    listActivity.add(loanPendingActivity);
    //
    final loanSanActivity = LoanActivityModel(
        name: MultiLanguage.of(context)!
            .translate("loan_sactioned"), //"LOAN SANCTIONED",
        date: "",
        status: "",
        enabled: false);
    listActivity.add(loanSanActivity);
    //
    final disbPendingActivity = LoanActivityModel(
        name: MultiLanguage.of(context)!
            .translate("disbursement_pending"), //"DISBURSEMENT PENDING",
        date: "",
        status: "",
        enabled: false);
    listActivity.add(disbPendingActivity);
    //
    final disbReleaseActivity = LoanActivityModel(
        name: MultiLanguage.of(context)!.translate(
            "disbursement_release_initiated"), //"DISBURSEMENT RELEASE INITIATED",
        date: "",
        status: "",
        enabled: false);
    listActivity.add(disbReleaseActivity);
    //
    final disbActivity = LoanActivityModel(
        name: MultiLanguage.of(context)!.translate("disbursed"), // "DISBURSED",
        date: "",
        status: "",
        enabled: false);
    listActivity.add(disbActivity);
    //
    setState(() {});
  }

  Future getLoanStatus() async {
    showLoadingDialog(
      context: context,
      hint: MultiLanguage.of(context)!
          .translate("fetching_loan_status"), //"Fetching Loan Status"
    );
    await Provider.of<AuthProvider>(context, listen: false)
        .getLoanStatus(applicationNumber ?? "")
        .then((response) {
      if (response != null) {
        final value = response["applicationDtls"];
        if (value is List) {
          value.forEach((application) {
            if (application is List && application.length > 4) {
              String activityName =
                  application.first.replaceAll("activity_name :", "");
              String activityBeginDate =
                  application[1].replaceAll("activity_begin_date :", "") ?? "";
              String activityEndDate =
                  application[2].replaceAll("activity_end_date :", "");
              String activityStatus =
                  application[4].replaceAll("activity_status_Code :", "") ?? "";
              appLogger(Environment().config?.envParam, activityName);
              final loanActivity = LoanActivityModel(
                  name: activityName,
                  date: activityBeginDate,
                  status: activityStatus,
                  enabled: activityBeginDate.isNotEmpty);
              if (activityName.equalsIgnoreCase("DEDUPE_REV_HIGHMARK_DET") && activityStatus.equalsIgnoreCase("NOTIFIED") ||
                  activityName.equalsIgnoreCase("DEDUPE_REV_HIGHMARK_DET") &&
                      activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("CIBIL_HIGHMARK_REVIEW") &&
                      activityStatus.equalsIgnoreCase("NOTIFIED")) {
                if (!appLoggedIn) {
                  appLoggedIn = true;
                  loanActivity.name = "APP LOGGED IN";
                  activeListActivity.add(loanActivity);
                }
              } else if (activityName.equalsIgnoreCase("INITIATE_VERIFICATION") && activityStatus.equalsIgnoreCase("NOTIFIED") ||
                  activityName.equalsIgnoreCase("INITIATE_VERIFICATION") &&
                      activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("OFFICE_VERIF_I") &&
                      activityStatus.equalsIgnoreCase("NOTIFIED") ||
                  activityName.equalsIgnoreCase("OFFICE_VERIF_I") &&
                      activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("RESI_VERIF_I") &&
                      activityStatus.equalsIgnoreCase("NOTIFIED") ||
                  activityName.equalsIgnoreCase("RESI_VERIF_I") &&
                      activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("PER_DEC_WAIVE") &&
                      activityStatus.equalsIgnoreCase("NOTIFIED") ||
                  activityName.equalsIgnoreCase("PER_DEC_WAIVE") &&
                      activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("TRC_VERIF_I") &&
                      activityStatus.equalsIgnoreCase("NOTIFIED") ||
                  activityName.equalsIgnoreCase("TRC_VERIF_I") &&
                      activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("CFA_ELIGIBILITY") &&
                      activityStatus.equalsIgnoreCase("NOTIFIED")) {
                if (!underCreditAssessment) {
                  underCreditAssessment = true;
                  loanActivity.name = "UNDER CREDIT ASSESSMENT";
                  activeListActivity.add(loanActivity);
                }
              } else if (activityName.equalsIgnoreCase("CFA_ELIGIBILITY") && activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("COLLATERAL_ENTRY") &&
                      activityStatus.equalsIgnoreCase("NOTIFIED") ||
                  activityName.equalsIgnoreCase("COLLATERAL_ENTRY") &&
                      activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("Property_Legal_Valun") &&
                      activityStatus.equalsIgnoreCase("NOTIFIED") ||
                  activityName.equalsIgnoreCase("Property_Legal_Valun") &&
                      activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("MAKE_DECISION") &&
                      activityStatus.equalsIgnoreCase("NOTIFIED") ||
                  activityName.equalsIgnoreCase("MAKE_DECISION") &&
                      activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("FINAL_DECISION") &&
                      activityStatus.equalsIgnoreCase("NOTIFIED")) {
                if (!sanctionPending) {
                  sanctionPending = true;
                  loanActivity.name = "LOAN SANCTION PENDING";
                  activeListActivity.add(loanActivity);
                }
              } else if (activityName.equalsIgnoreCase("UPDATE_FINAL_DECISION") &&
                      activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("ADD_SUBPRODUCT") &&
                      activityStatus.equalsIgnoreCase("NOTIFIED")) {
                if (!loanSanctioned) {
                  loanSanctioned = true;
                  loanActivity.name = "LOAN SANCTIONED";
                  activeListActivity.add(loanActivity);
                }
              } else if (activityName.equalsIgnoreCase("LOAN_AGREE_DOC_PRINT") &&
                      activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("LOAN_AGREE_DOC_PRINT") && activityStatus.equalsIgnoreCase("NOTIFIED") ||
                  activityName.equalsIgnoreCase("DOC_RECPT1") && activityStatus.equalsIgnoreCase("NOTIFIED") ||
                  activityName.equalsIgnoreCase("DOC_RECPT1") && activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("FIRST_TIME_RIGHT") && activityStatus.equalsIgnoreCase("NOTIFIED") ||
                  activityName.equalsIgnoreCase("FIRST_TIME_RIGHT") && activityStatus.equalsIgnoreCase("COMPLETE") ||
                  activityName.equalsIgnoreCase("VERIFY_DOC_APPLICATION") && activityStatus.equalsIgnoreCase("NOTIFIED") ||
                  activityName.equalsIgnoreCase("VERIFY_DOC_APPLICATION") && activityStatus.equalsIgnoreCase("COMPLETE")) {
                if (!disbPending) {
                  disbPending = true;
                  loanActivity.name = "DISBURSEMENT PENDING";
                  activeListActivity.add(loanActivity);
                }
              } else if (activityName.equalsIgnoreCase("GEN_DISB_RELEASE") && activityStatus.equalsIgnoreCase("NOTIFIED") || activityName.equalsIgnoreCase("APPROVE_DISB_RLS") && activityStatus.equalsIgnoreCase("NOTIFIED") || activityName.equalsIgnoreCase("APPROVE_DISB_RLS") && activityStatus.equalsIgnoreCase("COMPLETE")) {
                if (!disbReleaseInitiated) {
                  disbReleaseInitiated = true;
                  loanActivity.name = "DISBURSEMENT RELEASE INITIATED";
                  activeListActivity.add(loanActivity);
                }
              } else if (activityName.equalsIgnoreCase("GEN_DISB_RELEASE") && activityStatus.equalsIgnoreCase("COMPLETE")) {
                if (!disburbed) {
                  disburbed = true;
                  loanActivity.name = "DISBURSED";
                  activeListActivity.add(loanActivity);
                }
              }
            }
          });
        }
        setState(() {});
      }

      //hide loading dialog
      Navigator.pop(context);
      setState(() {});
    }, onError: (error) {
      //hide loading dialog
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              width: 10,
            ),
            Text(
              MultiLanguage.of(context)!
                  .translate("loan_status"), //"Loan Status",
              style: TextStyle(color: goldColor),
            ),
            SizedBox(
              width: 60,
            ),
          ],
        ),
        centerTitle: true,
        actions: [],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            if (index == 0) {
              return buildAccNumber();
            } else {
              final loanActiviryModel = listActivity[index - 1];
              return buildActivityWidget(loanActiviryModel);
            }
          },
          itemCount: listActivity.length + 1,
        ),
      ),
    );
  }

  Widget buildAccNumber() {
    return Card(
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${MultiLanguage.of(context)!.translate("acc_no")} : ", //"Acc No : ",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            Text(
              applicationNumber ?? "-",
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActivityWidget(LoanActivityModel loanActivityModel) {
    final activeActivities = activeListActivity
        .where((element) => element.name == loanActivityModel.name)
        .toList();
    final enabled = activeActivities.isNotEmpty;
    LoanActivityModel? activeActivity;
    if (enabled) {
      activeActivity = activeListActivity
          .firstWhere((element) => element.name == loanActivityModel.name);
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  height: 30,
                  width: 2,
                  color: primaryColor,
                ),
                SizedBox(
                  height: 5,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 15,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 30,
                  width: 2,
                  color: primaryColor,
                ),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 90,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                    width: enabled ? 1 : 6,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          loanActivityModel.name,
                          style: TextStyle(
                              color: enabled ? primaryColor : Colors.grey,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                  activeActivity != null && activeActivity.date.isNotEmpty
                      ? Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(activeActivity.date,
                                style: TextStyle(
                                  color: enabled ? primaryColor : Colors.grey,
                                )),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension StringExtensions on String {
  bool equalsIgnoreCase(String secondString) =>
      this.toLowerCase().contains(secondString.toLowerCase());
}
