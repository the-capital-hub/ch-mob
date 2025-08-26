// import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
// import 'package:capitalhub_crm/widget/buttons/button.dart';
// import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:get/get.dart';

// import '../../../controller/spotlightController/spotlight_controller.dart';
// import '../../../utils/constant/app_var.dart';
// import '../addSpotlightProductScreen/edit_existing_product.dart';
// import '../addSpotlightProductScreen/main_info_product_screen.dart';
// import '../product_list_screen.dart';

// class SpotlightTopProduct extends StatefulWidget {
//   @override
//   _SpotlightTopProductState createState() => _SpotlightTopProductState();
// }

// class _SpotlightTopProductState extends State<SpotlightTopProduct> {
//   SpotlightController spotlightController = Get.find();
//   final List<String> filters = [
//     "December '24",
//     "January '25",
//     "February '25",
//     "March '25",
//     "April '25",
//   ];
//   int selectedIndex = 0; // default March '25
//   final ScrollController _scrollController = ScrollController();

//   void _triggerSubFilterAnimation() async {
//     final subfilters = spotlightController.spotlightData.industries!;

//     if (!mounted) return;
//     setState(() {
//       filters.clear();
//     });

//     await Future.delayed(const Duration(milliseconds: 100));

//     if (!mounted) return;
//     setState(() {
//       filters.addAll(subfilters);
//     });
//   }

//   @override
//   void initState() {
//     super.initState();

//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       spotlightController
//           .getSpotlightProductList(industry: "All", stage: "All",type: "top")
//           .then((_) {
//         _triggerSubFilterAnimation();
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const TextWidget(
//           text: "Next Top Projects Win Rs. 1,000 Each",
//           textSize: 16,
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//                 child: AppButton.primaryButton(
//                     onButtonPressed: () {
//                       Get.to(() => const MainInfoProductScreen());
//                     },
//                     height: 40,
//                     title: "Post an Idea")),
//             const SizedBox(width: 10),
//             Expanded(
//                 child: AppButton.primaryButton(
//                     onButtonPressed: () {
//                       Get.to(() => EditExistingProduct());
//                     },
//                     title: "Edit Product",
//                     height: 40,
//                     bgColor: AppColors.blue)),
//           ],
//         ),
//         sizedTextfield,
//         SizedBox(
//           height: 40,
//           child: ListView.separated(
//             separatorBuilder: (context, index) =>
//                 const SizedBox(width: 8),
//             controller: _scrollController,
//             scrollDirection: Axis.horizontal,
//             itemCount: filters.length,
//             itemBuilder: (context, index) {
//               final isSelected = index == selectedIndex;
//               return ChoiceChip(
//                 label: TextWidget(text: filters[index], textSize: 12),
//                 selected: isSelected,
//                 surfaceTintColor: AppColors.blackCard,
//                 onSelected: (_) {
//                   setState(() {
//                     selectedIndex = index;
//                   });
//                 },
//                 selectedColor: AppColors.green700,
//                 backgroundColor: AppColors.blackCard,
//                 showCheckmark: false,
//                 labelStyle: TextStyle(
//                     color:
//                         isSelected ? AppColors.white : AppColors.white54),
//               );
//             },
//           ),
//         ),
//         sizedTextfield,
//         TextWidget(
//           text: "Top 3 All Products/Ideas from ${filters[selectedIndex]}",
//           textSize: 15,
//         ),
//         sizedTextfield,
//         if (spotlightController.spotlightData.products != null)
//           spotlightController.spotlightData.products!.isEmpty
//               ? const SizedBox(
//                   height: 210,
//                   child: Center(
//                     child: TextWidget(
//                         text: "No Data Found",
//                         textSize: 14,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 )
//               : ListView.separated(
//                   padding: const EdgeInsets.symmetric(horizontal: 4),
//                   itemCount:
//                       spotlightController.spotlightData.products!.length > 3
//                           ? 3
//                           : spotlightController.spotlightData.products!.length,
//                   separatorBuilder: (context, index) =>
//                       const SizedBox(height: 12),
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return SpotlightProductCard(
//                         item:
//                             spotlightController.spotlightData.products![index]);
//                   }),
//       ],
//     );
//   }
// }
