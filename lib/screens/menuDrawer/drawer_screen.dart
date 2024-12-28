

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:vistaar_bandhu_new_version/providers/auth_provider.dart';
import 'package:vistaar_bandhu_new_version/screens/home_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/login/login_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/menuDrawer/about_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/menuDrawer/faq_screen.dart';
import 'package:vistaar_bandhu_new_version/service/app_di.dart';
import 'package:vistaar_bandhu_new_version/storage/app_pref.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_enum.dart';
import 'package:vistaar_bandhu_new_version/util/app_helper.dart';
import 'package:vistaar_bandhu_new_version/util/size_config.dart';

import '../../multilanguage.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final AppSharedPref _pref = getIt<AppSharedPref>();
  AppHelper appHelper = getIt<AppHelper>();
  List<DrawerMenuType> _listMenu = DrawerMenuType.values;

  @override
  void initState() {
    super.initState();
  }

  void _showLogoutAlert() {
    showAdaptiveAlertDialog(
        context: context,
        title:
            '${MultiLanguage.of(context)!.translate("logout")}?', //'Log out?',
        content:
            '${MultiLanguage.of(context)!.translate("do_you_want_to_logout")}?', //'Do you want to Log out?',
        cancelActionText:
            MultiLanguage.of(context)!.translate('cancel'), //'Cancel',
        defaultActionText:
            MultiLanguage.of(context)!.translate('logout'), //'Log out',
        defaultActionColor: Colors.red,
        defaultAction: _logOut);
  }

  _logOut() {
    Provider.of<AuthProvider>(SizeConfig.cxt!, listen: false).clearUserData();
    Get.offNamedUntil(LoginScreen.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage:
                      AssetImage('assets/images/ic_profile_placeholder.jpg'),
                  radius: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  _pref.userName,
                ))
              ],
            ),
          ),
          const Divider(),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final drawerMenu = _listMenu[index];
                    return ListTile(
                      title: Text(
                          DrawerMenuTypeHelper.getTitle(drawerMenu, context),
                          style: const TextStyle(fontSize: 15.0)),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                      dense: true,
                      onTap: () {
                        onDrawMenuTapped(drawerMenu, context);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemCount: _listMenu.length)),
        ]),
      ),
    );
  }

  // Future<void> checkAppUpdate() async {
  //   print("checking update!");
  //   InAppUpdate.checkForUpdate().then((info) {
  //     debugPrint("info.updateAvailability: ${info.updateAvailability}");
  //     setState(() {
  //       if (info.updateAvailability == UpdateAvailability.updateAvailable) {
  //         print("update available");
  //         showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: Text('Information'),
  //               content: Text('Update available!'),
  //               actions: <Widget>[
  //                 TextButton(
  //                   child: Text('Update'),
  //                   onPressed: () {
  //                     update();
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       } else {
  //         showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: Text('Information'),
  //               content: Text('The app is up to date.'),
  //               actions: <Widget>[
  //                 TextButton(
  //                   child: Text('OK'),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       }
  //     });
  //   }).catchError((e) {
  //     print("Error: $e");
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Update Error. Please try again later'),
  //           content: Text(e.toString()),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   });
  // }

  // void update() async {
  //   print("Updating");
  //   await InAppUpdate.startFlexibleUpdate();
  //   InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
  //     print("Error: $e");
  //   });
  // }

  void onDrawMenuTapped(DrawerMenuType drawerMenu, BuildContext context) {
    Get.back();
    String drawMenuTap = DrawerMenuTypeHelper.getTitle(drawerMenu, context);

    if (drawMenuTap == MultiLanguage.of(context)!.translate('home')) {
      Get.toNamed(HomeScreen.routeName);
    }
    if (drawMenuTap == MultiLanguage.of(context)!.translate('faq')) {
      Get.toNamed(FAQScreen.routeName);
    }
    if (drawMenuTap == MultiLanguage.of(context)!.translate('about_us')) {
      Get.toNamed(AboutScreen.routeName);
    }
    if (drawMenuTap == MultiLanguage.of(context)!.translate('logout')) {
      _showLogoutAlert();
    }

    // switch (DrawerMenuTypeHelper.getTitle(drawerMenu, context)) {
    //   case 'Home':
    //     {
    //       Get.toNamed(HomeScreen.routeName);
    //     }
    //     break;
    //   case 'About Us':
    //     {
    //       Get.toNamed(AboutScreen.routeName);
    //     }
    //     break;
    //   case 'FAQ':
    //     {
    //       Get.toNamed(FAQScreen.routeName);
    //     }
    //     break;
    //   // case 'Call Us':
    //   //   {
    //   //     _makePhoneCall("tel:08030088494");
    //   //   }
    //   //   break;
    //   case 'Logout':
    //     {
    //       _showLogoutAlert();
    //     }
    //     break;
    // }
  }

  // Future<void> _makePhoneCall(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
