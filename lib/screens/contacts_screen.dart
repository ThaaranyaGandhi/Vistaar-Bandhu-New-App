

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:vistaar_bandhu_new_version/util/adaptive_widgets.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

class ContactsScreen extends StatefulWidget {
  static const routeName = '/ContactsScreen';

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  bool permissionDenied = false;
  List<String?> contactName = [];
  List<String?> contactPhone = [];
  List<String> separateLabelArray = [];
  TextEditingController searchController = TextEditingController();
  List<Contact> originalContactsName = [];
  FocusNode searchFocusNode = new FocusNode();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 50)).then((value) async {
      getContactPermission();
    });
    super.initState();
  }

  void getContactPermission() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      List<Contact> listContacts = contacts.toList();
      originalContactsName = listContacts;
      contactName.clear();
      contactPhone.clear();
      separateLabelArray.clear();
      for (var item in originalContactsName) {
        if (item.phones.isNotEmpty) {
          var phone = item.phones.first.number;

          contactName.add(item.displayName);
          contactPhone.add(phone
              .replaceAll(".", "")
              .replaceAll("-", "")
              .replaceAll("+", "")
              .replaceAll(" ", "")
              .replaceAll("(", "")
              .replaceAll(")", "")
              .replaceAll("[", "")
              .replaceAll("]", ""));
        } else {
          showAdaptiveAlertDialog(
              context: context,
              title: "Contact service error",
              content: "Failed to get contacts",
              defaultActionText: "Ok");
        }
      }
    }
    setState(() {});
  }

  /// old permission
