import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';

import '../../../utils/constant/app_var.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/loginController/login_controller.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/constant/asset_constant.dart';
import '../../../utils/helper/helper_sncksbar.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/text_field/text_field.dart';
import '../../../widget/textwidget/text_widget.dart';
import '../selectWhatYouAreScreen/select_role_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  LoginController loginMobileController = Get.put(LoginController());
  @override
  void initState() {
    loginMobileController.isLogin = false;
    if (loginMobileController.selectedRoleIndex == 1) {
      loginMobileController.selectedIndustry = data.first;
    } else {
      loginMobileController.selectedIndustry = "";
    }
    super.initState();
  }

  @override
  void dispose() {
    loginMobileController.isLogin = true;

    super.dispose();
  }

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formkey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 100),
                      // const Spacer(),
                      Image.asset(
                        PngAssetPath.appLogo,
                        height: 80,
                        width: 60,
                      ),
                      const TextWidget(
                        text: "Join Capital Hub",
                        textSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      sizedTextfield,
                      Row(
                        children: [
                          Expanded(
                            child: MyCustomTextField.textField(
                                controller:
                                    loginMobileController.firstNameController,
                                lableText: 'First Name',
                                valText: "Please enter first name",
                                hintText: "Enter First Name"),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: MyCustomTextField.textField(
                                controller:
                                    loginMobileController.lastNameController,
                                valText: "Please enter last name",
                                lableText: 'Last Name',
                                hintText: "Enter Last Name"),
                          ),
                        ],
                      ),

                      sizedTextfield,
                      MyCustomTextField.textField(
                          controller:
                              loginMobileController.loginPhoneController,
                          valText: "Please enter mobile number",
                          textInputType: TextInputType.phone,
                          lableText: 'Mobile Number',
                          hintText: "Enter Mobile Number"),
                      sizedTextfield,
                      MyCustomTextField.textField(
                          controller: loginMobileController.emailController,
                          lableText: 'Email',
                          valText: "Please enter email",
                          hintText: "Enter Email"),

                      sizedTextfield,
                      MyCustomTextField.textField(
                          controller:
                              loginMobileController.companyNameController,
                          lableText: 'Company',
                          valText: "Please enter company name",
                          hintText: "Enter Company Name"),

                      sizedTextfield,
                      loginMobileController.selectedRoleIndex == 0
                          ? MyCustomTextField.textField(
                              controller:
                                  loginMobileController.designationController,
                              lableText: 'Designation',
                              valText: "Please enter designaiton",
                              hintText: "Enter Designation")
                          : DropDownWidget(
                              status: loginMobileController.selectedIndustry,
                              lable: "Industry",
                              statusList: data,
                              onChanged: (val) {
                                loginMobileController.selectedIndustry = val!;
                                setState(() {});
                              }),

                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                              text: "Alredy have an account ",
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                              textSize: 14),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const TextWidget(
                              text: "Sign In",
                              textSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),

                      AppButton.primaryButton(
                        title: 'Continue',
                        onButtonPressed: () {
                          // Get.offAll(SelectRoleScreen());

                          if (formkey.currentState!.validate()) {
                            if (loginMobileController.passwordController.text ==
                                loginMobileController
                                    .conPasswordController.text) {
                              loginMobileController.signupApi(context);
                            } else {
                              HelperSnackBar.snackBar(
                                  "Error", "Password not matched");
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  List<String> data = [
    "Sector Agnostic",
    "B2B",
    "B2C",
    "AI/ML",
    "API",
    "AR/VR",
    "Analytics",
    "Automation",
    "BioTech",
    "Cloud",
    "Consumer Tech",
    "Creator Economy",
    "Crypto/Blockchain",
    "D2C",
    "DeepTech",
    "Developer Tools",
    "E-Commerce",
    "Education",
    "Climate Tech",
    "Fintech",
    "Gaming",
    "Healthtech",
    "IoT (Internet of Things)",
    "Legaltech",
    "Logistics and Supply Chain",
    "Manufacturing",
    "Media and Entertainment",
    "Mobility and Transportation",
    "PropTech (Property Technology)",
    "Robotics",
    "Saas (Software as a Service)",
    "SpaceTech",
    "SportsTech",
    "Telecommunications",
    "Travel and Tourism",
    "Wearables",
    "Insurtech",
    "Agtech (Agriculture Technology)",
    "Clean Energy / Renewable Energy",
    "Foodtech",
    "HRtech (Human Resources Technology)",
    "B2B Marketplace",
    "Cybersecurity",
    "E-sports",
    "MarTech (Marketing Technology)",
    "MedTech (Medical Technology)",
    "Retail Tech",
    "others",
  ];
}

// Future<bool> chooseImage({
//   required BuildContext context,
//   required Function() onTapCamera,
//   required Function() onTapGallery,
// }) async {
//   final width = MediaQuery.of(context).size.width;
//   return await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             contentPadding: const EdgeInsets.all(0),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   height: 60,
//                   width: 60,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       color: AppColors.primaryColor,
//                       border: Border.all(color: AppColors.white, width: 0)),
//                   child: const Icon(
//                     Icons.image,
//                     size: 40,
//                     color: AppColors.white,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 const TextWidget(
//                   text: AppText.uploadProfile,
//                   textSize: 18,
//                   color: AppColors.black,
//                   maxLine: 2,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ListTile(
//                         leading: Icon(
//                           Icons.camera_alt,
//                           color: AppColors.black65,
//                           size: 30,
//                         ),
//                         title: const TextWidget(
//                           text: "Take Photo",
//                           textSize: 16,
//                           color: Colors.black,
//                         ),
//                         onTap: onTapCamera,
//                       ),
//                       ListTile(
//                         leading: Icon(
//                           Icons.image,
//                           color: AppColors.black65,
//                           size: 30,
//                         ),
//                         title: const TextWidget(
//                             text: "Choose From Gallery",
//                             textSize: 16,
//                             color: Colors.black),
//                         onTap: onTapGallery,
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   color: AppColors.grey3Color,
//                   height: 0,
//                   thickness: 1,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: InkWell(
//                         onTap: () {
//                           Get.back();
//                         },
//                         child: SizedBox(
//                           height: 45,
//                           child: Center(
//                             child: TextWidget(
//                               text: "cancel".toUpperCase(),
//                               color: Colors.black54,
//                               fontWeight: FontWeight.w500,
//                               textSize: 14,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ));
// }
