import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/textWidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/spotlightController/spotlight_controller.dart';
import '../../../utils/constant/app_var.dart';
import '../../../widget/appbar/appbar.dart';
import '../../../widget/buttons/button.dart';

class ProductTermsnconditionScreen extends StatefulWidget {
  const ProductTermsnconditionScreen({super.key});

  @override
  State<ProductTermsnconditionScreen> createState() =>
      _ProductTermsnconditionScreenState();
}

class _ProductTermsnconditionScreenState
    extends State<ProductTermsnconditionScreen> {
  bool isChecked = false;

  final String termsText = '''
By submitting your product to CapitalHub, you agree to the following terms and conditions:

1. Content Ownership: You confirm that you own or have the necessary rights to all content submitted, including images, text, and other materials.

2. Accuracy of Information: You warrant that all information provided about your product is accurate, truthful, and not misleading.

3. Intellectual Property: You retain ownership of your intellectual property, but grant CapitalHub a non-exclusive license to display and promote your product on the platform.

4. Community Guidelines: You agree to comply with CapitalHub's community guidelines and maintain professional conduct in all interactions.

5. Data Privacy: You acknowledge that your product information will be publicly visible and agree to the processing of your data in accordance with our privacy policy.

6. Updates and Modifications: You agree to keep your product information up to date and notify CapitalHub of any significant changes.

7. Termination: CapitalHub reserves the right to remove your product listing if it violates our terms or community guidelines.

8. Liability: You agree to indemnify CapitalHub against any claims arising from your product submission or content.

9. Changes to Terms: CapitalHub may modify these terms at any time, and continued use of the platform constitutes acceptance of modified terms.

10. Governing Law: These terms are governed by the laws of India, and any disputes shall be subject to the exclusive jurisdiction of the courts in Mumbai.
''';
  final SpotlightController _spotlightController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Terms & Conditions"),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
             
              sizedTextfield,
              TextWidget(
                text:
                    "Please review and accept the terms and conditions to submit your product.",
                color: AppColors.white54,
                maxLine: 2,
                textSize: 14,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Scrollbar(
                    thumbVisibility: true,
                    thickness: 4,
                    interactive: true,
                    radius: const Radius.circular(4),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextWidget(
                            text: termsText, maxLine: 1000, textSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
              sizedTextfield,
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (val) {
                      setState(() {
                        isChecked = val ?? false;
                      });
                    },
                    activeColor: AppColors.primary,
                    side: const BorderSide(color: Colors.white),
                    checkColor: Colors.black,
                  ),
                  const Expanded(
                    child: TextWidget(
                      text: "I have read and agree to the terms and conditions",
                      textSize: 14,
                      maxLine: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: AppButton.outlineButton(
                    onButtonPressed: () {
                      Get.back();
                    },
                    title: "Back"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      if (isChecked) {
                        Helper.loader(context);
                      } else {
                        HelperSnackBar.snackBar("Error",
                            "Please accept the terms and conditions to proceed.");
                      }
                    },
                    title: "Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
