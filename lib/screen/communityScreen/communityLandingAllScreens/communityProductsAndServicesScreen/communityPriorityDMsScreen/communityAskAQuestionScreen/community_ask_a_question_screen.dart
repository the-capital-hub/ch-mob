import 'dart:developer';

import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityPriorityDMsController/community_priority_dms_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import '../../../../../../controller/profileController/profile_controller.dart';
import '../../../../../../utils/helper/helper.dart';
import '../../../../../../utils/paymentService/payment_service.dart';

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
  void initState() {
    super.initState();

    autoFillDetails();
  }

  void autoFillDetails() {
    communityPriorityDMs.nameController.text =
        GetStoreData.getStore.read('name');
    communityPriorityDMs.emailController.text =
        GetStoreData.getStore.read('email');
    communityPriorityDMs.mobileController.text =
        GetStoreData.getStore.read('phone');
  }

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
                // const TextWidget(
                //   text:
                //       "Please fill these details for purchase confirmation and further communication.",
                //   textSize: 13,
                //   maxLine: 2,
                //   align: TextAlign.center,
                // ),
                // const SizedBox(height: 12),
                // MyCustomTextField.textField(
                //     hintText: "Enter Name",
                //     controller: communityPriorityDMs.nameController,
                //     lableText: "Name"),
                // const SizedBox(height: 12),
                // MyCustomTextField.textField(
                //     hintText: "Enter Email",
                //     controller: communityPriorityDMs.emailController,
                //     lableText: "Email"),
                // const SizedBox(height: 12),
                // MyCustomTextField.textField(
                //     hintText: "Enter Mobile Number",
                //     controller: communityPriorityDMs.mobileController,
                //     lableText: "Mobile Number"),
                // const SizedBox(height: 12),
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
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 12),
                        TextWidget(
                          text: "Service:",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          color: GetStoreData.getStore.read('isInvestor')
                              ? AppColors.primaryInvestor
                              : AppColors.primary,
                        ),
                        const SizedBox(height: 12),
                        TextWidget(
                            text: communityPriorityDMs
                                .communityPriorityDMsList[widget.index].title!,
                            textSize: 13),
                        const SizedBox(height: 12),
                        TextWidget(
                          text: "Description:",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          color: GetStoreData.getStore.read('isInvestor')
                              ? AppColors.primaryInvestor
                              : AppColors.primary,
                        ),
                        const SizedBox(height: 12),
                        HtmlWidget(
                          communityPriorityDMs
                              .communityPriorityDMsList[widget.index]
                              .description!,
                          textStyle:
                              TextStyle(fontSize: 13, color: AppColors.white),
                        ),
                        const SizedBox(height: 12),
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
                                  color:
                                      GetStoreData.getStore.read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                ),
                                const SizedBox(height: 8),
                                const TextWidget(
                                    text: "PriorityDM", textSize: 13),
                              ],
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: "Price",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      GetStoreData.getStore.read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                ),
                                const SizedBox(height: 8),
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
                    borderColor: GetStoreData.getStore.read('isInvestor')
                        ? AppColors.primaryInvestor
                        : AppColors.primary,
                    onButtonPressed: () {
                      Get.back();
                    },
                    title: "Cancel"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      ProfileController profileController =
                          Get.put(ProfileController());
                    },
                    title: "Proceed to Payment"),
              ),
            ]),
          ),
        ));
  }

  submitTap(index) {
    Helper.loader(Get.context);
    communityPriorityDMs
        .communityPriorityDMyAskQuestion(
            communityPriorityDMs.communityPriorityDMsList[index].id.toString())
        .then((_) {
      communityPriorityDMs.questionController.clear();
    });
  }
}
