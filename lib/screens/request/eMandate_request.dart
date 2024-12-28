import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/models/enach_detail_model.dart';
import 'package:vistaar_bandhu_new_version/models/enach_status_model.dart';
import 'package:vistaar_bandhu_new_version/models/loan_model.dart';
import 'package:vistaar_bandhu_new_version/providers/auth_provider.dart';
import 'package:vistaar_bandhu_new_version/providers/enach_provider.dart';
import 'package:vistaar_bandhu_new_version/screens/request/emandate_details_screen_customer_id.dart';
import 'package:vistaar_bandhu_new_version/screens/request/payment_option.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:vistaar_bandhu_new_version/util/empty_message.dart';

import '../../environment.dart';
import '../../multilanguage.dart';
import '../home_screen.dart';

class EmandateScreen extends BasePage {
  static const routeName = '/EmandateScreen';

  @override
  _EmandateScreenState createState() => _EmandateScreenState();
}

class _EmandateScreenState extends BaseState<EmandateScreen> {
  List<String> listLoans = [];
  List<String> filteredLoans = [];
  int tabIndex = 0;
  String? applicationNumber;
  D? enachDetailsModel;
  EnachStatus? enachStatus;

  // LoanModel? _loanModel;
  // bool isLoanClosed = false;
  @override
  void initState() {
    super.initState();
    listLoans = Get.arguments;
  }

  Future getEnachStatus({required String loanNo}) async {
    showLoadingDialog(
        context: context,
        hint: "${MultiLanguage.of(context)!.translate("loading")}...");
    var param = {
      'Lan': applicationNumber,
      'Token': API_TOKEN,
      'Env': Environment().config?.envParam
    };
    await Provider.of<EnachProvider>(context, listen: false)
        .getEnachStatus(param)
        .then((value) {
      if (value != null) {
        if (value.d != null) {
          enachStatus = value.d;
          if (enachStatus?.rPTransStatus == "success") {
            Get.offNamed(EmandateDetails.routeName, arguments: loanNo);
          } else {
            //  Navigator.of(context).pop();
            getEnachDetail(loanNo: loanNo);
          }
          setState(() {});
        } else {
          showSuccessToast("Please add bank details");
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          setState(() {});
        }
      } else {
        showSuccessToast('Please add bank details');
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        setState(() {});
      }

      //  Navigator.of(context).pop();
    }, onError: (error) {
      Navigator.of(context).pop();
    });
  }

  Future getEnachDetail({required String loanNo}) async {
    showLoadingDialog(
        context: context,
        hint: "${MultiLanguage.of(context)!.translate("loading")}...");
    var param = {
      'Lan': applicationNumber,
      'Token': API_TOKEN,
      'Env': Environment().config?.envParam
    };
    await Provider.of<EnachProvider>(context, listen: false)
        .getEnachDetails(param)
        .then((value) {
      if (value != null) {
        if (value.d != null) {
          enachDetailsModel = value.d;
          if (int.parse(enachDetailsModel!.maxEmi!) >= 15000) {
            Navigator.of(context).pop();
            Get.offNamed(EmandateDetails.routeName, arguments: loanNo);
          } else {
            Navigator.of(context).pop();
            Get.offNamed(PaymentOptionalScreen.routeName, arguments: loanNo);
          }
          setState(() {});
        } else {
          showSuccessToast(
              "Please add bank detail");
          Navigator.of(context).pop();
          Navigator.of(context).pop();

          setState(() {});
        }
      } else {
        showSuccessToast(
            "Please add bank details");
        Navigator.of(context).pop();
        Navigator.of(context).pop();

        setState(() {});
      }
    }, onError: (error) {
      setState(() {});
      Navigator.of(context).pop();
    });
    // log('log pvl: ${enachDetailsModel?.ifscCode}');
  }

  /*Future getLoanDetails({required String loanNo}) async {
    showLoadingDialog(
        context: context,
        hint:
        "${MultiLanguage.of(context)!.translate("fetching_loan_details")}");
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
            if (int.parse(_loanModel!.loIEmi!) >= 15000) {
              log('EMI is greater than 15K');
              Get.toNamed(EmandateDetails.routeName,
                  arguments: loanNo);
            } else {
              log('EMI is lesser than 15K');
              Get.toNamed(PaymentOptionalScreen.routeName,
                  arguments: loanNo);
            }
          }
          if (_loanModel != null && _loanModel!.loDtClosedt != "") {
            isLoanClosed = true;
          } else {
            isLoanClosed = false;
          }
        } else {
          isLoanClosed = false;
        }
        setState(() {});
      }
    });
  }*/

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
          appLogger(Environment().config?.envParam, filteredLoans.toString());
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
                MultiLanguage.of(context)!.translate("e_nach_activation"),
                style:  const TextStyle(color: goldColor),
                overflow: TextOverflow.fade,
              ),
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
                      onTap: () {
                        setState(() {
                          applicationNumber = listLoans[index];
                          getEnachStatus(loanNo: listLoans[index]);
                          //    getEnachDetail(loanNo :listLoans[index] );
                        });

                        //  getLoanDetails(loanNo :listLoans[index] );
                        /* Get.toNamed(EmandateDetails.routeName,
                            arguments: listLoans[index]);*/
                      },
                    ),
                  );
                },
                itemCount: listLoans.length,
              ),
      ),
      bottomNavigationBar:  BottomNavigationBar(
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              this.tabIndex = index;
            });
            _navigateToScreens();
          },
          type: BottomNavigationBarType.fixed,
          items:const [
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.location_pin), label: "Locate Us"),
             BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
             BottomNavigationBarItem(icon: Icon(Icons.call), label: "Call Us"),
          ]),
    );
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
