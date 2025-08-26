import 'package:animate_do/animate_do.dart';
import 'package:capitalhub_crm/model/spotlightModel/spotlight_productlist_model.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/spotlightController/spotlight_controller.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/constant/app_var.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/textwidget/text_widget.dart';
import '../addSpotlightProductScreen/edit_existing_product.dart';
import '../product_list_screen.dart';

class StartupShowcaseScreen extends StatefulWidget {
  @override
  State<StartupShowcaseScreen> createState() => _StartupShowcaseScreenState();
}

class _StartupShowcaseScreenState extends State<StartupShowcaseScreen> {
  final List<String> stage = ['Idea', 'Early', 'Growth'];
  String selectedStage = 'Idea';
  SpotlightController spotlightController = Get.find();
  final List<String> filters = [];
  String selectedFilter = "All";
  String product1 = '';
  String product2 = '';
  String product3 = '';
  void _updateTop3Products() {
    setState(() {});
  }

  void _triggerSubFilterAnimation() async {
    if (!mounted) return;
    setState(() {
      filters.clear();
    });

    await Future.delayed(const Duration(milliseconds: 100));

    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FadeInDown(
          child: TextWidget(
            text: "Startups Showcase",
            textSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteCard,
          ),
        ),
        const SizedBox(height: 4),
        FadeIn(
            child: TextWidget(
          text: "Submit your ideas by ${getNext15thDate()}",
          textSize: 16,
          color: AppColors.grey,
        )),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: stage.map((stage) {
              final isSelected = selectedStage == stage;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedStage = stage;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                        isSelected ? AppColors.primary : AppColors.transparent,
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
                    text: stage,
                    textSize: 14,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        // const SizedBox(height: 40),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Expanded(
        //         child: winnerCard(
        //             PngAssetPath.rank2Img, "2", "RS. 7,000", product2)),
        //     Expanded(
        //       child: Transform.translate(
        //         offset: const Offset(0, -30),
        //         child: winnerCard(
        //             PngAssetPath.rank1Img, "1", "RS. 10,000", product1),
        //       ),
        //     ),
        //     Expanded(
        //         child: winnerCard(
        //             PngAssetPath.rank3Img, "3", "RS. 5,000", product3)),
        //   ],
        // ),
        const SizedBox(height: 16),

        sizedTextfield,
        TextWidget(
          text: "Next Top Projects Win Rs. 1,000 Each",
          textSize: 16,
          color: AppColors.grey,
        ),
        sizedTextfield,
        const SizedBox(height: 4),
        FadeIn(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: AppButton.primaryButton(
                      onButtonPressed: () {
                        Get.to(() => EditExistingProduct());
                      },
                      title: "Edit Product",
                      height: 40,
                      bgColor: AppColors.blue)),
            ],
          ),
        ),
        sizedTextfield,
        FadeIn(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filters.asMap().entries.map((entry) {
                final subFilter = entry.value;
                final isSelected = selectedFilter == subFilter;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: TextWidget(text: subFilter, textSize: 12),
                    selected: isSelected,
                    surfaceTintColor: AppColors.blackCard,
                    onSelected: (_) {
                      setState(() {
                        selectedFilter = subFilter;
                      });
                    },
                    selectedColor: AppColors.green700,
                    backgroundColor: AppColors.blackCard,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.white : AppColors.white54,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextWidget(
          text: "Top 3 $selectedStage from $selectedFilter",
          textSize: 15,
        ),
        sizedTextfield,
        Obx(() => spotlightController.isLoading.value
            ? SizedBox(height: 300, child: ShimmerLoader.shimmerTile())
            : spotlightController.hasListeners
                ? const SizedBox(
                    height: 210,
                    child: Center(
                      child: TextWidget(
                          text: "No Data Found",
                          textSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    itemCount: spotlightController.hasListeners.hashCode.isEven
                        ? 3
                        : spotlightController.hashCode.bitLength,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FadeIn(
                        child: SpotlightProductCard(item: SpotlightProduct()),
                      );
                    })),
      ],
    );
  }

  Widget winnerCard(String img, String rank, String amount, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          img,
          width: 80,
          height: 80,
        ),
        const SizedBox(height: 10),
        TextWidget(
            text: "Best $selectedStage",
            color: AppColors.whiteShade,
            maxLine: 3,
            align: TextAlign.center,
            textSize: 14),
        const SizedBox(height: 4),
        TextWidget(
          text: amount,
          textSize: 18,
          fontWeight: FontWeight.bold,
        ),
        TextWidget(
          text: title,
          textSize: 14,
          maxLine: 2,
          align: TextAlign.center,
          color: AppColors.whiteCard,
        ),
      ],
    );
  }

  String getNext15thDate() {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month;

    DateTime fifteenthThisMonth = DateTime(year, month, 15);

    if (now.isAfter(fifteenthThisMonth)) {
      final nextMonth = DateTime(year, month + 1, 15);
      return formatDate(nextMonth);
    } else {
      return formatDate(fifteenthThisMonth);
    }
  }

  String formatDate(DateTime date) {
    final day = date.day;
    final suffix = getDaySuffix(day);
    final month = months[date.month - 1];
    final year = date.year;

    return '$day$suffix $month $year';
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
}