/*  void getContactPermission() async {
    var check = await Permission.contacts.request();
    if (check == PermissionStatus.granted) {
      Iterable<Contact> contacts = await FlutterContacts.getContacts();
      List<Contact> listContacts = contacts.toList();
      originalContactsName = listContacts;
      log('originalContactsName - ${originalContactsName.toString()}');
      contactName.clear();
      contactPhone.clear();
      separateLabelArray.clear();
      for (var item in originalContactsName) {
        if (item.phones != null && item.phones!.length > 0) {

          var phone = item.phones.first.number;
          log('phone - $phone');

          contactName.add(item.displayName);
          contactPhone.add(phone
              .replaceAll(".", "")
              .replaceAll("-", "")
              .replaceAll("+", "")
              .replaceAll(" ", "")
              .replaceAll("(", "")
              .replaceAll(")", "")
              .replaceAll("[", "")
              .replaceAll("]", ""));
        }
      }
    } else {
      showAdaptiveAlertDialog(
          context: context,
          title: "Contact service error",
          content: "Failed to get contacts",
          defaultActionText: "Ok");
    }
    setState(() {});
  }*/

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
            const Text(
              "Contacts",
              style: TextStyle(color: goldColor, fontSize: 18),
            ),
            const SizedBox(
              width: 40,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                height: 90,
                padding: const EdgeInsets.only(top: 10),
                child: buildSearchBar()),
            Expanded(
              child: ListView.builder(
                  itemCount: contactName.length,
                  itemBuilder: (ctx, index) {
                    return buildContact(
                        context, contactName[index], contactPhone[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Container buildSearchBar() {
    return Container(
        child: Stack(children: [
      Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: TextField(
          style: const TextStyle(fontSize: 14.0, color: Colors.black),
          onChanged: (text) {
            final filteredContacts = originalContactsName
                .where((contact) =>
                    contact.displayName != '' &&
                    contact.displayName
                        .toLowerCase()
                        .contains(text.toLowerCase()))
                .toList();
            contactName.clear();
            contactPhone.clear();
            separateLabelArray.clear();
            for (var item in filteredContacts) {
              if (item.phones.isNotEmpty) {
                contactName.add(item.displayName);
                // contactPhone.add(item.phones!.first.value!);
                contactPhone.add(item.phones.first.number
                    .replaceAll(".", "")
                    .replaceAll("-", "")
                    .replaceAll("+", "")
                    .replaceAll(" ", "")
                    .replaceAll("(", "")
                    .replaceAll(")", "")
                    .replaceAll("[", "")
                    .replaceAll("]", ""));
              }
            }
            setState(() {});
          },
          keyboardType: TextInputType.text,
          controller: searchController,
          decoration: new InputDecoration(
              hintText: 'Search by name',
              hintStyle:
                  const TextStyle(fontSize: 14.0, color: Color(0xff707070)),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff707070)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff707070)),
              ),
              suffixIcon: Container(
                width: 120,
                padding: const EdgeInsets.all(0),
                color: Colors.transparent,
                constraints: const BoxConstraints(
                  maxHeight: 0.0,
                  maxWidth: 0.0,
                ),
              )),
        ),
      ),
      (searchController.text == "")
          ? Container(height: 50, width: double.infinity)
          : Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              searchController.text = "";
                              final filteredContacts = originalContactsName
                                  .where((contact) =>
                                      contact.displayName != '' &&
                                      contact.displayName
                                          .toLowerCase()
                                          .contains(searchController.text
                                              .toLowerCase()))
                                  .toList();
                              contactName.clear();
                              contactPhone.clear();
                              separateLabelArray.clear();
                              for (var item in filteredContacts) {
                                if (item.phones.isNotEmpty) {
                                  contactName.add(item.displayName);
                                  // contactPhone.add(item.phones!.first.value!);
                                  contactPhone.add(item.phones.first.number
                                      .replaceAll(".", "")
                                      .replaceAll("-", "")
                                      .replaceAll("+", "")
                                      .replaceAll(" ", "")
                                      .replaceAll("(", "")
                                      .replaceAll(")", "")
                                      .replaceAll("[", "")
                                      .replaceAll("]", ""));
                                }
                              }
                              setState(() {});
                            },
                            child: Container(
                                padding: const EdgeInsets.all(15),
                                color: Colors.transparent,
                                constraints: const BoxConstraints(
                                  maxHeight: 10.0,
                                  maxWidth: 10.0,
                                ),
                                child: const Icon(Icons.cancel)))),
                  ))),
    ]));
  }

  addSeparateLabel(String name) {
    if (separateLabelArray.contains(name[0].toUpperCase()))
      return Container();
    else {
      separateLabelArray.add(name[0].toUpperCase());
      return Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        alignment: Alignment.centerLeft,
        child: Text(
          name[0].toUpperCase(),
          textAlign: TextAlign.left,
          style: const TextStyle(color: Color(0xff707070), fontSize: 12),
        ),
      );
    }
  }

  Widget buildContact(BuildContext context, String? name, String? phone) =>
      Column(
        children: [
          // if (name != null && name != "") addSeparateLabel(name),
          InkWell(
            onTap: () {
              checkAddValidation(name, phone);
              // selectContact(name, phone);
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 30, right: 30),
              margin: const EdgeInsets.only(bottom: 3),
              // color: Color(0xff38384A),
              child: Stack(children: <Widget>[
                Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text(
                      name != null && name != ""
                          ? convertInitialName(name)
                          : "N/A",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 60),
                  child: Text(
                    name != null && name != "" ? name : "N/A",
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ]),
            ),
          )
        ],
      );

  selectContact(name, phone) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, {"name": name, "phone": phone});
  }

  checkAddValidation(String? name, String? phone) {
    var pass = true;
    if (name == null || name.isEmpty) {
      pass = false;
      showErrorToast("Invalid name");
      return;
    }

    if (phone == null ||
        phone.isEmpty ||
        phone.length < 10 ||
        phone.length > 12) {
      pass = false;
      showErrorToast("Invalid phone number");
      return;
    }

    if (pass) {
      selectContact(name, phone);
    }
  }

  convertInitialName(name) {
    if (name.contains(" ") && name[0] != " ") {
      List<String> names = name.split(" ");
      String initials = "";
      int numWords = 1;

      if (numWords < names.length) numWords = names.length;
      for (var i = 0; i < numWords; i++) {
        try {
          if (initials.length <= 1) initials += names[i][0];
        } catch (e) {}
      }
      return initials;
    } else {
      if (name == null || name.isEmpty) {
        return "";
      } else {
        return name[0].toUpperCase();
      }
    }
  }
}
