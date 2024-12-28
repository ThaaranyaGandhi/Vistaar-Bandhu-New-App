import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/models/de_nach_response.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/providers/loan_provider.dart';
import 'package:vistaar_bandhu_new_version/screens/request/nach_detail_screen.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:vistaar_bandhu_new_version/util/empty_message.dart';

class DeActivateNACHScreen extends BasePage {
  static const routeName = '/DeActivateNACHScreen';

  @override
  _DeActivateNACHScreenState createState() => _DeActivateNACHScreenState();
}

class _DeActivateNACHScreenState extends BaseState<DeActivateNACHScreen> {
  List<DeNachData> nachList = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      getNACHDetails();
    });
  }

  Future getNACHDetails() async {
    showLoadingDialog(
        context: context,
        hint: "${MultiLanguage.of(context)!.translate("loading")}...");
    var param = {
      'Mobile': pref.userMobile,
    };

    await Provider.of<LoanProvider>(context, listen: false)
        .getNACHDetails(param)
        .then((value) {
      if (value != null && value.d != null && value.d!.isNotEmpty) {
        nachList = value.d ?? [];
        setState(() {});
      } else {
        showSuccessToast(
            MultiLanguage.of(context)!.translate("you_do_not_have_lan"));
      }
      Navigator.of(context).pop();
    }, onError: (error) {
      Navigator.of(context).pop();
    });
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
            Text(
              MultiLanguage.of(context)!.translate("nach_deactivate"),
              style: const TextStyle(color: goldColor),
            ),
            const SizedBox(
              width: 50,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            final nachData = nachList[index];

            return nachList.isEmpty
                ? EmptyMessage(
                    MultiLanguage.of(context)!.translate("e_nach_not_active"))
                : nachData.nachList!.isEmpty
                    ? ExpansionTile(
                        title: Text(
                          nachData.lan ?? "",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        textColor: primaryColor,
                        collapsedTextColor: primaryColor,
                        iconColor: primaryColor,
                        children: const [
                          Text(
                            "There is no Loan details",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    : ExpansionTile(
                        title: Text(
                          nachData.lan ?? "",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        textColor: primaryColor,
                        collapsedTextColor: primaryColor,
                        iconColor: primaryColor,
                        children: nachData.nachList != null
                            ? nachData.nachList!.map((e) {
                                return Padding(
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    "${MultiLanguage.of(context)!.translate("name")} : ",
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    nachData.custFname ?? "",
                                                  ),
                                                ),
                                              ]),
                                              TableRow(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    "${MultiLanguage.of(context)!.translate("urmn")} : ",
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    e.umrn ?? "",
                                                  ),
                                                ),
                                              ]),
                                              TableRow(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    "${MultiLanguage.of(context)!.translate("bank_name")} : ",
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    e.bankname ?? "",
                                                  ),
                                                ),
                                              ]),
                                              TableRow(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    "${MultiLanguage.of(context)!.translate("account_number")} : ",
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    e.acNumber ?? "",
                                                  ),
                                                ),
                                              ]),
                                              TableRow(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    "${MultiLanguage.of(context)!.translate("account_status")} : ",
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    e.nachStatus ?? "-",
                                                  ),
                                                ),
                                              ]),
                                            ],
                                          ),
                                          e.nachStatus == "Active"
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    primaryColor),
                                                      ),
                                                      child: Text(
                                                        MultiLanguage.of(
                                                                context)!
                                                            .translate(
                                                                "nach_deactivate"),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      onPressed: () async {
                                                        showAdaptiveAlertDialog(
                                                            context: context,
                                                            title: MultiLanguage
                                                                    .of(
                                                                        context)!
                                                                .translate(
                                                                    "de_activate"),
                                                            content: MultiLanguage
                                                                    .of(
                                                                        context)!
                                                                .translate(
                                                                    "are_you_sure_you_want_to_de_activate_nach"),
                                                            //"Are you sure you want to De-Activate NACH?",
                                                            defaultActionText:
                                                                MultiLanguage.of(
                                                                        context)!
                                                                    .translate(
                                                                        "yes"),
                                                            //"Yes",
                                                            cancelActionText:
                                                                MultiLanguage.of(
                                                                        context)!
                                                                    .translate(
                                                                        "no"),
                                                            //"No",
                                                            defaultAction:
                                                                () async {
                                                              final status =
                                                                  await Get.toNamed(
                                                                      NACHDetailsScreen
                                                                          .routeName,
                                                                      arguments: {
                                                                    "nachData":
                                                                        nachData,
                                                                    "nachModel":
                                                                        e
                                                                  });
                                                              if (status ==
                                                                  null) {
                                                                nachList
                                                                    .clear();
                                                                setState(() {});
                                                                getNACHDetails();
                                                              }
                                                            });
                                                      },
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()
                            : [],
                      );
          },
          itemCount: nachList.length,
        ),
      ),
    );
  }
}
