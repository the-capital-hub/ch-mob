import 'package:capitalhub_crm/controller/meetingController/meeting_controller.dart';
import 'package:capitalhub_crm/model/meetingModel/get_priority_dm_founder_model.dart';
import 'package:capitalhub_crm/model/meetingModel/get_priority_dm_user_model.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionScreen extends StatefulWidget {
  int tabIndex;
  User? userData;
  Founder? founderData;
  QuestionScreen(
      {required this.tabIndex, this.userData, this.founderData, super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

bool questionFieldVisibility = true;
MeetingController founderController = Get.find();

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "Question",
            hideBack: false,
            autoAction: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Card(
                    color: AppColors.blackCard,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 18,
                                  backgroundImage: NetworkImage(
                                      widget.tabIndex == 0
                                          ? widget.userData!.profileImage
                                          : widget.founderData!.profileImage)),
                              const SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: widget.tabIndex == 0
                                    ? widget.userData!.founderName
                                    : widget.founderData!.userName,
                                textSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Spacer(),
                              Icon(
                                Icons.star,
                                color: AppColors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              TextWidget(
                                text:
                                    "${widget.tabIndex == 0 ? widget.userData!.founderRating : widget.founderData!.userRating}/5",
                                textSize: 16,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: AppColors.blackCard,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: "Question",
                                textSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          sizedTextfield,
                          Row(
                            children: [
                              Expanded(
                                child: TextWidget(
                                  text: widget.tabIndex == 0
                                      ? widget.userData!.question
                                      : widget.founderData!.question,
                                  textSize: 16,
                                  maxLine: 9,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: AppColors.blackCard,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.tabIndex == 0
                              ? widget.userData!.isAnswered
                              : false) ...[
                            Row(
                              children: [
                                TextWidget(
                                  text: "Answer",
                                  textSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            sizedTextfield,
                          ],
                          if (widget.tabIndex == 1)
                            Column(
                              children: [
                                MyCustomTextField.textField(
                                  hintText: "Type your answer here...",
                                  controller: founderController.answerController,
                                  maxLine: 3,
                                  borderClr: AppColors.white12,
                                ),
                                sizedTextfield,
                                AppButton.primaryButton(
                                  onButtonPressed: () {
                                    if (founderController
                                        .answerController.text.isEmpty) {
                                      HelperSnackBar.snackBar("Error",
                                          "Answer field cannot be empty");
                                    }
                                    Helper.loader(context);
                                    founderController.answerPriorityDM(
                                        widget.founderData!.priorityDMId);
                                  },
                                  title: "Submit Answer",
                                ),
                              ],
                            ),
                          if (widget.tabIndex != 1)
                            Row(
                              children: [
                                Expanded(
                                  child: TextWidget(
                                    text: widget.tabIndex == 0 &&
                                            widget.userData!.isAnswered
                                        ? widget.userData!.answer
                                        : widget.tabIndex == 2
                                            ? widget.founderData!.answer
                                            : "Thank you for your question! When the founder answers your query, we will notify you via email.",
                                    textSize: 16,
                                    maxLine: 3,
                                    color: (widget.tabIndex == 0 &&
                                                widget.userData!.isAnswered) ||
                                            (widget.tabIndex == 2)
                                        ? AppColors.white
                                        : AppColors.white54,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
