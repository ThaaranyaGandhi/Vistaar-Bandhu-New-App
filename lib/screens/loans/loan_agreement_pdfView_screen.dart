import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vistaar_bandhu_new_version/base/base_page.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

class LoanAgreementPdfViewScreen extends BasePage {
  static const routeName = '/LoanAgreementPdfViewScreen';

  @override
  LoanAgreementPdfViewScreenState createState() =>
      LoanAgreementPdfViewScreenState();
}

class LoanAgreementPdfViewScreenState
    extends BaseState<LoanAgreementPdfViewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController lottieController;
  String? file = "";
  String? documentName = "";
  String? bank = "";
  int index = 0;
 // PDFDocument? document;
  bool _isLoading = true;
  bool _shouldIgnore = true;
  late String pdfFilePath;

  @override
  void initState() {
    super.initState();
    // _openBox();
    final data = Get.arguments;

    // if(pref.messageSent.isEmpty){
    //   setState(() {
    //     _shouldIgnore = true;
    //   });
    // }

    // }
    // file = "${Environment().config?.assetDocumentUrl}$bank/$documentName";
    file = data;
    // var file =
    //     "${Environment().config?.assetUrl}LSS_Schedule_0143SBML00610.pdf";
   //  createPdf(file!);
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

  Future<void> loadDocument(String doc) async {
    try {
      // Decode the base64 string and save it to a temporary file
      var bytes = base64Decode(doc.replaceAll('\n', ''));
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/agreement.pdf");
      await file.writeAsBytes(bytes);

      setState(() {
        pdfFilePath = file.path;
        _isLoading = false;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading document: $e");
    }
  }



/*
  loadDocument(String doc) async {
    // // document = await PDFDocument.fromURL(file);
    // document = await PDFDocument.fromAsset(file);
    // showWelcomeDialog();
    // setState(() => _isLoading = false);

    var bytes = base64Decode(doc.replaceAll('\n', ''));
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/agreement.pdf");
    await file.writeAsBytes(bytes.buffer.asUint8List());

    print("${output.path}/agreement.pdf");
    // await OpenFile.open("${output.path}/example.pdf");
    document = await PDFDocument.fromFile(file);
    // showWelcomeDialog();
    LinearProgressIndicator();
    setState(() => _isLoading = false);
    setState(() {});
  }
*/


/*   createPdf(String doc) async {
    var bytes = base64Decode(doc.replaceAll('\n', ''));
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/agreement.pdf");
    await file.writeAsBytes(bytes.buffer.asUint8List());

    print("${output.path}/agreement.pdf");
    // await OpenFile.open("${output.path}/example.pdf");
    document = await PDFDocument.fromFile(file);
    showWelcomeDialog();
    setState(() => _isLoading = false);
    setState(() {});
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
                      const Expanded(
                        child: Text(
                          "Loan application form",
                          style: TextStyle(color: goldColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              //TODO: To be implemented

              // IconButton(
              //     icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
              //     iconSize: 30,
              //     color: Colors.green,
              //     onPressed: _shouldIgnore == true
              //         ? () {
              //             setState(() {
              //               // sendWhatsappMessages();
              //             });

              //             Timer(Duration(hours: 24), () {
              //               setState(() {
              //                 _shouldIgnore = true;
              //               });
              //             });
              //           }
              //         : null)
              // onPressed:() => sendWhatsappMessages(),
            ],
          ),
        ),
        body: Container(
            child: _isLoading
                ? Container()
                : PDFView(
              filePath: pdfFilePath,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageSnap: true,
                  )));
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
                const Center(
                  child: Text(
                    "Welcome!",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 21),
              ],
            ),
          ));

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
}
