import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/providers/auth_provider.dart';
import 'package:vistaar_bandhu_new_version/screens/contacts_screen.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

import '../environment.dart';

class ReferScreen extends BasePage {
  static const routeName = '/ReferScreen';

  @override
  _ReferScreenState createState() => _ReferScreenState();
}

class _ReferScreenState extends BaseState<ReferScreen> {
  final _referFormKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _mobileTextController = TextEditingController();
  List<String> listLoans = [];

  @override
  void initState() {
    super.initState();
    listLoans = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    MultiLanguage multiLanguage = MultiLanguage.of(context)!;
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
            Expanded(
              child: Text(
                multiLanguage.translate("refer_a_friend"),
                style: TextStyle(color: goldColor, fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 50,
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
                  multiLanguage.translate(
                      "fun_sharing_something_new"), // "It's fun sharing something new to your Friends. Help us with their numbers, we will talk to them.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: primaryColor, fontSize: 16),
                ),
              ),
              Form(
                key: _referFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    TextField(
                      controller: _nameTextController,
                      decoration: InputDecoration(
                          hintText: multiLanguage.translate("name")), //name
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _mobileTextController,
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: multiLanguage
                            .translate("mobile_number"), //"Mobile number",
                        suffixIcon: InkWell(
                          child: Icon(Icons.contacts),
                          onTap: () async {
                            final selectedContact =
                                await Get.toNamed(ContactsScreen.routeName);
                            if (selectedContact != null) {
                              setState(() {
                                _nameTextController.text =
                                    selectedContact["name"];
                                _mobileTextController.text =
                                    selectedContact["phone"];
                                _mobileTextController.text =
                                    _mobileTextController.text
                                        .replaceAll(" ", "");
                              });
                            }
                          },
                        ),
                      ),
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
                      multiLanguage.translate("refer"), // 'Refer',
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
      showErrorToast("Please enter the name of the Person");
    } else if (_mobileTextController.text.trim() == "") {
      showErrorToast("Please enter the 10 digit mobile number of the Person");
    } else if (_mobileTextController.text.trim().length == 10 ||
        _mobileTextController.text.trim().length == 11 ||
        _mobileTextController.text.trim().length == 12) {
      Map<String, dynamic> params = Map();
      params["FriendMobile"] = _mobileTextController.text.trim();
      params["FriendName"] = _nameTextController.text.trim();
      params["CreatedBy"] = pref.userMobile;
      params["CustName"] = pref.userName;
      params["Lan"] = "${listLoans[0]}";
      params["Token"] = API_TOKEN;
      params["Env"] = Environment().config?.envParam;

      showLoadingDialog(context: context, hint: "Sending Invite....");
      await Provider.of<AuthProvider>(context, listen: false)
          .referFriends(params)
          .then((value) {
        //hide loading dialog
        Navigator.pop(context);
        showSuccessToast(
            MultiLanguage.of(context)!.translate("thanks_for_refering"));
        Get.back();
      }, onError: (error) {
        //hide loading dialog
        Navigator.pop(context);
      });
    } else {
      showErrorToast("Please enter the 10 digit mobile number of the Person");
    }
  }
}
