import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistaar_bandhu_new_version/util/size_config.dart';

showErrorToast(String message, {Color color = Colors.red}) {
  if (message.isNotEmpty)
    ScaffoldMessenger.of(SizeConfig.cxt!).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  // Get.snackbar('Vistaar', message,
  //     backgroundColor: color, colorText: Colors.white);
}

showSuccessToast(String message, {Color color = Colors.green}) {
  if (message.isNotEmpty)
    ScaffoldMessenger.of(SizeConfig.cxt!).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  // Get.snackbar('Vistaar', message,
  //     backgroundColor: color, colorText: Colors.white);
}
