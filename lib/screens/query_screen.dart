import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

import '../multilanguage.dart';
import 'home_screen.dart';

// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
class QueryScreen extends BasePage {
  static const routeName = '/QueryScreen';

  @override
  _QueryScreenState createState() => _QueryScreenState();
}

class _QueryScreenState extends BaseState<QueryScreen> {
  final _queryFormKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _queryTextController = TextEditingController();

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
            SizedBox(
              width: 10,
            ),
            Text(
              MultiLanguage.of(context)!
                  .translate("queries_complaints"), //"Queries/Complaints",
              style: TextStyle(color: goldColor, fontSize: 18),
            ),
            SizedBox(
              width: 40,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            hideKeyboard();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  MultiLanguage.of(context)!.translate(
                      "type_message_below"), //"For Queries and Escalations, Type a message below and send",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: primaryColor, fontSize: 16),
                ),
              ),
              Form(
                key: _queryFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    TextField(
                      controller: _nameTextController,
                      decoration: InputDecoration(
                          hintText: MultiLanguage.of(context)!.translate(
                              "enter_your_name")), // "Enter your name"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _queryTextController,
                      decoration: InputDecoration(
                          hintText: MultiLanguage.of(context)!.translate(
                              "enter_the_query")), // "Please enter the query"),
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                    ),
                  ]),
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 55,
                  child: CupertinoButton(
                    color: primaryColor,
                    child: Text(
                      MultiLanguage.of(context)!.translate('send'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () async {
                      onClickSend();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onClickSend() async {
    if (_nameTextController.text.trim() == "") {
      showErrorToast(
          MultiLanguage.of(context)!.translate("please_enter_your_name"));
    } else if (_queryTextController.text.trim() == "") {
      showErrorToast(
          MultiLanguage.of(context)!.translate("please_enter_your_query"));
    } else {
      // String? encodeQueryParameters(Map<String, String> params) {
      //   return params.entries
      //       .map((e) =>
      //           '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      //       .join('&');
      // }
      //
      // final Uri emailLaunchUri = Uri(
      //   scheme: 'mailto',
      //   path: 'contactus@vistaarfinance.com',
      //   query: encodeQueryParameters(<String, String>{
      //     'subject': 'Query/Complaint',
      //     'body':
      //         'From : ${_nameTextController.text.trim()} \n Phone Number : ${pref.userMobile} '
      //             '\n Query/Complaint : ${_queryTextController.text.trim()}'
      //   }),
      // );
      // await canLaunch(emailLaunchUri.toString()).then((can) {
      //   if (can) {
      //     launch(emailLaunchUri.toString());
      //   } else {
      //     showErrorToast("Oops, something went wrong.");
      //   }
      // });
      sendMail();
      showSuccessToast(MultiLanguage.of(context)!.translate("query_recieved"));
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => HomeScreen(),
        ),
        (route) => false, //if you want to disable back feature set to false
      );
    }
  }

  void sendMail() async {
    String username = 'reminder@vistaarfinance.com';
    String password = 'Hari123@';
    final smtpServer = gmail(username, password);
    final equivalentMessage = Message()
      ..from = Address(username, "reminder@vistaarfinance.com")
      ..recipients.add(Address('contactus@vistaarfinance.com'))
      ..subject = 'Query/Complaint ${DateTime.now()}'
      ..text =
          'From : ${_nameTextController.text.trim()} \n Phone Number : ${pref.userMobile} '
              '\n Query/Complaint : ${_queryTextController.text.trim()}';

    await send(equivalentMessage, smtpServer);
  }
}
