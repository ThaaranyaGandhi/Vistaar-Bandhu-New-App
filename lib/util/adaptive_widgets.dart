import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';

import 'colors.dart';

Widget adaptiveSwitch(bool value, Function onChange) {
  if (Platform.isIOS) {
    return CupertinoSwitch(
        activeColor: primaryColor,
        value: value,
        onChanged: (value) {
          onChange();
        });
  }
  return Switch(
    activeColor: primaryColor,
    value: value,
    onChanged: (value) {
      onChange();
    },
  );
}

Future showAdaptiveAlertDialog(
    {required BuildContext context,
    required String title,
    required String content,
    String? cancelActionText,
    required String defaultActionText,
    Function? defaultAction,
    Function? cancelAction,
    Color? defaultActionColor}) async {
  if (!Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (cancelActionText != null)
            TextButton(
              child: Text(cancelActionText),
              onPressed: () {
                Navigator.of(context).pop(false);
                if (cancelAction != null) cancelAction();
              },
            ),
          TextButton(
            child: Text(defaultActionText),
            onPressed: () {
              Navigator.of(context).pop(false);
              if (defaultAction != null) defaultAction();
            },
          ),
        ],
      ),
    );
  }

  // showDialog for ios
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      insetAnimationCurve: Curves.easeInOut,
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(cancelActionText),
            onPressed: () {
              Navigator.of(context).pop(false);
              if (cancelAction != null) cancelAction();
            },
          ),
        CupertinoDialogAction(
          textStyle: defaultActionColor != null
              ? TextStyle(color: Colors.red)
              : TextStyle(),
          isDefaultAction: true,
          child: Text(defaultActionText),
          onPressed: () {
            Navigator.of(context).pop(false);
            if (defaultAction != null) defaultAction();
          },
        ),
      ],
    ),
  );
}

showLoadingDialog({String hint = "", required BuildContext context}) {
  AlertDialog alert = AlertDialog(
    content: Container(
      // height: 80,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Platform.isAndroid
              ? const CircularProgressIndicator()
              : const CupertinoActivityIndicator(
                  radius: 15,
                ),
          Container(
              margin: EdgeInsets.all(5.0),
              child: hint != ""
                  ? Text(hint)
                  : Text(MultiLanguage.of(context)!.translate("loading"))),
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    // context: SizeConfig.cxt!,
    context: context, //added
    builder: (BuildContext context) {
      return WillPopScope(onWillPop: () => Future.value(false), child: alert);
    },
  );
}

showProgressDialog(
    {required BuildContext context,
    String hint = "",
    required double percent}) {
  AlertDialog alert = AlertDialog(
    content: Container(
      height: 100,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            value: percent,
            backgroundColor: Colors.grey,
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
          Container(
              margin: EdgeInsets.all(10.0),
              child: hint != "" ? Text(hint) : Text('Loading')),
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(onWillPop: () => Future.value(false), child: alert);
    },
  );
}
