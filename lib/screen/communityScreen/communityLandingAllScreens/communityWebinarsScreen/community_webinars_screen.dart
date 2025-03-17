import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddServiceScreen/community_add_service_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityWebinarsScreen/communityRegisterNowScreen/community_register_now_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityWebinarsScreen/communityRegisteredUsersScreen/community_registered_users_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/custom_dialogue.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityWebinarsScreen extends StatefulWidget {
  const CommunityWebinarsScreen({super.key});

  @override
  State<CommunityWebinarsScreen> createState() =>
      _CommunityWebinarsScreenState();
}

class _CommunityWebinarsScreenState extends State<CommunityWebinarsScreen> {
  bool isWebinarEnded = false;
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
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: NetworkImage(
                            "https://bettermeetings.expert/wp-content/uploads/engaging-interactive-webinar-best-practices-and-formats.jpg",
                          ),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10)),
                ),
                sizedTextfield,
                Row(
                  children: [
                    const TextWidget(
                      text: "Title",
                      textSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    if (isAdmin) ...[
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.whiteCard,
                          size: 20,
                        ),
                        onPressed: () {
                          addServiceIndex = 3;
                          Get.to(() => const CommunityAddServiceScreen());
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            showCustomPopup(
                              context: context,
                              title: "Delete this webinar",
                              message:
                                  "Are you sure you\nwant to delete this webinar?",
                              button1Text: "Cancel",
                              button2Text: "Disable",
                              icon: Icons.delete,
                              onButton1Pressed: () {
                                Get.back();
                              },
                              onButton2Pressed: () {
                                Get.back();
                              },
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.white,
                          )),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.mobile_screen_share_rounded,
                          color: AppColors.whiteCard,
                        ),
                        onPressed: () {
                          sharePostPopup(context, "", "share webinar detail");
                        },
                      ),
                    ],
                    if (!isAdmin)
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.mobile_screen_share_rounded,
                          color: AppColors.whiteCard,
                        ),
                        onPressed: () {
                          sharePostPopup(context, "", "share webinar detail");
                        },
                      ),
                  ],
                ),
                sizedTextfield,
                const TextWidget(
                  text: "Description",
                  textSize: 16,
                ),
                sizedTextfield,
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: AppColors.white,
                      size: 22,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const TextWidget(text: "7 March 2024", textSize: 16)
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: AppColors.white,
                      size: 22,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const TextWidget(text: "30 mins", textSize: 16)
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: AppColors.white,
                      size: 22,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const TextWidget(text: "0 joined", textSize: 16)
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.payment,
                      color: AppColors.white,
                      size: 22,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const TextWidget(text: "\u{20B9}450", textSize: 16)
                  ],
                ),
                sizedTextfield,
                if (isAdmin)
                  AppButton.primaryButton(
                      onButtonPressed: () {
                        Get.to(() => const CommunityRegisteredUsersScreen());
                      },
                      title: "View Guests"),
                if (!isAdmin)
                  AppButton.primaryButton(
                      onButtonPressed: () {
                        Get.to(() => const CommunityRegisterNowScreen());
                      },
                      title: "+ Register Now"),
                if (!isAdmin && isWebinarEnded)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: AppColors.redColor,
                        width: 1,
                      ),
                    ),
                    color: AppColors.redColor.withOpacity(0.3),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: TextWidget(
                        text: "Webinar Ended",
                        textSize: 16,
                        color: AppColors.redColor,
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
