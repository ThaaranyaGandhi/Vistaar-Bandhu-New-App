
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/models/user_model.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/providers/auth_provider.dart';
import 'package:vistaar_bandhu_new_version/screens/login/otp_screen.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_textfield.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:vistaar_bandhu_new_version/util/size_config.dart';

import '../../environment.dart';
import '../home_screen.dart';

class LoginScreen extends BasePage {
  static const routeName = '/LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {
  List<String> imgList = [
    "assets/images/vist_img_4.png",
    "assets/images/vist_img_5.png",
    "assets/images/vist_img_6.png",
    "assets/images/vist_img_7.png"
  ];
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final _loginFormKey = GlobalKey<FormState>();
  final _mobileNumTextController = TextEditingController();

  @override
  void initState() {
    // _mobileNumTextController.text = "9962339945";
    // _mobileNumTextController.text = "9698979920";
    // versionCheck(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    appFirstLoad(multiLanguage: MultiLanguage.of(context)!, supportedLanguage: [
      ["en", "english"],
      ["hi", "hindi"],
      ["te", "telugu"],
      ["kn", "kannada"],
      ["ta", "tamil"],
    ]);
  }

  void appFirstLoad(
      {required multiLanguage, required supportedLanguage}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstLoad = true;

    firstLoad = prefs.getBool("firstLoad") ?? true;

    if (firstLoad) {
      await prefs.setBool("firstLoad", false);

      Get.defaultDialog(
        title: multiLanguage!.translate("select_language"), //"Select Language",
        content: SizedBox(
          height: MediaQuery.of(context).size.height / 2.3,
          width: MediaQuery.of(context).size.width / 1.2,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: supportedLanguage.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    debugPrint(
                        "supportedLanguage[index][0] = ${supportedLanguage[index][0]}");
                    MultiLanguage().setLocale(
                      context,
                      Locale.fromSubtags(
                          languageCode: supportedLanguage[index][0]),
                    );
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: SizeConfig.screenHeight! / 15,
                      child: Card(
                        elevation: 2.5,
                        child: Center(
                          child: Text(
                            MultiLanguage.of(context)!
                                .translate(supportedLanguage[index][1]),
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MultiLanguage multiLanguage = MultiLanguage.of(context)!;
    List<List<String>> supportedLanguage = [
      ["en", "english"],
      ["hi", "hindi"],
      ["te", "telugu"],
      ["kn", "kannada"],
      ["ta", "tamil"],
    ];

    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(multiLanguage.translate("vistaar_bandhu")),
        actions: [
          LanguageSelectButton(
            multilanguage: multiLanguage,
            supportedLanguage: supportedLanguage,
            animate: false,
          ),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            hideKeyboard();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: primaryColor,
                  child: CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      aspectRatio: 2.0,
                      viewportFraction: 1.0,
                      reverse: false,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                    items: imgList.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.asset(image, fit: BoxFit.contain);
                        },
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        margin:const  EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor.withOpacity(
                                _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
                Form(
                  key: _loginFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          multiLanguage.translate("welcome"), //'Welcome',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 40),
                        AppFormTextField(
                          hintLabel: multiLanguage.translate("mobile_number"),
                          //'Mobile Number',
                          hintText: multiLanguage
                              .translate("enter_your_mobile_number"),
                          //'Enter your mobile number',
                          controller: _mobileNumTextController,
                          ctx: context,
                          textInputAction: TextInputAction.next,
                          keyboardType:
                              const TextInputType.numberWithOptions(signed: true),
                          validator: (phone) {
                            if (phone == "") {
                              return 'Please enter mobile number';
                            } else if (phone!.length < 10) {
                              return 'Please enter valid mobile number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.maxFinite,
                          child: CupertinoButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              multiLanguage.translate("sign_in"),
                              style: const TextStyle(color: Colors.white),
                            ),
                            onPressed: () => login(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    hideKeyboard();
    if (_mobileNumTextController.text.trim() == "8860088996") {
      UserModel user = UserModel();
      user.phoneNumber = "8860088996";
      user.name = 'Name: Mr. Test';

      Get.toNamed(OtpVerificationScreen.routeName, arguments: user);
    } else if (_validateInputs()) {
      showLoadingDialog(
          context: context,
          hint: "${MultiLanguage.of(context)!.translate("signing_in")}....");
      await Provider.of<AuthProvider>(context, listen: false)
          .userLogin(_mobileNumTextController.text.trim())
          .then((value) {
        //hide loading dialog
        Navigator.pop(context);
        UserModel user = UserModel();
        user.phoneNumber = _mobileNumTextController.text.trim();
        if (value != null) {
          if (value.applicationReference != null &&
              value.applicationReference!.isNotEmpty) {
            user.name = value.applicationReference!.where((element) {
              if (element.contains("Borrower Name")) {
                return true;
              }
              return false;
            }).first;
          }
          // user.name = user.name?.replaceAll("Borrower Name :", "");

          Get.toNamed(OtpVerificationScreen.routeName, arguments: user);
        }
      });
    }
  }

  bool _validateInputs() {
    if (_loginFormKey.currentState!.validate()) {
      appLogger(Environment().config?.envParam, 'Form is valid');
      _loginFormKey.currentState!.save();
      return true;
    } else {
      appLogger(Environment().config?.envParam, 'Form is invalid');
      return false;
    }
  }
}
