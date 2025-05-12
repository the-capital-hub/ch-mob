import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityPriorityDMsController/community_priority_dms_controller.dart';
import 'package:capitalhub_crm/model/communityModel/communityLandingAllModels/communityPriorityDMsModel/community_priority_dms_model.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityQuestionsScreen extends StatefulWidget {
  int? index;
  CommunityQuestionsScreen({this.index, super.key});

  @override
  State<CommunityQuestionsScreen> createState() =>
      _CommunityQuestionsScreenState();
}

class _CommunityQuestionsScreenState extends State<CommunityQuestionsScreen>
    with SingleTickerProviderStateMixin {
  CommunityPriorityDMsController communityPriorityDMs = Get.find();
  List<Question> answeredQuestions = [];
  List<Question> unansweredQuestions = [];
  List<TextEditingController> answerControllers = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    for (int i = 0;
        i <
            communityPriorityDMs
                .communityPriorityDMsList[widget.index!].questions!.length;
        i++) {
      if (communityPriorityDMs
          .communityPriorityDMsList[widget.index!].questions![i].isAnswered!) {
        answeredQuestions.add(communityPriorityDMs
            .communityPriorityDMsList[widget.index!].questions![i]);
      } else {
        unansweredQuestions.add(communityPriorityDMs
            .communityPriorityDMsList[widget.index!].questions![i]);
      }
    }
    for (int i = 0; i < unansweredQuestions.length; i++) {
      answerControllers.add(TextEditingController());
    }
  }

  late final TabController _tabController;
  @override
  void dispose() {
    for (var controller in answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          appBar: HelperAppBar.appbarHelper(
            title: "Questions",
            hideBack: true,
            autoAction: true,
          ),
          backgroundColor: AppColors.transparent,
          body: Obx(
            () => communityPriorityDMs.isLoading.value
                ? Helper.pageLoading()
                : communityPriorityDMs.communityPriorityDMsList.isEmpty
                    ? const Center(
                        child: TextWidget(
                          align: TextAlign.center,
                            text:
                                "No PriorityDMs\nQuestions and Answers Available",
                            textSize: 16))
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TabBar(
                                padding: EdgeInsets.zero,
                                controller: _tabController,
                                isScrollable: true,
                                dividerHeight: 0,
                                tabAlignment: TabAlignment.start,
                                indicator: BoxDecoration(
                                  color: AppColors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                labelPadding: const EdgeInsets.only(left: 12),
                                indicatorSize: TabBarIndicatorSize.label,
                                tabs: [
                                  Tab(
                                      text:
                                          "Unanswered (${unansweredQuestions.length})"),
                                  Tab(
                                      text:
                                          "Answered (${answeredQuestions.length})")
                                ],
                                labelColor:
                                    GetStoreData.getStore.read('isInvestor')
                                        ? AppColors.primaryInvestor
                                        : AppColors.primary,
                                unselectedLabelColor: AppColors.white,
                                unselectedLabelStyle: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                                labelStyle: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                              ),
                              Expanded(
                                  child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                    unansweredQuestions.isEmpty
                                        ? const Center(
                                            child: TextWidget(
                                              align: TextAlign.center,
                                                text:
                                                    "No Unanswered\nPriorityDMs Questions Available",
                                                textSize: 16))
                                        : ListView.builder(
                                            itemCount:
                                                unansweredQuestions.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                color: AppColors.blackCard,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 18,
                                                            foregroundImage:
                                                                NetworkImage(
                                                              unansweredQuestions[
                                                                      index]
                                                                  .userId!
                                                                  .profilePicture
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 12,
                                                          ),
                                                          TextWidget(
                                                            text:
                                                                "${unansweredQuestions[index].userId!.firstName} ${unansweredQuestions[index].userId!.lastName}",
                                                            textSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          const Spacer(),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              TextWidget(
                                                                  text: unansweredQuestions[
                                                                          index]
                                                                      .timeAgo!,
                                                                  textSize: 13),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              TextWidget(
                                                                text:
                                                                    "Time to answer :\n${unansweredQuestions[index].timeToAnswer}",
                                                                textSize: 13,
                                                                color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      sizedTextfield,
                                                      TextWidget(
                                                        text:
                                                            "${unansweredQuestions[index].question}",
                                                        textSize: 16,
                                                        maxLine: 2,
                                                      ),
                                                      sizedTextfield,
                                                      MyCustomTextField.textField(
                                                          hintText:
                                                              "Type your answer...",
                                                          controller:
                                                              answerControllers[
                                                                  index],
                                                          borderClr: AppColors
                                                              .white12),
                                                      sizedTextfield,
                                                      AppButton.primaryButton(
                                                          onButtonPressed: () {
                                                            setState(() {
                                                              communityPriorityDMs
                                                                      .answerController
                                                                      .text =
                                                                  answerControllers[
                                                                          index]
                                                                      .text;
                                                              answerControllers[
                                                                      index]
                                                                  .clear();
                                                            });
                                                            Helper.loader(
                                                                context);
                                                            communityPriorityDMs.communityAnswerPriorityDM(
                                                                communityPriorityDMs
                                                                    .communityPriorityDMsList[
                                                                        widget
                                                                            .index!]
                                                                    .id
                                                                    .toString(),
                                                                unansweredQuestions[
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                          },
                                                          title:
                                                              "Submit Answer")
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                    answeredQuestions.isEmpty
                                        ? const Center(
                                            child: TextWidget(
                                              align: TextAlign.center,
                                                text:
                                                    "No Answered\nPriorityDMs Questions Available",
                                                textSize: 16))
                                        : ListView.builder(
                                            itemCount: answeredQuestions.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                color: AppColors.blackCard,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 18,
                                                            foregroundImage:
                                                                NetworkImage(
                                                              answeredQuestions[
                                                                      index]
                                                                  .userId!
                                                                  .profilePicture
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 12,
                                                          ),
                                                          TextWidget(
                                                            text:
                                                                "${answeredQuestions[index].userId!.firstName} ${answeredQuestions[index].userId!.lastName}",
                                                            textSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          const SizedBox(
                                                            width: 12,
                                                          ),
                                                          const Spacer(),
                                                          TextWidget(
                                                              text:
                                                                  answeredQuestions[
                                                                          index]
                                                                      .timeAgo!,
                                                              textSize: 13),
                                                        ],
                                                      ),
                                                      sizedTextfield,
                                                      TextWidget(
                                                        text:
                                                            "${answeredQuestions[index].question}",
                                                        textSize: 16,
                                                        maxLine: 2,
                                                      ),
                                                      sizedTextfield,
                                                      const TextWidget(
                                                          text: "Answer:",
                                                          textSize: 16),
                                                      TextWidget(
                                                          text:
                                                              "${answeredQuestions[index].answer}",
                                                          textSize: 16),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  ]))
                            ])),
          ),
        ));
  }
}
