import 'package:capitalhub_crm/controller/meetingController/meeting_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/question_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class PriorityDMScreen extends StatefulWidget {
  const PriorityDMScreen({super.key});

  @override
  State<PriorityDMScreen> createState() => _PriorityDMScreenState();
}

class _PriorityDMScreenState extends State<PriorityDMScreen>
    with SingleTickerProviderStateMixin {
  MeetingController userController = Get.put(MeetingController());
  MeetingController founderController = Get.put(MeetingController());
  bool anyUnanswered = false;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      userController.getPriorityDMForUser().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      founderController.getPriorityDMForFounder().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    anyUnanswered = founderController.founderList.any((founder) => founder.isAnswered == false);

    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  late final TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          drawer: GetStoreData.getStore.read('isInvestor')
              ? const DrawerWidgetInvestor()
              : const DrawerWidget(),
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "Priority DM",
            hideBack: true,
            autoAction: true,
          ),
          body: Obx(
            () => Column(
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
                  tabs: const [
                    Tab(text: "My Questions"),
                    Tab(text: "Unanswered"),
                    Tab(text: "Answered")
                  ],
                  labelColor: GetStoreData.getStore.read('isInvestor')
                      ? AppColors.primaryInvestor
                      : AppColors.primary,
                  unselectedLabelColor: AppColors.white,
                  unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 16),
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 16),
                ),
                Expanded(
                    child: TabBarView(controller: _tabController, children: [
                  userController.isLoading.value
                      ? Helper.pageLoading()
                      : userController.userList.isEmpty
                          ? const Center(
                              child: TextWidget(
                                  text: "No Questions Available", textSize: 16))
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              itemCount: userController.userList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    print(_tabController.index);
                                    Get.to(() => QuestionScreen(
                                          tabIndex: _tabController.index,
                                          userData:
                                              userController.userList[index],
                                        ));
                                  },
                                  child: Card(
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
                                              CircleAvatar(
                                                  radius: 18,
                                                  backgroundImage: NetworkImage(
                                                      userController
                                                          .userList[index]
                                                          .profileImage)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              TextWidget(
                                                text: userController
                                                    .userList[index]
                                                    .founderName,
                                                textSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              TextWidget(
                                                text:
                                                    "${userController.userList[index].founderRating}/5",
                                                textSize: 16,
                                              )
                                            ],
                                          ),
                                          sizedTextfield,
                                          TextWidget(
                                            text: userController
                                                .userList[index].question,
                                            textSize: 16,
                                            maxLine: 2,
                                          ),
                                          sizedTextfield,
                                          TextWidget(
                                            text: userController
                                                    .userList[index].isAnswered
                                                ? userController
                                                    .userList[index].answer
                                                : "Thank you for your question! When the founder answers your query, we will notify you via email.",
                                            textSize: 16,
                                            maxLine: 3,
                                            color: AppColors.white54,
                                          ),
                                          sizedTextfield,
                                          TextWidget(
                                            text: userController
                                                    .userList[index].isAnswered
                                                ? "Answered"
                                                : "Unanswered",
                                            textSize: 16,
                                            maxLine: 3,
                                            color: userController
                                                    .userList[index].isAnswered
                                                ? GetStoreData.getStore
                                                        .read('isInvestor')
                                                    ? AppColors.primaryInvestor
                                                    : AppColors.primary
                                                : AppColors.white54,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                  founderController.isLoading.value
                      ? Helper.pageLoading()
                      : founderController.founderList.isEmpty || !anyUnanswered
                          ? const Center(
                              child: TextWidget(
                                  text: "No Questions Available", textSize: 16))
                          : 
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: founderController.founderList.length,
                    itemBuilder: (context, index) {
                      if (founderController.founderList[index].isAnswered ==
                          false) {
                        return InkWell(
                            onTap: () {
                              Get.to(() => QuestionScreen(
                                    tabIndex: _tabController.index,
                                    founderData:
                                        founderController.founderList[index],
                                  ));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                                                founderController
                                                    .founderList[index]
                                                    .profileImage)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        TextWidget(
                                          text: founderController
                                              .founderList[index].userName,
                                          textSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        TextWidget(
                                          text:
                                              "${founderController.founderList[index].userRating}/5",
                                          textSize: 16,
                                        ),
                                      ],
                                    ),
                                    sizedTextfield,
                                    TextWidget(
                                      text: founderController
                                          .founderList[index].question,
                                      textSize: 16,
                                      maxLine: 2,
                                    ),
                                    sizedTextfield,
                                    TextWidget(
                                      text:
                                          "Thank you for your question! When the founder answers your query, we will notify you via email.",
                                      textSize: 16,
                                      maxLine: 3,
                                      color: AppColors.white54,
                                    ),
                                    sizedTextfield,
                                    TextWidget(
                                      text: "Unanswered",
                                      textSize: 16,
                                      maxLine: 3,
                                      color: AppColors.white54,
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                  founderController.isLoading.value
                      ? Helper.pageLoading()
                      : founderController.founderList.isEmpty || anyUnanswered
                          ? const Center(
                              child: TextWidget(
                                  text: "No Questions Available", textSize: 16))
                          : 
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: founderController.founderList.length,
                    itemBuilder: (context, index) {
                      if (founderController.founderList[index].isAnswered ==
                          true) {
                        return InkWell(
                            onTap: () {
                              Get.to(() => QuestionScreen(
                                    tabIndex: _tabController.index,
                                    founderData:
                                        founderController.founderList[index],
                                  ));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                                                founderController
                                                    .founderList[index]
                                                    .profileImage)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        TextWidget(
                                          text: founderController
                                              .founderList[index].userName,
                                          textSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        TextWidget(
                                          text:
                                              "${founderController.founderList[index].userRating}/5",
                                          textSize: 16,
                                        ),
                                      ],
                                    ),
                                    sizedTextfield,
                                    TextWidget(
                                      text: founderController
                                          .founderList[index].question,
                                      textSize: 16,
                                      maxLine: 2,
                                    ),
                                    sizedTextfield,
                                    TextWidget(
                                      text: founderController
                                          .founderList[index].answer,
                                      textSize: 16,
                                      maxLine: 3,
                                      color: AppColors.white54,
                                    ),
                                    sizedTextfield,
                                    const TextWidget(
                                      text: "Answered",
                                      textSize: 16,
                                      maxLine: 3,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ])),
              ],
            ),
          ),
        ));
  }
}
