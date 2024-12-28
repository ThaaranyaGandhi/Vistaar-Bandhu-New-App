import 'package:vistaar_bandhu_new_version/base/base_config.dart';

class ProdConfig implements BaseConfig {
  String get apiHost =>
      "https://los.vistaarfinance.net.in/pdglos/services/RSILServiceImplPort";

  String get apiProductivityBaseUrl =>
      "https://productivity.vistaarfinance.net.in:446/SVC_Lead.svc/";

  String get envParam => "PROD";

  bool get reportErrors => true;

  bool get trackEvents => true;

  bool get useHttps => true;

  String get razorPayKey => "rzp_live_wttpRiUPLjNEWp";

  String get razorPaySecretKey => "XfOfOV8WuWYsdCPpNDWOc77L";

  String get loanDetails => "https://los.vistaarfinance.net.in/";

  String get pvlBaseURL => "http://45.113.139.123:81/Svc_PVLVVL.svc/";
  String get assetUrl =>
      "https://productivity.vistaarfinance.net.in:446/WelcomeKit/";
  String get assetDocumentUrl =>
      "http://productivity.vistaarfinance.net.in:98/";
  // String get assetUrl => "https://productivity.vistaarfinance.net.in:446/GetWelcomeKitByLan/";
  String get apiProductivityBaseUrlNew =>
      "https://productivity.vistaarfinance.net.in:469/VisAPIs.svc/";
  String get apiGetLoanAgreementDocument =>
      "https://workflow.vistaarfinance.net.in/KareDocsAPI/api/get";
}
