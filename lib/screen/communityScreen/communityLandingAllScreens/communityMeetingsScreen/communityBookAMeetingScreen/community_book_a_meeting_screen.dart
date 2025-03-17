import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class CommunityBookAMeetingScreen extends StatefulWidget {
  const CommunityBookAMeetingScreen({super.key});

  @override
  State<CommunityBookAMeetingScreen> createState() =>
      _CommunityBookAMeetingScreenState();
}

class _CommunityBookAMeetingScreenState
    extends State<CommunityBookAMeetingScreen> {
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          appBar: HelperAppBar.appbarHelper(
            title: "Book a Meeting",
            hideBack: false,
            autoAction: true,
          ),
          backgroundColor: AppColors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
              child: Column(children: [
                const TextWidget(
                  text:
                      "Please fill these details for purchase confirmation and further communication.",
                  textSize: 13,
                  maxLine: 2,
                  align: TextAlign.center,
                ),
                const SizedBox(height: 12),
                MyCustomTextField.textField(
                    hintText: "Enter Name",
                    controller: urlController,
                    lableText: "Name"),
                const SizedBox(height: 12),
                MyCustomTextField.textField(
                    hintText: "Enter Email",
                    controller: urlController,
                    lableText: "Email"),
                const SizedBox(height: 12),
                MyCustomTextField.textField(
                    hintText: "Enter Mobile Number",
                    controller: urlController,
                    lableText: "Mobile Number"),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                Card(
                  margin: EdgeInsets.zero,
                  color: AppColors.blackCard,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                          text: "Details",
                          textSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 12),
                        const TextWidget(
                          text: "Meeting:",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 12),
                        const TextWidget(text: "title", textSize: 13),
                        const SizedBox(height: 12),
                        const TextWidget(
                          text: "Description:",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 12),
                        HtmlWidget(
                          "Description",
                          textStyle:
                              TextStyle(fontSize: 13, color: AppColors.white),
                        ),
                        const SizedBox(height: 12),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: "Selected Slot",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: 8),
                                TextWidget(
                                    text:
                                        "Friday, March 14, 2024\n09:00 - 09:30",
                                    textSize: 13),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: "Duration",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: 8),
                                TextWidget(text: "30 minutes", textSize: 13),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: "Price",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: 8),
                                TextWidget(text: "\u{20B9}300/-", textSize: 13),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: AppButton.outlineButton(
                    borderColor: AppColors.primary,
                    onButtonPressed: () {},
                    title: "Cancel"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {}, title: "Proceed to Payment"),
              ),
            ]),
          ),
        ));
  }
}
