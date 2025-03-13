import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPriorityDMsScreen/communityQuestionsScreen/community_questions_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPriorityDMsScreen/communityYourQuestionsScreen/community_your_questions_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/community_products_and_services_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/create_new_webinar_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/custom_dialogue.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityPriorityDMsScreen extends StatefulWidget {
  const CommunityPriorityDMsScreen({super.key});

  @override
  State<CommunityPriorityDMsScreen> createState() =>
      _CommunityPriorityDMScreenState();
}

class _CommunityPriorityDMScreenState
    extends State<CommunityPriorityDMsScreen> {
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
  ];
  bool isQuestionFieldVisible = false;
  bool noQuestions = true;
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: AppColors.navyBlue,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: "Title",
                      textSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.mobile_screen_share_rounded,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        sharePostPopup(context, "", "share priorityDMs detail");
                      },
                    )
                  ],
                ),

                sizedTextfield,
                TextWidget(
                  text: "Description",
                  textSize: 15,
                  // fontWeight: FontWeight.w500,
                ),
                sizedTextfield,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(text: "Response Time: 1 hour", textSize: 16),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                          text: "Free",
                          textSize: 10,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  ],
                ),
                sizedTextfield,
                // Row(
                //   children: [
                //     Icon(
                //       Icons.language,
                //       color: AppColors.white,
                //       size: 22,
                //     ),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //     const TextWidget(text: "Online", textSize: 16)
                //   ],
                // ),

                // sizedTextfield,

                Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: List.generate(data.length, (index) {
                    return InkWell(
                      onTap: () {
                        // loginMobileController
                        //         .userNameController.text =
                        //     loginMobileController
                        //         .suggestions[index];
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: AppColors.white12,
                        surfaceTintColor: AppColors.white12,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: TextWidget(text: data[index], textSize: 14),
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(
                  height: 15,
                ),
                if (isAdmin)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppButton.primaryButton(
                          onButtonPressed: () {
                            Get.to(() => const CommunityQuestionsScreen());
                          },
                          title: "View Questions",
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      IconButton(
                          onPressed: () {
                            Get.to(() =>
                                const CommunityProductsAndServicesScreen());
                          },
                          icon: Icon(
                            Icons.edit,
                            color: AppColors.white,
                          )),
                      const SizedBox(width: 8),
                      IconButton(
                          onPressed: () {
                            showCustomPopup(
                              context: context, // Pass the context
                              title: "Delete this Priority DM", // Dialog Title
                              message:
                                  "Are you sure you\nwant to delete this Priority DM?", // Dialog Message
                              button1Text: "Cancel", // First button text
                              button2Text: "OK", // Second button text
                              icon:
                                  Icons.delete, // Icon to display in the popup
                              onButton1Pressed: () {
                                // Action for the first button (e.g., Cancel)
                                Get.back(); // Close the dialog
                              },
                              onButton2Pressed: () {
                                // Action for the second button (e.g., OK)
                                Get.back(); // Close the dialog
                              },
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.white,
                          )),
                      // const Icon(
                      //   Icons.schedule,
                      //   color: AppColors.redColor,
                      //   size: 22,
                      // ),
                      // const SizedBox(width: 5),
                      //  TextWidget(
                      //   text: webinarController.webinarsList[index].duration,
                      //   textSize: 16,
                      //   color: AppColors.redColor,
                      // ),
                    ],
                  ),
                // sizedTextfield,
                if (!isAdmin)
                  if (noQuestions)
                    // Show this section if there are no questions
                    Column(
                      children: [
                        AppButton.primaryButton(
                          onButtonPressed: () {
                            setState(() {
                              isQuestionFieldVisible = !isQuestionFieldVisible;
                            });
                          },
                          title: "Ask Question",
                        ),
                        if (isQuestionFieldVisible) ...[
                          sizedTextfield,
                          MyCustomTextField.textField(
                            hintText: "Type your question here...",
                            controller: urlController,
                            maxLine: 3,
                            borderClr: AppColors.white12,
                          ),
                          sizedTextfield,
                          AppButton.primaryButton(
                            onButtonPressed: () {
                              // Handle question submission
                              setState(() {
                                noQuestions = false;
                                isQuestionFieldVisible = false;
                              });
                            },
                            title: "Submit",
                          ),
                        ],
                      ],
                    )
                  else
                    // Show this section when there are existing questions
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: AppButton.primaryButton(
                                onButtonPressed: () {
                                  setState(() {
                                    isQuestionFieldVisible =
                                        !isQuestionFieldVisible; // Toggle visibility of the question input
                                  });
                                },
                                title: "Ask Question",
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: AppButton.primaryButton(
                                onButtonPressed: () {
                                  // Handle "View Your Questions" action (navigate to a page, etc.)
                                  Get.to(() =>
                                      const CommunityYourQuestionsScreen());
                                },
                                title:
                                    "View Your\nQuestions (3)", // This should reflect the actual number of questions
                              ),
                            ),
                          ],
                        ),
                        if (isQuestionFieldVisible) ...[
                          sizedTextfield,
                          MyCustomTextField.textField(
                            hintText: "Type your question here...",
                            controller: urlController,
                            maxLine: 3,
                            borderClr: AppColors.white12,
                          ),
                          sizedTextfield,
                          AppButton.primaryButton(
                            onButtonPressed: () {
                              // Handle question submission
                            },
                            title: "Submit",
                          ),
                        ],
                      ],
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
