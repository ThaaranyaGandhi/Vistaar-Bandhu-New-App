
import 'dart:io';

import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/models/loan_model.dart';
import 'package:vistaar_bandhu_new_version/models/pvl_offer_model.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/providers/auth_provider.dart';
import 'package:vistaar_bandhu_new_version/providers/pvl_provider.dart';
import 'package:vistaar_bandhu_new_version/screens/policyScreen/policy_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/payEmi/pay_emi_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/pvl/pvl_offer_list.dart';
import 'package:vistaar_bandhu_new_version/screens/query_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/refer_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/request/eMandate_request.dart';
import 'package:vistaar_bandhu_new_version/screens/request/request_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/topup_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/welcomeKit/welcomeKitList.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:vistaar_bandhu_new_version/util/size_config.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../environment.dart';
import '../version_check.dart';
import 'loanAgreementForm/loanAgreementFormList.dart';
import 'loans/loan_screen.dart';
import 'menuDrawer/drawer_screen.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends BasePage {
  static const routeName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen>
    with WidgetsBindingObserver {
  int tabIndex = 0;
  List<String> listLoans = [];
  List<String> lmsLoans = [];
  List<PvlList>? listPvlOffers = [];
  List<String> filteredLoans = [];
  bool isLoanClosed = false;
  LoanModel? _loanModel;
  bool animate = true;

  List<List<String>> supportedLanguage = [
    ["en", "english"],
    ["hi", "hindi"],
    ["te", "telugu"],
    ["kn", "kannada"],
    ["ta", "tamil"],
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      if (mounted) {
        // getLoanList();
        getLMSLoan();
        getPvlList();
        Future.delayed(const Duration(seconds: 10), () {
          if (mounted) {
            // And this check
            setState(() {
              animate = false;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    versionCheck(context);

    var multilanguage = MultiLanguage.of(context);

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
              multilanguage!.translate("vistaar_bandhu"), //"Vistaar Bandhu",
              style: const TextStyle(color: goldColor),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              width: 10,
            ),
            //TODO: (Un)comment this to enable/disable multi language support
          ],
        ),
        centerTitle: true,
        actions: [
          LanguageSelectButton(
            multilanguage: multilanguage,
            supportedLanguage: supportedLanguage,
            animate: animate,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // height: 160,
                width: double.infinity,
                color: primaryColor,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    // Text(
                    //   multilanguage
                    //       .translate("live_your_dream"), //"Live Your Dream",
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.w700,
                    //       fontSize: 20),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      multilanguage.translate("we_offer_full_range"),
                      //"We offer a full range of financial services customized to fulfil your every business requirement. \n Our dream is to help you live your dream.",
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 10,
                color: goldColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      multilanguage.translate("account"), //"Account",
                      style: const TextStyle(color: primaryColor, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Expanded(
                        child: InkWell(
                          child: SizedBox(
                            height: 95,
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.monetization_on,
                                          color: primaryColor,
                                        ),
                                        Text(
                                          MultiLanguage.of(context)!
                                              .translate('loans'),
                                          // "Loans",
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () => Get.toNamed(LoanListScreen.routeName,
                              arguments: listLoans),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: 95,
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.credit_card,
                                          color: primaryColor,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          height: 22,
                                          child: Text(
                                            multilanguage.translate(
                                                "pay_emi"), //"Pay EMI",
                                            style: const TextStyle(
                                                color: primaryColor,
                                                fontSize: 13),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(PayEMIScreen.routeName,
                                arguments: filteredLoans);
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: SizedBox(
                            height: 95,
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 2, 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          const Icon(
                                            Icons.policy,
                                            color: primaryColor,
                                          ),
                                          Text(
                                            multilanguage.translate(
                                                "insurance"), //"Insurance",
                                            style: const TextStyle(
                                                color: primaryColor,
                                                fontSize: 13),
                                          ),
                                          Text(
                                            multilanguage.translate(
                                                "policy"), //"Policy",
                                            style: const TextStyle(
                                                color: primaryColor,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(InsurancePolicyScreen.routeName,
                                arguments: filteredLoans);
                          },
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // if (filteredLoans.isNotEmpty || kDebugMode)
                          Expanded(
                            child: InkWell(
                              child: Container(
                                height: 95,
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 20, 2, 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              const Icon(
                                                Icons.drafts_outlined,
                                                color: primaryColor,
                                              ),
                                              Text(
                                                multilanguage.translate(
                                                    "welcome"), //"Welcome",
                                                style: const TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                multilanguage
                                                    .translate("kit"), //"Kit",
                                                style: const TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              onTap: () {
                                Get.toNamed(WelcomeKitList.routeName,
                                    arguments: filteredLoans);
                              },
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                height: 95,
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 20, 2, 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              const Icon(
                                                Icons.app_registration,
                                                color: primaryColor,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                child: Text(
                                                  multilanguage.translate(
                                                      "emandate_details"),
                                                  //"Emandate",
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 13),
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ),
                                              // Text(
                                              //   multilanguage.translate(
                                              //       "activation"), //"Activation",
                                              //   style: TextStyle(
                                              //       color: primaryColor,
                                              //       fontSize: 13),
                                              //   overflow: TextOverflow.fade,
                                              // ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              onTap: () {
                                Get.toNamed(EmandateScreen.routeName,
                                    arguments: lmsLoans);
                              },
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                height: 95,
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 20, 2, 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              const Icon(
                                                Icons.receipt,
                                                color: primaryColor,
                                              ),
                                              Text(
                                                "${multilanguage.translate("top_up")}/", //"Top-up/",
                                                style: const TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                multilanguage
                                                    .translate("new_loans"),
                                                // "New Loans",
                                                style: const TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              onTap: () {
                                Get.toNamed(TopUpScreen.routeName);
                              },
                            ),
                          )
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      multilanguage.translate("others"), //"Others",
                      style: const TextStyle(color: primaryColor, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(QueryScreen.routeName);
                            },
                            child: SizedBox(
                              height: 95,
                              child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          const Icon(
                                            Icons.help,
                                            color: primaryColor,
                                          ),
                                          Text(
                                            multilanguage.translate(
                                                "queries"), //"Queries",
                                            style: const TextStyle(
                                                color: primaryColor,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                ReferScreen.routeName,
                                arguments: listLoans,
                              );
                            },
                            child: SizedBox(
                              height: 95,
                              child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          const Icon(
                                            Icons.emoji_people,
                                            color: primaryColor,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Text(
                                              multilanguage
                                                  .translate("refer_a_friend"),
                                              // "Refer a",
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 15),
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                          // Text(
                                          //   multilanguage.translate(
                                          //       "friend"), //"friend",
                                          //   style: TextStyle(
                                          //       color: primaryColor,
                                          //       fontSize: 15),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(PvlListScreen.routeName,
                                  arguments: listPvlOffers);
                            },
                            child: Container(
                              height: 95,
                              child: badge.Badge(
                                // padding: EdgeInsets.all(6),
                                // shape: BadgeShape.square,
                                // badgeColor: Colors.deepOrange,
                                // position:
                                //     BadgePosition.topStart(top: -5, start: 0),
                                // elevation: 5,
                                // borderRadius: BorderRadius.circular(7),
                                badgeContent: Text(
                                  '${listPvlOffers?.length ?? 0}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.credit_score,
                                          color: primaryColor,
                                        ),
                                        Text(
                                          multilanguage.translate(
                                              "pre_approved_loans_offers"),
                                          //"Pre Approved",
                                          style: const TextStyle(
                                            color: primaryColor,
                                            fontSize: 13,
                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                        ),
                                        // Expanded(
                                        //   child: Text(
                                        //     multilanguage.translate(
                                        //         "loans_offers"), //"Loans offers",
                                        //     style: TextStyle(
                                        //         color: primaryColor,
                                        //         fontSize: 13),
                                        //     overflow: TextOverflow.fade,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(RequestScreen.routeName);
                            },
                            child: SizedBox(
                              height: 95,
                              child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          const Icon(
                                            Icons.request_page,
                                            color: primaryColor,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Text(
                                              multilanguage.translate(
                                                  "requests"), //"Requests",
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 15),
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(LoanAgreementForm.routeName,
                                  arguments: listLoans);
                            },
                            child: SizedBox(
                              height: 95,
                              child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          const Icon(
                                            Icons.request_page,
                                            color: primaryColor,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child: Text(
                                              multilanguage.translate(
                                                  "loan_application_form"),
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 13),
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: Container(),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: new BottomNavigationBar(
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              this.tabIndex = index;
            });
            _navigateToScreens();
          },
          type: BottomNavigationBarType.fixed,
          items: [
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.location_pin), label: "Locate Us"),
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: MultiLanguage.of(context)!.translate("home") //"Home"
                ),
            BottomNavigationBarItem(
                icon: const Icon(Icons.call),
                label:
                    MultiLanguage.of(context)!.translate("call_us") //"Call Us"
                ),
          ]),
    );
  }

/*
  Future getLoanList() async {
    showLoadingDialog(
        context: context,
        hint: MultiLanguage.of(context)!
            .translate("fetching_loans") //"Fetching Loans"

        );
    await Provider.of<AuthProvider>(context, listen: false)
        .userLogin(pref.userMobile)
        .then((value) {
      //hide loading dialog
    //  Navigator.of(context).pop();
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
          listLoans.clear();
          for (var app in applicationNum) {
            final newApp = app.replaceAll("Application Number :", "");
            listLoans.add(newApp);
          }
        }
        setState(() {});
      }
    });
  }
*/

  getLMSLoan() async {
    showLoadingDialog(
        context: context,
        hint: MultiLanguage.of(context)!
            .translate("fetching_loans") //"Fetching Loans"
        );
    if (pref.userMobile == "8860088996") {
      Navigator.of(context).pop();
    }
    await Provider.of<AuthProvider>(context, listen: false)
        .userLogin(pref.userMobile)
        .then((value) async {
    //  Navigator.of(context).pop();
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

          for (var lanNo in listLoans) {
            await checkLoanClosed(lanNo).then((isClosed) {});
          }
          lmsLoans = filteredLoans;
          //hide loading dialog
          if (Navigator.canPop(context)) Navigator.pop(context);
        }
        setState(() {});
      } else {
        Navigator.of(context).pop();
      }
    }, onError: (error) {
      Get.snackbar("", MultiLanguage.of(context)!.translate("no_loans"),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      sleep(const Duration(seconds: 10));
      // Navigator.of(context).pop(); //FIXME: Remove this if server fixed
    });
  }

  Future<bool?> checkLoanClosed(String? applicationNumber) async {
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

  _navigateToScreens() {
    if (tabIndex == 1) {
      tabIndex = 0;
      _makePhoneCall("tel:08030088494");
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showErrorToast(
        MultiLanguage.of(context)!.translate(
            "something_went_wrong"), //"Something went wrong. Please try later"
      );
    }
  }

  void notify(String? imagePath) async {
    String timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'key1',
          title: 'Offers for you',
          body: 'Check your Pre-approved Loans',
          bigPicture: imagePath,
          notificationLayout: NotificationLayout.BigPicture),
      schedule: NotificationInterval(
          interval: const Duration(seconds: 3),
          timeZone: timezone,
          repeats: true),
    );
    appLogger(Environment().config?.envParam,
        "scheduler created at ${DateTime.now()}");
  }

  Future getPvlList() async {
/*    showLoadingDialog(
        context: context,
        hint:
            "${MultiLanguage.of(context)!.translate("loading")}..."); */
    //"Loading..."//);
    var param = {
      'Mobile': pref.userMobile,
      'Token': API_TOKEN,
      'Env': Environment().config?.envParam
    };

    await Provider.of<PvlProvider>(context, listen: false)
        .getPvlList(param)
        .then((value) {
      if (value != null) {
        if (value.d != null) {
          var listings = value.d!.toList();
          listPvlOffers!.addAll(listings);
          if (listPvlOffers!.isNotEmpty) {
            var image = listPvlOffers![0].imagePath;
            listPvlOffers!.forEach((element) {
              if (element.customerConsent == "Interested") {
                notify(image);
              }
            });
          }else {
            showSuccessToast('you do not have pvl offers');
          }

          setState(() {});
        } else {
          showSuccessToast('you do not have pvl offers');
        }
      } else {
        showSuccessToast('you do not have pvl offers');
      }

      //FIXME: Un-comment this if loans are added to UAT

    //  Environment == Environment.DEV ? null : Navigator.of(context).pop();
    }, onError: (error) {
      Navigator.of(context).pop();
    });
  }
}

class LanguageSelectButton extends StatelessWidget {
  LanguageSelectButton({
    Key? key,
    required this.multilanguage,
    required this.supportedLanguage,
    required this.animate,
  }) : super(key: key);

  final MultiLanguage? multilanguage;
  final List<List<String>> supportedLanguage;
  bool animate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.defaultDialog(
              title: multilanguage!
                  .translate("select_language"), //"Select Language",
              content: SizedBox(
                height: MediaQuery.of(context).size.height / 2.3,
                width: MediaQuery.of(context).size.width / 1.2,
                // height: 300,
                // width: 300,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: supportedLanguage.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          debugPrint(
                              "supportedLanguage[index][0] = ${supportedLanguage[index][0]}");
                          MultiLanguage().setLocale(
                            context,
                            Locale.fromSubtags(
                                languageCode: supportedLanguage[index][0]),
                          );
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: SizeConfig.screenHeight! / 15,
                            child: Card(
                              elevation: 2.5,
                              child: Center(
                                child: Text(
                                  MultiLanguage.of(context)!
                                      .translate(supportedLanguage[index][1]),
                                  style: const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Lottie.asset(
            "assets/json/language.json",
            height: 80,
            animate: animate,
          ),
        ));
  }
}
