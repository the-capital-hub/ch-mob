import 'package:capitalhub_crm/controller/meetingController/meeting_controller.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen>
    with SingleTickerProviderStateMixin {
  MeetingController meetingController = Get.put(MeetingController());
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    meetingController.getALLScheduledMeetings("upcoming");
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 0) {
          meetingController.getALLScheduledMeetings("upcoming");
        } else if (_tabController.index == 1) {
          meetingController.getALLScheduledMeetings("past");
        }
      }
    });

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      meetingController.getWebinars().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  List<String> iconPath = [
    PngAssetPath.facebookIcon,
    PngAssetPath.twitterIconSmall,
    PngAssetPath.instagramIcon,
    PngAssetPath.youtubeIcon
  ];
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
          title: "Plans",
          hideBack: true,
          autoAction: true,
        ),
        body: Obx(
          () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(text: "Upcoming"),
                Tab(text: "Past"),
              ],
              labelColor: GetStoreData.getStore.read('isInvestor')
                  ? AppColors.primaryInvestor
                  : AppColors.primary,
              unselectedLabelColor: AppColors.white,
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            Expanded(
                child: meetingController.isLoading.value
                    ? Helper.pageLoading()
                    : meetingController.meetingsList.isEmpty
                        ? const Center(
                            child: TextWidget(
                                text: "No Meetings Available", textSize: 16))
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  ListView.separated(
                                      itemCount:
                                          meetingController.meetingsList.length,
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 20,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          color: AppColors.navyBlue,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                sizedTextfield,
                                                sizedTextfield,
                                                TextWidget(
                                                  text: meetingController
                                                      .meetingsList[index]
                                                      .title,
                                                  textSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                sizedTextfield,
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.schedule,
                                                      color: AppColors.white,
                                                      size: 22,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    TextWidget(
                                                        text: meetingController
                                                            .meetingsList[index]
                                                            .startTime,
                                                        textSize: 16)
                                                  ],
                                                ),
                                                sizedTextfield,
                                                Row(
                                                  children: [
                                                    const CircleAvatar(
                                                      radius: 15,
                                                      backgroundImage:
                                                          AssetImage(
                                                              PngAssetPath
                                                                  .accountImg),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    TextWidget(
                                                        text: meetingController
                                                            .meetingsList[index]
                                                            .name,
                                                        textSize: 20)
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: AppButton
                                                          .primaryButton(
                                                        onButtonPressed: () {},
                                                        title: "Join",
                                                        bgColor:
                                                            AppColors.brown,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: AppButton
                                                          .primaryButton(
                                                        onButtonPressed: () {
                                                          Helper.loader(context);
                                                          meetingController
                                                              .cancelScheduledMeeting(
                                                                  meetingController
                                                                      .meetingsList[
                                                                          index]
                                                                      .id);
                                                        },
                                                        title: "Cancel",
                                                        bgColor:
                                                            AppColors.redColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  ListView.separated(
                                      itemCount:
                                          meetingController.meetingsList.length,
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 20,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          color: AppColors.navyBlue,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                sizedTextfield,
                                                sizedTextfield,
                                                TextWidget(
                                                  text: meetingController
                                                      .meetingsList[index]
                                                      .title,
                                                  textSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                sizedTextfield,
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.schedule,
                                                      color: AppColors.white,
                                                      size: 22,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    TextWidget(
                                                        text: meetingController
                                                            .meetingsList[index]
                                                            .startTime,
                                                        textSize: 16)
                                                  ],
                                                ),
                                                sizedTextfield,
                                                Row(
                                                  children: [
                                                    const CircleAvatar(
                                                      radius: 15,
                                                      backgroundImage:
                                                          AssetImage(
                                                              PngAssetPath
                                                                  .accountImg),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    TextWidget(
                                                        text: meetingController
                                                            .meetingsList[index]
                                                            .name,
                                                        textSize: 20)
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: AppButton
                                                          .primaryButton(
                                                        onButtonPressed: () {},
                                                        title: "Join",
                                                        bgColor:
                                                            AppColors.brown,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: AppButton
                                                          .primaryButton(
                                                        onButtonPressed: () {
                                                          meetingController
                                                              .cancelScheduledMeeting(
                                                                  meetingController
                                                                      .meetingsList[
                                                                          index]
                                                                      .id);
                                                        },
                                                        title: "Cancel",
                                                        bgColor:
                                                            AppColors.redColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ]),
                          )),
          ]),
        ),
      ),
    );
  }
}
