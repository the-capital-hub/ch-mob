import 'dart:async';
import 'dart:convert';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import '../../../../utils/constant/app_var.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/loginController/login_controller.dart';
import '../../../../utils/appcolors/app_colors.dart';
import '../../../../widget/buttons/button.dart';
import '../../../../widget/text_field/text_field.dart';
import '../../../../widget/textwidget/text_widget.dart';
import 'signup_add_startup_screen.dart';

class SignupInfoScreen extends StatefulWidget {
  const SignupInfoScreen({super.key});

  @override
  State<SignupInfoScreen> createState() => _SignupInfoScreenState();
}

class _SignupInfoScreenState extends State<SignupInfoScreen> {
  LoginController loginMobileController = Get.put(LoginController());
  Timer? _debounce;
  GlobalKey<FormState> formkey = GlobalKey();
  void onUserNameChanged(String userName) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      await loginMobileController.checkUsernameAvailability(userName);
      setState(() {
        loginMobileController.suggestions;
      });
    });
  }

  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: formkey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                          text: "Complete Your Profile",
                          textSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                        TextWidget(
                          text:
                              "Please provide the following information to complete your profile",
                          textSize: 14,
                          color: AppColors.grey3Color,
                          maxLine: 2,
                        ),
                        sizedTextfield,
                        sizedTextfield,
                        MyCustomTextField.textField(
                            controller:
                                loginMobileController.firstNameController,
                            lableText: 'First Name',
                            valText: "Please enter first name",
                            hintText: "Enter First Name"),
                        sizedTextfield,
                        MyCustomTextField.textField(
                            controller:
                                loginMobileController.lastNameController,
                            valText: "Please enter last name",
                            lableText: 'Last Name',
                            hintText: "Enter Last Name"),
                        sizedTextfield,
                        MyCustomTextField.textField(
                            controller: loginMobileController.emailController,
                            lableText: 'Email',
                            valText: "Please enter email",
                            hintText: "Enter Email"),
                        sizedTextfield,
                        MyCustomTextField.textField(
                            controller:
                                loginMobileController.userNameController,
                            onChange: (String userName) {
                              onUserNameChanged(userName);
                            },
                            lableText: 'User Name',
                            valText: "Please enter user name",
                            hintText: "Enter User Name"),
                        if (loginMobileController.suggestions.isNotEmpty) ...[
                          sizedTextfield,
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: AppColors.blackCard,
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(
                                    text: "Suggested Usernames", textSize: 14),
                                sizedTextfield,
                                Wrap(
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: List.generate(
                                      loginMobileController.suggestions.length,
                                      (index) {
                                    return InkWell(
                                      onTap: () {
                                        loginMobileController
                                                .userNameController.text =
                                            loginMobileController
                                                .suggestions[index];
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        color: AppColors.white12,
                                        surfaceTintColor: AppColors.white12,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          child: TextWidget(
                                              text: loginMobileController
                                                  .suggestions[index],
                                              textSize: 14),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (GetStoreData.getStore.read("isInvestor")) ...[
                          sizedTextfield,
                          MyCustomTextField.textField(
                              controller:
                                  loginMobileController.companyNameController,
                              lableText: 'Company name',
                              hintText: "Enter Company Name"),
                          sizedTextfield,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextWidget(
                                  text: "My Investments", textSize: 15),
                              InkWell(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  await Get.to(() => SignupAddStartupScreen(
                                          isEdit: false))!
                                      .whenComplete(() {
                                    Future.delayed(Duration(milliseconds: 1),
                                        () {
                                      if (mounted) {
                                        FocusScope.of(context).unfocus();
                                      }
                                    });
                                    setState(() {});
                                  });
                                },
                                child: const TextWidget(
                                  text: "+ Add",
                                  textSize: 15,
                                  color: AppColors.primaryInvestor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          if (loginMobileController.myInvestments.isNotEmpty)
                            sizedTextfield,
                          if (loginMobileController.myInvestments.isNotEmpty)
                            SizedBox(
                              height: 170,
                              child: ListView.separated(
                                itemCount:
                                    loginMobileController.myInvestments.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(width: 12);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        width: Get.width / 1.3,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: AppColors.blackCard,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: AppColors.white38,
                                              width: 0.4),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 22,
                                                  backgroundImage: MemoryImage(
                                                      base64Decode(
                                                          "${loginMobileController.myInvestments[index].logo}")),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: TextWidget(
                                                    text:
                                                        "${loginMobileController.myInvestments[index].name}",
                                                    textSize: 15,
                                                    maxLine: 2,
                                                  ),
                                                ),
                                                const SizedBox(width: 12)
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            TextWidget(
                                              text:
                                                  "${loginMobileController.myInvestments[index].description}",
                                              textSize: 5,
                                              maxLine: 3,
                                            ),
                                            const Spacer(),
                                            Divider(
                                              color: AppColors.white54,
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.local_atm,
                                                    color: AppColors.white),
                                                const SizedBox(width: 6),
                                                TextWidget(
                                                    text:
                                                        "Invested: ${loginMobileController.myInvestments[index].investedEquity}% Equity",
                                                    textSize: 13),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          right: 6,
                                          top: 6,
                                          child: InkWell(
                                            onTap: () {
                                              loginMobileController
                                                  .myInvestments
                                                  .removeAt(index);
                                              setState(() {});
                                            },
                                            child: const Icon(
                                                Icons.remove_circle,
                                                color: AppColors.redColor),
                                          )),
                                    ],
                                  );
                                },
                              ),
                            ),
                          sizedTextfield,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextWidget(text: "Sectors", textSize: 15),
                              InkWell(
                                onTap: () async {
                                  loginMobileController.sectorsList
                                      .add(TextEditingController());
                                  setState(() {});
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    scrollController.animateTo(
                                      scrollController.position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeOut,
                                    );
                                  });
                                },
                                child: const TextWidget(
                                  text: "+ Add",
                                  textSize: 15,
                                  color: AppColors.primaryInvestor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          sizedTextfield,
                          ListView.separated(
                            itemCount: loginMobileController.sectorsList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return sizedTextfield;
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return MyCustomTextField.textField(
                                  hintText: "Enter Sector ${index + 1}",
                                  controller:
                                      loginMobileController.sectorsList[index],
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      loginMobileController.sectorsList
                                          .removeAt(index);
                                      setState(() {});
                                    },
                                    child: const Icon(Icons.remove_circle,
                                        color: AppColors.redColor),
                                  ));
                            },
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(12),
            child: AppButton.primaryButton(
              title: 'Continue',
              bgColor: GetStoreData.getStore.read("isInvestor")
                  ? AppColors.primaryInvestor
                  : AppColors.primary,
              onButtonPressed: () {
                if (formkey.currentState!.validate()) {
                  Helper.loader(context);
                  loginMobileController.saveRequiredData(context);
                }
              },
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
