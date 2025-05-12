import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:capitalhub_crm/controller/homeController/home_controller.dart';
import 'package:capitalhub_crm/controller/newsController/news_controller.dart';
import 'package:capitalhub_crm/controller/notificationController/notification_controller.dart';
import 'package:capitalhub_crm/controller/profileController/profile_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/createPostScreen/create_post_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/homeScreen/widget/communities_corner_widget.dart';
import 'package:capitalhub_crm/screen/homeScreen/widget/fullscreen_image_view.dart';
import 'package:capitalhub_crm/screen/homeScreen/widget/polls_widget.dart';
import 'package:capitalhub_crm/screen/homeScreen/widget/startup_corner_widget.dart';
import 'package:capitalhub_crm/screen/homeScreen/widget/video_player.dart';
import 'package:capitalhub_crm/screen/publicProfileScreen/public_profile_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/paymentService/payment_service.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/create_collection.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../main.dart';
import '../../utils/constant/app_var.dart';
import '../../utils/constant/asset_constant.dart';
import '../../utils/helper/placeholder.dart';
import '../../utils/notificationService/local_notification_service.dart';
import '../chatScreen/chat_member_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../notificationScreen/notification_screen.dart';
import '../profileScreen/polls_widget_profile.dart';
import '../resourceScreen/resource_template.dart';
import '../subscriptionScreen/subscription_screen.dart';
import 'widget/animation_feed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  HomeController homeController = Get.put(HomeController());
  NewsController newsController = Get.put(NewsController());
  ProfileController profileController = Get.put(ProfileController());
  NotificaitonController notificaitonController =
      Get.put(NotificaitonController());
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  // late AnimationController _controller;
  ScrollController scrollController = ScrollController();
  int page = 1;
  bool isPaginationLoad = false;

  RxBool isLoading = true.obs;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      // Get.offAll(const SignupInfoScreen());
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
        homeController.getPublicPost(++page, false).then((val) {
          isPaginationLoad = false;
          setState(() {});
        });
      }
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

  Future<void> _fetchAllApis() async {
    try {
      // Call all APIs concurrently
      await Future.wait([
        newsController.getTodaysNews(),
        homeController.getPublicPost(page, true).then((v) {
          // _controller.forward();
        }),
        homeController.geCommunityCorner(),
        homeController.getUserCollection(),
        homeController.getStartupNews(offSet: 10)
      ]);
    } catch (e) {
      print("Error calling APIs: $e");
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    // _controller.dispose();

    super.dispose();
  }

  void _animate(index) {
    _animationController.reset();

    _animationController.forward();
    if (!homeController.postList[index].isLiked!) {
      homeController.postList[index].isLiked = true;
      homeController.postList[index].likeCount =
          (homeController.postList[index].likeCount ?? 0) + 1;

      homeController.likeUnlike(homeController.postList[index].postId);
    }

    Future.delayed(const Duration(milliseconds: 1000), () {
      _animationController.reverse();
    });

    setState(() {});
  }

 
  TextEditingController searchController = TextEditingController();
  int tapindex = -1;
  @override
  Widget build(BuildContext context) {
    // final ResourceController resourceController = Get.put(ResourceController());
    return Container(
        decoration: bgDec,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {
            // Get.to(() => LandingScreenNew());
          }),
          backgroundColor: AppColors.transparent,
          drawer: GetStoreData.getStore.read('isInvestor')
              ? const DrawerWidgetInvestor()
              : const DrawerWidget(),
          appBar: AppBar(
            backgroundColor: AppColors.black,
            iconTheme: IconThemeData(color: AppColors.white),
            titleSpacing: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: getGreeting(), textSize: 12),
                const SizedBox(height: 3),
                TextWidget(
                    text: "${GetStoreData.getStore.read('name')}",
                    textSize: 16),
              ],
            ),
            actions: [
              if (!GetStoreData.getStore.read('isSubscribed'))
                InkWell(
                    onTap: () {
                      Get.to(SubscriptionScreen(fromCampaign: false));
                    },
                    child: Image.asset(
                      PngAssetPath.subscribeImg,
                      height: 35,
                    )),
              const SizedBox(width: 12),
              InkWell(
                  onTap: () {
                    Get.to(const NotificationScreen())!.whenComplete(() {
                      notificaitonController.getNotificationCount();
                    });
                  },
                  child: Obx(() => Stack(
                        children: [
                          const Icon(Icons.notifications_none_sharp),
                          if (notificaitonController.notificationCount.value !=
                              "0")
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: AppColors.redColor,
                              child: TextWidget(
                                  text: notificaitonController
                                      .notificationCount.value,
                                  textSize: 8),
                            )
                        ],
                      ))),
              const SizedBox(width: 10),
              InkWell(
                  onTap: () {
                    Get.to(const ChatMemberScreen());
                  },
                  child: const Icon(
                    CupertinoIcons.chat_bubble_text,
                    size: 22,
                  )),
              const SizedBox(width: 10),
            ],
          ),
          body: Obx(() => isLoading.value
              ? ShimmerLoader.shimmerLoading()
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          return _fetchAllApis();
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                controller: scrollController,
                                itemCount: calculateTotalItems(
                                        homeController.postList.length,
                                        newsController.newsList.length) +
                                    1,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 8);
                                },
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0) {
                                    return InkWell(
                                      onTap: () => Get.to(
                                          () => const ResourceTemplate()),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(PngAssetPath.foxImg,
                                                height: 40, width: 40),
                                            const SizedBox(width: 10),
                                            const Text(
                                              'Join Hustlers Club Now',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  index = index - 1;
                                  int feedIndex = index -
                                      (index ~/
                                          4); // Account for the startup section and news posts

                                  // Calculate the news index
                                  int newsIndex = (index - (index ~/ 4)) ~/
                                      4; // News posts appear after every 3 feed posts

                                  // Insert Startup Corner after every 3 feed posts, once only
                                  if (feedIndex == 3 &&
                                      index > 2 &&
                                      (index - 3) % 4 == 0) {
                                    return startupCorner();
                                  }

                                  // Show news after every 3 feed posts
                                  if ((index + 1) % 4 == 0 &&
                                      newsIndex <
                                          newsController.newsList.length) {
                                    return news(
                                        newsIndex); // Show news after every 3 feed posts
                                  }

                                  // Show feed posts
                                  if (feedIndex <
                                      homeController.postList.length) {
                                    return feeds(feedIndex); // Show feed post
                                  }

                                  // If there are no more feed posts or news, return an empty widget
                                  return const SizedBox
                                      .shrink(); // No more items to display
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isPaginationLoad)
                      Positioned(
                          bottom: 10,
                          child: SpinKitThreeBounce(
                              size: 30,
                              color: GetStoreData.getStore.read('isInvestor')
                                  ? AppColors.primaryInvestor
                                  : AppColors.primary))
                  ],
                )),
        ));
  }

  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _isExpanded = false;
  feeds(index) {
    return AnimatedFeedItem(
        index: index,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              homeController.postList[index].userIsSubscribed!
                                  ? AppColors.golden
                                  : AppColors.transparent,
                          radius: 22,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                '${homeController.postList[index].userImage}'),
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
                                          id: homeController
                                              .postList[index].userId!));
                                    },
                                    child: TextWidget(
                                        text:
                                            "${homeController.postList[index].userFirstName} ${homeController.postList[index].userLastName}",
                                        textSize: 14),
                                  ),
                                  const SizedBox(width: 4),
                                  if (homeController
                                      .postList[index].userIsSubscribed!)
                                    Image.asset(PngAssetPath.verifyImg,
                                        height: 14),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: TextWidget(
                                      text:
                                          "${homeController.postList[index].createdAt}",
                                      textSize: 10,
                                      color: AppColors.white54,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  InkWell(
                                    onTap: () {
                                      if (homeController.postList[index]
                                              .connectionStatus !=
                                          "pending") {
                                        homeController
                                            .followUnfollow(
                                                userId: homeController
                                                    .postList[index].userId!,
                                                connectionStatus: homeController
                                                    .postList[index]
                                                    .connectionStatus!)
                                            .then((val) {
                                          if (val) {}
                                        });
                                        if (homeController.postList[index]
                                                .connectionStatus ==
                                            "not_sent") {
                                          homeController.postList[index]
                                              .connectionStatus = "pending";
                                        } else if (homeController
                                                .postList[index]
                                                .connectionStatus ==
                                            "accepted") {
                                          homeController.postList[index]
                                              .connectionStatus = "not_sent";
                                        }
                                        setState(() {});
                                      }
                                    },
                                    child: TextWidget(
                                      // text: "",
                                      text: homeController.postList[index]
                                                  .connectionStatus ==
                                              "not_sent"
                                          ? "Follow"
                                          : homeController.postList[index]
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
                              if (homeController.postList[index]
                                      .userDesignation!.isNotEmpty ||
                                  homeController
                                      .postList[index].userCompany!.isNotEmpty)
                                TextWidget(
                                  text:
                                      "${homeController.postList[index].userDesignation}  ${homeController.postList[index].userCompany}",
                                  textSize: 12,
                                  maxLine: 2,
                                  color: AppColors.whiteCard,
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            feedBottomSheet(index).then((v) {
                              setState(() {});
                            });
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
                              ? "${homeController.postList[index].description}"
                              : homeController
                                          .postList[index].description!.length >
                                      500
                                  ? "${homeController.postList[index].description!.substring(0, 500)} ..."
                                  : homeController.postList[index].description!,
                          onTapUrl: (url) async {
                            return await launch(url);
                          },
                          textStyle: TextStyle(
                              fontSize:
                                  (MediaQuery.of(context).size.width / 375) *
                                      12,
                              color: AppColors.white),
                        ),
                        if (homeController.postList[index].description!.length >
                            500)
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
                        if (homeController
                            .postList[index].pollOptions!.isNotEmpty)
                          const SizedBox(height: 10),
                        if (homeController
                            .postList[index].pollOptions!.isNotEmpty)
                          PollWidget(
                              pollOptions:
                                  homeController.postList[index].pollOptions!,
                              totalVotes:
                                  homeController.postList[index].totalVotes!,
                              postId: homeController.postList[index].postId!,
                              myVotes: homeController.postList[index].myVotes!),
                        const SizedBox(height: 6),
                        if (homeController.postList[index].image!.isNotEmpty)
                          Column(children: [
                            SizedBox(
                              height: 250,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: homeController
                                    .postList[index].image!.length,
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
                                            imageURl: homeController
                                                .postList[index].image![ind],
                                            name: homeController.postList[index]
                                                    .userFirstName! +
                                                homeController.postList[index]
                                                    .userLastName!));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(homeController
                                                .postList[index].image![ind]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Page Indicator
                            if (homeController
                                    .postList[index].image!.isNotEmpty &&
                                homeController.postList[index].image!.length >
                                    1)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  homeController.postList[index].image!.length,
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
                        if (homeController
                            .postList[index].video_url!.isNotEmpty)
                          VideoPlayerItem(
                            videoUrl: homeController.postList[index].video_url!,
                          ),
                        if (homeController
                            .postList[index].document_url!.isNotEmpty)
                          SizedBox(
                              width: 150,
                              height: 200,
                              child: SfPdfViewer.network(homeController
                                  .postList[index].document_url!)),
                        if (homeController.postList[index].resharedPostData !=
                                null &&
                            !homeController.postList[index].resharedPostData!
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
                            isLiked: homeController.postList[index].isLiked,
                            likeCount:
                                homeController.postList[index].likeCount!,
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
                              homeController.postList[index].isLiked = !isLiked;
                              homeController.postList[index].likeCount = isLiked
                                  ? homeController.postList[index].likeCount! -
                                      1
                                  : homeController.postList[index].likeCount! +
                                      1;

                              homeController.likeUnlike(
                                  homeController.postList[index].postId);

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
                                      " ${homeController.postList[index].commentCount!}",
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
                              sharePostPopup(context,
                                  homeController.postList[index].postId!, "");
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
                                postid: homeController.postList[index].postId,
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
                              if (homeController.postList[index].isSaved!) {
                                homeController
                                    .unSavePost(
                                  context,
                                  postID:
                                      homeController.postList[index].postId!,
                                )
                                    .then((val) {
                                  homeController
                                      .getPublicPost(page, false)
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
                              homeController.postList[index].isSaved!
                                  ? Icons.bookmark
                                  : Icons.bookmark_add_outlined,
                              color: AppColors.whiteCard,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
                          '${homeController.postList[index].resharedPostData!.userProfilePicture}'),
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
                                    "${homeController.postList[index].resharedPostData!.userFirstName} ${homeController.postList[index].resharedPostData!.userLastName}",
                                textSize: 12),
                            const Expanded(child: SizedBox()),
                            TextWidget(
                              text:
                                  "${homeController.postList[index].resharedPostData!.age}",
                              textSize: 10,
                              color: AppColors.white54,
                            ),
                          ],
                        ),
                        // const SizedBox(height: 1),
                        TextWidget(
                          text:
                              "${homeController.postList[index].resharedPostData!.userDesignation}  ${homeController.postList[index].resharedPostData!.userLocation}",
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
                        ? "${homeController.postList[index].description}"
                        : homeController.postList[index].description!.length >
                                100
                            ? "${homeController.postList[index].description!.substring(0, 100)} ..."
                            : homeController.postList[index].description!,
                    onTapUrl: (url) async {
                      return await launch(url);
                    },
                    textStyle: TextStyle(fontSize: 10, color: AppColors.white),
                  ),
                  if (homeController.postList[index].description!.length > 100)
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
                  if (homeController
                              .postList[index].resharedPostData!.pollOptions !=
                          null &&
                      homeController.postList[index].resharedPostData!
                          .pollOptions!.isNotEmpty)
                    PollWidgetProfile(
                        pollOptions: homeController
                            .postList[index].resharedPostData!.pollOptions!,
                        totalVotes: homeController
                            .postList[index].resharedPostData!.totalVotes!,
                        myVotes: homeController
                            .postList[index].resharedPostData!.myVotes!),
                  homeController.postList[index].resharedPostData!.images !=
                              null &&
                          homeController
                              .postList[index].resharedPostData!.images!.isEmpty
                      ? const SizedBox(height: 0)
                      : Column(children: [
                          if (homeController
                                  .postList[index].resharedPostData!.images !=
                              null)
                            SizedBox(
                              height: 133,
                              child: PageView.builder(
                                itemCount: homeController.postList[index]
                                    .resharedPostData!.images!.length,
                                onPageChanged: (ind) {},
                                itemBuilder: (context, ind) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(homeController
                                            .postList[index]
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

  news(index) {
    return Card(
      color: AppColors.blackCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: CachedNetworkImage(
                height: 200, width: double.infinity,
                imageUrl: newsController.newsList[index].image!,
                placeholder: (context, url) => const SizedBox(
                  height: 200,
                  child: Center(
                      child: SpinKitThreeBounce(size: 30, color: Colors.white)),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover, // Image fit style
              )
              // Image.network(
              //   newsController.newsList[index].image!,
              //   width: double.infinity,
              //   height: 200,
              //   fit: BoxFit.cover,
              // ),
              ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                TextWidget(
                  text: '${newsController.newsList[index].title}',
                  textSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 8),
                TextWidget(
                    text: '${newsController.newsList[index].subtitle}',
                    textSize: 14,
                    maxLine: 10,
                    color: AppColors.whiteCard),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Helper.launchUrl(
                          "${newsController.newsList[index].readmoreUrl}");
                    },
                    child: const TextWidget(
                      text: 'Read More',
                      color: AppColors.blue,
                      textSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  startupCorner() {
    return Column(
      children: [AutoScrollListView(), CommunitiesCornerWidget()],
    );
  }

  int calculateTotalItems(int feedLength, int newsLength) {
    int newsSlots = (feedLength ~/ 3).clamp(0, newsLength);
    return feedLength + newsSlots + 1;
  }

  // bool isLiked = false;
  Future feedBottomSheet(index) {
    String reportReason = "";
    bool isExpanded = false;
    return Get.bottomSheet(backgroundColor: AppColors.blackCard,
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return Container(
        // height: 251,
        width: Get.width,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 3,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.whiteCard),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (homeController.postList[index].isMyPost!)
                    ListTile(
                      onTap: () {
                        homeController
                            .addPostFeature(context,
                                postID: homeController.postList[index].postId!)
                            .then((val) {
                          Get.back();
                        });
                      },
                      leading: Icon(Icons.post_add, color: AppColors.white),
                      title: const TextWidget(
                        text: "Featured",
                        textSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (homeController.postList[index].isMyPost!)
                    ListTile(
                      onTap: () {
                        homeController
                            .postDelete(context,
                                postID: homeController.postList[index].postId!)
                            .then((val) {
                          if (val) {
                            Get.back(closeOverlays: true);
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
                  if (homeController.postList[index].isMyPost!)
                    ListTile(
                      onTap: () {
                        homeController
                            .addPostCompany(context,
                                postID: homeController.postList[index].postId!)
                            .then((val) {
                          Get.back();
                        });
                      },
                      leading: Icon(Icons.add_circle_outline,
                          color: AppColors.white),
                      title: const TextWidget(
                        text: "Company",
                        textSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  // if (homeController.postList[index].isMyPost!)
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
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          isExpanded = expanded;
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
                            fontWeight: FontWeight.w500,
                          ),
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
                            fontWeight: FontWeight.w500,
                          ),
                          tileColor:
                              reportReason == "Spam" ? AppColors.white38 : null,
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
                            fontWeight: FontWeight.w500,
                          ),
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
                            fontWeight: FontWeight.w500,
                          ),
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
                            Get.back();
                            Helper.loader(context);
                            homeController
                                .reportPost(
                                    postID:
                                        homeController.postList[index].postId!,
                                    reportReason: reportReason)
                                .then((val) {
                              if (val) {
                                homeController.getPublicPost(1, true);
                              }
                            });
                          },
                          title: "Submit report"),
                    )
                ],
              ),
            ],
          ),
        ),
      );
    }));
  }

  commentBottomSheet(Index) {
    return Get.bottomSheet(
      backgroundColor: AppColors.blackCard,
      StatefulBuilder(
        builder: (BuildContext context, setStates) {
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
                  child: homeController.postList[Index].comments!.isEmpty
                      ? const Center(
                          child:
                              TextWidget(text: "No Comments Yet", textSize: 14))
                      : ListView.builder(
                          itemCount:
                              homeController.postList[Index].comments!.length,
                          itemBuilder: (BuildContext context, int ind) {
                            return ListTile(
                              visualDensity: VisualDensity.compact,
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    '${homeController.postList[Index].comments![ind].userImage}'),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text:
                                        "${homeController.postList[Index].comments![ind].user}",
                                    textSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  TextWidget(
                                    text:
                                        "${homeController.postList[Index].comments![ind].userDesignation} and ${homeController.postList[Index].comments![ind].userCompany}",
                                    textSize: 12,
                                    color: AppColors.white54,
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: TextWidget(
                                    text:
                                        "${homeController.postList[Index].comments![ind].text}",
                                    textSize: 14),
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (homeController.postList[Index]
                                          .comments![ind].isMyComment!)
                                        InkWell(
                                            onTap: () {
                                              homeController
                                                  .commentDelete(context,
                                                      postID: homeController
                                                          .postList[Index]
                                                          .postId!,
                                                      commentID: homeController
                                                          .postList[Index]
                                                          .comments![ind]
                                                          .id!)
                                                  .then((val) {
                                                if (val) {
                                                  homeController
                                                      .getPublicPost(page, true)
                                                      .then((val) {
                                                    setState(() {});
                                                  });
                                                }
                                              });
                                            },
                                            child: Icon(Icons.delete,
                                                color: AppColors.white,
                                                size: 18)),
                                      const SizedBox(width: 4),
                                      TextWidget(
                                          text:
                                              "${homeController.postList[Index].comments![ind].createdAt}",
                                          textSize: 12),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        splashColor: AppColors.transparent,
                                        onTap: () {
                                          homeController.postList[Index]
                                                  .comments![ind].isLiked =
                                              !homeController.postList[Index]
                                                  .comments![ind].isLiked!;
                                          setStates(() {});
                                          homeController
                                              .commentLikeDislike(context,
                                                  postID: homeController
                                                      .postList[Index].postId!,
                                                  commentID: homeController
                                                      .postList[Index]
                                                      .comments![ind]
                                                      .id!)
                                              .then((val) {
                                            if (val) {
                                              homeController
                                                  .postList[Index]
                                                  .comments![ind]
                                                  .likesCount = homeController
                                                      .postList[Index]
                                                      .comments![ind]
                                                      .isLiked!
                                                  ? (int.parse(homeController
                                                              .postList[Index]
                                                              .comments![ind]
                                                              .likesCount!) +
                                                          1)
                                                      .toString()
                                                  : (int.parse(homeController
                                                              .postList[Index]
                                                              .comments![ind]
                                                              .likesCount!) -
                                                          1)
                                                      .toString();

                                              setStates(() {});
                                            }
                                          });
                                        },
                                        child: Icon(
                                          homeController.postList[Index]
                                                  .comments![ind].isLiked!
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          color: homeController.postList[Index]
                                                  .comments![ind].isLiked!
                                              ? AppColors.redColor
                                              : AppColors.whiteCard,
                                          size: 15,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      TextWidget(
                                          text:
                                              "${homeController.postList[Index].comments![ind].likesCount}",
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
                                homeController
                                    .commentPost(context,
                                        postID: homeController
                                            .postList[Index].postId!,
                                        userId: GetStoreData.getStore
                                            .read('id')
                                            .toString(),
                                        text: commentController.text)
                                    .then((val) {
                                  if (val) {
                                    commentController.clear();
                                    homeController
                                        .getPublicPost(page, false)
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
                  child: homeController.collectionList.isEmpty
                      ? const Center(
                          child: TextWidget(
                            text: "No Collection Found",
                            textSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : ListView.builder(
                          itemCount: homeController.collectionList.length,
                          itemBuilder: (BuildContext context, int ind) {
                            return ListTile(
                                onTap: () {
                                  homeController
                                      .savePost(context,
                                          postID: homeController
                                              .postList[Index].postId!,
                                          colelctionName: homeController
                                              .collectionList[ind].name!)
                                      .then((val) {
                                    if (val) {
                                      homeController
                                          .getPublicPost(page, false)
                                          .then((v) {
                                        Get.back();
                                        Get.back();
                                      });
                                    }
                                  });
                                },
                                title: TextWidget(
                                  text:
                                      "${homeController.collectionList[ind].name}",
                                  textSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                trailing: Icon(Icons.add_circle_outline_rounded,
                                    color: AppColors.white, size: 26));
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

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }
}
