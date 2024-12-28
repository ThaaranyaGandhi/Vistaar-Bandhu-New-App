import 'dart:async';
import 'dart:convert';
import 'dart:io';

//import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/environment.dart';
import 'package:vistaar_bandhu_new_version/providers/welcomeKit_provider.dart';
import 'package:vistaar_bandhu_new_version/service/api_client.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

import 'package:http/http.dart' as http;

import '../../multilanguage.dart';

class WelcomeKitScreen extends BasePage {
  static const routeName = '/WelcomeKitScreen';

  @override
  WelcomeKitState createState() => WelcomeKitState();
}

class WelcomeKitState extends BaseState<WelcomeKitScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController lottieController;
  String? file = "";
  String? lan = "";
  int index = 0;
  //PDFDocument? document;
  bool _isLoading = true;
  bool _shouldIgnore = true;
  List<int>? fileBytes;
  Uint8List? pdfData;
  bool _showText = true;
  late String pdfFilePath;

  @override
  void initState() {
    super.initState();
    final data = Get.arguments;
    if (data is Map<String, dynamic>) {
      setState(() {
        lan = data["loanNumber"];
        index = data["index"];
      });
    }

    file = "${Environment().config?.assetUrl}LSS_Schedule_$lan.pdf";

    // var file =
    //     "${Environment().config?.assetUrl}LSS_Schedule_0143SBML00610.pdf";

    loadDocument(file ?? "");
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    // });
    lottieController = AnimationController(vsync: this);
    lottieController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        lottieController.reset();
      }
    });
  }



  Future<void> getWelcomePDF({required String lanNo}) async {
    Map<String, String> body = {"Lan": lanNo, "Token": "0xH0xH01U01S0x01N"};
    var response = await ApiClient().welcomeKitPDF(body);
    Map<String, dynamic> parsedJson = jsonDecode(response);
    if (parsedJson['d'] == 'File not found.' || parsedJson['d'] == 'error') {
      file = '';
      fileBytes = null;
      setState(() => _isLoading = false);
    } else {
      String path = parsedJson['d'];
      List<int> bytes = base64Decode(path);
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      File filePath = File('$appDocPath/decoded_file.pdf');
      await filePath.writeAsBytes(bytes);
      file = filePath.path;
      setState(() {
        fileBytes = bytes;
        _isLoading = false;
        Timer(const Duration(seconds: 10), () {
          _showText = false;
        });
      });
    }
  }

/*  Future<String> saveBase64AsPdf({required String base64String}) async {
    try {
      List<int> bytes = base64Decode(base64String);
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      File filePath = File('$appDocPath/decoded_file.pdf');
      await filePath.writeAsBytes(bytes);
      print('PDF saved successfully at $appDocPath/decoded_file.pdf');
      return filePath.path;
    } catch (e) {
      print('Error saving PDF: $e');
      return '';
    }
  }*/

  Future<void> loadDocument(String doc) async {
    setState(() => _isLoading = true);
    try {
      Directory tempDir = await getTemporaryDirectory();
      String filePath = '${tempDir.path}/downloaded.pdf';

      var response = await http.get(Uri.parse(doc));

      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        pdfFilePath = filePath;
        _isLoading = false;
      });
      showWelcomeDialog();
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint("Error loading document: $e");
    }
  }


