import 'package:flutter/material.dart';

import '../multilanguage.dart';

enum DrawerMenuType {
  home,
  faq,
  about,
  // locateUs,
  // contactUs,
  logout
}

class DrawerMenuTypeHelper {
  static String getTitle(DrawerMenuType type, BuildContext context) {
    switch (type) {
      case DrawerMenuType.home:
        return MultiLanguage.of(context)!.translate('home'); //"Home";
      case DrawerMenuType.faq:
        return MultiLanguage.of(context)!.translate('faq'); //"FAQ";
      case DrawerMenuType.about:
        return MultiLanguage.of(context)!.translate('about_us'); //"About Us";
      // case DrawerMenuType.locateUs:
      //   return "Locate Us";
      // case DrawerMenuType.contactUs:
      //   return "Call Us";
      case DrawerMenuType.logout:
        return MultiLanguage.of(context)!.translate('logout'); //"Logout";
      default:
        return "";
    }
  }
}

enum PaymentType { payEMI, payDueAmount, payOtherAmount }

class PaymentTypeHelper {
  static String getTitle(PaymentType type, BuildContext context) {
    switch (type) {
      case PaymentType.payEMI:
        // return "Pay EMI";
        return MultiLanguage.of(context)!.translate("pay_emi");
      case PaymentType.payDueAmount:
        // return "Pay Due Amount";
        return MultiLanguage.of(context)!.translate("pay_due_amount");
      case PaymentType.payOtherAmount:
        // return "Pay Other Amount";
        return MultiLanguage.of(context)!.translate("pay_other_amount");
      default:
        return "";
    }
  }
}

enum LastLoanType {
  moreThan12Month,
  lessThan12Month,
}

class LastLoanTypeHelper {
  static String getTitle(LastLoanType type, BuildContext context) {
    switch (type) {
      case LastLoanType.moreThan12Month:
        return MultiLanguage.of(context)!.translate("more_than_12_months");
      case LastLoanType.lessThan12Month:
        return MultiLanguage.of(context)!.translate("less_than_12_months");
      default:
        return "";
    }
  }
}
