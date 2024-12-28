import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vistaar_bandhu_new_version/models/loan_agreement_model.dart';
import 'package:vistaar_bandhu_new_version/screens/loans/loan_agreement_pdfView_screen.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/empty_message.dart';

import '../../util/colors.dart';

class LoanAgreementScreen extends StatefulWidget {
  LoanAgreementScreen({Key? key}) : super(key: key);

  // static const String routeName = "/LoanAgreementScreen";

  @override
  State<LoanAgreementScreen> createState() => _LoanAgreementScreenState();
}

class _LoanAgreementScreenState extends State<LoanAgreementScreen> {
  final listLoans = Get.arguments;

  LoanAgreementDetailModel? loanAgreementModel;
  LoanAgreementDetailModel? loanAgreementDetailModel;
  String? authToken;

  @override
  void initState() {
    super.initState();
    // getDocumentToken();main
  }

  // getDocumentToken() async {
  //   await Provider.of<LoanProvider>(context, listen: false)
  //       .getLoanAgreementAuthenticationToken()
  //       .then((value) {
  //     if (value != null) {
  //       setState(() {
  //         loanAgreementModel = value;
  //       });
  //     }
  //   });
  // }

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
            const Text(
              "Loan Agreement ",
              style: TextStyle(color: goldColor),
            ),
            const SizedBox(
              width: 60,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: (loanAgreementModel == null || listLoans.isEmpty)
          ? EmptyMessage("No Document found")
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
                          onTap: () async {
                            showLoadingDialog(
                                context: context,
                                hint: "Fetching your agreement");

                            // loanAgreementDetailModel =
                            //     await Provider.of<LoanProvider>(context,
                            //             listen: false)
                            //         .getLoanAgreementDetails(
                            //             token: loanAgreementModel!
                            //                 .authData![0].authToken);
                            Navigator.pop(context);
                            Get.toNamed(LoanAgreementPdfViewScreen.routeName,
                                arguments: loanAgreementDetailModel!
                                    .docDetails![0].imagedata![0].imgb64);
                          },
                        ),
                      );
                    },
                    itemCount: listLoans.length,
                  ),
                ),
              ],
            ),
    );
  }
}
