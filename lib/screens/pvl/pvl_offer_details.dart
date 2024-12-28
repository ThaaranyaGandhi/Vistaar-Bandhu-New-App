
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/models/pvl_offer_model.dart';
import 'package:vistaar_bandhu_new_version/providers/pvl_provider.dart';

import '../home_screen.dart';


String name = "";

class PvlOfferDetailScreen extends BasePage {
  final PvlList? pvlOfferModel;

  PvlOfferDetailScreen({ this.pvlOfferModel});

  _PvlOfferDetailsState createState() =>
      _PvlOfferDetailsState(list: pvlOfferModel);
}

class _PvlOfferDetailsState extends BaseState<PvlOfferDetailScreen> {
  final PvlList? list;
  var interest = "";

  _PvlOfferDetailsState({this.list});

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( child:Container(
      padding: EdgeInsets.all(5.0),
      height: MediaQuery.of(context).size.height/1.25,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: ListTile(
              title: Text(list?.offeredProduct ?? "",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              subtitle: Text("${list?.offeredProductdesc}"),
              leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                    maxWidth: 24,
                    maxHeight: 24,
                  ),
                  child: Image.asset("assets/images/backbutton.png",
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),

          Container(
            child: ListTile(
              title: Text("Offered Loan Amount",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              subtitle: Text(
                  "Upto Rs." +
                      "${list?.offeredLoanAmount?.toStringAsFixed(0) ?? ""}" +
                      " /-",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: Image.asset("assets/images/bank_loan.png",
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Container(
              child: ListTile(
                  title: Text("Approx Existing POS as on Oct 1st",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  subtitle: Text(
                      " Rs.${list?.dISBURSE_AMT?.toStringAsFixed(0) ?? 0} /-",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: 64,
                      maxHeight: 64,
                    ),
                    child: Image.asset("assets/images/interest.png",
                        fit: BoxFit.cover),
                  ))),
          Container(
              child: ListTile(
                  title: Text("Approx Net In Hand",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  subtitle: Text("Rs.${list?.aPPLIEDAMOUNT}/-",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: 64,
                      maxHeight: 64,
                    ),
                    child: Image.asset("assets/images/net-worth.png",
                        fit: BoxFit.cover),
                  ))),
          Container(
              child: ListTile(
                  title: Text("Approx Tenure",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  subtitle: Text("upto ${list?.tENURE} months",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: 64,
                      maxHeight: 64,
                    ),
                    child: Image.asset("assets/images/hourglass.png",
                        fit: BoxFit.cover),
                  ))),
          Container(
              child: ListTile(
                  title: Text("Approx EMI",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  subtitle: Text("upto Rs.${list?.offeredEMI} /-",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: 64,
                      maxHeight: 64,
                    ),
                    child: Image.asset("assets/images/money.png",
                        fit: BoxFit.cover),
                  ))),
          if (list?.customerConsent != "INTERESTED")
            Container(
              padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,10.0),
              child: CupertinoButton(
                color: Colors.yellow[900],
                child: Text(
                  'Interested',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () => onInterestPressed(list?.iD ?? 0),
              ),
            )
          else
            Container(
              padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,10.0),
              child: Text(
                'Thank you for your interest,we have received your request!'
                    ' our team will contact you shortly. ',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 16),
              ),
            ),
        ],
      ),
    ),
    );
  }

  Future postInterest(int id) async {
    var param = {'Mobile': pref.userMobile, "ID": id, "Consent": "INTERESTED"};
    await Provider.of<PvlProvider>(context, listen: false)
        .postCustomerInterest(param)
        .then((value) {
      // var listings = value;
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => HomeScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );
      Get.snackbar("Interest Consent",
          "Thank you for showing interest in our product , we will get in touch with you shortly",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);

    }, onError: (error) {
      Navigator.of(context).pop();
    });
  }

  onInterestPressed(int id) {
    postInterest(id);
    Navigator.pop(context);
  }


}
