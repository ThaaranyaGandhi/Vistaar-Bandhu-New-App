import 'dart:io';
// import 'package:device_info/device_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:package_info/package_info.dart';

class AppHelper {
  static AppHelper? _instance;
  static AndroidDeviceInfo? _androidInfo;
  static IosDeviceInfo? _iosInfo;
  static PackageInfo? packageInfo;

  static Future<AppHelper> getInstance() async {
    if (_instance == null) {
      _instance = AppHelper();
    }
    if (Platform.isAndroid) {
      _androidInfo = await DeviceInfoPlugin().androidInfo;
    } else if (Platform.isIOS) {
      _iosInfo = await DeviceInfoPlugin().iosInfo;
    }
    packageInfo = await PackageInfo.fromPlatform();
    return _instance!;
  }

  String getDevicePlatform() {
    if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'iOS';
    }
    return '';
  }

  String getDeviceModel() {
    if (Platform.isAndroid && _androidInfo != null) {
      final String manufacturer = _androidInfo!.manufacturer;
      final String model = _androidInfo!.model;
      return '$manufacturer $model';
    } else if (Platform.isIOS && _iosInfo != null) {
      final String name = _iosInfo!.utsname.machine;
      return '$name';
    }
    return '';
  }

  String getOSVersionNumber() {
    if (Platform.isAndroid && _androidInfo != null) {
      final String manufacturer = _androidInfo!.manufacturer;
      return "${_androidInfo!.version.sdkInt}";
    } else if (Platform.isIOS && _iosInfo != null) {
      return _iosInfo!.systemVersion;
    }
    return '';
  }

  String getVersionNumber() {
    if (packageInfo != null) {
      return packageInfo!.version;
    }
    return '';
  }

  String getBuildNumber() {
    if (packageInfo != null) {
      return packageInfo!.buildNumber;
    }
    return '';
  }

  String getSystemLanguage() {
    return Platform.localeName;
  }

  String getDeviceID() {
    if (Platform.isAndroid && _androidInfo != null) {
      return _androidInfo!.id;
      // return _androidInfo!.androidId;
    } else if (Platform.isIOS && _iosInfo != null) {
      return _iosInfo!.identifierForVendor!;
      // return _iosInfo!.identifierForVendor;
    }
    return '';
  }

  bool isTablet(BuildContext context) {
    if (Platform.isIOS) {
      return _iosInfo!.model.toLowerCase() == "ipad";
    } else {
      // The equivalent of the "smallestWidth" qualifier on Android.
      var shortestSide = MediaQuery.of(context).size.shortestSide;
      // Determine if we should use mobile layout or not, 600 here is
      // a common breakpoint for a typical 7-inch tablet.
      return shortestSide > 600;
    }
  }

  String getDateTime(String dateString) {
    // Extract timestamp and time zone offset from string
    int timestamp = int.parse(dateString.substring(6, 19));
    int hoursOffset = int.parse(dateString.substring(19, 22));
    int minutesOffset = int.parse(dateString.substring(22, 24));

    // Create DateTime object with timestamp and offset
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true)
        .add(Duration(hours: hoursOffset, minutes: minutesOffset));

    // Format the DateTime object using DateFormat
    String formattedDate = DateFormat('MMM dd, yyyy').format(date);
    return formattedDate;
  }

  String getCurrencyFormat(double amount) {
    NumberFormat format = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    String formattedAmount = format.format(amount);
    return formattedAmount;
  }
}
