import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityPriorityDMsController/community_priority_dms_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CommunityYourQuestionsScreen extends StatefulWidget {
  String priorityDMId;
  CommunityYourQuestionsScreen({required this.priorityDMId, super.key});

  @override
  State<CommunityYourQuestionsScreen> createState() =>
      _CommunityYourQuestionsScreenState();
}

class _CommunityYourQuestionsScreenState
    extends State<CommunityYourQuestionsScreen> {
  CommunityPriorityDMsController communityPriorityDMs =
      Get.put(CommunityPriorityDMsController());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      communityPriorityDMs
          .getCommunityPriorityDMYourQuestions(widget.priorityDMId)
          .then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "Your Questions",
            hideBack: true,
            autoAction: true,
          ),
          body: Obx(
            () => communityPriorityDMs.isLoading.value
                ? Helper.pageLoading()
                : communityPriorityDMs.yourQuestionsData.questions!.isEmpty
                    ? const Center(
                        child: TextWidget(
                            text: "No Your Questions Available", textSize: 16))
                    : ListView.builder(
                        itemCount: communityPriorityDMs
                            .yourQuestionsData.questions!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: AppColors.blackCard,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text:
                                        "Question: ${communityPriorityDMs.yourQuestionsData.questions![index].question}",
                                    textSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  sizedTextfield,
                                  TextWidget(
                                    text:
                                        "Time left:${communityPriorityDMs.yourQuestionsData.questions![index].timeLeft}",
                                    textSize: 16,
                                    color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                                  ),
                                  sizedTextfield,
                                  TextWidget(
                                      text:
                                          "Asked ${communityPriorityDMs.yourQuestionsData.questions![index].timeAgo}",
                                      textSize: 13),
                                  sizedTextfield
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ));
  }
}
