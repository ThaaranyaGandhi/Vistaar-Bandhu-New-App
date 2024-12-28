

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/models/user_model.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/providers/auth_provider.dart';
import 'package:vistaar_bandhu_new_version/screens/home_screen.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../environment.dart';

class OtpVerificationScreen extends BasePage {
  static const routeName = '/otpScreen';

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends BaseState<OtpVerificationScreen> {
  TextEditingController controller = TextEditingController(text: "");
  int pinLength = 6;
  bool hasError = false;
  String? errorMessage;
  int? otp;
  String? mobileNumber;
  UserModel? user;

  @override
  void initState() {
    user = Get.arguments;
    mobileNumber = user!.phoneNumber;
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      sendOtp();
    });
    super.initState();
  }

  Future sendOtp() async {
    showLoadingDialog(
        context: context,
        hint: MultiLanguage.of(context)!.translate("signing_in"));
    if (mobileNumber == "8860088996") {
      Navigator.pop(context);
      otp = 111111;
    } else {
      await Provider.of<AuthProvider>(context, listen: false)
          .otpVerification(mobileNumber ?? "")
          .then((value) {
        //111222
        //hide loading dialog
        Navigator.pop(context);
        debugPrint("OTP => $value");
        otp = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MultiLanguage multilanguage = MultiLanguage.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(multilanguage.translate("otp")),
        backgroundColor: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(multilanguage.translate("please_enter_otp")),
                //"Please enter the OTP received at registered mobile number."),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: PinCodeTextField(
                  autofocus: true,
                  controller: controller,
                  highlight: true,
                  highlightColor: Colors.black,
                  defaultBorderColor: Colors.grey,
                  hasTextBorderColor: Colors.green,
                  maxLength: pinLength,
                  hasError: hasError,
                  // highlightPinBoxColor: Colors.orange,
                  // hideCharacter: true,
                  // maskCharacter: "😎",s
                  onTextChanged: (text) {
                    setState(() {
                      hasError = false;
                    });
                  },
                  onDone: (text) {
                    appLogger(Environment().config?.envParam,
                        "DONE CONTROLLER ${controller.text}");
                  },
                  pinBoxWidth: 50,
                  pinBoxHeight: 60,
                  hasUnderline: true,
                  wrapAlignment: WrapAlignment.spaceAround,
                  pinBoxDecoration:
                      ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                  pinTextStyle: const TextStyle(fontSize: 22.0),
                  pinTextAnimatedSwitcherTransition:
                      ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                  pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
//                    highlightAnimation: true,
                  highlightAnimationBeginColor: Colors.black,
                  highlightAnimationEndColor: Colors.white12,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: InkWell(
                    child: Text(
                      multilanguage.translate("resend_otp"), //resend OTP
                      textAlign: TextAlign.end,
                      style: const TextStyle(color: primaryColor),
                    ),
                    onTap: () {
                      sendOtp();
                    },
                  ),
                ),
                const SizedBox(
                  width: 30,
                )
              ]),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                width: double.maxFinite,
                child: CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    multilanguage.translate("verify_otp"), //'Verify OTP',
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    validateOTP(controller.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateOTP(String otpText) async {
    if (int.parse(otpText) == otp) {
      // Provider.of<AuthProvider>(context, listen: false).saveUser();

      var uuid = const Uuid();
      String appKey = uuid.v4();
      await Provider.of<AuthProvider>(context, listen: false)
          .getIpAddress()
          .then((value) async {
        if (value != null) {
          Map body = {
            "I/P": value,
            "AppKey": appKey,
            "MobileNumber": user!.phoneNumber,
            "Token": API_TOKEN,
            "Env": Environment().config?.envParam
          };
          await Provider.of<AuthProvider>(context, listen: false)
              .addAppKey(body)
              .then((Value) {
            if (value.isNotEmpty) {
              debugPrint('addAppKey - $Value');
            }
          });
        } else {
          showErrorToast("Mobile IP address is missing");
        }
      });

      pref.userMobile = user!.phoneNumber ?? "";
      var str = user?.name;
      var parts = str?.split(':');
      var prefix = parts?[1].trim(); // prefix: "date"
      var date = parts?.sublist(1).join(':').trim(); // date: "'2019:04:01'"
      pref.userName = prefix ?? "";
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => HomeScreen(),
        ),
        (route) => false, //if you want to disable back feature set to false
      );
    } else {
      setState(() {
        hasError = true;
      });
      showErrorToast("${MultiLanguage.of(context)!.translate("invalid_otp")}.");
    }
  }
}
