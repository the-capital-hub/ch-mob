import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/community_home_screen.dart';
import 'package:capitalhub_crm/screen/createPostScreen/create_post_screen.dart';
import 'package:capitalhub_crm/screen/manageAccountScreen/manage_account_Screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/profile_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityDrawerWidget extends StatefulWidget {
  const CommunityDrawerWidget({super.key});

  @override
  State<CommunityDrawerWidget> createState() => _CommunityDrawerWidgetState();
}

class _CommunityDrawerWidgetState extends State<CommunityDrawerWidget> {
  List<String> items = [
    "Home",
    "Products",
    "Events",
    "People",
    "About",
    "Profile",
  ];
  
  
  List icons = [
    PngAssetPath.homeIcon,
     PngAssetPath.categoryIcon,
     PngAssetPath.meetingIcon,
     PngAssetPath.teamIcon,
    PngAssetPath.infoIcon,
    PngAssetPath.userIcon,
  ];
  List page = [
    const CommunityHomeScreen(),
    const CommunityHomeScreen(),
    const CommunityHomeScreen(),
    const CommunityHomeScreen(),
    const CommunityHomeScreen(),
    const CommunityHomeScreen(),
  ];
  
 
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedTextfield,
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                )),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        color: AppColors.blackCard,
                        surfaceTintColor: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    '${GetStoreData.getStore.read('profile_image')}'),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                      text:
                                          "${GetStoreData.getStore.read('name')}",
                                      textSize: 16,
                                      fontWeight: FontWeight.w500),
                                  TextWidget(
                                      text:
                                          "${GetStoreData.getStore.read('phone')}",
                                      textSize: 12),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 18, vertical: 8),
                    //   child: AppButton.primaryButton(
                    //       onButtonPressed: () {
                    //         Get.to(CreatePostScreen());
                    //       },
                    //       height: 42,
                    //       title: "Create Post"),
                    // ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: items.length,
                      padding: const EdgeInsets.only(
                        top: 0,
                        bottom: 10,
                        right: 16,
                        left: 0,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        
                          return InkWell(
                            onTap: () {
                              Get.to(page[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(100),
                                      bottomRight: Radius.circular(100))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, top: 10, left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      icons[index],
                                      color: AppColors.white,
                                      height: 22,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    TextWidget(
                                        text: items[index],
                                        textSize: 16,
                                        fontWeight: FontWeight.w500,
                                        maxLine: 1,
                                        align: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 0);
                      },
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child: Card(
                    //     color: AppColors.blackCard,
                    //     surfaceTintColor: AppColors.blackCard,
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(12.0),
                    //       child: Column(
                    //         children: [
                    //           CircleAvatar(
                    //             radius: 25,
                    //             backgroundImage: NetworkImage(
                    //                 '${GetStoreData.getStore.read('profile_image')}'),
                    //           ),
                    //           const SizedBox(height: 8),
                    //           TextWidget(
                    //             text: "${GetStoreData.getStore.read('name')}",
                    //             textSize: 16,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //           const SizedBox(height: 3),
                    //           TextWidget(
                    //               text:
                    //                   "${GetStoreData.getStore.read('email')}",
                    //               textSize: 12),
                    //           const SizedBox(height: 3),
                    //           AppButton.primaryButton(
                    //               onButtonPressed: () {
                    //                 Get.to(const ProfileScreen());
                    //               },
                    //               height: 38,
                    //               title: "View Profile"),
                    //           const SizedBox(height: 8),
                    //           AppButton.primaryButton(
                    //               onButtonPressed: () {
                    //                 Get.to(const ManageAccountScreen());
                    //               },
                    //               height: 38,
                    //               bgColor: AppColors.white12,
                    //               title: "Manage Account"),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    sizedTextfield
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}