/*  loadDocument(String file) async {
    document = await PDFDocument.fromURL(file);
    showWelcomeDialog();
    setState(() => _isLoading = false);
  }*/

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      MultiLanguage.of(context)!.translate("welcome_kit"),
                      style: const TextStyle(color: goldColor),
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
                        setState(() {
                          sendWhatsappMessages();
                        });

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
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            :
            PDFView(
              filePath: pdfFilePath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageSnap: true,

              /*  document: document!,
                lazyLoad: false,
                scrollDirection: Axis.vertical,*/
              ),
      ),
    );
  }

  // _lockButton()  {
  //   if (pref.messageSent == lan &&
  //       (DateFormat("yyyy-MM-dd hh:mm:ss").parse(pref.storeDate)
  //           .add(Duration(hours: 24)))
  //           .isBefore(DateTime.now())) {
  //     if (pref.messageSent != lan)
  //       {_shouldIgnore = false;
  //       print("$_shouldIgnore in if ${pref.storeDate}");
  //
  //       }
  //     else
  //       {
  //         _shouldIgnore = true;
  //         print("$_shouldIgnore in else ${pref.storeDate}");
  //
  //         showMessageSentDialog(
  //             "Message has already been sent to your whatsapp");
  //       }
  //   }
  //   print("$_shouldIgnore ${pref.storeDate}");
  //
  // }

  void showMessageSentDialog(String msg) => showDialog(
      context: context,
      builder: (context) => Dialog(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset("assets/json/messageSent.json",
                    repeat: false,
                    height: 300,
                    width: 300,
                    controller: lottieController, onLoaded: (composition) {
                  lottieController.duration = 3.seconds;
                  lottieController.forward();
                }),
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
                Lottie.asset("assets/json/49654-welcome-kit.json",
                    repeat: false,
                    height: 300,
                    width: 300,
                    controller: lottieController, onLoaded: (composition) {
                  lottieController.duration = 3.seconds;
                  lottieController.forward();
                }),
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
    // if (pref.messageSent.isNotEmpty && pref.storeDate.isNotEmpty) {
    //   if (pref.messageSent == lan &&
    //       (DateFormat("HH:mm:ss.SSS")
    //               .parse(pref.storeDate)
    //               .add(Duration(hours: 24)))
    //           .isBefore(DateTime.now())) {

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

        // var a = _messageStatus?.containsKey(lan!);
        // print(a);
        // Messages messages = Messages(lan!, true, DateTime.now());
        //   _messageStatus?.add(messages);
        // print(_messageStatus?.values);
        // _messageStatus?.putAt(index, lan);
        //   _messageStatus?.putAt(index, true);
        //   _messageStatus?.put(index, DateTime.now());
        //   print("$a ${_messageStatus?.keys}" );
        // }
        // print("in else block ");
        // Messages messages = Messages(lan!, true, DateTime.now());
        // _messageStatus?.add(messages);
        // var a =  _messageStatus?.values;
        // print(a);

        //   setState(() {
        //     _shouldIgnore = false;
        //   });
        // }

        // pref.messageSent = ["${_date.toString()}"];
        // pref.storeDate = _date.toString();
        // print(
        //     " printing in if  ${pref.storeDate} ${pref.messageSent} "
        //         "$lan $_shouldIgnore");

        var message =
            MultiLanguage.of(context)!.translate("message_sent_successfully");
        showMessageSentDialog(message);
      } else {
        setState(() {
          _shouldIgnore = true;
        });

        // print(
        //     "printing in else  ${pref.storeDate} ${pref.messageSent}"
        //         " $lan $_shouldIgnore ${value?.mESSAGEACK?.gUID?.eRROR?.cODE} $param");
        // showErrorToast("Message has already been sent");
      }
    });
  }

  //     } else {
  //       print(" printing ${pref.storeDate} ${pref.messageSent} $lan");
  //       pref.messageSent = "";
  //       setState(() {});
  //       showSuccessToast("Message has already been sent");
  //     }
  //   } else {
  //     await Provider.of<WelcomeKitProvider>(context, listen: false)
  //         .getWhatsappMessageStatus(param)
  //         .then((value) {
  //       if (value?.mESSAGEACK?.gUID?.eRROR == null) {
  //         var _date = DateTime.now();
  //         var format = DateFormat("HH:mm:ss.SSS").format(_date);
  //         pref.messageSent = "$lan";
  //         pref.storeDate = format.toString();
  //         var message = "Message has been sent to your Whatsapp on";
  //         showMessageSentDialog(message);
  //       } else {
  //         showErrorToast("Message has already been sent");
  //       }
  //     });
  //   }
  // }

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

// Future<void> _createItems(Messages newItems) async{
//    await _messageStatus?.add(newItems);
//    _refreshItems();
// }
//
// Map<String,dynamic> _readItem(String key){
//
//     final item = _messageStatus?.get(key);
//     return item;
// }
//
// Future<void> _updateItem(int key, Map<String,dynamic> item) async{
//   await _messageStatus?.put(key, item );
//   _refreshItems();
// }
//
// // Delete a single item
// Future<void> _deleteItem(int itemKey) async {
//   await _messageStatus?.delete(itemKey);
//   _refreshItems(); // update the UI
//
//   // Display a snackbar
//   ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('An item has been deleted')));
// }

// Future<http.Response> sendWhatsappMessage() {
//   var param = {'@VER': '1.2',
//     'USER': {'@USERNAME': 'vistafintransWA',
//       '@PASSWORD': 'u1Qx0ne7',
//       '@CH_TYPE': '4',
//       '@UNIXTIMESTAMP': ''},
//     'SMS': [{'@UDH': '0',
//       '@CODING': '1',
//       '@TEXT': 'Dear ${pref.userName}, Welcome to the Vistaar Family. As you had requested, attached please find your Welcome Kit that provides you all the information on your loan account no $lan availed from Vistaar. For further queries you can reach us at the respective branch or give us a Missed Call on 08030088494. Regards, Vistaar Finance.',
//       '@CAPTION': '',
//       '@TEMPLATEINFO': '4052439',
//       '@CONTENTTYPE': 'document/pdf',
//       '@TYPE': 'document',
//       '@MEDIADATA': '${Environment().config?.assetUrl}$file',
//       '@PROPERTY': '0',
//       '@MSGTYPE': '3',
//       '@ID': '23',
//       'ADDRESS':
//       [{'@FROM': '916366864440',
//         '@TO': '91${pref.userMobile}',
//         '@SEQ': '1',
//         '@TAG': 'some clientside random data'
//       }
//       ]
//     }
//     ]
//   };
//   return http.post(
//     Uri.parse('https://api.myvfirst.com/psms/servlet/psms.JsonEservice'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(param),
//
//   );
//
// }
