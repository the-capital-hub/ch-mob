import 'dart:developer';

import 'package:capitalhub_crm/controller/profileController/profile_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/profileModel/profile_model.dart';
import 'package:capitalhub_crm/screen/Auth-Process/userDetailsScreen/bio_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/challengeScreen/challenges_category_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/experience_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/personal_info_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/polls_widget_profile.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../model/01-StartupModel/publicPostModel/public_post_model.dart';
import '../../utils/constant/app_var.dart';
import '../homeScreen/widget/polls_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  ProfileController profileController = Get.find();

  late TabController _tabController;
  final List<String> tabs = ["Featured Posts", "Company Update", "My Posts"];
  PageController _pageController = PageController();
  int _currentIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.getProfile();
      profileController.getProfilePost(0);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: AppColors.transparent,
            drawer: const DrawerWidget(),
            appBar: HelperAppBar.appbarHelper(
                title: "Profile", hideBack: true, autoAction: true),
            body: Obx(() => profileController.isLoading.value
                ? Helper.pageLoading()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 42,
                              backgroundColor:
                                  profileController.profileData.isSubscribed!
                                      ? AppColors.golden
                                      : AppColors.transparent,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                    '${profileController.profileData.profilePicture}'),
                              ),
                            ),
                            sizedTextfield,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Icon(
                                //   Icons.mode_edit_outlined,
                                //   color: AppColors.transparent,
                                //   size: 20,
                                // ),
                                // const SizedBox(width: 8),
                                TextWidget(
                                    text:
                                        "${profileController.profileData.firstName} ${profileController.profileData.lastName}",
                                    textSize: 18,
                                    fontWeight: FontWeight.w500),
                                // const SizedBox(width: 8),
                                // InkWell(
                                //   onTap: () {
                                //     Get.to(() => PersonalInfoScreen(
                                //           isEdit: true,
                                //         ));
                                //   },
                                //   child: const Icon(
                                //     Icons.mode_edit_outlined,
                                //     color: AppColors.primary,
                                //     size: 20,
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextWidget(
                                    text:
                                        "${profileController.profileData.userName}",
                                    textSize: 15),
                                if (profileController.profileData.isSubscribed!)
                                  const SizedBox(width: 6),
                                if (profileController.profileData.isSubscribed!)
                                  Image.asset(PngAssetPath.verifyImg,
                                      height: 18)
                              ],
                            ),
                            const SizedBox(height: 6),
                            TextWidget(
                                text:
                                    "${profileController.profileData.designation} of ${profileController.profileData.companyName}, ${profileController.profileData.location}",
                                textSize: 14),
                            const SizedBox(height: 6),
                            TextWidget(
                                text:
                                    "${profileController.profileData.followersCount} Followers  |  ${profileController.profileData.connectionsCount} Connections",
                                color: AppColors.primary,
                                textSize: 14),
                            // const SizedBox(height: 12),
                            // AppButton.primaryButton(
                            //     onButtonPressed: () {},
                            //     title: "Connect",
                            //     height: 28,
                            //     fontSize: 12,
                            //     width: 95),
                            // sizedTextfield,
                            // Card(
                            //   color: AppColors.blackCard,
                            //   surfaceTintColor: AppColors.blackCard,
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(
                            //         left: 12, right: 12, top: 10, bottom: 12),
                            //     child: Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         Stack(
                            //           alignment: Alignment.center,
                            //           clipBehavior: Clip.none,
                            //           children: [
                            //             SizedBox(
                            //               width: 50,
                            //               height: 50,
                            //               child: CircularProgressIndicator(
                            //                 value: profileCompletion,
                            //                 strokeWidth: 4.0,
                            //                 strokeCap: StrokeCap.round,
                            //                 backgroundColor: AppColors.white38,
                            //                 valueColor:
                            //                     const AlwaysStoppedAnimation<Color>(
                            //                         AppColors.primary),
                            //               ),
                            //             ),
                            //             const CircleAvatar(
                            //               radius: 20,
                            //               backgroundImage: NetworkImage(
                            //                   'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'), // Replace with your avatar image URL
                            //             ),
                            //             Positioned(
                            //               bottom: -10,
                            //               child: Card(
                            //                 color: AppColors.whiteCard,
                            //                 shape: RoundedRectangleBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(2)),
                            //                 child: Padding(
                            //                   padding: const EdgeInsets.symmetric(
                            //                       horizontal: 4.0, vertical: 1),
                            //                   child: TextWidget(
                            //                       text: "30%",
                            //                       textSize: 10,
                            //                       color: AppColors.black,
                            //                       fontWeight: FontWeight.w500),
                            //                 ),
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //         const SizedBox(width: 12),
                            //         const Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             TextWidget(
                            //                 text:
                            //                     "Please complete the remaining profile",
                            //                 textSize: 14),
                            //             Row(
                            //               children: [
                            //                 TextWidget(
                            //                     text: "Complete the profile",
                            //                     color: AppColors.primary,
                            //                     textSize: 12),
                            //                 SizedBox(width: 4),
                            //               ],
                            //             ),
                            //           ],
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),

                            // const SizedBox(height: 14),
                            // Align(
                            //     alignment: Alignment.bottomLeft,
                            //     child: AnimationLimiter(
                            //       child: SizedBox(
                            //         height: 71,
                            //         child: ListView.separated(
                            //           itemCount: 5,
                            //           padding:
                            //               const EdgeInsets.symmetric(horizontal: 8),
                            //           shrinkWrap: true,
                            //           separatorBuilder: (context, index) {
                            //             return const SizedBox(width: 12);
                            //           },
                            //           scrollDirection: Axis.horizontal,
                            //           itemBuilder: (BuildContext context, int index) {
                            //             if (index == 4) {
                            //               // Last item (manual child)
                            //               return AnimationConfiguration.staggeredList(
                            //                   position: index,
                            //                   delay:
                            //                       const Duration(milliseconds: 150),
                            //                   duration:
                            //                       const Duration(milliseconds: 375),
                            //                   child: SlideAnimation(
                            //                       horizontalOffset: 1000,
                            //                       verticalOffset: 50.0,
                            //                       child: Column(
                            //                         children: [
                            //                           CircleAvatar(
                            //                             radius: 25,
                            //                             backgroundColor:
                            //                                 AppColors.white38,
                            //                             child: Icon(Icons.add,
                            //                                 color: AppColors.white),
                            //                           ),
                            //                           const SizedBox(height: 8),
                            //                           const TextWidget(
                            //                               text: "Add Post",
                            //                               textSize: 10)
                            //                         ],
                            //                       )));
                            //             } else {
                            //               return AnimationConfiguration.staggeredList(
                            //                   position: index,
                            //                   delay:
                            //                       const Duration(milliseconds: 150),
                            //                   duration:
                            //                       const Duration(milliseconds: 375),
                            //                   child: const SlideAnimation(
                            //                       horizontalOffset: 1000,
                            //                       verticalOffset: 50.0,
                            //                       child: SizedBox(
                            //                         width: 52,
                            //                         child: Column(
                            //                           children: [
                            //                             CircleAvatar(
                            //                               radius: 25,
                            //                               backgroundImage: NetworkImage(
                            //                                   "https://t3.ftcdn.net/jpg/02/76/45/48/360_F_276454828_xHQvpXWGJxkI0n2v9tlA34PmNev13IHq.jpg"),
                            //                             ),
                            //                             SizedBox(height: 8),
                            //                             TextWidget(
                            //                                 text: "Capital Hub",
                            //                                 textSize: 10)
                            //                           ],
                            //                         ),
                            //                       )));
                            //             }
                            //           },
                            //         ),
                            //       ),
                            //     )),

                            const SizedBox(height: 12),

                            TabBar(
                              indicator:
                                  const BoxDecoration(), // Removes the indicator
                              labelColor: Colors.orange,
                              dividerColor: AppColors.white54,
                              unselectedLabelColor: AppColors.whiteCard,
                              labelPadding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              tabAlignment: TabAlignment.start,
                              isScrollable: true,
                              onTap: (value) {
                                profileController.getProfilePost(value);
                              },
                              controller: _tabController,
                              tabs: tabs.map((tab) => Tab(text: tab)).toList(),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 250,
                              child: profileController.isTabLoading.value
                                  ? Helper.tabLoading()
                                  : profileController.profilePosts.isEmpty
                                      ? const Center(
                                          child: TextWidget(
                                              text: "No Post Found",
                                              textSize: 14),
                                        )
                                      : TabBarView(
                                          controller: _tabController,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: tabs.map((_) {
                                            return ListView.separated(
                                              itemCount: profileController
                                                  .profilePosts.length,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              separatorBuilder:
                                                  (context, index) {
                                                return const SizedBox(width: 8);
                                              },
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SizedBox(
                                                  width: Get.width / 1.7,
                                                  child: Card(
                                                    elevation: 3,
                                                    shadowColor:
                                                        AppColors.white12,
                                                    color: AppColors.blackCard,
                                                    surfaceTintColor:
                                                        AppColors.blackCard,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .transparent,
                                                                radius: 18,
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 20,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          '${profileController.profilePosts[index].userProfilePicture}'),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 8),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        TextWidget(
                                                                            text:
                                                                                "${profileController.profilePosts[index].userFirstName} ${profileController.profilePosts[index].userLastName}",
                                                                            textSize:
                                                                                12),
                                                                        const Expanded(
                                                                            child:
                                                                                SizedBox()),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            profileController.deletePost(context, _tabController.index, profileController.profilePosts[index].postId!).then((v) {
                                                                              profileController.profilePosts.removeAt(index);
                                                                              setState(() {});
                                                                            });
                                                                          },
                                                                          child:
                                                                              const Icon(
                                                                            Icons.delete,
                                                                            color:
                                                                                AppColors.redColor,
                                                                            size:
                                                                                18,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    // const SizedBox(height: 1),
                                                                    TextWidget(
                                                                      text:
                                                                          "${profileController.profilePosts[index].userDesignation}  ${profileController.profilePosts[index].userLocation}",
                                                                      textSize:
                                                                          10,
                                                                      color: AppColors
                                                                          .whiteCard,
                                                                    ),
                                                                    // const SizedBox(height: 1),
                                                                    TextWidget(
                                                                      text:
                                                                          "${profileController.profilePosts[index].age}",
                                                                      textSize:
                                                                          10,
                                                                      color: AppColors
                                                                          .white54,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(
                                                            height: 0,
                                                            color: AppColors
                                                                .white38,
                                                            thickness: 0.5),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              HtmlWidget(
                                                                "${profileController.profilePosts[index].description}",
                                                                // onTapUrl: (url) async {
                                                                //   return await launch(
                                                                //       url);
                                                                // },
                                                                textStyle: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: AppColors
                                                                        .white),
                                                              ),
                                                              const SizedBox(
                                                                  height: 6),
                                                              if (profileController
                                                                  .profilePosts[
                                                                      index]
                                                                  .pollOptions!
                                                                  .isNotEmpty)
                                                                PollWidgetProfile(
                                                                    pollOptions: profileController
                                                                        .profilePosts[
                                                                            index]
                                                                        .pollOptions!,
                                                                    totalVotes: profileController
                                                                        .profilePosts[
                                                                            index]
                                                                        .totalVotes!,
                                                                    myVotes: profileController
                                                                        .profilePosts[
                                                                            index]
                                                                        .myVotes!),
                                                              profileController
                                                                      .profilePosts[
                                                                          index]
                                                                      .images!
                                                                      .isEmpty
                                                                  ? const SizedBox(
                                                                      height:
                                                                          145)
                                                                  : Column(
                                                                      children: [
                                                                          SizedBox(
                                                                            height:
                                                                                133,
                                                                            child:
                                                                                PageView.builder(
                                                                              controller: _pageController,
                                                                              itemCount: profileController.profilePosts[index].images!.length,
                                                                              onPageChanged: (ind) {
                                                                                setState(() {
                                                                                  _currentIndex = ind;
                                                                                });
                                                                              },
                                                                              itemBuilder: (context, ind) {
                                                                                return Container(
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(12),
                                                                                    image: DecorationImage(
                                                                                      fit: BoxFit.cover,
                                                                                      image: NetworkImage(profileController.profilePosts[index].images![ind]),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                          if (profileController.profilePosts[index].images!.isNotEmpty &&
                                                                              profileController.profilePosts[index].images!.length > 1)
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: List.generate(
                                                                                profileController.profilePosts[index].images!.length,
                                                                                (index) => Container(
                                                                                  margin: const EdgeInsets.only(left: 4, right: 4, top: 8),
                                                                                  width: _currentIndex == index ? 5 : 3,
                                                                                  height: _currentIndex == index ? 5 : 3,
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                    color: _currentIndex == index ? AppColors.primary : AppColors.grey,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                        ])
                                                            ],
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }).toList(),
                                        ),
                            ),
                            const SizedBox(height: 8),

                            Divider(
                              color: AppColors.whiteCard,
                              thickness: 0.5,
                            ),
                            const SizedBox(height: 8),
                            // Card(
                            //   color: AppColors.blackCard,
                            //   surfaceTintColor: AppColors.blackCard,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Container(
                            //         decoration: BoxDecoration(
                            //             color: AppColors.white12,
                            //             borderRadius: const BorderRadius.only(
                            //                 topLeft: Radius.circular(12),
                            //                 topRight: Radius.circular(12))),
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(12.0),
                            //           child: Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.spaceBetween,
                            //             children: [
                            //               const TextWidget(
                            //                 text: "Experience",
                            //                 textSize: 16,
                            //                 fontWeight: FontWeight.w500,
                            //               ),
                            //               InkWell(
                            //                 onTap: () {
                            //                   Get.to(() =>
                            //                       const ExperienceScreen());
                            //                 },
                            //                 child: const Icon(
                            //                   Icons.edit_outlined,
                            //                   color: AppColors.primary,
                            //                   size: 22,
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //       Divider(
                            //         height: 0,
                            //         thickness: 0.2,
                            //         color: AppColors.white,
                            //       ),
                            //       const Padding(
                            //         padding: EdgeInsets.only(
                            //             left: 12, right: 12, bottom: 12),
                            //         child: Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             SizedBox(height: 8),
                            //             TextWidget(
                            //                 text: "Current Company",
                            //                 fontWeight: FontWeight.w300,
                            //                 textSize: 13),
                            //             SizedBox(height: 4),
                            //             TextWidget(
                            //                 text: "Capital Hub",
                            //                 textSize: 15,
                            //                 fontWeight: FontWeight.w500),
                            //             SizedBox(height: 8),
                            //             TextWidget(
                            //                 text: "Designation",
                            //                 fontWeight: FontWeight.w300,
                            //                 textSize: 13),
                            //             SizedBox(height: 4),
                            //             TextWidget(
                            //                 text: "Founder & CEO",
                            //                 textSize: 15,
                            //                 fontWeight: FontWeight.w500),
                            //             SizedBox(height: 8),
                            //             TextWidget(
                            //                 text: "Education",
                            //                 fontWeight: FontWeight.w300,
                            //                 textSize: 13),
                            //             SizedBox(height: 4),
                            //             TextWidget(
                            //                 text:
                            //                     "Graduate, University of Northampton",
                            //                 textSize: 15,
                            //                 fontWeight: FontWeight.w500),
                            //             SizedBox(height: 8),
                            //             TextWidget(
                            //                 text: "Experience",
                            //                 fontWeight: FontWeight.w300,
                            //                 textSize: 13),
                            //             SizedBox(height: 4),
                            //             TextWidget(
                            //                 text:
                            //                     "5+ Years building various startups , Mentored 21 startups Growth \$ 10M+",
                            //                 textSize: 15,
                            //                 maxLine: 3,
                            //                 fontWeight: FontWeight.w500),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // sizedTextfield,

                            Card(
                              color: AppColors.blackCard,
                              surfaceTintColor: AppColors.blackCard,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white12,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const TextWidget(
                                            text: "Personal Information",
                                            textSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => PersonalInfoScreen(
                                                    isEdit: true,
                                                  ));
                                            },
                                            child: const Icon(
                                              Icons.edit_outlined,
                                              color: AppColors.primary,
                                              size: 22,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                    thickness: 0.2,
                                    color: AppColors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12, bottom: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        const TextWidget(
                                            text: "Company",
                                            fontWeight: FontWeight.w300,
                                            textSize: 13),
                                        const SizedBox(height: 4),
                                        TextWidget(
                                            text:
                                                "${profileController.profileData.companyName}",
                                            textSize: 15,
                                            fontWeight: FontWeight.w500),
                                        const SizedBox(height: 8),
                                        const TextWidget(
                                            text: "Designation",
                                            fontWeight: FontWeight.w300,
                                            textSize: 13),
                                        const SizedBox(height: 4),
                                        TextWidget(
                                            text:
                                                "${profileController.profileData.designation}",
                                            textSize: 15,
                                            fontWeight: FontWeight.w500),
                                        const SizedBox(height: 8),
                                        const TextWidget(
                                            text: "Education",
                                            fontWeight: FontWeight.w300,
                                            textSize: 13),
                                        const SizedBox(height: 4),
                                        TextWidget(
                                            text:
                                                "${profileController.profileData.education}",
                                            textSize: 15,
                                            fontWeight: FontWeight.w500),
                                        const SizedBox(height: 8),
                                        const TextWidget(
                                            text: "Experience",
                                            fontWeight: FontWeight.w300,
                                            textSize: 13),
                                        const SizedBox(height: 4),
                                        TextWidget(
                                            text:
                                                "${profileController.profileData.experience}",
                                            textSize: 15,
                                            maxLine: 3,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            sizedTextfield,
                            Card(
                              color: AppColors.blackCard,
                              surfaceTintColor: AppColors.blackCard,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.white12,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const TextWidget(
                                            text: "Bio",
                                            textSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.to(BioScreen(
                                                isEdit: true,
                                              ));
                                            },
                                            child: const Icon(
                                              Icons.edit_outlined,
                                              color: AppColors.primary,
                                              size: 22,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                    thickness: 0.2,
                                    color: AppColors.white,
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12, bottom: 12),
                                    child: TextWidget(
                                        text:
                                            "${profileController.profileData.bio}",
                                        maxLine: 10,
                                        textSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            if (profileController
                                .profileData.companyData!.companyName!.isEmpty)
                              sizedTextfield,
                            if (profileController
                                .profileData.companyData!.companyName!.isEmpty)
                              Card(
                                color: AppColors.blackCard,
                                surfaceTintColor: AppColors.blackCard,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        profileController
                                                                .profileData
                                                                .companyData!
                                                                .logo ??
                                                            ""))),
                                          ),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                text:
                                                    "${profileController.profileData.companyData!.companyName}",
                                                textSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              const SizedBox(height: 4),
                                              TextWidget(
                                                text:
                                                    "${profileController.profileData.companyData!.location} Founded in ${profileController.profileData.companyData!.startedAtDate}",
                                                textSize: 11,
                                              ),
                                              TextWidget(
                                                text:
                                                    "Last funding ${profileController.profileData.companyData!.lastFunding} Sector ${profileController.profileData.companyData!.sector}",
                                                textSize: 11,
                                              ),
                                              TextWidget(
                                                text:
                                                    "Stage ${profileController.profileData.companyData!.stage}",
                                                textSize: 11,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      if (profileController.profileData
                                          .companyData!.description!.isNotEmpty)
                                        Card(
                                          color: AppColors.white12,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: TextWidget(
                                                text:
                                                    "${profileController.profileData.companyData!.description}",
                                                maxLine: 12,
                                                textSize: 13),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            // sizedTextfield,
                            // Card(
                            //     color: AppColors.blackCard,
                            //     surfaceTintColor: AppColors.blackCard,
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(12),
                            //       child: Row(
                            //         children: [
                            //           Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             children: [
                            //               const TextWidget(
                            //                 text: "Add Social Media Links",
                            //                 textSize: 16,
                            //                 fontWeight: FontWeight.w500,
                            //               ),
                            //               const SizedBox(height: 12),
                            //               AppButton.primaryButton(
                            //                   onButtonPressed: () {},
                            //                   title: "Add Link",
                            //                   fontSize: 12,
                            //                   width: 95,
                            //                   bgColor: AppColors.white12,
                            //                   height: 30)
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //     )),
                            if (profileController
                                .profileData.recentConnections!.isNotEmpty)
                              sizedTextfield,
                            if (profileController
                                .profileData.recentConnections!.isNotEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                        text: "Connections",
                                        textSize: 16,
                                        fontWeight: FontWeight.w500),
                                    // TextWidget(
                                    //     text: "See more",
                                    //     textSize: 13,
                                    //     color: AppColors.primary)
                                  ],
                                ),
                              ),
                            if (profileController
                                .profileData.recentConnections!.isNotEmpty)
                              SizedBox(
                                height: 179,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: profileController
                                      .profileData.recentConnections!.length,
                                  padding: const EdgeInsets.only(top: 8),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: Get.width / 2,
                                      child: Card(
                                        color: AppColors.blackCard,
                                        surfaceTintColor: AppColors.blackCard,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 28,
                                                backgroundImage: NetworkImage(
                                                    '${profileController.profileData.recentConnections![index].profilePicture}'),
                                              ),
                                              const SizedBox(height: 6),
                                              TextWidget(
                                                  text:
                                                      "${profileController.profileData.recentConnections![index].firstName} ${profileController.profileData.recentConnections![index].lastName}",
                                                  fontWeight: FontWeight.w500,
                                                  textSize: 14),
                                              TextWidget(
                                                  text:
                                                      "${profileController.profileData.recentConnections![index].designation}",
                                                  textSize: 12),
                                              const SizedBox(height: 8),
                                              AppButton.primaryButton(
                                                  onButtonPressed: () {},
                                                  title: "Message",
                                                  width: 92,
                                                  fontSize: 12,
                                                  height: 32)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            const SizedBox(height: 8),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                      text: "Milestones",
                                      textSize: 16,
                                      fontWeight: FontWeight.w500),
                                  // TextWidget(
                                  //     text: "See more",
                                  //     textSize: 13,
                                  //     color: AppColors.primary)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 220,
                              child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    mileStoneWidget(
                                        profileController
                                            .profileData.milestoneProfile!,
                                        "User profile",
                                        () {}),
                                    mileStoneWidget(
                                        profileController
                                            .profileData.milestoneCompany!,
                                        "Company profile",
                                        () {}),
                                    mileStoneWidget(
                                        profileController
                                            .profileData.milestoneOnelink!,
                                        "One link",
                                        () {}),
                                    mileStoneWidget(
                                        profileController
                                            .profileData.milestoneDocuments!,
                                        "Document upload",
                                        () {}),
                                    mileStoneWidget(
                                        profileController
                                            .profileData.milestonePosts!,
                                        "Create first post",
                                        () {}),
                                  ]),
                            ),
                            const SizedBox(height: 8),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 4),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       const TextWidget(
                            //           text: "Challenges",
                            //           textSize: 16,
                            //           fontWeight: FontWeight.w500),
                            //       InkWell(
                            //         onTap: () {
                            //           Get.to(const ChallengeCategoryScreen());
                            //         },
                            //         child: const TextWidget(
                            //             text: "See more",
                            //             textSize: 13,
                            //             color: AppColors.primary),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 208,
                            //   child: GridView.builder(
                            //     gridDelegate:
                            //         const SliverGridDelegateWithFixedCrossAxisCount(
                            //             crossAxisCount: 2, crossAxisSpacing: 4),
                            //     physics: const NeverScrollableScrollPhysics(),
                            //     itemCount: 2,
                            //     padding: const EdgeInsets.only(top: 8),
                            //     itemBuilder: (BuildContext context, int index) {
                            //       return Card(
                            //         color: AppColors.blackCard,
                            //         surfaceTintColor: AppColors.blackCard,
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(12.0),
                            //           child: Column(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.spaceBetween,
                            //             children: [
                            //               Container(
                            //                 height: 70,
                            //                 width: Get.width / 3,
                            //                 decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(12),
                            //                     image: const DecorationImage(
                            //                         fit: BoxFit.cover,
                            //                         image: NetworkImage(
                            //                             "https://www.investopedia.com/thmb/GMKaRhdGn5dOSqVS-F-q_VtTGek=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/investment-ec4b8aab8c50432a9fd6707ed1c2749a.jpg"))),
                            //               ),
                            //               const TextWidget(
                            //                   text: "7 Days Challeges",
                            //                   textSize: 14),
                            //               AppButton.primaryButton(
                            //                   onButtonPressed: () {},
                            //                   title: "Challenge",
                            //                   fontSize: 12,
                            //                   width: 100,
                            //                   height: 32)
                            //             ],
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  )),
          ),
        ));
  }

  mileStoneWidget(Milestone milestone, String title, Function() ontap) {
    return SizedBox(
      width: Get.width / 2,
      child: Card(
        color: AppColors.blackCard,
        surfaceTintColor: AppColors.blackCard,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 65,
                width: Get.width / 3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(milestone.image!))),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      value: milestone.completion! / 100,
                      strokeWidth: 4.0,
                      strokeCap: StrokeCap.round,
                      backgroundColor: AppColors.whiteCard,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary),
                    ),
                  ),
                  TextWidget(text: "${milestone.completion}%", textSize: 10)
                ],
              ),
              TextWidget(
                  text: "${milestone.description}",
                  maxLine: 2,
                  align: TextAlign.center,
                  textSize: 12),
              AppButton.primaryButton(
                  onButtonPressed: ontap,
                  title: title,
                  fontSize: 12,
                  height: 32)
            ],
          ),
        ),
      ),
    );
  }
}
