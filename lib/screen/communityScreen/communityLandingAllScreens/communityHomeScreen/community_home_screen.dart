import 'dart:developer';

import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityHomeController/community_home_controller.dart';
import 'package:capitalhub_crm/controller/createPostController/create_post_controller.dart';
import 'package:capitalhub_crm/controller/homeController/home_controller.dart';

import 'package:capitalhub_crm/screen/communityScreen/communityDrawerScreen/community_drawer_screen.dart';
import 'package:capitalhub_crm/screen/createPostScreen/create_post_screen.dart';

import 'package:capitalhub_crm/screen/homeScreen/widget/community_polls_widget.dart';
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
        communityHomeController.getCommunityPosts(++page, false).then((val) {
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
  //         isCardVisible = communityHomeController.communityPostList[0].community!.whatsappGroupLink != ""?true:false;
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
      communityHomeController.getCommunityPosts(page, true).then((v) {
        _controller.forward();
        
        // Safely check if communityPostList is not empty and community is not null before accessing whatsappGroupLink
        isCardVisible = communityHomeController.communityPostList.isNotEmpty &&
                        communityHomeController.communityPostList[0].communityData != null &&
                        (communityHomeController.communityPostList[0].communityData!.whatsappGroupLink?.isNotEmpty ?? false);
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
    communityHomeController.communityPostList[0].postData![index].isLiked = true;
    communityHomeController.likeUnlikeCommunityPost(
        communityHomeController.communityPostList[0].postData![index].postId);
    Future.delayed(const Duration(milliseconds: 1000), () {
      _animationController.reverse();
    });
    setState(() {});
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
              () => isLoading.value
                  ? Helper.pageLoading():
                //  : communityHomeController.communityPostList[0].postData.isEmpty
                //       ? Center(child: TextWidget(text: "No Community Post Available", textSize: 16))
                //       :
                
                  
                  Padding(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: RefreshIndicator(
                          onRefresh: () async {
                            return _fetchAllApis();
                          },
                          child: Column(children: [
                            if (isCardVisible)
                              Card(
                                color: AppColors.darkGreen,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.chat_bubble_rounded,
                                        color: AppColors.white,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              text:
                                                  "Join our WhatsApp Community",
                                              textSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            TextWidget(
                                                text:
                                                    "Get instant updates and connect with members",
                                                textSize: 11),
                                            sizedTextfield,
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 25),
                                              child: AppButton.primaryButton(
                                                  onButtonPressed: () {
                                                    communityHomeController
                                                        .sendJoinRequest();
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
                                            isCardVisible =
                                                false; // Hide the card when pressed
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
                                Expanded(
                                  child: InkWell(
                                      child: Card(
                                        color: AppColors.primary,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.post_add,
                                                color: AppColors.white,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              TextWidget(
                                                text: "Create Post",
                                                textSize: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
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
                                      }),
                                ),

                                //                   InkWell(
                                //                     child: CircleAvatar(
                                //                       radius: 25,
                                //                       backgroundColor: AppColors.primary,
                                //                       child: Icon(Icons.filter_list,color: AppColors.white,)
                                //                     ),
                                //                     onTap: (){
                                //         //               DropDownWidget(
                                //         // status: postType,
                                //         // lable: "Filter",
                                //         // statusList: const ["Public", "Private", "Pitch Day"],
                                //         // onChanged: (val) {
                                //         //   setState(() {
                                //         //     privacyStatus = val.toString();
                                //         //   });
                                //         // });
                                //           DropdownButton<String>(
                                //   value: selectedItem,
                                //   onChanged: (String? newValue) {
                                //     setState(() {
                                //       selectedItem = newValue!;
                                //     });
                                //   },
                                //   items: postType.map<DropdownMenuItem<String>>((String value) {
                                //     return DropdownMenuItem<String>(
                                //       value: value,
                                //       child: Text(value),
                                //     );
                                //   }).toList(),
                                // ),
                                //         }
                                //                   ),
                                SizedBox(width: 4),
                                InkWell(
                                  onTap: () {
                                    _popupMenuKey.currentState
                                        ?.showButtonMenu();
                                  },
                                  child: Card(
                                    color: AppColors.primary,
                                    child: Row(
                                      children: [
                                        PopupMenuButton<String>(
                                            key: _popupMenuKey,
                                            icon: Icon(
                                              Icons.filter_list,
                                              size: 25,
                                            ),
                                            iconColor: AppColors.white,
                                            color: AppColors.blackCard,
                                            offset: Offset(100, 55),
                                            onSelected: (value) {},
                                            itemBuilder: (context) => [
                                                  const PopupMenuItem(
                                                    child: TextWidget(
                                                        text: "All Posts",
                                                        textSize: 14),
                                                  ),
                                                  PopupMenuItem(
                                                    child: TextWidget(
                                                        text: "Admin Posts",
                                                        textSize: 14),
                                                  ),
                                                  const PopupMenuItem(
                                                    child: TextWidget(
                                                        text: "Member Posts",
                                                        textSize: 14),
                                                  ),
                                                ]),
                                        // TextWidget(
                                        //   text: "Filter Post",
                                        //   textSize: 16,
                                        // ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),

                            // sizedTextfield,
                            // Flexible(
                            //   child: ListView.separated(
                            //       itemCount: communityHomeController.communityPostList.length,
                            //       shrinkWrap: true,
                            //       controller : scrollController,
                            //       separatorBuilder: (context, index) {
                            //         return const SizedBox(
                            //           height: 8,
                            //         );
                            //       },
                            //       itemBuilder: (context, index) {
                            //         return feeds(index);
                            //       }),
                            // ),
                            Expanded(
                              child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
    //                                 if (communityHomeController.communityPostList[0].postData.isEmpty)
    //   const Center(
    //     child: TextWidget(text: "No Posts in this Community", textSize: 16)
    //   )
    // else
                                    Column(
                                      children: [
                                        Expanded(
                                          child: ListView.separated(
                                            controller: scrollController,
                                            itemCount: communityHomeController
                                                .communityPostList[0].postData!.length,
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(height: 8);
                                            },
                                            shrinkWrap: true,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              // Show feed postData
                                              if (index <
                                                  communityHomeController
                                                .communityPostList[0].postData!.length) {
                                                return feeds(index); // Show feed post
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
                                      const Positioned(
                                          bottom: 10,
                                          child: SpinKitThreeBounce(
                                              size: 30,
                                              color: AppColors.primary))
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
                          backgroundColor: 
                          communityHomeController
                                  .communityPostList[0].postData![index].userIsSubscribed!
                              ? AppColors.golden
                              : 
                              AppColors.transparent,
                          radius: 22,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                communityHomeController.communityPostList[0].postData![index].userImage!),
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
                                              .communityPostList[0]
                                              .postData![index].userId!));
                                    },
                                    child: TextWidget(
                                        text:
                                            "${communityHomeController.communityPostList[0].postData![index].userFirstName} ${communityHomeController.communityPostList[0].postData![index].userLastName}",
                                        textSize: 14),
                                  ),
                                  const SizedBox(width: 4),
                                  if (communityHomeController
                                      .communityPostList[0]
                                      .postData![index].userIsSubscribed!)
                                    Image.asset(PngAssetPath.verifyImg,
                                        height: 14),
                                  const SizedBox(width: 4),
                                  TextWidget(
                                    text:
                                        communityHomeController.communityPostList[0].postData![index].createdAt!,
                                    textSize: 10,
                                    color: AppColors.white54,
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      if (communityHomeController
                                              .communityPostList[0]
                                              .postData![index].connectionStatus !=
                                          "pending") {
                                        homeController
                                            .followUnfollow(
                                                userId: communityHomeController
                                                    .communityPostList[0]
                                                    .postData![index].userId!,
                                                connectionStatus:
                                                    communityHomeController
                                                        .communityPostList[
                                                            0]
                                                        .postData![index].connectionStatus!)
                                            .then((val) {
                                          if (val) {}
                                        });
                                        if (communityHomeController
                                                .communityPostList[0]
                                                .postData![index].connectionStatus ==
                                            "not_sent") {
                                          communityHomeController
                                              .communityPostList[0]
                                              .postData![index].connectionStatus = "pending";
                                        } else if (communityHomeController
                                                .communityPostList[0]
                                                .postData![index].connectionStatus ==
                                            "accepted") {
                                          communityHomeController
                                              .communityPostList[0]
                                              .postData![index].connectionStatus = "not_sent";
                                        }
                                        setState(() {});
                                      }
                                    },
                                    child: TextWidget(
                                      // text: "",
                                      text: communityHomeController
                                                  .communityPostList[0]
                                                  .postData![index].connectionStatus ==
                                              "not_sent"
                                          ? "Follow"
                                          : communityHomeController
                                                      .communityPostList[0]
                                                      .postData![index].connectionStatus ==
                                                  "pending"
                                              ? "Pending"
                                              : "Unfollow",
                                      textSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primary,
                                    ),
                                  )
                                ],
                              ),
                              // const SizedBox(height: 1),
                              TextWidget(
                                text:
                                    "${communityHomeController.communityPostList[0].postData![index].userDesignation}  ${communityHomeController.communityPostList[0].postData![index].userCompany}",
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
                            .communityPostList[0].postData![index].isMyPost!)
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
                              ? communityHomeController.communityPostList[0].postData![index].description.toString()
                              : communityHomeController.communityPostList[0]
                                          .postData![index].description!.length >
                                      200
                                  ? "${communityHomeController.communityPostList[0].postData![index].description!.substring(0, 200)} ..."
                                  : communityHomeController
                                      .communityPostList[0].postData![index].description!,
                          onTapUrl: (url) async {
                            return await launch(url);
                          },
                          textStyle:
                              TextStyle(fontSize: 12, color: AppColors.white),
                        ),
                        if (communityHomeController
                                .communityPostList[0].postData![index].description!.length >
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
                            .communityPostList[0].postData![index].pollOptions!.isNotEmpty)
                          CommunityPollWidget(
                              pollOptions: communityHomeController
                                  .communityPostList[0].postData![index].pollOptions!,
                              totalVotes: communityHomeController
                                  .communityPostList[0].postData![index].totalVotes!,
                              postId: communityHomeController
                                  .communityPostList[0].postData![index].postId!,
                              myVotes: communityHomeController
                                  .communityPostList[0].postData![index].myVotes!),
                        const SizedBox(height: 6),
                        if (communityHomeController
                            .communityPostList[0].postData![index].image!.isNotEmpty)
                          Column(children: [
                            SizedBox(
                              height: 250,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: communityHomeController
                                    .communityPostList[0].postData![index].image!.length,
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
                                                .postData![0].image![ind],
                                            name: communityHomeController
                                                    .communityPostList[0]
                                                    .postData![index].userFirstName! +
                                                communityHomeController
                                                    .communityPostList[0]
                                                    .postData![index].userLastName!));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                communityHomeController
                                                    .communityPostList[0]
                                                    .postData![index].image![ind]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Page Indicator
                            if (communityHomeController.communityPostList[0]
                                    .postData![index].image!.isNotEmpty &&
                                communityHomeController.communityPostList[0]
                                        .postData![index].image!.length >
                                    1)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  communityHomeController
                                      .communityPostList[0].postData![index].image!.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.only(
                                        left: 4, right: 4, top: 8),
                                    width: _currentIndex == index ? 8 : 5,
                                    height: _currentIndex == index ? 8 : 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentIndex == index
                                          ? AppColors.primary
                                          : AppColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                          ]),
                        if (communityHomeController
                            .communityPostList[0].postData![index].video!.isNotEmpty)
                          VideoPlayerItem(
                            videoUrl: communityHomeController
                                .communityPostList[0].postData![index].video!,
                          ),
                        if (communityHomeController
                            .communityPostList[0].postData![index].documentUrl!.isNotEmpty)
                          SizedBox(
                              width: 150,
                              height: 200,
                              child: SfPdfViewer.network(communityHomeController
                                  .communityPostList[0].postData![index].documentUrl!)),
                        if (communityHomeController.communityPostList[0]
                                    .postData![index].resharedPostData !=
                                null &&
                            !communityHomeController
                                .communityPostList[0].postData![index].resharedPostData!
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
                  Divider(height: 0, color: AppColors.white38, thickness: 0.5),
                  if (communityHomeController
                      .communityPostList[0].postData![index].likes!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: AppColors.white12,
                            child: const Icon(
                              Icons.favorite,
                              color: AppColors.redColor,
                              size: 15,
                            ),
                          ),
                          // const SizedBox(width: 4),
                          // CircleAvatar(
                          //   radius: 12,
                          //   backgroundColor:
                          //       AppColors.white12,
                          //   child: Icon(
                          //     CupertinoIcons
                          //         .chat_bubble_text_fill,
                          //     color: AppColors.whiteCard,
                          //     size: 15,
                          //   ),
                          // ),
                          const SizedBox(width: 8),
                          if (communityHomeController
                              .communityPostList[0].postData![index].likes!.isNotEmpty)
                            Expanded(
                              child: TextWidget(
                                text:
                                    "${communityHomeController.communityPostList[0].postData![index].likes!.first.firstName} and Many Others",
                                textSize: 11,
                                maxLine: 2,
                              ),
                            ),
                          if (communityHomeController
                              .communityPostList[0].postData![index].comments!.isNotEmpty)
                            TextWidget(
                                text:
                                    "${communityHomeController.communityPostList[0].postData![index].comments!.length} Comments",
                                textSize: 10)
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
                      children: [
                        InkWell(
                          splashColor: AppColors.transparent,
                          onTap: () {
                            communityHomeController
                                    .communityPostList[0].postData![index].isLiked =
                                !communityHomeController
                                    .communityPostList[0].postData![index].isLiked!;
                            communityHomeController.likeUnlikeCommunityPost(
                                communityHomeController
                                    .communityPostList[0].postData![index].postId);

                            setState(() {});
                          },
                          child: Icon(
                            communityHomeController
                                    .communityPostList[0].postData![index].isLiked!
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: communityHomeController
                                    .communityPostList[0].postData![index].isLiked!
                                ? AppColors.redColor
                                : AppColors.whiteCard,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const TextWidget(text: "Like", textSize: 13),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            commentBottomSheet(index);
                          },
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.chat_bubble_text,
                                color: AppColors.whiteCard,
                                size: 21,
                              ),
                              const SizedBox(width: 4),
                              const TextWidget(text: "Comments", textSize: 13),
                            ],
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            sharePostPopup(
                                context,
                                communityHomeController
                                    .communityPostList[0].postData![index].postId!,"");
                          },
                          child: Icon(
                            Icons.mobile_screen_share_rounded,
                            color: AppColors.whiteCard,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Get.to(CreatePostScreen(
                              postid: communityHomeController
                                  .communityPostList[0].postData![index].postId,
                            ));
                          },
                          child: Transform.rotate(
                            angle: 0.77,
                            child: Icon(
                              Icons.screen_rotation_alt,
                              color: AppColors.whiteCard,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            if (communityHomeController
                                .communityPostList[0].postData![index].isSaved!) {
                              communityHomeController
                                  .unsaveCommunityPost(
                                context,
                                postID: communityHomeController
                                    .communityPostList[0].postData![index].postId!,
                              )
                                  .then((val) {
                                communityHomeController
                                    .getCommunityPosts(page, false)
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
                                    .communityPostList[0].postData![index].isSaved!
                                ? Icons.bookmark
                                : Icons.bookmark_border_outlined,
                            color: AppColors.whiteCard,
                            size: 22,
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
                          '${communityHomeController.communityPostList[0].postData![index].resharedPostData!.userProfilePicture}'),
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
                                    "${communityHomeController.communityPostList[0].postData![index].resharedPostData!.userFirstName} ${communityHomeController.communityPostList[index].postData![index].resharedPostData!.userLastName}",
                                textSize: 12),
                            const Expanded(child: SizedBox()),
                            TextWidget(
                              text:
                                  "${communityHomeController.communityPostList[0].postData![index].resharedPostData!.age}",
                              textSize: 10,
                              color: AppColors.white54,
                            ),
                          ],
                        ),
                        // const SizedBox(height: 1),
                        TextWidget(
                          text:
                              "${communityHomeController.communityPostList[0].postData![index].resharedPostData!.userDesignation}  ${communityHomeController.communityPostList[index].postData![index].resharedPostData!.userLocation}",
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
                        ? communityHomeController.communityPostList[0].postData![index].description.toString()
                        : communityHomeController.communityPostList[0].postData![index].
                                    description!.length >
                                100
                            ? "${communityHomeController.communityPostList[0].postData![index].description!.substring(0, 100)} ..."
                            : communityHomeController
                                .communityPostList[0].postData![index].description.toString(),
                    onTapUrl: (url) async {
                      return await launch(url);
                    },
                    textStyle: TextStyle(fontSize: 10, color: AppColors.white),
                  ),
                  if (communityHomeController
                          .communityPostList[0].postData![index].description!.length >
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
                  if (communityHomeController.communityPostList[0]
                              .postData![index].resharedPostData!.pollOptions !=
                          null &&
                      communityHomeController.communityPostList[0]
                          .postData![index].resharedPostData!.pollOptions!.isNotEmpty)
                    CommunityPollWidgetProfile(
                        pollOptions: communityHomeController
                            .communityPostList[0]
                            .postData![index].resharedPostData!
                            .pollOptions!,
                        totalVotes: communityHomeController
                            .communityPostList[0]
                            .postData![index].resharedPostData!
                            .totalVotes!,
                        myVotes: communityHomeController
                            .communityPostList[0]
                            .postData![index].resharedPostData!
                            .myVotes!),
                  communityHomeController.communityPostList[0]
                                  .postData![index].resharedPostData!.images !=
                              null &&
                          communityHomeController.communityPostList[0]
                              .postData![index].resharedPostData!.images!.isEmpty
                      ? const SizedBox(height: 0)
                      : Column(children: [
                          if (communityHomeController.communityPostList[0]
                                  .postData![index].resharedPostData!.images !=
                              null)
                            SizedBox(
                              height: 133,
                              child: PageView.builder(
                                itemCount: communityHomeController
                                    .communityPostList[0]
                                    .postData![index].resharedPostData!
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
                                                .communityPostList[0]
                                                .postData![index].resharedPostData!
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
            if (communityHomeController.communityPostList[0].postData![index].isMyPost!)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      communityHomeController
                          .deleteCommunityPost(context,
                              postID: communityHomeController
                                  .communityPostList[0].postData![index].postId!)
                          .then((val) {
                        if (val) {
                          Get.back();
                          communityHomeController.getCommunityPosts(1, true);
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
                      .communityPostList[0].postData![index].isMyPost!)
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
                              fontWeight: FontWeight.w500
                            ),
                          ],
                        ),
                        onExpansionChanged: (bool expanded) {
                            setState(() {
                              isExpanded = expanded;  // Track expansion state
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
                                text: "Harassment", textSize: 14, fontWeight: FontWeight.w500),
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
                            title: const TextWidget(text: "Spam", textSize: 14, fontWeight: FontWeight.w500),
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
                                text: "Fraud or scam", textSize: 14, fontWeight: FontWeight.w500),
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
                                text: "Hateful Speech", textSize: 14, fontWeight: FontWeight.w500),
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
                            communityHomeController
                                .reportPost(context,
                                    postID: communityHomeController
                                        .communityPostList[0].postData![index].postId!,
                                    reportReason: reportReason)
                                .then((val) {
                              if (val) {
                                Get.back();
                                communityHomeController.getCommunityPosts(
                                    1, true);
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
                        .communityPostList[0].postData![Index].comments!.length,
                    itemBuilder: (BuildContext context, int ind) {
                      return ListTile(
                        visualDensity: VisualDensity.compact,
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              '${communityHomeController.communityPostList[0].postData![Index].comments![ind].userImage}'),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text:
                                  "${communityHomeController.communityPostList[0].postData![Index].comments![ind].user}",
                              textSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            TextWidget(
                              text:
                                  "${communityHomeController.communityPostList[0].postData![Index].comments![ind].userDesignation} and ${communityHomeController.communityPostList[0].postData![Index].comments![ind].userCompany}",
                              textSize: 12,
                              color: AppColors.white54,
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: TextWidget(
                              text:
                                  "${communityHomeController.communityPostList[0].postData![Index].comments![ind].text}",
                              textSize: 14),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (communityHomeController
                                    .communityPostList[0]
                                    .postData![Index].comments![ind]
                                    .isMyComment!)
                                  InkWell(
                                      onTap: () {
                                        communityHomeController
                                            .deleteCommentCommunityPost(context,
                                                postID: communityHomeController
                                                    .communityPostList[0]
                                                    .postData![Index].postId!,
                                                commentID:
                                                    communityHomeController
                                                        .communityPostList[
                                                            Index]
                                                        .postData![Index].comments![ind]
                                                        .id!)
                                            .then((val) {
                                          if (val) {
                                            communityHomeController
                                                .getCommunityPosts(page, false)
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
                                        "${communityHomeController.communityPostList[0].postData![Index].comments![ind].createdAt}",
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
                                            .communityPostList[0]
                                            .postData![Index].comments![ind]
                                            .isLiked =
                                        !communityHomeController
                                            .communityPostList[0]
                                            .postData![Index].comments![ind]
                                            .isLiked!;
                                    communityHomeController
                                        .toggleLikeCommentCommunityPost(context,
                                            postID: communityHomeController
                                                .communityPostList[0]
                                                .postData![Index].postId!,
                                            commentID: communityHomeController
                                                .communityPostList[0]
                                                .postData![Index].comments![ind]
                                                .id!)
                                        .then((val) {
                                      if (val) {
                                        commentController.clear();
                                        communityHomeController
                                            .getCommunityPosts(page, false)
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
                                            .communityPostList[0]
                                            .postData![Index].comments![ind]
                                            .isLiked!
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: communityHomeController
                                            .communityPostList[0]
                                            .postData![Index].comments![ind]
                                            .isLiked!
                                        ? AppColors.redColor
                                        : AppColors.whiteCard,
                                    size: 15,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                TextWidget(
                                    text:
                                        "${communityHomeController.communityPostList[0].postData![Index].comments![ind].likesCount}",
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
                                            .communityPostList[0].postData![Index].postId!,
                                        userId: GetStoreData.getStore
                                            .read('id')
                                            .toString(),
                                        text: commentController.text)
                                    .then((val) {
                                  if (val) {
                                    commentController.clear();
                                    communityHomeController
                                        .getCommunityPosts(page, false)
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
                                              .communityPostList[0].postData![Index].postId!,
                                          colelctionName:
                                              communityHomeController
                                                  .communityCollectionList[ind]
                                                  .name)
                                      .then((val) {
                                    if (val) {
                                      communityHomeController
                                          .getCommunityPosts(page, false)
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
}
