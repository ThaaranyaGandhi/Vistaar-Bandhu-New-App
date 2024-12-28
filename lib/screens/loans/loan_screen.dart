import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/models/loan_model.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/providers/auth_provider.dart';
import 'package:vistaar_bandhu_new_version/screens/loans/loan_details_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/loans/loan_status_screen.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:vistaar_bandhu_new_version/util/empty_message.dart';

import '../../environment.dart';
import '../home_screen.dart';

class LoanListScreen extends BasePage {
  static const routeName = '/LoanListScreen';
  List<String> loanList = [];

  LoanListScreen({required this.loanList});

  @override
  _LoanListScreenState createState() => _LoanListScreenState();
}

class _LoanListScreenState extends BaseState<LoanListScreen> {
  List<String> listLoans = [];

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    listLoans = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    var multilanguage = MultiLanguage.of(context)!;
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
            Text(
              multilanguage.translate("loans"), //"Loans",
              style: const TextStyle(color: goldColor),
            ),
            const SizedBox(
              width: 60,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: listLoans.isEmpty
            ? EmptyMessage("No Loans")
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: const EdgeInsets.all(10.0),
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        height: 50,
                        child: Row(
                          children: [
                            // Expanded(
                            //   child: Text(
                            //     "Loan Account Number",
                            //     textAlign: TextAlign.start,
                            //   ),
                            // ),
                            Expanded(
                              child: Text(
                                listLoans[index],
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => getLoanDetails(listLoans[index]),
                    ),
                  );
                },
                itemCount: listLoans.length,
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

  Future getLoanDetails(String applicationNumber) async {
    bool isLoanClosed = false;
    LoanModel? _loanModel;
    showLoadingDialog(
        context: context,
        hint: MultiLanguage.of(context)!
            .translate("fetching_loan_details") //"Fetching Loan Details"
        );
    await Provider.of<AuthProvider>(context, listen: false)
        .getLoanDetail(applicationNumber)
        .then((value) {
//hide loading dialog
      Navigator.of(context).pop();
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
          // Get.to(LoanTwoPageTest(), arguments: {
          //   "isLoanClosed": isLoanClosed,
          //   "loanModel": _loanModel,
          //   "applicationNumber": applicationNumber
          // });
          Get.toNamed(LoanDetailScreen.routeName, arguments: {
            "isLoanClosed": isLoanClosed,
            "loanModel": _loanModel,
            "applicationNumber": applicationNumber
          });
        } else {
          Get.toNamed(LoanStatusScreen.routeName, arguments: applicationNumber);
        }

        setState(() {});
      }
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
