
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vistaar_bandhu_new_version/service/app_di.dart';
import 'package:vistaar_bandhu_new_version/storage/app_pref.dart';
import 'package:vistaar_bandhu_new_version/util/app_helper.dart';
import 'package:vistaar_bandhu_new_version/util/size_config.dart';

abstract class BasePage extends StatefulWidget {
  BasePage();
}

abstract class BaseState<Page extends BasePage> extends State<Page> {
  bool showLoading = false;
  AppSharedPref pref = getIt<AppSharedPref>();
  AppHelper appHelper = getIt<AppHelper>();
  final picker = ImagePicker();

  hideLoadingIndicator() {
    if (mounted)
      setState(() {
        showLoading = false;
      });
  }

  showLoadingIndicator() {
    if (mounted)
      setState(() {
        showLoading = true;
      });
  }

  hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  imagePickerDialog(Function onCamera, Function onGallery,
      {bool isPdfEnable = false, Function? onPdf}) {
    Get.bottomSheet(
      Wrap(
        children: [
          Container(
            color: Colors.white,
            height: !isPdfEnable
                ? MediaQuery.of(context).size.height * .25
                : MediaQuery.of(context).size.height * .32,
            width: SizeConfig.screenWidth,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Choose',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton.icon(
                  icon: Icon(Icons.photo_camera),
                  label: Text('Camera'),
                  onPressed: () {
                    Navigator.pop(context);
                    onCamera();
                  },
                ),
                Divider(
                  height: 3,
                ),
                TextButton.icon(
                  icon: Icon(Icons.photo_album),
                  label: Text('Gallery'),
                  onPressed: () {
                    Navigator.pop(context);
                    onGallery();
                  },
                ),
                !isPdfEnable
                    ? SizedBox()
                    : Divider(
                        height: 3,
                      ),
                !isPdfEnable
                    ? SizedBox()
                    : TextButton.icon(
                        icon: Icon(Icons.picture_as_pdf_outlined),
                        label: Text('PDF'),
                        onPressed: () {
                          Navigator.pop(context);
                          if (onPdf != null) onPdf();
                        },
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  videoPickerDialog(Function onCamera, Function onGallery) {
    Get.bottomSheet(
      Wrap(
        children: [
          Container(
            color: Colors.white,
            height: SizeConfig.screenHeight! * .25,
            width: SizeConfig.screenWidth,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Choose video using',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton.icon(
                  icon: Icon(Icons.photo_camera),
                  label: Text('Camera'),
                  onPressed: () {
                    Navigator.pop(context);
                    onCamera();
                  },
                ),
                Divider(
                  height: 3,
                ),
                TextButton.icon(
                  icon: Icon(Icons.photo_album),
                  label: Text('Gallery'),
                  onPressed: () {
                    Navigator.pop(context);
                    onGallery();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

mixin BasicPage<Page extends BasePage> on BaseState<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawer: drawer(),
      body: InkWell(
        onTap: () {
          hideKeyboard();
        },
        child: body(),
      ),
    );
  }

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  PreferredSizeWidget? appBar() {
    return null;
  }

  Widget? drawer() {
    return null;
  }

  Widget body();
}
