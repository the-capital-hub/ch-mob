import 'package:capitalhub_crm/controller/savedPostController/saved_post_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/polls_widget_profile.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../utils/getStore/get_store.dart';
import '../01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import '../homeScreen/widget/video_player.dart';

class SavedPostScreen extends StatefulWidget {
  const SavedPostScreen({super.key});

  @override
  State<SavedPostScreen> createState() => _SavedPostScreenState();
}

class _SavedPostScreenState extends State<SavedPostScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  SavedPostController savedPostController = Get.put(SavedPostController());
  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _initializeTabs();
      //   savedPostController.getSavedFolder().then((val) {
      //     if (_tabController != null) {
      //       _tabController!.dispose();
      //     }
      //     setState(() {
      //       _tabController = TabController(
      //           length: savedPostController.tabNames.length, vsync: this);
      //       savedPostController.getSavedPost(savedPostController.tabNames.first);
      //     });
      //   });
    });
  }

  Future<void> _initializeTabs() async {
    await savedPostController.getSavedFolder();

    // Ensure synchronization
    if (_tabController != null) {
      _tabController!.dispose();
    }

    setState(() {
      _tabController = TabController(
        length: savedPostController.tabNames.length,
        vsync: this,
      );

      // Fetch posts for the first tab
      if (savedPostController.tabNames.isNotEmpty) {
        savedPostController.getSavedPost(savedPostController.tabNames.first);
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _tabController = null; // Ensure cleanup
    _pageController.dispose();
    super.dispose();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          drawer: GetStoreData.getStore.read('isInvestor')
              ? const DrawerWidgetInvestor()
              : const DrawerWidget(),
          appBar: HelperAppBar.appbarHelper(
              title: "Saved Posts", hideBack: true, autoAction: true),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => savedPostController.isLoading.value
                ? Helper.pageLoading()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                          text: "Find all your saved posts here", textSize: 14),
                      // sizedTextfield,
                      _tabController != null
                          ? TabBar(
                              controller: _tabController,
                              labelPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              indicatorSize: TabBarIndicatorSize.tab,
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              indicatorPadding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 10),
                              indicator: BoxDecoration(
                                color: GetStoreData.getStore.read('isInvestor')
                                    ? AppColors.primaryInvestor
                                    : AppColors.primary,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              dividerHeight: 0,
                              onTap: (val) {
                                index = val;
                                savedPostController.getSavedPost(
                                    savedPostController.tabNames[val]);
                              },
                              unselectedLabelColor: AppColors.white,
                              labelColor:
                                  GetStoreData.getStore.read('isInvestor')
                                      ? AppColors.black
                                      : AppColors.white,
                              tabs: savedPostController.tabNames
                                  .map((name) => Tab(
                                        text: name,
                                      ))
                                  .toList())
                          : SizedBox(),
                      Expanded(
                        child: savedPostController.isTabLoading.value
                            ? Helper.tabLoading()
                            : savedPostController.savedPost.isEmpty
                                ? const Center(
                                    child: TextWidget(
                                        text: "No Post Found", textSize: 14),
                                  )
                                : _tabController != null
                                    ? TabBarView(
                                        controller: _tabController,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: savedPostController.tabNames
                                            .map((_) {
                                          return ListView.separated(
                                            itemCount: savedPostController
                                                .savedPost.length,
                                            shrinkWrap: true,
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(width: 8);
                                            },
                                            itemBuilder: (BuildContext context,
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
                                                  child: SingleChildScrollView(
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
                                                                        '${savedPostController.savedPost[index].userProfilePicture}'),
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
                                                                              "${savedPostController.savedPost[index].userFirstName} ${savedPostController.savedPost[index].userLastName}",
                                                                          textSize:
                                                                              12),
                                                                      const Expanded(
                                                                          child:
                                                                              SizedBox()),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          savedPostController
                                                                              .removePost(savedPostController.savedPost[index].postId!)
                                                                              .then((v) {
                                                                            savedPostController.savedPost.removeAt(index);
                                                                            setState(() {});
                                                                          });
                                                                        },
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .remove_circle_outline,
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
                                                                        "${savedPostController.savedPost[index].userDesignation}  ${savedPostController.savedPost[index].userLocation}",
                                                                    textSize:
                                                                        10,
                                                                    color: AppColors
                                                                        .whiteCard,
                                                                  ),
                                                                  // const SizedBox(height: 1),
                                                                  TextWidget(
                                                                    text:
                                                                        "${savedPostController.savedPost[index].age}",
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
                                                          color:
                                                              AppColors.white38,
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
                                                              "${savedPostController.savedPost[index].description}",
                                                              // onTapUrl: (url) async {
                                                              //   return await launch(
                                                              //       url);
                                                              // },
                                                              textStyle: TextStyle(
                                                                  fontSize: 10,
                                                                  color: AppColors
                                                                      .white),
                                                            ),
                                                            const SizedBox(
                                                                height: 6),
                                                            if (savedPostController
                                                                .savedPost[
                                                                    index]
                                                                .pollOptions!
                                                                .isNotEmpty)
                                                              PollWidgetProfile(
                                                                  height: 35,
                                                                  pollOptions: savedPostController
                                                                      .savedPost[
                                                                          index]
                                                                      .pollOptions!,
                                                                  totalVotes: savedPostController
                                                                      .savedPost[
                                                                          index]
                                                                      .totalVotes!,
                                                                  myVotes: savedPostController
                                                                      .savedPost[
                                                                          index]
                                                                      .myVotes!),
                                                            savedPostController
                                                                    .savedPost[
                                                                        index]
                                                                    .images!
                                                                    .isEmpty
                                                                ? const SizedBox()
                                                                : Column(
                                                                    children: [
                                                                        SizedBox(
                                                                          height:
                                                                              150,
                                                                          child:
                                                                              PageView.builder(
                                                                            controller:
                                                                                _pageController,
                                                                            itemCount:
                                                                                savedPostController.savedPost[index].images!.length,
                                                                            onPageChanged:
                                                                                (ind) {
                                                                              setState(() {
                                                                                _currentIndex = ind;
                                                                              });
                                                                            },
                                                                            itemBuilder:
                                                                                (context, ind) {
                                                                              return Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(12),
                                                                                  image: DecorationImage(
                                                                                    fit: BoxFit.cover,
                                                                                    image: NetworkImage(savedPostController.savedPost[index].images![ind]),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                        if (savedPostController.savedPost[index].images!.isNotEmpty &&
                                                                            savedPostController.savedPost[index].images!.length >
                                                                                1)
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children:
                                                                                List.generate(
                                                                              savedPostController.savedPost[index].images!.length,
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
                                                                      ]),
                        //                                                if (savedPostController.savedPost[index].video_url!.isNotEmpty)
                        //   VideoPlayerItem(
                        //     videoUrl: savedPostController.savedPost[index].video_url!,
                        //   ),
                        // if (savedPostController.savedPost[index].document_url!.isNotEmpty)
                        //   SizedBox(
                        //       width: 150,
                        //       height: 200,
                        //       child: SfPdfViewer.network(savedPostController.savedPost[index].document_url!)),
                        // if (savedPostController.savedPost[index].resharedPostData !=
                        //         null &&
                        //     !savedPostController.savedPost[index].resharedPostData!
                        //         .isEmpty())
                        //   Container(
                        //       padding: const EdgeInsets.all(8),
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12),
                        //           color: AppColors.black54),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           TextWidget(
                        //             text: "   Reshared Post",
                        //             textSize: 12,
                        //             color: AppColors.grey,
                        //             fontWeight: FontWeight.w500,
                        //           ),
                        //           resharedPostPreview(index),
                        //         ],
                        //       ))
                      
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
                                      )
                                    : SizedBox(),
                      ),
                      // Expanded(
                      //   child: TabBarView(
                      //     physics: NeverScrollableScrollPhysics(),
                      //     controller: _tabController,
                      //     children: savedPostController.tabNames
                      //         .map((name) => GridView.builder(
                      //               gridDelegate:
                      //                   const SliverGridDelegateWithFixedCrossAxisCount(
                      //                       crossAxisCount: 2,
                      //                       crossAxisSpacing: 10,
                      //                       mainAxisSpacing: 12,
                      //                       childAspectRatio: 0.68),
                      //               itemCount: 4,
                      //               shrinkWrap: true,
                      //               itemBuilder:
                      //                   (BuildContext context, int index) {
                      //                 return GradientContainer(
                      //                   imageUrl: img[index],
                      //                   index: index,
                      //                 );
                      //               },
                      //             ))
                      //         .toList(),
                      //   ),
                      // ),
                    ],
                  )),
          ),
        ));
  }

  // List img = [
  //   'https://static.vecteezy.com/system/resources/thumbnails/006/907/822/small/panoramic-banner-background-of-business-success-concept-business-hand-showing-marketing-growth-strategy-graph-with-creative-graphic-chart-of-investment-finance-analysis-diagram-concept-free-photo.jpg',
  //   'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Sunflower_from_Silesia2.jpg/1200px-Sunflower_from_Silesia2.jpg',
  //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxTtjoNiz3-FqyyechKy8e3Jsvct7oPW43XW99yhU2rfxwYslN6cblNcvyHpVVxTekg_g&usqp=CAU',
  //   'https://www.axisbank.com/images/default-source/progress-with-us_new/investing-for-the-long-term.jpg',
  // ];
}

