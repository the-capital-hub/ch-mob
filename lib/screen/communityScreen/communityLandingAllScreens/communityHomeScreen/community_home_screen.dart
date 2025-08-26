import 'dart:async';
import 'dart:developer';

import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityHomeController/community_home_controller.dart';
import 'package:capitalhub_crm/controller/createPostController/create_post_controller.dart';
import 'package:capitalhub_crm/controller/homeController/home_controller.dart';

import 'package:capitalhub_crm/screen/communityScreen/communityDrawerScreen/community_drawer_screen.dart';
import 'package:capitalhub_crm/screen/createPostScreen/create_post_screen.dart';

import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityHomeScreen/community_polls_widget.dart';
import 'package:capitalhub_crm/screen/homeScreen/widget/fullscreen_image_view.dart';

import 'package:capitalhub_crm/screen/homeScreen/widget/startup_corner_widget.dart';
import 'package:capitalhub_crm/screen/homeScreen/widget/video_player.dart';
import 'package:capitalhub_crm/screen/profileScreen/community_polls_widget_profile.dart';

import 'package:capitalhub_crm/screen/publicProfileScreen/public_profile_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/create_collection.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';

import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityHomeScreen extends StatefulWidget {
  const CommunityHomeScreen({super.key});

  @override
  State<CommunityHomeScreen> createState() => _CommunityHomeScreenState();
}

