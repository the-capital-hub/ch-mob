import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityPriorityDMsController/community_priority_dms_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';

import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddServiceScreen/community_add_service_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPriorityDMsScreen/communityQuestionsScreen/community_questions_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPriorityDMsScreen/communityYourQuestionsScreen/community_your_questions_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/custom_dialogue.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class CommunityPriorityDMsScreen extends StatefulWidget {
  const CommunityPriorityDMsScreen({super.key});

  @override
  State<CommunityPriorityDMsScreen> createState() =>
      _CommunityPriorityDMScreenState();
}

class _CommunityPriorityDMScreenState
    extends State<CommunityPriorityDMsScreen> {
  CommunityPriorityDMsController communityPriorityDMs =
      Get.put(CommunityPriorityDMsController());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      communityPriorityDMs.getCommunityPriorityDMs().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  bool isQuestionFieldVisible = false;
  bool noQuestions = true;
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(() => communityPriorityDMs.isLoading.value
        ? Helper.pageLoading()
        : communityPriorityDMs.communityPriorityDMsList.isEmpty
            ? const Center(
                child:
                    TextWidget(text: "No PriorityDMs Available", textSize: 16))
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: communityPriorityDMs.communityPriorityDMsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: AppColors.navyBlue,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text:
                                    "${communityPriorityDMs.communityPriorityDMsList[index].title}",
                                textSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.mobile_screen_share_rounded,
                                  color: AppColors.white,
                                ),
                                onPressed: () {
                                  sharePostPopup(
                                      context, "", "share priorityDMs detail");
                                },
                              )
                            ],
                          ),
                          sizedTextfield,
                          HtmlWidget(
                            "${communityPriorityDMs.communityPriorityDMsList[index].description}",
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: AppColors.white,
                            ),
                          ),
                          sizedTextfield,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                  text:
                                      "Response Time: ${communityPriorityDMs.communityPriorityDMsList[index].timeline}",
                                  textSize: 16),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: AppColors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextWidget(
                                    text: communityPriorityDMs
                                                .communityPriorityDMsList[index]
                                                .amount ==
                                            0
                                        ? "Free"
                                        : "\u{20B9} ${communityPriorityDMs.communityPriorityDMsList[index].amount}",
                                    textSize: 10,
                                    color: AppColors.primary,
                                  ),
                                ),
                              )
                            ],
                          ),
                          sizedTextfield,
                          if (communityPriorityDMs
                              .communityPriorityDMsList[index]
                              .topics!
                              .isNotEmpty)
                            Wrap(
                              spacing: 4.0,
                              runSpacing: 4.0,
                              children: List.generate(
                                  communityPriorityDMs
                                      .communityPriorityDMsList[index]
                                      .topics!
                                      .length, (innerIndex) {
                                return InkWell(
                                  onTap: () {},
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    color: AppColors.white12,
                                    surfaceTintColor: AppColors.white12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      child: TextWidget(
                                          text: communityPriorityDMs
                                              .communityPriorityDMsList[index]
                                              .topics![innerIndex],
                                          textSize: 14),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          const SizedBox(
                            height: 15,
                          ),
                          if (isAdmin)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AppButton.primaryButton(
                                    onButtonPressed: () {
                                      Get.to(() => CommunityQuestionsScreen(
                                          index: index));
                                    },
                                    title: "View Questions",
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                IconButton(
                                    onPressed: () {
                                      addServiceIndex = 0;

                                      Get.to(() => CommunityAddServiceScreen(
                                          isEdit: true,
                                          index: index,
                                          isPriorityDM: true,
                                          isMeeting: false,
                                          isEvent: false,
                                          isWebinar: false,
                                          priorityDMId: communityPriorityDMs
                                              .communityPriorityDMsList[index]
                                              .id
                                              .toString()));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: AppColors.white,
                                    )),
                                const SizedBox(width: 8),
                                IconButton(
                                    onPressed: () {
                                      showCustomPopup(
                                        context: context,
                                        title: "Delete this Priority DM",
                                        message:
                                            "Are you sure you\nwant to delete this Priority DM?",
                                        button1Text: "Cancel",
                                        button2Text: "OK",
                                        icon: Icons.delete,
                                        onButton1Pressed: () {
                                          Get.back();
                                        },
                                        onButton2Pressed: () {
                                          communityPriorityDMs
                                              .deleteCommunityPriorityDM(
                                                  communityPriorityDMs
                                                      .communityPriorityDMsList[
                                                          index]
                                                      .id
                                                      .toString());
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.white,
                                    )),
                              ],
                            ),
                          if (!isAdmin)
                            if (noQuestions)
                              Column(
                                children: [
                                  AppButton.primaryButton(
                                    onButtonPressed: () {
                                      setState(() {
                                        isQuestionFieldVisible =
                                            !isQuestionFieldVisible;
                                      });
                                    },
                                    title: "Ask Question",
                                  ),
                                  if (isQuestionFieldVisible) ...[
                                    sizedTextfield,
                                    MyCustomTextField.textField(
                                      hintText: "Type your question here...",
                                      controller: urlController,
                                      maxLine: 3,
                                      borderClr: AppColors.white12,
                                    ),
                                    sizedTextfield,
                                    AppButton.primaryButton(
                                      onButtonPressed: () {
                                        setState(() {
                                          noQuestions = false;
                                          isQuestionFieldVisible = false;
                                        });
                                      },
                                      title: "Submit",
                                    ),
                                  ],
                                ],
                              )
                            else
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AppButton.primaryButton(
                                          onButtonPressed: () {
                                            setState(() {
                                              isQuestionFieldVisible =
                                                  !isQuestionFieldVisible;
                                            });
                                          },
                                          title: "Ask Question",
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: AppButton.primaryButton(
                                          onButtonPressed: () {
                                            Get.to(() =>
                                                const CommunityYourQuestionsScreen());
                                          },
                                          title: "View Your\nQuestions (3)",
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (isQuestionFieldVisible) ...[
                                    sizedTextfield,
                                    MyCustomTextField.textField(
                                      hintText: "Type your question here...",
                                      controller: urlController,
                                      maxLine: 3,
                                      borderClr: AppColors.white12,
                                    ),
                                    sizedTextfield,
                                    AppButton.primaryButton(
                                      onButtonPressed: () {},
                                      title: "Submit",
                                    ),
                                  ],
                                ],
                              ),
                        ],
                      ),
                    ),
                  );
                },
              ));
  }
}
