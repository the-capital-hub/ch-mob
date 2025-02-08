// import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
// import 'package:capitalhub_crm/utils/constant/app_var.dart';
// import 'package:capitalhub_crm/utils/helper/helper.dart';
// import 'package:capitalhub_crm/widget/appbar/appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../widget/buttons/button.dart';
// import '../../../widget/textwidget/text_widget.dart';
// import '../updateCompanyDetailScreen/update_com_detail_screen.dart';

// class SelectIndustryScreen extends StatefulWidget {
//   const SelectIndustryScreen({super.key});

//   @override
//   State<SelectIndustryScreen> createState() => _SelectIndustryScreenState();
// }

// class _SelectIndustryScreenState extends State<SelectIndustryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return 
//     Container(
//       decoration:  bgDec,
//       child:
//     Scaffold(
//         backgroundColor: AppColors.transparent,
//         appBar: HelperAppBar.appbarHelper(title: "Select Industries", action: [
//           TextWidget(
//             text: "Skip",
//             textSize: 14,
//             fontWeight: FontWeight.w500,
//           ),
//           SizedBox(width: 12),
//         ]),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//           child: Column(
//             children: [
//               sizedTextfield,
//               TextWidget(text: "Technology and Innovation", textSize: 16),
//               sizedTextfield,
//               TextWidget(text: "Select the industries max 3 ", textSize: 12),
//               sizedTextfield,
//               GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                 ),
//                 shrinkWrap: true,
//                 itemCount: 10,
//                 itemBuilder: (BuildContext context, int index) {
//                   bool isSelected = selectedIndices.contains(index);
//                   return Column(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           setState(() {
//                             if (isSelected) {
//                               selectedIndices.remove(index);
//                             } else if (selectedIndices.length < 3) {
//                               selectedIndices.add(index);
//                             }
//                           });
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: AppColors.blackCard,
//                               border: Border.all(
//                                   color: isSelected
//                                       ? AppColors.primary
//                                       : AppColors.transparent,
//                                   width: 1.5),
//                               borderRadius: BorderRadius.circular(12)),
//                           child: const Padding(
//                             padding: EdgeInsets.all(12.0),
//                             child: FlutterLogo(),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       TextWidget(
//                           text: "Fintech",
//                           color:
//                               isSelected ? AppColors.primary : AppColors.white,
//                           textSize: 12)
//                     ],
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Padding(
//           padding: EdgeInsets.all(12),
//           child: Column(mainAxisSize: MainAxisSize.min,
//             children: [
//               if(selectedIndices.isNotEmpty)
//               TextWidget(text: "${selectedIndices.length} Industries are selected", textSize:14),
//               sizedTextfield,
//               AppButton.primaryButton(
//                   onButtonPressed: () {
//                     if (selectedIndices.isNotEmpty) {
//                       Get.to(UpdateComDetailScreen());
//                     }
//                   },
//                   bgColor: selectedIndices.isEmpty
//                       ? AppColors.white12
//                       : AppColors.primary,
//                   title: "Next"),
//             ],
//           ),
//         )));
//   }

//   List<int> selectedIndices = [];
// }
