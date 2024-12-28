import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vistaar_bandhu_new_version/multilanguage.dart';
import 'package:vistaar_bandhu_new_version/util/colors.dart';

class FAQScreen extends StatelessWidget {
  static const routeName = '/FAQScreen';

  @override
  Widget build(BuildContext context) {
    MultiLanguage multiLanguage = MultiLanguage.of(context)!;
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
            Flexible(
              child: Text(
                multiLanguage.translate("faq"), // "FAQ",
                style: const TextStyle(color: goldColor, fontSize: 18),
                overflow: TextOverflow.fade,
              ),
            ),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // buildQuestions("Q1. How to apply for additional loan?",
                //     "Please go to Top-up loan tab."),
                buildQuestions(
                    "Q1. ${multiLanguage.translate("faq_apply_additonal_loan")}?",
                    multiLanguage.translate("faq_apply_additonal_loan_answer")),

                // buildQuestions("Q2. What are the bounce charges?",
                //     "The bounce charges for loan amount up to 10 lakhs is Rs.500 and for loan amounts greater than 10 lakhs is Rs. 750 "),
                buildQuestions(
                    "Q2. ${multiLanguage.translate("faq_bounce_charges")}?",
                    multiLanguage.translate("faq_bounce_charges_answer")),

                // buildQuestions("Q3. What is the field collection charge?",
                //     "Field collection charge is Rs.250"),
                buildQuestions(
                    "Q3. ${multiLanguage.translate("faq_field_collection_charge")}?",
                    multiLanguage
                        .translate("faq_field_collection_charge_answer")),

                // buildQuestions("Q4. What is the EMI payment date?",
                //     "EMI gets deducted through NACH from your account on 5 th of every month. Please ensure to maintain sufficient balance to avoid bounce charges."),
                buildQuestions(
                    "Q4. ${multiLanguage.translate("faq_emi_payment_date")}?",
                    multiLanguage.translate("faq_emi_payment_date_answer")),
                buildQuestions(
                    "Q5. ${multiLanguage.translate("faq_branch_working_hours")}?",
                    multiLanguage.translate("faq_branch_working_hours_answer"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildQuestions(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: primaryColor),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const SizedBox(
              width: 35,
            ),
            Expanded(
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
