// import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
// import 'package:capitalhub_crm/widget/appbar/appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../utils/constant/app_var.dart';
// import '../../../widget/buttons/button.dart';
// import '../../../widget/text_field/text_field.dart';
// import 'upload_logo_screen.dart';

// class UpdateComDetailScreen extends StatefulWidget {
//   const UpdateComDetailScreen({super.key});

//   @override
//   State<UpdateComDetailScreen> createState() => _UpdateComDetailScreenState();
// }

// class _UpdateComDetailScreenState extends State<UpdateComDetailScreen> {
//   TextEditingController brandNameController = TextEditingController();
//   TextEditingController legalNameController = TextEditingController();
//   TextEditingController webLinkController = TextEditingController();
//   TextEditingController cusCarePhoneController = TextEditingController();
//   TextEditingController cusEmailController = TextEditingController();
//   TextEditingController stageOfCompController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return 
//     Container(
//       decoration:  bgDec,
//       child:
//     Scaffold(
//       backgroundColor: AppColors.transparent,
//       appBar: HelperAppBar.appbarHelper(title: "Update Company Details"),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               MyCustomTextField.textField(
//                   lableText: "Brand Name",
//                   hintText: "Enter Brand Name",
//                   controller: brandNameController),
//               sizedTextfield,
//               MyCustomTextField.textField(
//                   lableText: "Legal Name",
//                   hintText: "Enter Legal Name",
//                   controller: legalNameController),
//               sizedTextfield,
//               MyCustomTextField.textField(
//                   lableText: "Website Link",
//                   hintText: "Enter Website Link",
//                   controller: webLinkController),
//               sizedTextfield,
//               MyCustomTextField.textField(
//                   lableText: "Customer Contact",
//                   hintText: "Enter Customer Contact",
//                   controller: cusCarePhoneController),
//               sizedTextfield,
//               MyCustomTextField.textField(
//                   lableText: "Customer Support email",
//                   hintText: "Enter Customer Support email",
//                   controller: cusEmailController),
//               sizedTextfield,
//               MyCustomTextField.textField(
//                   lableText: "Stage of Company",
//                   hintText: "Enter Stage of Company",
//                   controller: stageOfCompController),
//               sizedTextfield,
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: AppButton.primaryButton(
//             onButtonPressed: () {
//               Get.to(() => UploadLogoScreen());
//             },
//             title: "Confirm"),
//       ),
//     ));
//   }
// }
