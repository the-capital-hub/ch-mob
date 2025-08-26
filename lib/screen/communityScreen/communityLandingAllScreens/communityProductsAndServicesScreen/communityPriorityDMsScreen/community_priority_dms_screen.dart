import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityPriorityDMsController/community_priority_dms_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityPriorityDMsScreen/communityAskAQuestionScreen/community_ask_a_question_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityPriorityDMsScreen/communityQuestionsScreen/community_questions_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityPriorityDMsScreen/communityYourQuestionsScreen/community_your_questions_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
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

import 'community_add_priority_dms_screen.dart';

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
  List<TextEditingController> questionControllers = [];
  Map<int, bool> questionFieldVisibility = {};
  bool _isExpanded = false;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      communityPriorityDMs.getCommunityPriorityDMs().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          for (int i = 0;
              i < communityPriorityDMs.communityPriorityDMsList.length;
              i++) {
            questionControllers.add(TextEditingController());
          }
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in questionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool isQuestionFieldVisible = false;
  bool noQuestions = true;
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: isAdmin
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(() => CommunityAddPriorityDmsScreen(
                        isEdit: false,
                      ));
                },
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(Icons.add, color: AppColors.white),
              )
            : null,
        backgroundColor: AppColors.transparent,
        body: Obx(() => communityPriorityDMs.isLoading.value
            ? Helper.pageLoading()
            : communityPriorityDMs.communityPriorityDMsList.isEmpty
                ? const Center(
                    child: TextWidget(
                        text: "No PriorityDMs Available", textSize: 16))
                : ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 6),
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount:
                        communityPriorityDMs.communityPriorityDMsList.length,
                    itemBuilder: (context, index) {
                      if (!questionFieldVisibility.containsKey(index)) {
                        questionFieldVisibility[index] = false;
                      }

                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text:
                                              "${communityPriorityDMs.communityPriorityDMsList[index].title}",
                                          textSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        const SizedBox(height: 6),
                                        HtmlWidget(
                                          _isExpanded
                                              ? "${communityPriorityDMs.communityPriorityDMsList[index].description}"
                                              : communityPriorityDMs
                                                          .communityPriorityDMsList[
                                                              index]
                                                          .description!
                                                          .length >
                                                      200
                                                  ? "${communityPriorityDMs.communityPriorityDMsList[index].description!.substring(0, 200)} ..."
                                                  : communityPriorityDMs
                                                      .communityPriorityDMsList[
                                                          index]
                                                      .description!,
                                          textStyle: TextStyle(
                                              fontSize: (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      375) *
                                                  12,
                                              color: AppColors.white),
                                        ),
                                        if (communityPriorityDMs
                                                .communityPriorityDMsList[index]
                                                .description!
                                                .length >
                                            200)
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _isExpanded = !_isExpanded;
                                                });
                                              },
                                              child: Text(
                                                _isExpanded
                                                    ? "Read Less"
                                                    : "Read More",
                                                style: const TextStyle(
                                                    color: AppColors.blue,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        const SizedBox(height: 6),
                                        TextWidget(
                                            text:
                                                "Response Time: ${communityPriorityDMs.communityPriorityDMsList[index].timeline}",
                                            textSize: 16),
                                        const SizedBox(height: 6),
                                        if (communityPriorityDMs
                                            .communityPriorityDMsList[index]
                                            .topics!
                                            .isNotEmpty)
                                          Wrap(
                                            spacing: 4.0,
                                            runSpacing: 4.0,
                                            children: List.generate(
                                                communityPriorityDMs
                                                    .communityPriorityDMsList[
                                                        index]
                                                    .topics!
                                                    .length, (innerIndex) {
                                              return InkWell(
                                                onTap: () {},
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  color: AppColors.white12,
                                                  surfaceTintColor:
                                                      AppColors.white12,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                    child: TextWidget(
                                                        text: communityPriorityDMs
                                                            .communityPriorityDMsList[
                                                                index]
                                                            .topics![innerIndex],
                                                        textSize: 14),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          sharePostPopup(
                                              context,
                                              "",
                                              communityPriorityDMs
                                                  .communityPriorityDMsList[
                                                      index]
                                                  .dmSharelink!);
                                        },
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundColor:
                                              AppColors.blue.withOpacity(0.8),
                                          child: Icon(
                                              Icons.mobile_screen_share_rounded,
                                              color: AppColors.whiteCard,
                                              size: 20),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      if (isAdmin)
                                        InkWell(
                                          onTap: () {
                                            Get.to(() =>
                                                CommunityAddPriorityDmsScreen(
                                                  isEdit: true,
                                                  communityPriorityDMs:
                                                      communityPriorityDMs
                                                              .communityPriorityDMsList[
                                                          index],
                                                ));
                                          },
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor: AppColors.green700
                                                .withOpacity(0.8),
                                            child: Icon(Icons.edit,
                                                color: AppColors.whiteCard,
                                                size: 20),
                                          ),
                                        ),
                                      const SizedBox(height: 6),
                                      if (isAdmin)
                                        InkWell(
                                          onTap: () {
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
                                                Get.back();
                                                Helper.loader(context);
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
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor: AppColors.redColor
                                                .withOpacity(0.8),
                                            child: Icon(Icons.delete,
                                                color: AppColors.whiteCard,
                                                size: 20),
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Card(
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    color: AppColors.primary,
                                    child: SizedBox(
                                      width: 80,
                                      height: 38,
                                      child: Center(
                                        child: TextWidget(
                                          text: communityPriorityDMs
                                                      .communityPriorityDMsList[
                                                          index]
                                                      .amount ==
                                                  0
                                              ? "Free"
                                              : "\u{20B9} ${communityPriorityDMs.communityPriorityDMsList[index].amount}",
                                          textSize: 14,
                                          color: AppColors.whiteCard,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  if (isAdmin)
                                    Expanded(
                                      child: AppButton.outlineButton(
                                        borderColor: GetStoreData.getStore
                                                .read('isInvestor')
                                            ? AppColors.primaryInvestor
                                            : AppColors.primary,
                                        height: 40,
                                        onButtonPressed: () {
                                          Get.to(() => CommunityQuestionsScreen(
                                              index: index));
                                        },
                                        title: "View Questions",
                                      ),
                                    )
                                  else
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: AppButton.primaryButton(
                                              height: 40,
                                              onButtonPressed: () {
                                                setState(() {
                                                  questionFieldVisibility[
                                                          index] =
                                                      !questionFieldVisibility[
                                                          index]!;
                                                });
                                              },
                                              title: "Ask Question",
                                            ),
                                          ),
                                          if (communityPriorityDMs
                                              .communityPriorityDMsList[index]
                                              .questions!
                                              .isNotEmpty)
                                            const SizedBox(
                                              width: 8,
                                            ),
                                          if (communityPriorityDMs
                                              .communityPriorityDMsList[index]
                                              .questions!
                                              .isNotEmpty)
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    CommunityYourQuestionsScreen(
                                                        priorityDMId:
                                                            communityPriorityDMs
                                                                .communityPriorityDMsList[
                                                                    index]
                                                                .id
                                                                .toString()));
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    AppColors.white12,
                                                radius: 20,
                                                child: Icon(
                                                  Icons.remove_red_eye_outlined,
                                                  color: AppColors.whiteCard,
                                                  size: 20,
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    )
                                ],
                              ),
                              if (questionFieldVisibility[index]!) ...[
                                sizedTextfield,
                                MyCustomTextField.textField(
                                  hintText: "Type your question here...",
                                  controller: questionControllers[index],
                                  maxLine: 3,
                                  borderClr: AppColors.white12,
                                ),
                                sizedTextfield,
                                AppButton.primaryButton(
                                  height: 40,
                                  onButtonPressed: () {
                                    setState(() {
                                      communityPriorityDMs
                                              .questionController.text =
                                          questionControllers[index].text;
                                      questionControllers[index].clear();
                                      questionFieldVisibility[index] = false;
                                    });
                                    if (communityPriorityDMs
                                            .communityPriorityDMsList[index]
                                            .amount !=
                                        0) {
                                      Get.to(() => CommunityAskAQuestionScreen(
                                          index: index));
                                    } else {
                                      submitTap(index);
                                    }
                                  },
                                  title: "Submit",
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  )));
  }

  submitTap(index) {
    Helper.loader(context);
    communityPriorityDMs
        .communityPriorityDMyAskQuestion(
            communityPriorityDMs.communityPriorityDMsList[index].id.toString())
        .then((_) {
      communityPriorityDMs.questionController.clear();
    });
  }
}
