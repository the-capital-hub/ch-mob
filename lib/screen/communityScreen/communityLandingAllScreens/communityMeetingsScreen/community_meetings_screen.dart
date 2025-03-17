import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddServiceScreen/community_add_service_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityMeetingsScreen/communityMeetingBookingsScreen/community_meeting_bookings_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/datePicker/datePicker.dart';
import 'package:capitalhub_crm/widget/dilogue/custom_dialogue.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityMeetingsScreen extends StatefulWidget {
  const CommunityMeetingsScreen({super.key});

  @override
  State<CommunityMeetingsScreen> createState() =>
      _CommunityMeetingScreenState();
}

class _CommunityMeetingScreenState extends State<CommunityMeetingsScreen> {
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
  bool isBooked = false;
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
                    const TextWidget(
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
                        sharePostPopup(context, "", "share meeting details");
                      },
                    )
                  ],
                ),
                sizedTextfield,
                const TextWidget(
                  text: "Description",
                  textSize: 15,
                ),
                sizedTextfield,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(
                        text: "Duration : 45 minutes", textSize: 16),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: AppColors.white,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
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
                Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: List.generate(data.length, (index) {
                    return InkWell(
                      onTap: () {},
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: AppColors.white12,
                        surfaceTintColor: AppColors.white12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
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
                            Get.to(
                                () => const CommunityMeetingBookingsScreen());
                          },
                          title: "View Bookings (1)",
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      IconButton(
                          onPressed: () {
                            addServiceIndex = 1;
                            Get.to(() =>
                                const CommunityAddServiceScreen());
                                
                          },
                          icon: Icon(
                            Icons.edit,
                            color: AppColors.white,
                          )),
                      const SizedBox(width: 8),
                      IconButton(
                          onPressed: () {
                            showCustomPopup(
                              context: context,
                              title: "Delete this meeting",
                              message:
                                  "Are you sure you\n want to delete this meeting?",
                              button1Text: "Cancel",
                              button2Text: "OK",
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
                    ],
                  ),
                  if(!isAdmin)
                AppButton.primaryButton(
                  onButtonPressed: () {
                    DateTime customDate = DateTime(2023, 12, 31);
                    selectDate(context, customDate);
                  },
                  title: "Book Meeting",
                ),
                if(isBooked)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: AppColors.green,
                      width: 1,
                    ),
                  ),
                  color: AppColors.green.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        AppButton.primaryButton(
                            onButtonPressed: () {},
                            title: "Booked!",
                            bgColor: AppColors.green700),
                        sizedTextfield,
                        const TextWidget(
                          text: "March 13, 2024",
                          textSize: 16,
                        ),
                        sizedTextfield,
                        const TextWidget(
                          text: "09:00 - 09:30",
                          textSize: 16,
                        ),
                      ],
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
