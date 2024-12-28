import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/screens/request/deActivate_nach_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/request/forceClosure_request_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/request/soa_request.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

class RequestScreen extends BasePage {
  static const routeName = '/RequestScreen';

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends BaseState<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    MultiLanguage multiLanguage = MultiLanguage.of(context)!;
    List<Map<String, String>> options = [
      {
        "title": multiLanguage.translate("statement_of_account"),
        "image": "assets/images/soa_vist.png"
      },
      {
        "title": multiLanguage.translate("foreclosure_request"),
        "image": "assets/images/loan_close.png"
      },
      {
        "title": multiLanguage.translate("nach_deactivate"),
        "image": "assets/images/cancel.png"
      }
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        // status bar brightness
        elevation: 0,
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
              multiLanguage.translate("requests"),
              style: const TextStyle(color: goldColor),
            ),
            const SizedBox(
              width: 60,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            var option = options[index];
            return Card(
              margin: const EdgeInsets.all(10.0),
              elevation: 8,
              child: InkWell(
                  child: SizedBox(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 70,
                          child: Image.asset(
                            option["image"]!,
                          ),
                        ),
                        Text(
                          option["title"] ?? "",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: primaryColor),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if (index == 0) {
                      Get.toNamed(SOARequestScreen.routeName);
                    } else if (index == 1) {
                      Get.toNamed(ForceClosureRequestScreen.routeName);
                    } else if (index == 2) {
                      Get.toNamed(DeActivateNACHScreen.routeName);
                    }
                  }),
            );
          },
          itemCount: options.length,
        ),
      ),
    );
  }
}
