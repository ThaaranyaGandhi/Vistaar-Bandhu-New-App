

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vistaar_bandhu_new_version/models/loan_model_payment_list.dart';
import 'package:vistaar_bandhu_new_version/providers/loan_provider.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

import '../../multilanguage.dart';

class LoanPaymentListScreen extends StatefulWidget {
  const LoanPaymentListScreen({Key? key}) : super(key: key);

  static const String routeName = '/Payment-List-Screen';

  @override
  State<LoanPaymentListScreen> createState() => _LoanPaymentListScreenState();
}

class _LoanPaymentListScreenState extends State<LoanPaymentListScreen> {
  String? applicationNumber;
  LoanPaymentListModel? _loanPaymentListModel;
  @override
  void initState() {
    super.initState();

    final data = Get.arguments;
    if (data is Map<String, dynamic>) {
      setState(() {
        applicationNumber = data["applicationNumber"];
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLoanPaymentList();
  }

  Future getLoanPaymentList() async {
    Map<String, String> body = {"Lan": applicationNumber!};
    await Provider.of<LoanProvider>(context, listen: false)
        .getLoanPaymentList(body)
        .then((value) {
          if(value != null){
            var paymentList = value.d;
            if(paymentList!.isNotEmpty){
              setState(() {
                _loanPaymentListModel = value;
              });
            }else{
              showSuccessToast('You do not have payments details');
            }
          }else{
            showSuccessToast('You do not have payments details');
          }

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
            Text(
              MultiLanguage.of(context)!.translate("payments"),
              style: const TextStyle(color: goldColor),
            ),
            const SizedBox(
              width: 60,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body:
          // ? showLoadingDialog(hint: "Fetching Payment List")
          DefaultTabController(
        length: 2,
        child: SingleChildScrollView(
          child: SafeArea(
            child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10),
                scrollDirection: Axis.vertical,
                itemCount: _loanPaymentListModel != null
                    ? _loanPaymentListModel!.d!.length
                    : 1,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: _loanPaymentListModel == null
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: const Center(child: CircularProgressIndicator()))
                          : Table(
                              columnWidths: {0: const FractionColumnWidth(.4)},
                              border:
                                  TableBorder.all(color: Colors.transparent),
                              children: [
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      "${MultiLanguage.of(context)!.translate("amount")} : ",
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                      _loanPaymentListModel == null
                                          ? ""
                                          : getCurrencyFormat(_loanPaymentListModel!.d![index].amount!.toDouble()),
                                      style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ]),
                                // TableRow(children: [
                                //   Padding(
                                //     padding:
                                //         const EdgeInsets.only(top: 10, bottom: 10),
                                //     child: Text(
                                //       "LAN : ",
                                //       style: TextStyle(color: Colors.grey),
                                //     ),
                                //   ),
                                //   Padding(
                                //     padding:
                                //         const EdgeInsets.only(top: 10, bottom: 10),
                                //     child: Text(
                                //       _loanPaymentListModel == null
                                //           ? ""
                                //           : "${_loanPaymentListModel!.d![index].lan}",
                                //       style: TextStyle(
                                //           color: primaryColor,
                                //           fontSize: 18,
                                //           fontWeight: FontWeight.w700),
                                //     ),
                                //   ),
                                // ]),

                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      "${MultiLanguage.of(context)!.translate("paid_on")}: ",
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      _loanPaymentListModel == null
                                          ? ""
                                          : getDateTime(_loanPaymentListModel!
                                              .d![index].paidOndate
                                              .toString()),
                                      style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      "${MultiLanguage.of(context)!.translate("payment_mode")} : ",
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      _loanPaymentListModel == null
                                          ? ""
                                          : "${_loanPaymentListModel!.d![index].paymentMode}",
                                      style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  String getDateTime(String dateString) {
    // Extract timestamp and time zone offset from string
    int timestamp = int.parse(dateString.substring(6, 19));
    int hoursOffset = int.parse(dateString.substring(19, 22));
    int minutesOffset = int.parse(dateString.substring(22, 24));

    // Create DateTime object with timestamp and offset
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true)
        .add(Duration(hours: hoursOffset, minutes: minutesOffset));

    // Format the DateTime object using DateFormat
    String formattedDate = DateFormat('MMM dd, yyyy').format(date);
    return formattedDate;
  }

  String getCurrencyFormat(double amount) {
    NumberFormat format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    String formattedAmount = format.format(amount);
    return formattedAmount;
  }
}
