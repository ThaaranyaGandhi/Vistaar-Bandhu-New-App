import 'package:flutter/cupertino.dart';
import 'package:vistaar_bandhu_new_version/environment.dart';

void appLogger(String? env, String message) {
  if (env == Environment.DEV) {
    // debugPrint(':::::::::: $message :::::::::: ', name: 'Log-R&R');
    debugPrint('$message');
  }
}

void appPrint(String? env, Object e) {
  if (env == Environment.DEV) {
    debugPrint("Error: $e");
  }
}
