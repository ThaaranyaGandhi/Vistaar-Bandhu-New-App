import 'package:vistaar_bandhu_new_version/environment.dart';

// const API_LOGIN =
//     "https://traininglos.vistaarfinance.net.in/pdglos/services/RSILServiceImplPort";
final apiLogin = Environment().config?.apiHost;
// const API_LOGIN_LIVE= "https://los.vistaarfinance.net.in/pdglos/services/RSILServiceImplPort";
final API_OTP = '${Environment().config?.apiProductivityBaseUrl}SendSMS';
// 'https://productivity.vistaarfinance.net.in:446/SVC_Lead.svc/SendSMS';
final apiLoanDetails =
    '${Environment().config?.loanDetails}pdglos/services/popSearchService';

//String get apiProductivityBaseUrl => "https://productivity.vistaarfinance.net.in:446/SVC_Lead.svc/";
final String apiReferFriends =
    "${Environment().config?.apiProductivityBaseUrl}AddCustomerFriendRefers";

final String appKeyMapping =
    "${Environment().config?.apiProductivityBaseUrl}AddAppKeyMapping";

final String apiTopUpLoans =
    "${Environment().config?.apiProductivityBaseUrl}AddCustomerTopUpRequest";

final String apiGetReceipt =
    "${Environment().config?.apiProductivityBaseUrl}GenerateVisReceipt";

final String apiAddCustomerPaymentInformation =
    "${Environment().config?.apiProductivityBaseUrl}AddCustomerPayment";
// const String API_INSERT_PAYMENT_DETAILS_UAT = "http://productivity.vistaarfinance.net.in:98/SVC_Lead.svc/AddCustomerPayment";

final String apiUpdateCustomerPaymentDetails =
    "${Environment().config?.apiProductivityBaseUrl}UpdateCustomerPayment";
//
// const String API_UPDATE_PAYMENT_DETAILS =
//     "https://productivity.vistaarfinance.net.in:446/SVC_Lead.svc/UpdateCustomerPayment";

const String API_RAZOR_PAY_ORDER = "https://api.razorpay.com/v1/orders";

final String apiSOARequest =
    "${Environment().config?.apiProductivityBaseUrl}AddCustomerRequest";

final String apiDeactivateNACH =
    "${Environment().config?.apiProductivityBaseUrl}NachCancelRequest";
// const String API_DE_ACTIVATE_NACH_LIVE ="https://productivity.vistaarfinance.net.in:446/SVC_Lead.svc/GetNACHRegisteredLanList";
final String apiGetNATCHdetails =
    "${Environment().config?.apiProductivityBaseUrl}GetNACHRegisteredLanList";

const API_UPLOAD_IMAGE = "";

const API_TOKEN = "0xH0xH01U01S0x01N";

// const RAZOR_PAY_UAT_KEY = "rzp_test_OYjmMLmTTjvvkb";
// const RAZOR_PAY_UAT_SECRET = "AmbE6P2IgryNGQ3bABMSDHms";
final razorpayKey = Environment().config?.razorPayKey;
final razorpaySecretKey = Environment().config?.razorPaySecretKey;
//
// const RAZOR_PAY_LIVE_KEY = "rzp_live_wttpRiUPLjNEWp";
// const RAZOR_PAY_LIVE_SECRET = "XfOfOV8WuWYsdCPpNDWOc77L";

final apiGetPVLOffers = "${Environment().config?.pvlBaseURL}GetPVLVVLOffers";
// const GET_PVL_VVL_OFFERS_LIVE = "http://45.113.139.123:81/Svc_PVLVVL.svc/GetPVLVVLOffers";
final apiUpdatePVLConsent =
    "${Environment().config?.pvlBaseURL}UpdateCustomerConsent";
// const PVL_UPDATE_CONSENT_LIVE = "http://45.113.139.123:81/Svc_PVLVVL.svc/UpdateCustomerConsent";
// const GET_ENACH_DETAILS_LIVE = "https://productivity.vistaarfinance.net.in:446/SVC_Lead.svc/GetBankDetailsByLan";
// const GET_ENACH_STATUS_LIVE = "https://productivity.vistaarfinance.net.in:446/SVC_Lead.svc/GetENachDetailsByLan";

final apiGetENachDetails =
    "${Environment().config?.apiProductivityBaseUrl}GetBankDetailsByLan";
final apiGetEnachStatus =
    "${Environment().config?.apiProductivityBaseUrl}GetENachDetailsByLan";

final apiGetWelcomekit =
    "${Environment().config?.apiProductivityBaseUrl}FetchWelcomeKitLan";

const razorPayEmandateApi =
    "https://api.razorpay.com/v1/subscription_registration/auth_links";
const razorPayCreateCustomerApi = "https://api.razorpay.com/v1/customers";
const razorPayCreateOrderApi = "https://api.razorpay.com/v1/orders";

const whatsappUrl = "https://api.myvfirst.com/psms/servlet/psms.JsonEservice";
final apiGetFuturePayment =
    "${Environment().config?.apiProductivityBaseUrl}GetFuturePaymentList";
final apiGetPaymentList =
    "${Environment().config?.apiProductivityBaseUrl}GetPaymentList";
final apiGetInsurance =
    "${Environment().config?.apiProductivityBaseUrl}FetchDocumentByLan";
final apiGetLotexUpdatedLeadIdByLan =
    "${Environment().config?.apiProductivityBaseUrlNew}GetLotexUpdatedLeadIdByLan";
final apiGetLoanAgreementDocumentAuth =
    "${Environment().config?.apiGetLoanAgreementDocument}";
