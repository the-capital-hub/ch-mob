import 'dart:developer';
import 'dart:js_interop';

import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/spotlightController/spotlight_controller.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/imagePickerWidget/image_picker_widget.dart';
import '../../../widget/textwidget/text_widget.dart';
import 'termsNcondition_product_screen.dart';

class FundingStageSelectorScreen extends StatefulWidget {
  const FundingStageSelectorScreen({super.key});

  @override
  _FundingStageSelectorScreenState createState() =>
      _FundingStageSelectorScreenState();
}

class _FundingStageSelectorScreenState
    extends State<FundingStageSelectorScreen> {
  int selectedIndex = 0;

  final List<Map<String, String>> stages = [
    {
      'title': 'Idea Stage',
      'description':
          'Just starting out with a brilliant concept. Your product is in the ideation phase, and you\'re looking to validate your idea and gather initial feedback.',
      'icon': '💡',
    },
    {
      'title': 'Early Stage',
      'description':
          'You have an MVP or prototype ready. Your product is being tested with early users, and you\'re gathering valuable market feedback.',
      'icon': '🚀',
    },
    {
      'title': 'Growth Stage',
      'description':
          'Your product has proven market fit and is generating revenue. You\'re ready to scale operations and expand your market presence.',
      'icon': '📈',
    },
  ];
  TextEditingController panController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController pitchController = TextEditingController();
  final SpotlightController _spotlightController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Funding Stage"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             
                sizedTextfield,
                const TextWidget(
                  text: "Select the current stage of your startup",
                  color: Colors.grey,
                  textSize: 16,
                ),
                const SizedBox(height: 16),
                Column(
                  children: List.generate(stages.length, (index) {
                    final isSelected = index == selectedIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.3),
                              radius: 20,
                              child: TextWidget(
                                text: stages[index]['icon']!,
                                textSize: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: stages[index]['title']!,
                                    textSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(height: 4),
                                  TextWidget(
                                    text: stages[index]['description']!,
                                    color: Colors.white70,
                                    textSize: 12,
                                    maxLine: 10,
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              CircleAvatar(
                                  backgroundColor:
                                      AppColors.primary.withOpacity(0.2),
                                  radius: 15,
                                  child: const Icon(
                                    Icons.check,
                                    color: AppColors.primary,
                                    size: 20,
                                  )),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                if (selectedIndex == 1 || selectedIndex == 2)
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: AppColors.white38),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWidget(
                              text: "KYC Documents",
                              textSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                            const SizedBox(height: 8),
                            TextWidget(
                              text:
                                  "Please upload your KYC documents for verification (mandatory).",
                              color: AppColors.white54,
                              maxLine: 2,
                              textSize: 14,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TextWidget(
                                          text: "Aadhar Card *",
                                          textSize: 14,
                                          color: Colors.white),
                                      const SizedBox(height: 4),
                                      MyCustomTextField.textField(
                                          hintText: "Choose File",
                                          readonly: true,
                                          onTap: () {
                                            ImagePickerWidget()
                                                .getImage(false)
                                                .then((value) {
                                              if (value != null) {
                                                aadharController.text =
                                                    "File Selected ✅";
                                              }
                                              setState(() {});
                                            });
                                          },
                                          controller: aadharController),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TextWidget(
                                          text: "PAN Card *",
                                          textSize: 14,
                                          color: Colors.white),
                                      const SizedBox(height: 4),
                                      MyCustomTextField.textField(
                                          hintText: "Choose File",
                                          readonly: true,
                                          onTap: () {
                                            ImagePickerWidget()
                                                .getImage(false)
                                                .then((value) {
                                              if (value != null) {
                                                panController.text =
                                                    "File Selected ✅";
                                              }
                                              setState(() {});
                                            });
                                          },
                                          controller: panController),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: AppColors.white38),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWidget(
                              text: "Pitch Deck",
                              textSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                            const SizedBox(height: 8),
                            TextWidget(
                              text:
                                  "Please either upload your pitch deck or request a review (mandatory).",
                              color: AppColors.white54,
                              maxLine: 3,
                              textSize: 14,
                            ),
                            const SizedBox(height: 12),
                            TextWidget(
                                text: "Upload Pitch Deck",
                                textSize: 14,
                                color: AppColors.white),
                            const SizedBox(height: 4),
                            MyCustomTextField.textField(
                              hintText: "Choose File",
                              readonly: true,
                              onTap: () {
                                PdfPickerWidget().pickPdf().then((value) {
                                  if (value != null) {
                                    pitchController.text = "File Selected ✅";
                                  }
                                  setState(() {});
                                });
                              },
                              controller: pitchController,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Switch(
                                  value: false,
                                  onChanged: (val) {
                                    setState(() {});
                                  },
                                  activeColor: AppColors.primary,
                                ),
                                const SizedBox(width: 4),
                                const Expanded(
                                  child: TextWidget(
                                    text:
                                        "Help me build my pitchdeck (If you don't have a pitchdeck, tick the button to get help from our team.)",
                                    textSize: 12,
                                    maxLine: 5,
                                    color: Colors.white70,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ],
            ),
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
                      if (selectedIndex == 0) {
                        Get.to(() => const ProductTermsnconditionScreen());
                      } else {
                        final aadharUploaded = aadharController.text.isNotEmpty;
                        final panUploaded = panController.text.isNotEmpty;
                        final pitchUploaded = pitchController.text.isNotEmpty;
                        final isHelpEnabled =
                            _spotlightController.isLoading;

                        if (!aadharUploaded || !panUploaded) {
                          HelperSnackBar.snackBar(
                            "Error",
                            "Missing Documents",
                          );
                          return;
                        }

                        if (!pitchUploaded && !isHelpEnabled.value) {
                          HelperSnackBar.snackBar(
                            "Error",
                            "Upload your pitch deck or enable help from our team",
                          );
                          return;
                        }
                        Get.to(() => const ProductTermsnconditionScreen());
                      }
                    },
                    title: "Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
