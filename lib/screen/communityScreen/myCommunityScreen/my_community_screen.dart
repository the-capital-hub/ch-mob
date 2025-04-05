import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityLandingScreen/community_landing_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/createCommunityAllScreens/createCommunityLandingScreen/create_community_landing_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
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
    return Container(
        decoration: bgDec,
        child: Scaffold(
          drawer: GetStoreData.getStore.read('isInvestor')
              ? const DrawerWidgetInvestor()
              : const DrawerWidget(),
          backgroundColor: AppColors.transparent,
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
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: myCommunities.myCommunitiesDetails.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              createdCommunityId =
                                  myCommunities.myCommunitiesDetails[index].id;
                              communityLogo = myCommunities
                                  .myCommunitiesDetails[index].image;
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
                                color: AppColors.blackCard,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 12, bottom: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                foregroundImage: NetworkImage(
                                                    myCommunities
                                                        .myCommunitiesDetails[
                                                            index]
                                                        .image),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              TextWidget(
                                                text: myCommunities
                                                    .myCommunitiesDetails[index]
                                                    .community,
                                                textSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  color: AppColors.green700,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 6),
                                                    child: TextWidget(
                                                        text: myCommunities
                                                            .myCommunitiesDetails[
                                                                index]
                                                            .role
                                                            .toString(),
                                                        textSize: 11),
                                                  ))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          TextWidget(
                                            text: myCommunities
                                                .myCommunitiesDetails[index]
                                                .size
                                                .toString(),
                                            textSize: 13,
                                            color: GetStoreData.getStore
                                                    .read('isInvestor')
                                                ? AppColors.primaryInvestor
                                                : AppColors.primary,
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: [
                                              TextWidget(
                                                  text:
                                                      "${myCommunities.myCommunitiesDetails[index].members!.length.toString()} Members",
                                                  textSize: 14),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                  height: 5,
                                                  width: 5,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: AppColors.white)),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              TextWidget(
                                                  text: myCommunities
                                                      .myCommunitiesDetails[
                                                          index]
                                                      .createdAtTimeAgo
                                                      .toString(),
                                                  textSize: 14),
                                            ],
                                          )
                                        ],
                                      ),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: Icon(
                                                Icons
                                                    .mobile_screen_share_rounded,
                                                color: AppColors.whiteCard,
                                                // size: 22,
                                              ),
                                              onPressed: () {
                                                sharePostPopup(
                                                    context,
                                                    "",
                                                    myCommunities
                                                        .myCommunitiesDetails[
                                                            index]
                                                        .shareLink
                                                        .toString());
                                              },
                                            ),
                                            if (myCommunities
                                                    .myCommunitiesDetails[index]
                                                    .role ==
                                                "Member")
                                              IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(Icons.logout),
                                                color: GetStoreData.getStore
                                                        .read('isInvestor')
                                                    ? AppColors.primaryInvestor
                                                    : AppColors.primary,
                                                onPressed: () {
                                                  Helper.loader(context);
                                                  myCommunities.leaveCommunity(
                                                      myCommunities
                                                          .myCommunitiesDetails[
                                                              index]
                                                          .id);
                                                },
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        },
                      ),
                    )),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 12,
            ),
            child: AppButton.primaryButton(
                onButtonPressed: () {
                  Get.to(() => const CreateCommunityLandingScreen());
                },
                title: "Create new Community"),
          ),
        ));
  }
}
