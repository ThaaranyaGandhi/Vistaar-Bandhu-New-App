import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:vistaar_bandhu_new_version/models/loan_future_installment_list_model.dart';

import 'package:vistaar_bandhu_new_version/providers/loan_provider.dart';

import 'package:vistaar_bandhu_new_version/util/colors.dart';

import '../../multilanguage.dart';
import '../../util/app_message.dart';

class LoanFutureInstallmentListScreen extends StatefulWidget {
  const LoanFutureInstallmentListScreen({Key? key}) : super(key: key);

  static const String routeName = '/Future-Installment-List-Screen';

  @override
  State<LoanFutureInstallmentListScreen> createState() =>
      _LoanFutureInstallmentListScreenState();
}

class _LoanFutureInstallmentListScreenState
    extends State<LoanFutureInstallmentListScreen> {
  String? applicationNumber;
  FutureInstallmentModel? _futureInstallmentModel;

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
        .getFuturePaymentList(body)
        .then((value) {
      if(value != null){
        var paymentList = value.d;
        if(paymentList!.isNotEmpty){
          setState(() {
            _futureInstallmentModel = value;
          });
        }else{
          showSuccessToast('You do not have future installment details');
        }
      }else{
        showSuccessToast('You do not have future installment details');
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
            Expanded(
              child: Text(
                MultiLanguage.of(context)!.translate("future_installments"),
                style: const TextStyle(color: goldColor),
                overflow: TextOverflow.ellipsis,
              ),
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
                itemCount: _futureInstallmentModel != null
                    ? _futureInstallmentModel!.d!.length
                    : 1,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: _futureInstallmentModel == null
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: const Center(
                                  child: CircularProgressIndicator()))
                          : Table(
                              columnWidths: {0: FractionColumnWidth(.4)},
                              border:
                                  TableBorder.all(color: Colors.transparent),
                              children: [
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      "${MultiLanguage.of(context)!.translate("due_amount")} : ",
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      _futureInstallmentModel!.d == []
                                          ? ""
                                          : "${getCurrencyFormat(_futureInstallmentModel!.d![index].eMIAmount!.toDouble())}",
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
                                      "${MultiLanguage.of(context)!.translate("due_date")}: ",
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      _futureInstallmentModel == null
                                          ? ""
                                          : getDateTime(_futureInstallmentModel!
                                              .d![index].installmentdate
                                              .toString()),
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
