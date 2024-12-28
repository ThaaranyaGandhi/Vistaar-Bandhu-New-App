
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/models/loan_model.dart';
import 'package:vistaar_bandhu_new_version/providers/auth_provider.dart';
import 'package:vistaar_bandhu_new_version/screens/payEmi/emi_option_screen.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:vistaar_bandhu_new_version/util/empty_message.dart';

import '../../environment.dart';
import '../../multilanguage.dart';
import '../home_screen.dart';

class PayEMIScreen extends BasePage {
  static const routeName = '/PayEMIScreen';

  @override
  _LoanListScreenState createState() => _LoanListScreenState();
}

class _LoanListScreenState extends BaseState<PayEMIScreen> {
  List<String> listLoans = [];
  int? selectedIndex;
  LoanModel? _loanModel;
  bool isLoanClosed = false;
  List<String> filteredLoans = [];
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    listLoans = Get.arguments;
  }

  Future getLoanList() async {
    showLoadingDialog(
        context: context,
        hint: MultiLanguage.of(context)!.translate("fetching_loans"));
    if (pref.userMobile == "8860088996") {
      Navigator.of(context).pop();
    }
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

          for (var lanNo in listLoans) {
            await checkLoanClosed(lanNo).then((isClosed) {});
          }
          listLoans = filteredLoans;
          print(filteredLoans);
          //hide loading dialog
          Navigator.pop(context);
        }
        setState(() {});
      }
    }, onError: (error) {
      Navigator.of(context).pop();
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
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                MultiLanguage.of(context)!
                    .translate("make_emi_payment"), //"Make EMI Payment",
                style: const TextStyle(color: goldColor),
                overflow: TextOverflow.fade,
              ),
            ),
            const SizedBox(
              width: 40,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: listLoans.isEmpty
            ? EmptyMessage("No Loans")
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
                          MultiLanguage.of(context)!.translate("pay_emi"), //  "PAY EMI",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () async {
                          if (selectedIndex == null) {
                            showErrorToast(MultiLanguage.of(context)!.translate(
                                "please_select_lan_account")); //"Please select a LAN(Loan Account Number)");
                          } else {
                            getLoanDetails(listLoans[selectedIndex!]);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
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

  Future getLoanDetails(String? applicationNumber) async {
    showLoadingDialog(
        context: context,
        hint: MultiLanguage.of(context)!
            .translate("fetching_emi_details") //"Fetching EMI Details"
        );

    await Provider.of<AuthProvider>(context, listen: false)
        .getLoanDetail(applicationNumber ?? "")
        .then((value) {
      //hide loading dialog
      Navigator.pop(context);
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
          isLoanClosed = false;
        }

        if (isLoanClosed) {
          showErrorToast('This Lan is Closed');
        } else if (_loanModel != null) {
          onPayClick(_loanModel!);
        } else {
          showErrorToast('Something went wrong. Please try later');
        }
      }
      setState(() {});
    });
  }

  onPayClick(LoanModel loanModel) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          return EMIOptionScreen(loanModel: loanModel);
        });
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
