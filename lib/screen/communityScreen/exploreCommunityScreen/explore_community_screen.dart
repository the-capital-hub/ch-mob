import 'dart:async';

import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAboutScreen/communities_about_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityLandingScreen/community_landing_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPublicScreen/community_public_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/dilogue/community_details.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ExploreCommunityScreen extends StatefulWidget {
  const ExploreCommunityScreen({super.key});

  @override
  State<ExploreCommunityScreen> createState() => _ExploreCommunityScreenState();
}

class _ExploreCommunityScreenState extends State<ExploreCommunityScreen> {
  TextEditingController searchController = TextEditingController();
  CommunityController allCommunities = Get.put(CommunityController());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      allCommunities.getAllCommunities("").then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }
  
  Timer? _debounce;
  void onCommunityNameChanged(String name) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      await allCommunities.getAllCommunities(name);
      
    });
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
            title: "Explore Community",
            hideBack: true,
            autoAction: true,
          ),
          body: Obx(() => allCommunities.isLoading.value
              ? Helper.pageLoading()
              : allCommunities.allCommunitiesDetails.isEmpty
                  ? const Center(
                      child: TextWidget(
                          text: "No Community Available", textSize: 16))
                  : Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          MyCustomTextField.textField(
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.white54,
                              ),
                              onChange: (String name){
                                onCommunityNameChanged(name);
                              },
                              fillColor: AppColors.white,
                              borderClr: AppColors.white54,
                              borderRadius: 8,
                              hintText: "Search",
                              controller: searchController),
                          const SizedBox(
                            height: 12,
                          ),
                          Expanded(
                            child: GridView.builder(
                              itemCount:
                                  allCommunities.allCommunitiesDetails.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 7,
                                mainAxisSpacing: 7,
                                childAspectRatio: 0.7,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (!allCommunities
                                            .allCommunitiesDetails[index]
                                            .isCommunityMember &&
                                        allCommunities
                                            .allCommunitiesDetails[index]
                                            .isOpen) {
                                      createdCommunityId = allCommunities
                                          .allCommunitiesDetails[index].id;
                                      communityLogo = allCommunities
                                          .allCommunitiesDetails[index].image;
                                      communityName = allCommunities
                                          .allCommunitiesDetails[index]
                                          .community;
                                      isAdmin = allCommunities
                                                  .allCommunitiesDetails[index]
                                                  .role ==
                                              "Admin"
                                          ? true
                                          : false;
                                      Get.to(() => CommunityAboutScreen(
                                          isPublic: true, index: index));
                                    } else if (!allCommunities
                                            .allCommunitiesDetails[index]
                                            .isCommunityMember &&
                                        !allCommunities
                                            .allCommunitiesDetails[index]
                                            .isOpen) {
                                      showCommunityDetailsPopup(context);
                                    } else {
                                      createdCommunityId = allCommunities
                                          .allCommunitiesDetails[index].id;
                                      communityLogo = allCommunities
                                          .allCommunitiesDetails[index].image;
                                      communityName = allCommunities
                                          .allCommunitiesDetails[index]
                                          .community;
                                      isAdmin = allCommunities
                                                  .allCommunitiesDetails[index]
                                                  .role ==
                                              "Admin"
                                          ? true
                                          : false;
                                      Get.to(
                                          () => const CommunityLandingScreen());
                                    }
                                  },
                                  child: Card(
                                      margin: EdgeInsets.zero,
                                      color: AppColors.blackCard,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4, right: 7),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            CircleAvatar(
                                              foregroundImage: NetworkImage(
                                                  allCommunities
                                                      .allCommunitiesDetails[
                                                          index]
                                                      .image
                                                      .toString()),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            TextWidget(
                                              text: allCommunities
                                                  .allCommunitiesDetails[index]
                                                  .community,
                                              textSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            const SizedBox(height: 3),
                                            TextWidget(
                                              text: allCommunities
                                                  .allCommunitiesDetails[index]
                                                  .size,
                                              textSize: 12,
                                              color: GetStoreData.getStore
                                                      .read('isInvestor')
                                                  ? AppColors.primaryInvestor
                                                  : AppColors.primary,
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            TextWidget(
                                                text:
                                                    "${allCommunities.allCommunitiesDetails[index].members.length.toString()} Members",
                                                textSize: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Container(
                                                      height: 3,
                                                      width: 3,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color:
                                                              AppColors.white)),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                TextWidget(
                                                    text: allCommunities
                                                        .allCommunitiesDetails[
                                                            index]
                                                        .createdAtTimeAgo,
                                                    textSize: 5),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              color: AppColors.grey700,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 6),
                                                child: TextWidget(
                                                    text: allCommunities
                                                        .allCommunitiesDetails[
                                                            index]
                                                        .isAbleToJoinTag,
                                                    textSize: 11),
                                              ),
                                            ),
                                            TextWidget(
                                                text: allCommunities
                                                    .allCommunitiesDetails[
                                                        index]
                                                    .amount,
                                                textSize: 11),
                                            if (!allCommunities
                                                    .allCommunitiesDetails[
                                                        index]
                                                    .isCommunityMember &&
                                                allCommunities
                                                    .allCommunitiesDetails[
                                                        index]
                                                    .isOpen)
                                              InkWell(
                                                onTap: () async {
                                                  Helper.loader(context);
                                                  createdCommunityId =
                                                      allCommunities
                                                          .allCommunitiesDetails[
                                                              index]
                                                          .id;
                                                  await allCommunities
                                                      .joinCommunity();
                                                  communityLogo = allCommunities
                                                      .allCommunitiesDetails[
                                                          index]
                                                      .image;
                                                  communityName = allCommunities
                                                      .allCommunitiesDetails[
                                                          index]
                                                      .community;
                                                  isAdmin = allCommunities
                                                              .allCommunitiesDetails[
                                                                  index]
                                                              .role ==
                                                          "Admin"
                                                      ? true
                                                      : false;
                                                  Get.to(() =>
                                                      const CommunityLandingScreen());
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  color: GetStoreData.getStore
                                                          .read('isInvestor')
                                                      ? AppColors
                                                          .primaryInvestor
                                                      : AppColors.primary,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5,
                                                        vertical: 6),
                                                    child: TextWidget(
                                                      text: "Join Now",
                                                      textSize: 11,
                                                      color: GetStoreData
                                                              .getStore
                                                              .read(
                                                                  'isInvestor')
                                                          ? AppColors.black
                                                          : AppColors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      )),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )),
        ));
  }
}
