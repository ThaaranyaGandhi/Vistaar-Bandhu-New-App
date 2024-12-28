import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/environment.dart';
import 'package:vistaar_bandhu_new_version/models/loan_agreement_form_model.dart';
import 'package:vistaar_bandhu_new_version/providers/welcomeKit_provider.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

import '../../multilanguage.dart';
import '../../providers/loan_provider.dart';

import 'package:http/http.dart' as http;

class LoanAgreementFormScreen extends BasePage {
  static const routeName = '/LoanAgreementFormScreen';

  @override
  WelcomeKitState createState() => WelcomeKitState();
}

class WelcomeKitState extends BaseState<LoanAgreementFormScreen>
    with SingleTickerProviderStateMixin {
  // late AnimationController lottieController;
  String? file = "";
  String? lan = "";
  int index = 0;

  //PDFDocument? document;
  bool _isLoading = true;
  bool _shouldIgnore = true;
  D? _laf;
  bool noDocuments = false;
  late String pdfFilePath;

  int _totalPages = 0;
  int _currentPage = 0;
  late PDFViewController _pdfViewController;

  @override
  void initState() {
    super.initState();
    // _openBox();
    final data = Get.arguments;

    if (data is Map<String, dynamic>) {
      setState(() {
        lan = data["loanNumber"];
        index = data["index"];
      });
    }
    getLotexUpdatedLeadIdByLan(lan!);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLotexUpdatedLeadIdByLan(lan!);
  }

  getLotexUpdatedLeadIdByLan(String lan) async {
    var param = {
      'Lan': lan,
      'Tag': 'Report',
      'SubTag': 'Application Form',
      'ENV': Environment().config?.envParam
    };
    await Provider.of<LoanProvider>(context, listen: false)
        .getLotexUpdatedLeadIdByLan(param)
        .then((value) {
      if (value != null && value.d != "NOT FOUND") {
        _laf = value.d;
        if(_laf!.leadId != 'NA'){

          lafAuth(
            leadId: _laf!.leadId,
            updatedReferenceId: _laf!.updatedId,
          );
        }else{
          showSuccessToast(
              "Application form is not available");
        }
      }else{
        showSuccessToast(
            "Application form is not available");
      }
      setState(() {

      });
    });
  }

  lafAuth({String? leadId, String? updatedReferenceId}) async {
    await Provider.of<LoanProvider>(context, listen: false)
        .LAFAuth()
        .then((value) {
      LAFAuthModel authForm = value;
      String token = authForm.authData![0].authToken!;
      lafDoc(token: token, refId: leadId, updateRefNo: updatedReferenceId);
    });
  }

  lafDoc({
    String? token,
    String? refId,
    String? updateRefNo,
  }) async {
    try {
      await Provider.of<LoanProvider>(context, listen: false)
          .LAFDoc(
        token!,
        (refId! != "NA" && refId.isNotEmpty) ? refId : lan!,
        (updateRefNo! != "NA" && updateRefNo.isNotEmpty) ? updateRefNo : "",
      )
          .then((value) {
        LAFModel lafModel = value;
        file = lafModel.docDetails![0].imagedata![0].imgb64 ?? "";
        loadDocument(file!);
        //   createPdf(file!);
      });
    } catch (e) {
      if (lan == "0010SBML03254") {
        // setState(() {

        //  });
      }
      //   createPdf(file!);
      loadDocument(file!);
    }
  }


  Future<void> loadDocument(String url) async {
    try {
      // Download the PDF file from the URL
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final output = await getTemporaryDirectory();
        final file = File("${output.path}/downloaded.pdf");
        await file.writeAsBytes(bytes);

        setState(() {
          pdfFilePath = file.path;
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load PDF");
      }
    } catch (e) {
      print("Error loading document: $e");
      setState(() => _isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    MultiLanguage multiLanguage = MultiLanguage.of(context)!;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Center(
            child: Column(
              children: [
                Row(
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
                    Flexible(
                      child: Text(
                        multiLanguage.translate("loan_application_form"),
                        style: const TextStyle(color: goldColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 4, right: 30, bottom: 2),
                      child: Text(
                        "${MultiLanguage.of(context)!.translate("lan")} : $lan",
                        style: const TextStyle(color: goldColor, fontSize: 15),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: const FaIcon(FontAwesomeIcons.whatsapp,
                    color: Colors.green),
                iconSize: 30,
                color: Colors.green,
                onPressed: _shouldIgnore == true
                    ? () {
                        if (file == null || file!.isEmpty) {
                          Get.snackbar(
                              MultiLanguage.of(context)!.translate("alert"),
                              "${multiLanguage.translate("file_not_available")}!",
                              //"Please select an option to make payment",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        } else {
                          setState(() {
                            sendWhatsappMessages();
                          });
                        }

                        Timer(const Duration(hours: 24), () {
                          setState(() {
                            _shouldIgnore = true;
                          });
                        });
                      }
                    : null)
            // onPressed:() => sendWhatsappMessages(),
          ],
        ),
      ),
      body: Container(
        child: (_laf == null || file == null)
            ? const Center(child: CircularProgressIndicator())
            : file != ""
                ? PDFView(
          filePath: pdfFilePath,
          onRender: (pages) {
            setState(() {
              _totalPages = pages!;
            });
          },
          onViewCreated: (controller) {
            _pdfViewController = controller;
          },
          onPageChanged: (page, total) {
            setState(() {
              _currentPage = page!;
            });
          },
                  /*  document: document!,
                    lazyLoad: false,
                    scrollDirection: Axis.vertical,*/
                  )
                : Container(),
        // : Text("${_laf!.leadId ?? ""}")),
      ),
    );
  }

  void showMessageSentDialog(String msg) => showDialog(
      context: context,
      builder: (context) => Dialog(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Lottie.asset("assets/json/messageSent.json",
                //     repeat: false,
                //     height: 300,
                //     width: 300,
                //     controller: lottieController, onLoaded: (composition) {
                //   lottieController.duration = 3.seconds;
                //   lottieController.forward();
                // }),
                Center(
                  child: Text(
                    "$msg",
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 21),
              ],
            ),
          ));

  void showWelcomeDialog() => showDialog(
      context: context,
      builder: (context) => Dialog(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "${MultiLanguage.of(context)!.translate("welcome")}!",
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 21),
              ],
            ),
          ));

  Future sendWhatsappMessages() async {
    Map<String, dynamic> param = {
      '@VER': '1.2',
      'USER': {
        '@USERNAME': 'vistafintransWA',
        '@PASSWORD': 'u1Qx0ne7',
        '@CH_TYPE': '4',
        '@UNIXTIMESTAMP': ''
      },
      'SMS': [
        {
          '@UDH': '0',
          '@CODING': '1',
          '@TEXT':
              'Dear ${pref.userName}, Welcome to the Vistaar Family. As you had requested, attached please find your Welcome Kit that provides you all the information on your loan account no $lan availed from Vistaar. For further queries you can reach us at the respective branch or give us a Missed Call on 08030088494. Regards, Vistaar Finance.',
          '@CAPTION': "",
          '@TEMPLATEINFO': '4052439',
          '@CONTENTTYPE': 'document/pdf',
          '@TYPE': 'document',
          '@MEDIADATA': file,
          '@PROPERTY': '0',
          '@MSGTYPE': '3',
          '@ID': '23',
          'ADDRESS': [
            {
              '@FROM': '916366864440',
              '@TO': '91${pref.userMobile}',
              '@SEQ': '1',
              '@TAG': 'some clientside random data'
            }
          ]
        }
      ]
    };
    await Provider.of<WelcomeKitProvider>(context, listen: false)
        .getWhatsappMessageStatus(param)
        .then((value) {
      if (value?.mESSAGEACK?.gUID?.eRROR == null) {
        var _date = DateTime.now();
        String format = DateFormat("HH:mm:ss.SSS").format(_date);
        if (pref.messageSent.isNotEmpty &&
            pref.messageSent.contains(pref.messageSent[index])) {
          pref.messageSent.insert(index, format);
        } else {
          pref.messageSent.add(format);
        }
        setState(() {
          _shouldIgnore = false;
        });

        var message =
            MultiLanguage.of(context)!.translate("message_sent_successfully");
        showMessageSentDialog(message);
      } else {
        setState(() {
          _shouldIgnore = true;
        });
      }
    });
  }

  Widget noData() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            "assets/json/13659-no-data.json",
            repeat: true,
            height: 300,
            width: 300,
          ),
          const SizedBox(height: 21),
        ],
      );
}

