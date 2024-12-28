import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/screens/request/emandate_details_screen_customer_id.dart';
import 'package:vistaar_bandhu_new_version/screens/request/upi_payment_details.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import '../../multilanguage.dart';

class PaymentOptionalScreen extends BasePage {
  static const routeName = '/PaymentOptionalScreen';

  @override
  _PaymentOptionalScreenState createState() => _PaymentOptionalScreenState();
}

class _PaymentOptionalScreenState extends BaseState<PaymentOptionalScreen> {
  int? selectedIndex;
  String? loanNumber;

  @override
  void initState() {
    super.initState();
    loanNumber = Get.arguments;
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
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(10.0),
              child: InkWell(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      selectedIndex != null && selectedIndex == 0
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
                          MultiLanguage.of(context)!
                              .translate("e-mandate_debit_net_aadhar"),
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  selectedIndex = 0;
                  setState(() {});
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.all(10.0),
              child: InkWell(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      selectedIndex != null && selectedIndex == 1
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
                          MultiLanguage.of(context)!.translate("upi_mandate"),
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  selectedIndex = 1;
                  setState(() {});
                },
              ),
            ),
            const Spacer(),

            /*       Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        return Card(
                          margin: EdgeInsets.all(10.0),
                          child: InkWell(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              height: 50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  selectedIndex != null &&
                                          selectedIndex == index
                                      ? Icon(
                                          Icons.radio_button_checked,
                                          color: primaryColor,
                                        )
                                      : Icon(
                                          Icons.radio_button_off,
                                          color: primaryColor,
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      paymentType[index],
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
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
                      itemCount: paymentType.length,
                    ),
                  ),*/
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.maxFinite,
                height: 55,
                child: CupertinoButton(
                  color: primaryColor,
                  child: Text(
                    MultiLanguage.of(context)!.translate("pay_emi"),
                    //  "PAY EMI",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () async {
                    if (selectedIndex == null) {
                      showErrorToast(MultiLanguage.of(context)!.translate(
                          "please_select_payment_mode")); //"Please select a LAN(Loan Account Number)");
                    } else {
                      if (selectedIndex == 0) {
                        Get.toNamed(EmandateDetails.routeName,
                            arguments: loanNumber);
                      } else {
                        Get.toNamed(UPIDetails.routeName,
                            arguments: loanNumber);
                      }
                      //   getLoanDetails(listLoans[selectedIndex!]);
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
}
