import 'package:capitalhub_crm/controller/spotlightController/spotlight_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/spotlLightScreen/spotlightHome/spotlight_top_product_screen.dart';
import 'package:capitalhub_crm/utils/helper/placeholder.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/constant/app_var.dart';
import '../addSpotlightProductScreen/main_info_product_screen.dart';
import '../product_list_screen.dart';
import '../spotlight_animation.dart';

class SpotLightAllProductScreen extends StatefulWidget {
  const SpotLightAllProductScreen({super.key});

  @override
  State<SpotLightAllProductScreen> createState() =>
      _SpotLightAllProductScreenState();
}

class _SpotLightAllProductScreenState extends State<SpotLightAllProductScreen>
    with SingleTickerProviderStateMixin {
  SpotlightController spotlightController = Get.put(SpotlightController());
  List<String> animatedSubFilters = [];
  String selectedFilter = 'All';
  String selectedSubFilter = 'All';
  final List<String> filters = ['All', 'Idea', 'Early', 'Growth'];
  @override
  void initState() {
    super.initState();
    _spotlightController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      spotlightController
          .getSpotlightProductList(industry: "All", stage: "All", type: "all")
          .then((_) {
        _triggerSubFilterAnimation();
        _spotlightController.forward().whenComplete(() {
          setState(() {});
        });
      });
    });
  }

  late AnimationController _spotlightController;

  bool showSubFilters = false;
  @override
  void dispose() {
    _spotlightController.dispose();
    super.dispose();
  }

  void _triggerSubFilterAnimation() async {
    final subfilters = spotlightController.spotlightData.industries!;

    if (!mounted) return;
    setState(() {
      animatedSubFilters.clear();
      showSubFilters = false;
    });

    await Future.delayed(const Duration(milliseconds: 100));

    if (!mounted) return;
    setState(() {
      animatedSubFilters.addAll(subfilters);
      showSubFilters = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        drawer: const DrawerWidget(),
        appBar: HelperAppBar.appbarHelper(
            title: "Spotlight",
            hideBack: true,
            action: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.swap_vert, color: AppColors.primary),
                onSelected: (value) {
                  _sortProducts(value);
                },
                offset: const Offset(0, 50),
                color: const Color(0xFF2A2A2A),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 'newest',
                    child: Row(
                      children: [
                        Icon(Icons.bolt, color: AppColors.white),
                        const SizedBox(width: 10),
                        const TextWidget(text: "Newest", textSize: 14),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'liked',
                    child: Row(
                      children: [
                        Icon(Icons.thumb_up_alt, color: AppColors.white),
                        const SizedBox(width: 10),
                        const TextWidget(text: "Most Liked", textSize: 14),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'comments',
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.chat_bubble_2_fill,
                            color: AppColors.white),
                        const SizedBox(width: 10),
                        const TextWidget(text: "Most Comments", textSize: 14),
                      ],
                    ),
                  ),
                ],
              )
            ]),
        body: Obx(
          () => Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: filters.map((filter) {
                        final isSelected = selectedFilter == filter;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedFilter = filter;

                                spotlightController.getSpotlightProductList(
                                    stage: selectedFilter,
                                    industry: selectedSubFilter,
                                    type: "all");
                              });
                              _triggerSubFilterAnimation();
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: isSelected
                                  ? AppColors.primary
                                  : AppColors.transparent,
                              side: BorderSide(
                                  color: isSelected
                                      ? AppColors.transparent
                                      : AppColors.white54),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 14),
                            ),
                            child: TextWidget(
                              text: filter,
                              textSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Divider(
                    color: AppColors.white54,
                    thickness: 0.5,
                    height: 30,
                  ),
                  Expanded(
                    child: spotlightController.isLoading.value
                        ? Stack(
                            children: [
                              ShimmerLoader.shimmerSpotlightLoader(),
                              const AnimatedSwingingSpotlight()
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  text: "  Category",
                                  textSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white54),
                              const SizedBox(height: 2),
                              AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children:
                                        animatedSubFilters.map((subFilter) {
                                      final index =
                                          animatedSubFilters.indexOf(subFilter);
                                      final isSelected =
                                          selectedSubFilter == subFilter;

                                      return TweenAnimationBuilder<double>(
                                        tween: Tween(begin: 0, end: 1),
                                        duration: Duration(
                                            milliseconds: 500 + (index * 100)),
                                        builder: (context, value, child) {
                                          return Opacity(
                                            opacity: value,
                                            child: Transform.translate(
                                              offset:
                                                  Offset(10 * (1 - value), 0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedSubFilter =
                                                          subFilter;
                                                      spotlightController
                                                          .getSpotlightProductList(
                                                              stage:
                                                                  selectedFilter,
                                                              industry:
                                                                  selectedSubFilter,
                                                              type: "all");
                                                    });
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    // backgroundColor: isSelected
                                                    //     ? AppColors.primary
                                                    //     : AppColors.transparent,
                                                    side: BorderSide(
                                                      color: isSelected
                                                          ? AppColors.primary
                                                          : AppColors.white38,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 14),
                                                  ),
                                                  child: TextWidget(
                                                    text: subFilter,
                                                    textSize: 13,
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              sizedTextfield,
                              // if (spotlightController.spotlightData.products !=
                              //     null)
                              spotlightController.spotlightData.products.isEmpty
                                  ? const Expanded(
                                      child: Center(
                                        child: TextWidget(
                                            text: "No Data Found",
                                            textSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.separated(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          itemCount: spotlightController
                                              .spotlightData.products!.length,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(height: 12),
                                          itemBuilder: (context, index) {
                                            return SpotlightProductCard(
                                                item: spotlightController
                                                    .spotlightData
                                                    .products[index]);
                                          })),
                            ],
                          ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  void _sortProducts(String criteria) {
    final products = spotlightController.spotlightData.products;

    if (criteria == 'newest') {
      products.sort((a, b) => b.date!.compareTo(a.date!));
    } else if (criteria == 'liked') {
      products.sort((a, b) => b.upvotesCount!.compareTo(a.upvotesCount ?? 0));
    } else if (criteria == 'comments') {
      products.sort((a, b) => b.comments!.compareTo(a.comments ?? 0));
    }

    setState(() {}); // Rebuild UI after sorting
  }
}