class GradientContainer extends StatefulWidget {
  final String imageUrl;
  final int index;

  GradientContainer({required this.imageUrl, required this.index});

  @override
  _GradientContainerState createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  PaletteGenerator? paletteGenerator;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _updatePaletteGenerator();
  }

  Future<void> _updatePaletteGenerator() async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.imageUrl),
      size: const Size(200, 200), // Specify the size of the image
    );
    setState(() {
      paletteGenerator = generator;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: Helper.spinLoading())
        : AnimationConfiguration.staggeredList(
            position: widget.index,
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    paletteGenerator?.dominantColor?.color ?? AppColors.black,
                    paletteGenerator?.lightVibrantColor?.color ??
                        AppColors.white54,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.black38,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  paletteGenerator?.dominantColor?.color,
                              radius: 16,
                              child: const FlutterLogo(size: 18),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(text: "Fintech", textSize: 14),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.home,
                                      color: AppColors.white,
                                      size: 10,
                                    ),
                                    const TextWidget(
                                        text: " Corporate", textSize: 10),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Icon(Icons.more_vert_outlined,
                                color: AppColors.whiteCard, size: 20)
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 90,
                          width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.imageUrl))),
                        ),
                        const SizedBox(height: 4),
                        const TextWidget(text: "Fintech", textSize: 14),
                        const SizedBox(height: 2),
                        const TextWidget(
                          text:
                              "Fintech a company in the first stages of operations and also doing great hard work and more in the company",
                          textSize: 12,
                          googleFont: false,
                          maxLine: 5,
                        ),
                        const Spacer(),
                        const TextWidget(text: "2 days ago", textSize: 10)
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
