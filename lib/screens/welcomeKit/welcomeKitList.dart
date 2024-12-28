import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/providers/loan_provider.dart';
import 'package:vistaar_bandhu_new_version/screens/welcomeKit/welcomeKitScreen.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:vistaar_bandhu_new_version/util/empty_message.dart';


import '../../environment.dart';
import '../../multilanguage.dart';
import '../home_screen.dart';

class WelcomeKitList extends BasePage {
  static const routeName = '/WelcomeKitList';

  WelcomeKitListState createState() => WelcomeKitListState();
}

class WelcomeKitListState extends BaseState<WelcomeKitList> {
  List<String> listLoans = [];
  int tabIndex = 0;
  String? _lss = "";
  List<String> welcomeKits = [];

  @override
  void initState() {
    super.initState();
    // listLoans = Get.arguments;

    welcomeKits = Get.arguments;

    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      getWelcomeKit(welcomeKits);
    });
  }

  getWelcomeKit(List<String>? welcomeKit) async {
    var param = {
      'Lan': welcomeKit,
      'Token': '0xH0xH01U01S0x01N',
      'Env': Environment().config?.envParam
    };
    showLoadingDialog(
        context: context,
        hint: MultiLanguage.of(context)!.translate("fetching_loans"));
    await Provider.of<LoanProvider>(context, listen: false)
        .getWelcomeKit(param)
        .then((value) {
      if (value != null && value.d != "NOT FOUND") {
        _lss = value.d;
        List<String> kits = _lss!.split(',').toList();
        listLoans = kits;
      }
      setState(() {});

      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("listloans => ${listLoans.length}");
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
              MultiLanguage.of(context)!.translate("welcome_kit"),
              style: const TextStyle(color: goldColor),
            ),
            const SizedBox(
              width: 60,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: <Widget>[
          Expanded(
              flex: 35,
              child: (listLoans.isEmpty || listLoans[0] == "")
                  ? EmptyMessage("No Welcome Kits")
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
                              Get.toNamed(WelcomeKitScreen.routeName,
                                  arguments: {
                                    "loanNumber": listLoans[index],
                                    "index": index
                                  });
                            },
                          ),
                        );
                      },
                      itemCount: listLoans.length,
                    )),
          Expanded(
              flex: 2,
              child: Container(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ElevatedButton(
                      child: Text(
                          MultiLanguage.of(context)!.translate("disclaimer"),
                          style: const TextStyle(fontSize: 16)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            content: Builder(
                              builder: (context) {
                                // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                var height = MediaQuery.of(context).size.height;
                                var width = MediaQuery.of(context).size.width;

                                return SingleChildScrollView(
                                  child: Container(
                                      // height: height - 300,
                                      width: width - 100,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "1. ${MultiLanguage.of(context)!.translate("vistaar_not_liable_1")}"),
                                          // "1.Vistaar is not liable for any damages, losses (direct or indirect) whatsoever, due to disruption or non availability of any of services/facilities due to technical fault/error or any failure in the telecommunication network or any error in any software or hardware systems which is beyond the control of Vistaar."),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "2. ${MultiLanguage.of(context)!.translate("vistaar_not_liable_2")}"),
                                          // "2.Vistaar is not liable for any consequences arising out of non-compliance of our instructions due to inadequacy of knowledge or not following the instructions."),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "3. ${MultiLanguage.of(context)!.translate("vistaar_not_liable_1")}"),
                                          // "3.In case of any error in downloading and uploading the forms, please contact the nearest branch or email at contactus@vistaarfinance.com"),
                                        ],
                                      )),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                )),
              ))
        ]),
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
                label: MultiLanguage.of(context)!.translate("home")),
            BottomNavigationBarItem(
                icon: const Icon(Icons.call),
                label: MultiLanguage.of(context)!.translate("call_us")),
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
