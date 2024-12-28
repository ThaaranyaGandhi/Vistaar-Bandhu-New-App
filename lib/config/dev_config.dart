import 'package:vistaar_bandhu_new_version/base/base_config.dart';

class DevConfig implements BaseConfig {
  String get apiHost =>
      //  "https://uatlos.vistaarfinance.net.in/pdglos/services/RSILServiceImplPort";

      //TODO: THIS IS PROD API USED IN UAT FOR LOGIN
      "https://los.vistaarfinance.net.in/pdglos/services/RSILServiceImplPort";

  //FIXME: Training los changed to uatlos due to Server issue.
  // String get apiHost =>
  //     "https://traininglos.vistaarfinance.net.in/pdglos/services/RSILServiceImplPort";

  String get apiProductivityBaseUrl =>
      "http://productivity.vistaarfinance.net.in:98/SVC_Lead.svc/";
  // String get apiProductivityBaseUrl => "http://10.1.7.44:98/SVC_Lead.svc/";
/*  String get apiProductivityBaseUrl => "http://192.168.133.13:98/SVC_Lead.svc/";*/

  bool get reportErrors => true;

  bool get trackEvents => false;

  bool get useHttps => false;

  String get envParam => "UAT";

  /// Live key using for UAT, UPI payments only working in live keys
  String get razorPayKey => "rzp_live_wttpRiUPLjNEWp";
  String get razorPaySecretKey => "XfOfOV8WuWYsdCPpNDWOc77L";

  /// Testing key, UIP payment is not working in testing keys
  // String get razorPayKey => "rzp_test_OYjmMLmTTjvvkb";
  // String get razorPaySecretKey => "AmbE6P2IgryNGQ3bABMSDHms";

  // String get loanDetails => "https://uatlos.vistaarfinance.net.in/";

  //TODO: THIS IS PROD API USED IN UAT FOR FETCHING LOANS

  // String get loanDetails => "https://traininglos.vistaarfinance.net.in/";
  //FIXME: Training los changed to uatlos due to Server issue.
  String get loanDetails => "https://los.vistaarfinance.net.in/";

  String get pvlBaseURL => "http://45.113.139.123:88/Svc_PVLVVL.svc/";

  String get assetUrl =>
      "http://productivity.vistaarfinance.net.in:98/WelcomeKit/";
  // String get assetUrl => "http://10.1.7.44:98/WelcomeKit/";
  String get assetDocumentUrl =>
      "http://productivity.vistaarfinance.net.in:98/";
  // String get assetDocumentUrl => "http://10.1.7.44:98/";

  String get apiProductivityBaseUrlNew =>
      "https://productivity.vistaarfinance.net.in:469/VisAPIs.svc/";
  String get apiGetLoanAgreementDocument =>
      "https://workflow.vistaarfinance.net.in/KareDocsAPI/api/get";
}
