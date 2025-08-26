import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityLandingScreen/community_landing_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/createCommunityAllScreens/createCommunityLandingScreen/create_community_landing_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class MyCommunityScreen extends StatefulWidget {
  const MyCommunityScreen({super.key});

  @override
  State<MyCommunityScreen> createState() => _MyCommunityScreenState();
}

class _MyCommunityScreenState extends State<MyCommunityScreen> {
  CommunityController myCommunities = Get.put(CommunityController());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      myCommunities.getMyCommunities().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: GetStoreData.getStore.read('isInvestor')
            ? const DrawerWidgetInvestor()
            : const DrawerWidget(),
        backgroundColor: AppColors.black,
        appBar: HelperAppBar.appbarHelper(
          title: "My Community",
          hideBack: true,
          autoAction: true,
        ),
        body: Obx(() => myCommunities.isLoading.value
            ? Helper.pageLoading()
            : myCommunities.myCommunitiesDetails.isEmpty
                ? const Center(
                    child: TextWidget(
                        text: "No Community Available", textSize: 16))
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 4,
                      ),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 70),
                      itemCount: myCommunities.myCommunitiesDetails.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            createdCommunityId =
                                myCommunities.myCommunitiesDetails[index].id;
                            communityLogo =
                                myCommunities.myCommunitiesDetails[index].image;
                            communityName = myCommunities
                                .myCommunitiesDetails[index].community;
                            isAdmin = myCommunities
                                        .myCommunitiesDetails[index].role ==
                                    "Admin"
                                ? true
                                : false;
                            Get.to(() => const CommunityLandingScreen());
                          },
                          child: Card(
                              shadowColor: AppColors.white54,
                              elevation: 2,
                              color: AppColors.blackCard,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                              image: NetworkImage(myCommunities
                                                  .myCommunitiesDetails[index]
                                                  .image))),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: myCommunities
                                                .myCommunitiesDetails[index]
                                                .community,
                                            textSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Card(
                                                margin: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                color: AppColors.white12,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  child: TextWidget(
                                                    text: myCommunities
                                                        .myCommunitiesDetails[
                                                            index]
                                                        .size
                                                        .toString(),
                                                    textSize: 13,
                                                    color: GetStoreData.getStore
                                                            .read('isInvestor')
                                                        ? AppColors
                                                            .primaryInvestor
                                                        : AppColors.primary,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  color: AppColors.green700,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                    child: TextWidget(
                                                        text: myCommunities
                                                            .myCommunitiesDetails[
                                                                index]
                                                            .role
                                                            .toString(),
                                                        textSize: 10),
                                                  ))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              TextWidget(
                                                  text:
                                                      "${myCommunities.myCommunitiesDetails[index].members.length.toString()} Members",
                                                  textSize: 12),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              TextWidget(
                                                  text: myCommunities
                                                      .myCommunitiesDetails[
                                                          index]
                                                      .createdAtTimeAgo
                                                      .toString(),
                                                  color: AppColors.grey,
                                                  textSize: 12),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            sharePostPopup(
                                                context,
                                                "",
                                                myCommunities
                                                    .myCommunitiesDetails[index]
                                                    .shareLink
                                                    .toString());
                                          },
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor:
                                                AppColors.blue.withOpacity(0.5),
                                            child: Icon(
                                                Icons
                                                    .mobile_screen_share_rounded,
                                                color: AppColors.whiteCard,
                                                size: 20),
                                          ),
                                        ),
                                        if (myCommunities
                                                .myCommunitiesDetails[index]
                                                .role ==
                                            "Member")
                                          const SizedBox(height: 10),
                                        if (myCommunities
                                                .myCommunitiesDetails[index]
                                                .role ==
                                            "Member")
                                          InkWell(
                                            onTap: () {
                                              Helper.loader(context);
                                              myCommunities.leaveCommunity(
                                                  myCommunities
                                                      .myCommunitiesDetails[
                                                          index]
                                                      .id);
                                            },
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: AppColors
                                                  .redColor
                                                  .withOpacity(0.5),
                                              child: Icon(Icons.logout,
                                                  color: AppColors.whiteCard,
                                                  size: 20),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        );
                      },
                    ),
                  )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const CreateCommunityLandingScreen());
          },
          backgroundColor: AppColors.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: Icon(Icons.add, color: AppColors.white),
        ));
  }
}
