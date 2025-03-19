import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityPriorityDMsController/community_priority_dms_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityPriorityDMsModel/community_priority_dms_model.dart';
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
  }

  late final TabController _tabController;
  TextEditingController urlController = TextEditingController();
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
                            text:
                                "No PriorityDMs Questions and Answers Available",
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
                                    ListView.builder(
                                      itemCount: unansweredQuestions.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          color: AppColors.blackCard,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const CircleAvatar(
                                                      radius: 18,
                                                      backgroundImage:
                                                          AssetImage(
                                                              PngAssetPath
                                                                  .accountImg),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    TextWidget(
                                                      text:
                                                          "${unansweredQuestions[index].question}",
                                                      textSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        TextWidget(
                                                            text:
                                                                "${unansweredQuestions[index].createdAt}",
                                                            textSize: 13),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        const TextWidget(
                                                          text:
                                                              "Time to answer:Time expired",
                                                          textSize: 13,
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                sizedTextfield,
                                                const TextWidget(
                                                  text: "Question",
                                                  textSize: 16,
                                                  maxLine: 2,
                                                ),
                                                sizedTextfield,
                                                MyCustomTextField.textField(
                                                    hintText:
                                                        "Type your answer...",
                                                    controller: urlController,
                                                    borderClr:
                                                        AppColors.white12),
                                                sizedTextfield,
                                                AppButton.primaryButton(
                                                    onButtonPressed: () {},
                                                    title: "Submit Answer")
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    ListView.builder(
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          color: AppColors.blackCard,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 18,
                                                      backgroundImage:
                                                          AssetImage(
                                                              PngAssetPath
                                                                  .accountImg),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    TextWidget(
                                                      text: "Name",
                                                      textSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Spacer(),
                                                    TextWidget(
                                                        text:
                                                            "Asked 16 days ago",
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