class _CommunityHomeScreenState extends State<CommunityHomeScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  CreatePostController createCommunityPostController =
      Get.put(CreatePostController());
  CommunityHomeController communityHomeController =
      Get.put(CommunityHomeController());
  HomeController homeController = Get.put(HomeController());
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  late AnimationController _controller;
  late Animation<double> _animation;
  ScrollController scrollController = ScrollController();
  int page = 1;
  bool isPaginationLoad = false;
  bool isCardVisible = false;
  String postFilter = "";

  RxBool isLoading = true.obs;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchAllApis().then((val) {
        {
          isLoading.value = false;
        }
      });
    });
    log(GetStoreData.getStore.read('access_token'));
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isPaginationLoad = true;
        setState(() {});
        communityHomeController
            .getCommunityPosts(++page, false, postFilter)
            .then((val) {
          isPaginationLoad = false;
          setState(() {});
        });
      }
    });

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCirc,
    )..addListener(() {
        setState(() {});
      });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 50, end: 100).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  // Future<void> _fetchAllApis() async {
  //   try {
  //     // Call all APIs concurrently
  //     await Future.wait([
  //       communityHomeController.getCommunityPosts(page, true).then((v) {
  //         _controller.forward();
  //         isCardVisible = communityHomeController.communityPostList.community!.whatsappGroupLink != ""?true:false;
  //       }),
  //       communityHomeController.getSavedCommunityPostCollections(),

  //     ]);
  //   } catch (e) {
  //     print("Error calling APIs: $e");
  //   }
  // }

  Future<void> _fetchAllApis() async {
    try {
      // Call all APIs concurrently
      await Future.wait([
        communityHomeController
            .getCommunityPosts(page, true, postFilter)
            .then((v) {
          _controller.forward();

          // Safely check if communityPostList is not empty and community is not null before accessing whatsappGroupLink
          isCardVisible =
              communityHomeController.communityPostList.isNotEmpty &&
                  communityHomeController.communityLinkData != null &&
                  (communityHomeController
                          .communityLinkData!.whatsappGroupLink?.isNotEmpty ??
                      false);
        }),
        communityHomeController.getSavedCommunityPostCollections(),
      ]);
    } catch (e) {
      print("Error calling APIs: $e");
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _animate(index) {
    _animationController.reset();

    _animationController.forward();
    communityHomeController.communityPostList[index].isLiked = true;
    communityHomeController.likeUnlikeCommunityPost(
        communityHomeController.communityPostList[index].postId);
    Future.delayed(const Duration(milliseconds: 1000), () {
      _animationController.reverse();
    });
    setState(() {});
  }

  Timer? _debounce;
  void onPostTypeChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      await _fetchAllApis();
      Get.back();
      setState(() {});
    });
  }

  int tapindex = -1;

  String privacyStatus = "Public";
  List<String> postsFilter = ['All Posts', 'Admin Posts', 'Member Posts'];
  GlobalKey<PopupMenuButtonState<String>> _popupMenuKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
            backgroundColor: AppColors.transparent,
            body: Obx(
              () =>
                  // isLoading.value
                  //     ? Helper.pageLoading()
                  //     :
                  //  : communityHomeController.communityPostList.postData.isEmpty
                  //       ? Center(child: TextWidget(text: "No Community Post Available", textSize: 16))
                  //       :

                  Padding(
                      padding: EdgeInsets.only(
                          left: 8, right: 8, top: isCardVisible ? 0 : 8),
                      child: RefreshIndicator(
                          onRefresh: () async {
                            return _fetchAllApis();
                          },
                          child: Column(children: [
                            if (isCardVisible)
                              Card(
                                margin: const EdgeInsets.only(
                                    bottom: 8, left: 4, right: 4),
                                color: AppColors.darkGreen,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const TextWidget(
                                              text:
                                                  "Join our Whatsapp Community",
                                              textSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            const TextWidget(
                                                text:
                                                    "Get instant updates and connect with members",
                                                textSize: 10),
                                            const SizedBox(height: 6),
                                            // sizedTextfield,
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 25),
                                              child: AppButton.primaryButton(
                                                  onButtonPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              AppColors
                                                                  .blackCard,
                                                          content: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              const TextWidget(
                                                                text:
                                                                    'Join WhatsApp Group',
                                                                textSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              sizedTextfield,
                                                              const TextWidget(
                                                                maxLine: 3,
                                                                text:
                                                                    'Please enter your phone number to join the community WhatsApp group',
                                                                textSize: 15,
                                                              ),
                                                              sizedTextfield,
                                                              MyCustomTextField.textFieldPhone(
                                                                  borderClr:
                                                                      AppColors
                                                                          .white,
                                                                  textClr:
                                                                      AppColors
                                                                          .white,
                                                                  hintText:
                                                                      "Enter your phone number",
                                                                  controller:
                                                                      communityHomeController
                                                                          .mobileController)
                                                            ],
                                                          ),
                                                          actions: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          50),
                                                              child: AppButton
                                                                  .primaryButton(
                                                                bgColor:
                                                                    AppColors
                                                                        .primary,
                                                                title:
                                                                    'Join Group',
                                                                onButtonPressed:
                                                                    () {
                                                                  if (communityHomeController
                                                                      .mobileController
                                                                      .text
                                                                      .isEmpty) {
                                                                    HelperSnackBar.snackBar(
                                                                        "Error",
                                                                        "Enter a valid phone number");
                                                                  } else {
                                                                    Helper.loader(
                                                                        context);
                                                                    communityHomeController
                                                                        .sendJoinRequest();
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  title: "Join Now",
                                                  textColor:
                                                      AppColors.darkGreen,
                                                  bgColor: AppColors.white,
                                                  height: 30),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: AppColors.white38,
                                          child: Icon(
                                            Icons.close,
                                            color: AppColors.white,
                                            size: 15,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            isCardVisible = false;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(width: 4),
                                InkWell(
                                  onTap: () {
                                    _popupMenuKey.currentState
                                        ?.showButtonMenu();
                                  },
                                  child: Row(
                                    children: [
                                      PopupMenuButton<String>(
                                          key: _popupMenuKey,
                                          color: AppColors.blackCard,
                                          offset: const Offset(0, 50),
                                          onSelected: (value) {
                                            Helper.loader(context);
                                            setState(() {
                                              postFilter = value;
                                            });
                                            onPostTypeChanged();
                                          },
                                          itemBuilder: (context) => [
                                                const PopupMenuItem(
                                                  value: "",
                                                  child: TextWidget(
                                                      text: "All Posts",
                                                      textSize: 14),
                                                ),
                                                const PopupMenuItem(
                                                  value: "admin",
                                                  child: TextWidget(
                                                      text: "Admin Posts",
                                                      textSize: 14),
                                                ),
                                                const PopupMenuItem(
                                                  value: "members",
                                                  child: TextWidget(
                                                      text: "Member Posts",
                                                      textSize: 14),
                                                ),
                                              ],
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: GetStoreData
                                                    .getStore
                                                    .read('isInvestor')
                                                ? AppColors.primaryInvestor
                                                : AppColors.primary,
                                            child: Icon(
                                              Icons.filter_list,
                                              color: GetStoreData.getStore
                                                      .read('isInvestor')
                                                  ? AppColors.black
                                                  : AppColors.white,
                                              size: 25,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: AppButton.primaryButton(
                                      onButtonPressed: () {
                                        Get.to(CreatePostScreen());
                                        log(createCommunityPostController
                                            .isCommunityPost
                                            .toString());
                                        setState(() {
                                          createCommunityPostController
                                              .isCommunityPost = true;

                                          log(createCommunityPostController
                                              .isCommunityPost
                                              .toString());
                                        });
                                      },
                                      title: "Create Post"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    isLoading.value
                                        ? Helper.pageLoading()
                                        : communityHomeController
                                                .communityPostList.isEmpty
                                            ? const Center(
                                                child: TextWidget(
                                                    text:
                                                        "No Posts in this Community",
                                                    textSize: 16))
                                            : Column(
                                                children: [
                                                  Expanded(
                                                    child: ListView.separated(
                                                      controller:
                                                          scrollController,
                                                      itemCount:
                                                          communityHomeController
                                                              .communityPostList
                                                              .length,
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return const SizedBox(
                                                            height: 8);
                                                      },
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        // Show feed postData
                                                        if (index <
                                                            communityHomeController
                                                                .communityPostList
                                                                .length) {
                                                          return feeds(
                                                              index); // Show feed post
                                                        }

                                                        // If there are no more feed postData or news, return an empty widget
                                                        return const SizedBox
                                                            .shrink(); // No more items to display
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                    if (isPaginationLoad)
                                      Positioned(
                                          bottom: 10,
                                          child: SpinKitThreeBounce(
                                              size: 30,
                                              color: GetStoreData.getStore
                                                      .read('isInvestor')
                                                  ? AppColors.primaryInvestor
                                                  : AppColors.primary))
                                  ]),
                            )
                          ]))),
            )));
  }

  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _isExpanded = false;
  feeds(index) {
    return Transform.scale(
        scale: _animation.value,
        child: GestureDetector(
          onDoubleTap: () {
            _animate(index);
            tapindex = index;
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Card(
                elevation: 3,
                shadowColor: AppColors.white38,
                color: AppColors.blackCard,
                surfaceTintColor: AppColors.blackCard,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: communityHomeController
                                  .communityPostList[index].userIsSubscribed!
                              ? AppColors.golden
                              : AppColors.transparent,
                          radius: 22,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                communityHomeController
                                    .communityPostList[index].userImage!),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(PublicProfileScreen(
                                          id: communityHomeController
                                              .communityPostList[index]
                                              .userId!));
                                    },
                                    child: TextWidget(
                                        text:
                                            "${communityHomeController.communityPostList[index].userFirstName} ${communityHomeController.communityPostList[index].userLastName}",
                                        textSize: 14),
                                  ),
                                  const SizedBox(width: 4),
                                  if (communityHomeController
                                      .communityPostList[index]
                                      .userIsSubscribed!)
                                    Image.asset(PngAssetPath.verifyImg,
                                        height: 14),
                                  const SizedBox(width: 4),
                                  TextWidget(
                                    text: communityHomeController
                                        .communityPostList[index].createdAt!,
                                    textSize: 10,
                                    color: AppColors.white54,
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      if (communityHomeController
                                              .communityPostList[index]
                                              .connectionStatus !=
                                          "pending") {
                                        homeController
                                            .followUnfollow(
                                                userId: communityHomeController
                                                    .communityPostList[index]
                                                    .userId!,
                                                connectionStatus:
                                                    communityHomeController
                                                        .communityPostList[
                                                            index]
                                                        .connectionStatus!)
                                            .then((val) {
                                          if (val) {}
                                        });
                                        if (communityHomeController
                                                .communityPostList[index]
                                                .connectionStatus ==
                                            "not_sent") {
                                          communityHomeController
                                              .communityPostList[index]
                                              .connectionStatus = "pending";
                                        } else if (communityHomeController
                                                .communityPostList[index]
                                                .connectionStatus ==
                                            "accepted") {
                                          communityHomeController
                                              .communityPostList[index]
                                              .connectionStatus = "not_sent";
                                        }
                                        setState(() {});
                                      }
                                    },
                                    child: TextWidget(
                                      // text: "",
                                      text: communityHomeController
                                                  .communityPostList[index]
                                                  .connectionStatus ==
                                              "not_sent"
                                          ? "Follow"
                                          : communityHomeController
                                                      .communityPostList[index]
                                                      .connectionStatus ==
                                                  "pending"
                                              ? "Pending"
                                              : "Unfollow",
                                      textSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: GetStoreData.getStore
                                              .read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                    ),
                                  )
                                ],
                              ),
                              // const SizedBox(height: 1),
                              TextWidget(
                                text:
                                    "${communityHomeController.communityPostList[index].userDesignation}  ${communityHomeController.communityPostList[index].userCompany}",
                                textSize: 12,
                                color: AppColors.whiteCard,
                              ),
                              // const SizedBox(height: 1),
                              const TextWidget(text: "Bangalore", textSize: 12),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (communityHomeController
                            .communityPostList[index].isMyPost!)
                          InkWell(
                            onTap: () {
                              feedBottomSheet(index);
                            },
                            child: Icon(
                              Icons.more_vert_rounded,
                              color: AppColors.whiteCard,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Divider(height: 0, color: AppColors.white38, thickness: 0.5),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        HtmlWidget(
                          _isExpanded
                              ? communityHomeController
                                  .communityPostList[index].description
                                  .toString()
                              : communityHomeController.communityPostList[index]
                                          .description!.length >
                                      200
                                  ? "${communityHomeController.communityPostList[index].description!.substring(0, 200)} ..."
                                  : communityHomeController
                                      .communityPostList[index].description!,
                          onTapUrl: (url) async {
                            return await launch(url);
                          },
                          textStyle:
                              TextStyle(fontSize: 12, color: AppColors.white),
                        ),
                        if (communityHomeController
                                .communityPostList[index].description!.length >
                            200)
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                            child: Text(
                              _isExpanded ? "Read Less" : "Read More",
                              style: const TextStyle(
                                  color: AppColors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        const SizedBox(height: 10),
                        if (communityHomeController
                            .communityPostList[index].pollOptions!.isNotEmpty)
                          CommunityPollWidget(
                              pollOptions: communityHomeController
                                  .communityPostList[index].pollOptions!,
                              totalVotes: communityHomeController
                                  .communityPostList[index].totalVotes!,
                              postId: communityHomeController
                                  .communityPostList[index].postId!,
                              myVotes: communityHomeController
                                  .communityPostList[index].myVotes!),
                        const SizedBox(height: 6),
                        if (communityHomeController
                            .communityPostList[index].image!.isNotEmpty)
                          Column(children: [
                            SizedBox(
                              height: 250,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: communityHomeController
                                    .communityPostList[index].image!.length,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                                itemBuilder: (context, ind) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => FullscreenImageView(
                                            imageURl: communityHomeController
                                                .communityPostList[0]
                                                .image![ind],
                                            name: communityHomeController
                                                    .communityPostList[index]
                                                    .userFirstName! +
                                                communityHomeController
                                                    .communityPostList[index]
                                                    .userLastName!));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                communityHomeController
                                                    .communityPostList[index]
                                                    .image![ind]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Page Indicator
                            if (communityHomeController.communityPostList[index]
                                    .image!.isNotEmpty &&
                                communityHomeController.communityPostList[index]
                                        .image!.length >
                                    1)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  communityHomeController
                                      .communityPostList[index].image!.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.only(
                                        left: 4, right: 4, top: 8),
                                    width: _currentIndex == index ? 8 : 5,
                                    height: _currentIndex == index ? 8 : 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentIndex == index
                                          ? GetStoreData.getStore
                                                  .read('isInvestor')
                                              ? AppColors.primaryInvestor
                                              : AppColors.primary
                                          : AppColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                          ]),
                        if (communityHomeController
                            .communityPostList[index].video!.isNotEmpty)
                          VideoPlayerItem(
                            videoUrl: communityHomeController
                                .communityPostList[index].video!,
                          ),
                        if (communityHomeController
                            .communityPostList[index].documentUrl!.isNotEmpty)
                          SizedBox(
                              width: 150,
                              height: 200,
                              child: SfPdfViewer.network(communityHomeController
                                  .communityPostList[index].documentUrl!)),
                        if (communityHomeController.communityPostList[index]
                                    .resharedPostData !=
                                null &&
                            !communityHomeController
                                .communityPostList[index].resharedPostData!
                                .isEmpty())
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.black54),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: "   Reshared Post",
                                    textSize: 12,
                                    color: AppColors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  resharedPostPreview(index),
                                ],
                              ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                        color: Color(0xff54545433)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: LikeButton(
                            size: 22,
                            isLiked: communityHomeController
                                .communityPostList[index].isLiked,
                            likeCount: communityHomeController
                                .communityPostList[index].likeCount!,
                            circleColor: const CircleColor(
                                start: AppColors.redColor,
                                end: Colors.redAccent),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: AppColors.redColor,
                              dotSecondaryColor: Colors.redAccent,
                            ),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isLiked
                                    ? AppColors.redColor
                                    : AppColors.whiteCard,
                                size: 22,
                              );
                            },
                            onTap: (bool isLiked) async {
                              communityHomeController
                                  .communityPostList[index].isLiked = !isLiked;

                              communityHomeController.likeUnlikeCommunityPost(
                                  communityHomeController
                                      .communityPostList[index].postId);

                              return !isLiked;
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              commentBottomSheet(index);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.chat_bubble_text,
                                  color: AppColors.whiteCard,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                // if (homeController.postList[index].commentCount! >
                                //     0)
                                TextWidget(
                                  text:
                                      " ${communityHomeController.communityPostList[index].commentCount!}",
                                  textSize: 14,
                                  color: AppColors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              sharePostPopup(
                                  context,
                                  communityHomeController
                                      .communityPostList[index].postId!,
                                  "");
                            },
                            child: Icon(
                              Icons.ios_share_outlined,
                              color: AppColors.whiteCard,
                              size: 22,
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.to(CreatePostScreen(
                                postid: communityHomeController
                                    .communityPostList[index].postId,
                              ));
                            },
                            child: Icon(
                              Icons.autorenew,
                              color: AppColors.whiteCard,
                              size: 22,
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (communityHomeController
                                  .communityPostList[index].isSaved!) {
                                communityHomeController
                                    .unsaveCommunityPost(
                                  context,
                                  postID: communityHomeController
                                      .communityPostList[index].postId!,
                                )
                                    .then((val) {
                                  communityHomeController
                                      .getCommunityPosts(
                                          page, false, postFilter)
                                      .then((val) {
                                    Get.back();
                                    setState(() {});
                                  });
                                });
                              } else {
                                saveUnsavePost(index);
                              }
                            },
                            child: Icon(
                              communityHomeController
                                      .communityPostList[index].isSaved!
                                  ? Icons.bookmark
                                  : Icons.bookmark_add_outlined,
                              color: AppColors.whiteCard,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              if (tapindex == index)
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _opacityAnimation.value,
                      child: Icon(
                        Icons.favorite,
                        size: _scaleAnimation.value,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
            ],
          ),
        ));
  }

  Widget resharedPostPreview(index) {
    return SizedBox(
      width: Get.width,
      // height: 250,
      child: Card(
        elevation: 3,
        shadowColor: AppColors.white12,
        color: AppColors.blackCard,
        surfaceTintColor: AppColors.blackCard,
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.transparent,
                    radius: 16,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                          '${communityHomeController.communityPostList[index].resharedPostData!.userProfilePicture}'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextWidget(
                                text:
                                    "${communityHomeController.communityPostList[index].resharedPostData!.userFirstName} ${communityHomeController.communityPostList[index].resharedPostData!.userLastName}",
                                textSize: 12),
                            const Expanded(child: SizedBox()),
                            TextWidget(
                              text:
                                  "${communityHomeController.communityPostList[index].resharedPostData!.age}",
                              textSize: 10,
                              color: AppColors.white54,
                            ),
                          ],
                        ),
                        // const SizedBox(height: 1),
                        TextWidget(
                          text:
                              "${communityHomeController.communityPostList[index].resharedPostData!.userDesignation}  ${communityHomeController.communityPostList[index].resharedPostData!.userLocation}",
                          textSize: 10,
                          color: AppColors.whiteCard,
                        ),
                        // const SizedBox(height: 1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 0, color: AppColors.white38, thickness: 0.5),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  HtmlWidget(
                    _isExpanded
                        ? communityHomeController
                            .communityPostList[index].description
                            .toString()
                        : communityHomeController.communityPostList[index]
                                    .description!.length >
                                100
                            ? "${communityHomeController.communityPostList[index].description!.substring(0, 100)} ..."
                            : communityHomeController
                                .communityPostList[index].description
                                .toString(),
                    onTapUrl: (url) async {
                      return await launch(url);
                    },
                    textStyle: TextStyle(fontSize: 10, color: AppColors.white),
                  ),
                  if (communityHomeController
                          .communityPostList[index].description!.length >
                      100)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(
                        _isExpanded ? "Read Less" : "Read More",
                        style: const TextStyle(
                            color: AppColors.blue,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  const SizedBox(height: 6),
                  if (communityHomeController.communityPostList[index]
                              .resharedPostData!.pollOptions !=
                          null &&
                      communityHomeController.communityPostList[index]
                          .resharedPostData!.pollOptions!.isNotEmpty)
                    CommunityPollWidgetProfile(
                        pollOptions: communityHomeController
                            .communityPostList[index]
                            .resharedPostData!
                            .pollOptions!,
                        totalVotes: communityHomeController
                            .communityPostList[index]
                            .resharedPostData!
                            .totalVotes!,
                        myVotes: communityHomeController
                            .communityPostList[index]
                            .resharedPostData!
                            .myVotes!),
                  communityHomeController.communityPostList[index]
                                  .resharedPostData!.images !=
                              null &&
                          communityHomeController.communityPostList[index]
                              .resharedPostData!.images!.isEmpty
                      ? const SizedBox(height: 0)
                      : Column(children: [
                          if (communityHomeController.communityPostList[index]
                                  .resharedPostData!.images !=
                              null)
                            SizedBox(
                              height: 133,
                              child: PageView.builder(
                                itemCount: communityHomeController
                                    .communityPostList[index]
                                    .resharedPostData!
                                    .images!
                                    .length,
                                onPageChanged: (ind) {},
                                itemBuilder: (context, ind) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            communityHomeController
                                                .communityPostList[index]
                                                .resharedPostData!
                                                .images![ind]),
                                      ),
                                    ),
                                  );
                                },
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
  }

  startupCorner() {
    return AutoScrollListView();
  }

  int calculateTotalItems(int feedLength, int newsLength) {
    int newsSlots = (feedLength ~/ 3).clamp(0, newsLength);
    return feedLength + newsSlots + 1;
  }

  // bool isLiked = false;
  feedBottomSheet(index) {
    String reportReason = "";
    bool isExpanded = false;
    return Get.bottomSheet(backgroundColor: AppColors.blackCard,
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Container(
        width: Get.width,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Container(
              height: 3,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.whiteCard),
            ),
            if (communityHomeController.communityPostList[index].isMyPost!)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      communityHomeController
                          .deleteCommunityPost(context,
                              postID: communityHomeController
                                  .communityPostList[index].postId!)
                          .then((val) {
                        if (val) {
                          isLoading.value = true;
                          return _fetchAllApis().then((val) {
                            {
                              isLoading.value = false;
                            }
                          });
                        }
                      });
                    },
                    leading: Icon(Icons.delete, color: AppColors.white),
                    title: const TextWidget(
                      text: "Delete",
                      textSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (communityHomeController
                      .communityPostList[index].isMyPost!)
                    Theme(
                      data: ThemeData(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        collapsedIconColor: AppColors.white,
                        iconColor: AppColors.white,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.report, color: AppColors.white),
                            const SizedBox(width: 16),
                            TextWidget(
                                text: "Report",
                                textSize: 14,
                                color: AppColors.white,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                        onExpansionChanged: (bool expanded) {
                          setState(() {
                            isExpanded = expanded; // Track expansion state
                          });
                        },
                        childrenPadding: const EdgeInsets.only(left: 40),
                        children: [
                          ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            title: const TextWidget(
                                text: "Harassment",
                                textSize: 14,
                                fontWeight: FontWeight.w500),
                            tileColor: reportReason == "Harassment"
                                ? AppColors.white38
                                : null,
                            onTap: () {
                              reportReason = "Harassment";
                              setState(() {});
                            },
                          ),
                          ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            title: const TextWidget(
                                text: "Spam",
                                textSize: 14,
                                fontWeight: FontWeight.w500),
                            tileColor: reportReason == "Spam"
                                ? AppColors.white38
                                : null,
                            onTap: () {
                              reportReason = "Spam";
                              setState(() {});
                            },
                          ),
                          ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            title: const TextWidget(
                                text: "Fraud or scam",
                                textSize: 14,
                                fontWeight: FontWeight.w500),
                            tileColor: reportReason == "Fraud or scam"
                                ? AppColors.white38
                                : null,
                            onTap: () {
                              reportReason = "Fraud or scam";
                              setState(() {});
                            },
                          ),
                          ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            title: const TextWidget(
                                text: "Hateful Speech",
                                textSize: 14,
                                fontWeight: FontWeight.w500),
                            tileColor: reportReason == "Hateful Speech"
                                ? AppColors.white38
                                : null,
                            onTap: () {
                              reportReason = "Hateful Speech";
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 12),
                  if (isExpanded && reportReason != "")
                    Padding(
                      padding: const EdgeInsets.only(left: 43),
                      child: AppButton.primaryButton(
                          onButtonPressed: () {
                            Helper.loader(context);
                            communityHomeController
                                .reportPost(
                                    postID: communityHomeController
                                        .communityPostList[index].postId!,
                                    reportReason: reportReason)
                                .then((val) {
                              if (val) {
                                communityHomeController.getCommunityPosts(
                                    1, true, postFilter);
                              }
                            });
                          },
                          title: "Submit report"),
                    )
                ],
              ),
          ],
        ),
      );
    }));
  }

  commentBottomSheet(Index) {
    return Get.bottomSheet(
      backgroundColor: AppColors.blackCard,
      StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Container(
            height: Get.height / 1.5,
            width: Get.width,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                Container(
                  height: 3,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.whiteCard),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: communityHomeController
                        .communityPostList[Index].comments!.length,
                    itemBuilder: (BuildContext context, int ind) {
                      return ListTile(
                        visualDensity: VisualDensity.compact,
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              '${communityHomeController.communityPostList[Index].comments![ind].userImage}'),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text:
                                  "${communityHomeController.communityPostList[Index].comments![ind].user}",
                              textSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            TextWidget(
                              text:
                                  "${communityHomeController.communityPostList[Index].comments![ind].userDesignation} and ${communityHomeController.communityPostList[Index].comments![ind].userCompany}",
                              textSize: 12,
                              color: AppColors.white54,
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: TextWidget(
                              text:
                                  "${communityHomeController.communityPostList[Index].comments![ind].text}",
                              textSize: 14),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (communityHomeController
                                    .communityPostList[Index]
                                    .comments![ind]
                                    .isMyComment!)
                                  InkWell(
                                      onTap: () {
                                        communityHomeController
                                            .deleteCommentCommunityPost(context,
                                                postID: communityHomeController
                                                    .communityPostList[Index]
                                                    .postId!,
                                                commentID:
                                                    communityHomeController
                                                        .communityPostList[
                                                            Index]
                                                        .comments![ind]
                                                        .id!)
                                            .then((val) {
                                          if (val) {
                                            communityHomeController
                                                .getCommunityPosts(
                                                    page, false, postFilter)
                                                .then((val) {
                                              setState(() {});
                                            });
                                          }
                                        });
                                      },
                                      child: Icon(Icons.delete,
                                          color: AppColors.white, size: 18)),
                                const SizedBox(width: 4),
                                TextWidget(
                                    text:
                                        "${communityHomeController.communityPostList[Index].comments![ind].createdAt}",
                                    textSize: 12),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  splashColor: AppColors.transparent,
                                  onTap: () {
                                    communityHomeController
                                            .communityPostList[Index]
                                            .comments![ind]
                                            .isLiked =
                                        !communityHomeController
                                            .communityPostList[Index]
                                            .comments![ind]
                                            .isLiked!;
                                    communityHomeController
                                        .toggleLikeCommentCommunityPost(context,
                                            postID: communityHomeController
                                                .communityPostList[Index]
                                                .postId!,
                                            commentID: communityHomeController
                                                .communityPostList[Index]
                                                .comments![ind]
                                                .id!)
                                        .then((val) {
                                      if (val) {
                                        commentController.clear();
                                        communityHomeController
                                            .getCommunityPosts(
                                                page, false, postFilter)
                                            .then((val) {
                                          setState(() {});
                                        });
                                      }
                                    });
                                    ;
                                    setState(() {});
                                  },
                                  child: Icon(
                                    communityHomeController
                                            .communityPostList[Index]
                                            .comments![ind]
                                            .isLiked!
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: communityHomeController
                                            .communityPostList[Index]
                                            .comments![ind]
                                            .isLiked!
                                        ? AppColors.redColor
                                        : AppColors.whiteCard,
                                    size: 15,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                TextWidget(
                                    text:
                                        "${communityHomeController.communityPostList[Index].comments![ind].likesCount}",
                                    textSize: 14),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: MyCustomTextField.textField(
                          borderClr: AppColors.white,
                          hintText: "Add a comment",
                          suffixIcon: InkWell(
                            onTap: () {
                              if (commentController.text.isNotEmpty) {
                                communityHomeController
                                    .commentCommunityPost(context,
                                        postID: communityHomeController
                                            .communityPostList[Index].postId!,
                                        userId: GetStoreData.getStore
                                            .read('id')
                                            .toString(),
                                        text: commentController.text)
                                    .then((val) {
                                  if (val) {
                                    commentController.clear();
                                    communityHomeController
                                        .getCommunityPosts(
                                            page, false, postFilter)
                                        .then((val) {
                                      setState(() {});
                                    });
                                  }
                                });
                              }
                            },
                            child: Icon(
                              CupertinoIcons.arrow_up_right_circle_fill,
                              size: 35,
                              color: AppColors.white,
                            ),
                          ),
                          controller: commentController),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  saveUnsavePost(Index) {
    return Get.bottomSheet(
      backgroundColor: AppColors.blackCard,
      StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Container(
            height: Get.height / 1.5,
            width: Get.width,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                Container(
                  height: 3,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.whiteCard),
                ),
                Expanded(
                  child: communityHomeController.communityCollectionList.isEmpty
                      ? const Center(
                          child: TextWidget(
                            text: "No Collection Found",
                            textSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : ListView.builder(
                          itemCount: communityHomeController
                              .communityCollectionList.length,
                          itemBuilder: (BuildContext context, int ind) {
                            return ListTile(
                                onTap: () {
                                  communityHomeController
                                      .saveCommunityPost(context,
                                          postID: communityHomeController
                                              .communityPostList[Index].postId!,
                                          colelctionName:
                                              communityHomeController
                                                  .communityCollectionList[ind]
                                                  .name)
                                      .then((val) {
                                    if (val) {
                                      communityHomeController
                                          .getCommunityPosts(
                                              page, false, postFilter)
                                          .then((v) {
                                        Get.back();
                                        Get.back();
                                      });
                                    }
                                  });
                                },
                                title: TextWidget(
                                  text:
                                      "${communityHomeController.communityCollectionList[ind].name}",
                                  textSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                trailing: Icon(Icons.add_circle_outline_rounded,
                                    color:
                                        GetStoreData.getStore.read('isInvestor')
                                            ? AppColors.black
                                            : AppColors.white,
                                    size: 26));
                          },
                        ),
                ),
                const SizedBox(height: 8),
                AppButton.outlineButton(
                    borderRadius: 12,
                    borderColor: AppColors.white,
                    onButtonPressed: () {
                      createCollectionPopup(context, Index, page).then((val) {
                        setState(() {});
                      });
                    },
                    title: "Create New Collection +")
              ],
            ),
          );
        },
      ),
    ).whenComplete(() {
      setState(() {});
    });
  }

  TextEditingController commentController = TextEditingController();
}
