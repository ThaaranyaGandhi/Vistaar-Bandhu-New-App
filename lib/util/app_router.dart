import 'package:flutter/material.dart';
import 'package:vistaar_bandhu_new_version/screens/contacts_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/home_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/loanAgreementForm/loan_agreement_form.dart';
//import 'package:vistaar_bandhu_new_version/screens/loanAgreementForm/loan_agreement_form_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/loans/loan_details_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/loans/loan_future_installment_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/loans/loan_payment_list_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/loans/loan_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/loans/loan_status_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/policyScreen/insurance_policy_document_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/request/payment_option.dart';
import 'package:vistaar_bandhu_new_version/screens/request/upi_payment_details.dart';
import 'package:vistaar_bandhu_new_version/screens/welcomeKit/welcomeKitScreen.dart';
import 'package:vistaar_bandhu_new_version/screens/login/login_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/login/otp_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/menuDrawer/about_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/menuDrawer/faq_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/payEmi/pay_emi_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/pvl/pvl_offer_list.dart';
import 'package:vistaar_bandhu_new_version/screens/query_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/refer_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/request/deActivate_nach_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/request/eMandate_request.dart';
import 'package:vistaar_bandhu_new_version/screens/request/emandate_details_screen_customer_id.dart';
import 'package:vistaar_bandhu_new_version/screens/request/forceClosure_request_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/request/nach_detail_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/request/request_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/request/soa_request.dart';
import 'package:vistaar_bandhu_new_version/screens/topup_screen.dart';
import 'package:vistaar_bandhu_new_version/screens/welcomeKit/welcomeKitList.dart';

import '../screens/loanAgreementForm/loanAgreementFormList.dart';
import '../screens/policyScreen/policy_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        {
          return MaterialPageRoute(
              builder: (_) => HomeScreen(),
              settings: settings,
              maintainState: false);
        }
      case OtpVerificationScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => OtpVerificationScreen(),
            settings: settings,
          );
        }
      case AboutScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => AboutScreen(),
            settings: settings,
          );
        }
      case LoanListScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => LoanListScreen(
              loanList: [],
            ),
            settings: settings,
          );
        }
      case LoanDetailScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => LoanDetailScreen(),
            settings: settings,
          );
        }
      case LoanStatusScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => LoanStatusScreen(),
            settings: settings,
          );
        }
      case QueryScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => QueryScreen(),
            settings: settings,
          );
        }
      case ReferScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => ReferScreen(),
            settings: settings,
          );
        }
      case ContactsScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => ContactsScreen(),
            settings: settings,
          );
        }
      case FAQScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => FAQScreen(),
            settings: settings,
          );
        }
      case TopUpScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => TopUpScreen(),
            settings: settings,
          );
        }
      case PayEMIScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => PayEMIScreen(),
            settings: settings,
          );
        }
      case RequestScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => RequestScreen(),
            settings: settings,
          );
        }
      case SOARequestScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => SOARequestScreen(),
            settings: settings,
          );
        }
      case ForceClosureRequestScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => ForceClosureRequestScreen(),
            settings: settings,
          );
        }
      case DeActivateNACHScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => DeActivateNACHScreen(),
            settings: settings,
          );
        }
      case NACHDetailsScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => NACHDetailsScreen(),
            settings: settings,
          );
        }
      case PvlListScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => PvlListScreen(
              listPvlOffers: [],
            ),
            settings: settings,
          );
        }
      case EmandateScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => EmandateScreen(),
            settings: settings,
          );
        }
      case PaymentOptionalScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => PaymentOptionalScreen(),
            settings: settings,
          );
        }
      case UPIDetails.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => UPIDetails(),
            settings: settings,
          );
        }
      case EmandateDetails.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => EmandateDetails(),
            settings: settings,
          );
        }
      case WelcomeKitScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => WelcomeKitScreen(),
            settings: settings,
          );
        }
      case WelcomeKitList.routeName:
        {
          return MaterialPageRoute(
              builder: (_) => WelcomeKitList(), settings: settings);
        }
      case LoanFutureInstallmentListScreen.routeName:
        {
          return MaterialPageRoute(
              builder: (_) => LoanFutureInstallmentListScreen(),
              settings: settings);
        }
      case LoanPaymentListScreen.routeName:
        {
          return MaterialPageRoute(
              builder: (_) => LoanPaymentListScreen(), settings: settings);
        }
      case InsurancePolicyScreen.routeName:
        {
          return MaterialPageRoute(
              builder: (_) => InsurancePolicyScreen(), settings: settings);
        }
      case InsurancePolicyDocumentScreen.routeName:
        {
          return MaterialPageRoute(
              builder: (_) => InsurancePolicyDocumentScreen(),
              settings: settings);
        }
      case LoanAgreementForm.routeName:
        {
          return MaterialPageRoute(
              builder: (_) => LoanAgreementForm(), settings: settings);
        }
      case LoanAgreementFormScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (_) => LoanAgreementFormScreen(),
            settings: settings,
          );
        }
      default:
        {
          return MaterialPageRoute(
            builder: (_) => LoginScreen(),
            settings: settings,
          );
        }
    }
  }
}
