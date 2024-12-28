import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/environment.dart';
import 'package:vistaar_bandhu_new_version/models/pvl_offer_model.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/providers/pvl_provider.dart';
import 'package:vistaar_bandhu_new_version/screens/pvl/pvl_offer_details.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';
import 'package:vistaar_bandhu_new_version/util/empty_message.dart';

import '../home_screen.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class PvlListScreen extends BasePage {
  static const routeName = '/PvlOfferList';
  List<PvlList>? listPvlOffers = [];
  PvlListScreen({required this.listPvlOffers});
  @override
  _PvlListScreen createState() => _PvlListScreen();
}

class _PvlListScreen extends BaseState<PvlListScreen> {
  List<PvlList>? listPvlOffers = [];

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    listPvlOffers = Get.arguments;
  }

  Future getPvlList() async {
    showLoadingDialog(
        context: context,
        hint: "${MultiLanguage.of(context)!.translate("loading")}...");
    var param = {
      'Mobile': pref.userMobile,
      'Token': API_TOKEN,
      'Env': Environment().config?.envParam
    };

    await Provider.of<PvlProvider>(context, listen: false)
        .getPvlList(param)
        .then((value) {
      if (value!.d != null) {
        var listings = value.d!.toList();
        listPvlOffers!.addAll(listings);

        setState(() {});
      } else {
        showSuccessToast(
            MultiLanguage.of(context)!.translate("you_do_not_have_offers"));
      }

      Navigator.of(context).pop();
    }, onError: (error) {
      Navigator.of(context).pop();
    });
    appLogger(
        Environment().config?.envParam, 'log pvl: ${listPvlOffers!.length}');
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
                MultiLanguage.of(context)!
                    .translate("exciting_offers"), //Exciting Offers
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
      body: buildListView(listPvlOffers),
      bottomNavigationBar: new BottomNavigationBar(
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              this.tabIndex = index;
            });
            _navigateToScreens();
          },
          type: BottomNavigationBarType.fixed,
          items: [
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.location_pin), label: "Locate Us"),
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: MultiLanguage.of(context)!.translate("home")),
            BottomNavigationBarItem(
                icon: const Icon(Icons.call),
                label: MultiLanguage.of(context)!.translate("call_us")),
          ]),
      //SafeArea(
    );
  }

  Widget buildListView(List<PvlList>? d) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: d!.isEmpty
          ? EmptyMessage(
              "${MultiLanguage.of(context)!.translate("we_are_working_offers")}!")
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: d.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      elevation: 10,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      shadowColor: Colors.grey[800],
                      child: InkWell(
                        onTap: () async {
                          onShowInterest(d[index]);
                          setState(() {});
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FadeInImage.assetNetwork(
                                image: d[index].imagePath ?? "",
                                fit: BoxFit.cover,
                                placeholder: 'assets/images/vist_img_4.png',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ListTile(
                              title: Text(d[index].offeredProductdesc ?? "",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              trailing: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(10.0), //or 15.0
                                child: Container(
                                    height: 90.0,
                                    width: 120.0,
                                    color: Colors.blue[900],
                                    child: Center(
                                        child: Text(
                                      "₹.${(d[index].offeredLoanAmount?.toStringAsFixed(0) ?? 0)} /-",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    ))),
                              ),
                            ),
                            // CircleAvatar(child: Text("${(d[index].offeredLoanAmount?.toStringAsFixed(0) ?? 0)} /-")),

                            Container(
                              padding: const EdgeInsets.all(20.0),
                              child: CupertinoButton(
                                color: Colors.blue[900],
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  MultiLanguage.of(context)!
                                      .translate("click_for_more_details"),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  onShowInterest(d[index]);
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            ),
    );
  }

  onShowInterest(PvlList pvlOfferModel) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (BuildContext context) {
          return PvlOfferDetailScreen(pvlOfferModel: pvlOfferModel);
        });
  }

  _navigateToScreens() {
    if (tabIndex == 0) {
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => HomeScreen(),
        ),
        (route) => false, //if you want to disable back feature set to false
      );
    } else {
      tabIndex = 0;
      _makePhoneCall("tel:08030088494");
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showErrorToast(
          MultiLanguage.of(context)!.translate("something_went_wrong"));
    }
  }
}
