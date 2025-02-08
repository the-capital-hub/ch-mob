// import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
// import 'package:capitalhub_crm/widget/appbar/appbar.dart';
// import 'package:capitalhub_crm/widget/text_field/text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../utils/constant/app_var.dart';
// import '../../../widget/buttons/button.dart';
// import '../../../widget/textwidget/text_widget.dart';
// import '../selectedIndustryScreen/select_field_screen.dart';
// import 'social_media_link_screen.dart';

// class DescriptionScreen extends StatefulWidget {
//   const DescriptionScreen({super.key});

//   @override
//   State<DescriptionScreen> createState() => _DescriptionScreenState();
// }

// class _DescriptionScreenState extends State<DescriptionScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return 
//     Container(
//       decoration:  bgDec,
//       child:
//     Scaffold(
//       backgroundColor: AppColors.transparent,
//       appBar: HelperAppBar.appbarHelper(title: ""),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const TextWidget(
//               text: "Write Description",
//               textSize: 22,
//               fontWeight: FontWeight.w500,
//             ),
//             sizedTextfield,
//             const TextWidget(
//               text: "Write something about Company !",
//               textSize: 14,
//               maxLine: 3,
//             ),
//             sizedTextfield,
//             sizedTextfield,
//             MyCustomTextField.textField(
//                 hintText: "Write description",
//                 maxLine: 6,
//                 controller: bioController),
//             sizedTextfield,
//             sizedTextfield,
//             AppButton.primaryButton(
//                 onButtonPressed: () {
//                   Get.to(SocialMediaScreen());
//                 },
//                 title: "Next")
//           ],
//         ),
//       ),
//     ));
//   }

//   TextEditingController bioController = TextEditingController();
// }
