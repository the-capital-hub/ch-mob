import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityMeetingsController/community_meetings_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityPriorityDMsController/community_priority_dms_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class CommunityAskAQuestionScreen extends StatefulWidget {
  int index;
  CommunityAskAQuestionScreen({
    required this.index,
    super.key,
  });

  @override
  State<CommunityAskAQuestionScreen> createState() =>
      _CommunityBookAMeetingScreenState();
}

class _CommunityBookAMeetingScreenState
    extends State<CommunityAskAQuestionScreen> {
  CommunityPriorityDMsController communityPriorityDMs = Get.find();
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          appBar: HelperAppBar.appbarHelper(
            title: "Ask A Question",
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
                    controller: communityPriorityDMs.nameController,
                    lableText: "Name"),
                const SizedBox(height: 12),
                MyCustomTextField.textField(
                    hintText: "Enter Email",
                    controller: communityPriorityDMs.emailController,
                    lableText: "Email"),
                const SizedBox(height: 12),
                MyCustomTextField.textField(
                    hintText: "Enter Mobile Number",
                    controller: communityPriorityDMs.mobileController,
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
                          text: "Service:",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 12),
                        TextWidget(
                            text: communityPriorityDMs
                                .communityPriorityDMsList[widget.index].title!,
                            textSize: 13),
                        const SizedBox(height: 12),
                        const TextWidget(
                          text: "Description:",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 12),
                        HtmlWidget(
                          communityPriorityDMs
                              .communityPriorityDMsList[widget.index]
                              .description!,
                          textStyle:
                              TextStyle(fontSize: 13, color: AppColors.white),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: "Type",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: 8),
                                TextWidget(text: "PriorityDM", textSize: 13),
                              ],
                            ),
                            SizedBox(
                              width: 100,
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
                                TextWidget(
                                    text:
                                        "\u{20B9}${communityPriorityDMs.communityPriorityDMsList[widget.index].amount!}",
                                    textSize: 13),
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
                    onButtonPressed: () {
                      Get.back();
                    },
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
