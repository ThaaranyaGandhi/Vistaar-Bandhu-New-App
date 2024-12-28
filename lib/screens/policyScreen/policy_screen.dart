import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/providers/loan_provider.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:vistaar_bandhu_new_version/util/empty_message.dart';

import '../home_screen.dart';
import 'insurance_policy_document_screen.dart';

class InsurancePolicyScreen extends BasePage {
  static const routeName = '/InsurancePolicyScreen';

  InsurancePolicyScreenState createState() => InsurancePolicyScreenState();
}

class InsurancePolicyScreenState extends BaseState<InsurancePolicyScreen> {
  List<String> listLoans = [];
  int tabIndex = 0;
  String? _lss = "";
  List<String> insuranceDoc = [];

  bool selected = false;

  @override
  void initState() {
    super.initState();
    insuranceDoc = Get.arguments;
  }

  getInsuranceDoc(String? insuranceDoc, String? bank) async {
    var param = {
      'Lan': insuranceDoc,
      'DocType': bank,
      'Token': '0xH0xH01U01S0x01N',
    };
    showLoadingDialog(
        context: context,
        hint: MultiLanguage.of(context)!.translate("fetching_documents"));
    await Provider.of<LoanProvider>(context, listen: false)
        .getPolicyInsurance(param)
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
    MultiLanguage multilanguage = MultiLanguage.of(context)!;

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
            Column(
              children: [
                Text(
                  multilanguage.translate("insurance"),
                  style: const TextStyle(color: goldColor),
                ),
                Text(
                  multilanguage.translate("policy"),
                  style: const TextStyle(color: goldColor),
                ),
              ],
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
              child: insuranceDoc.isEmpty
                  ? EmptyMessage("No Documents Available")
                  : ListView.builder(
                      itemBuilder: (ctx, index) {
                        return Card(
                          margin: const EdgeInsets.all(10.0),
                          child: InkWell(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(15.0),
                              height: selected ? 120 : 50,
                              curve: Curves.easeInOut,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          insuranceDoc[index],
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),

                                        //TODO : to be implemented
                                        // if (selected)
                                        //   Padding(
                                        //     padding: const EdgeInsets.only(
                                        //         top: 10.0),
                                        //     child: Row(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.center,
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.spaceAround,
                                        //       children: [
                                        //         ElevatedButton(
                                        //           onPressed: () async {
                                        //             await getInsuranceDoc(
                                        //                 insuranceDoc[index],
                                        //                 "Kotak");
                                        //             print("_lss = $_lss");
                                        //             Get.toNamed(
                                        //                 InsurancePolicyDocumentScreen
                                        //                     .routeName,
                                        //                 arguments: {
                                        //                   "documentName": _lss,
                                        //                   "bank": "Kotak",
                                        //                 });
                                        //           },
                                        //           style:
                                        //               ElevatedButton.styleFrom(
                                        //             minimumSize: Size(150, 40),
                                        //             primary: Color.fromARGB(
                                        //                 244, 255, 233, 233),
                                        //           ),
                                        //           child: Text(
                                        //             "kotak",
                                        //             style: TextStyle(
                                        //               color: Colors.red,
                                        //               fontSize: 20,
                                        //               fontWeight:
                                        //                   FontWeight.bold,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //         ElevatedButton(
                                        //           onPressed: () {},
                                        //           style:
                                        //               ElevatedButton.styleFrom(
                                        //             minimumSize: Size(150, 40),
                                        //             primary: Color.fromARGB(
                                        //                 255, 221, 221, 241),
                                        //           ),
                                        //           child: Text(
                                        //             "ICICI",
                                        //             style: TextStyle(
                                        //               color: Color.fromARGB(
                                        //                   255, 0, 59, 107),
                                        //               fontSize: 20,
                                        //               fontWeight:
                                        //                   FontWeight.bold,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async {
                              await getInsuranceDoc(
                                  insuranceDoc[index], "Kotak");
                              print("_lss = $_lss");
                              Get.toNamed(
                                  InsurancePolicyDocumentScreen.routeName,
                                  arguments: {
                                    "documentName": _lss,
                                    "bank": "Kotak",
                                    "lan": insuranceDoc[index],
                                  });
                              // setState(() {
                              //   selected = !selected;
                              // });
                            },
                          ),
                        );
                      },
                      itemCount: insuranceDoc.length,
                    )),
          // Expanded(
          //     flex: 2,
          //     child: Container(
          //       child: Center(
          //           child: ElevatedButton(
          //               child:
          //                   Text("Disclaimer", style: TextStyle(fontSize: 16)),
          //               onPressed: () {
          //                 showDialog(
          //                     context: context,
          //                     builder: (_) => new AlertDialog(
          //                         shape: RoundedRectangleBorder(
          //                             borderRadius: BorderRadius.all(
          //                                 Radius.circular(10.0))),
          //                         content: Builder(
          //                           builder: (context) {
          //                             // Get available height and width of the build area of this widget. Make a choice depending on the size.
          //                             var height =
          //                                 MediaQuery.of(context).size.height;
          //                             var width =
          //                                 MediaQuery.of(context).size.width;

          //                             return Container(
          //                                 height: height - 300,
          //                                 width: width - 200,
          //                                 child: Column(
          //                                   children: [
          //                                     SizedBox(
          //                                       height: 10,
          //                                     ),
          //                                     Text(
          //                                         "1.Vistaar is not liable for any damages, losses (direct or indirect) whatsoever, due to disruption or non availability of any of services/facilities due to technical fault/error or any failure in the telecommunication network or any error in any software or hardware systems which is beyond the control of Vistaar."),
          //                                     SizedBox(
          //                                       height: 10,
          //                                     ),
          //                                     Text(
          //                                         "2.Vistaar is not liable for any consequences arising out of non-compliance of our instructions due to inadequacy of knowledge or not following the instructions."),
          //                                     SizedBox(
          //                                       height: 10,
          //                                     ),
          //                                     Text(
          //                                         "3.In case of any error in downloading and uploading the forms, please contact the nearest branch or email at contactus@vistaarfinance.com"),
          //                                   ],
          //                                 ));
          //                           },
          //                         )));
          //               })),
          //     ))
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
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            const BottomNavigationBarItem(icon: Icon(Icons.call), label: "Call Us"),
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
