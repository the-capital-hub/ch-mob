import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityMeetingsController/community_meetings_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommunityMeetingBookingsScreen extends StatefulWidget {
  int? index;
  CommunityMeetingBookingsScreen({required this.index, super.key});

  @override
  State<CommunityMeetingBookingsScreen> createState() =>
      _CommunityMeetingBookingsScreenState();
}

class _CommunityMeetingBookingsScreenState
    extends State<CommunityMeetingBookingsScreen> {
  CommunityMeetingsController communityMeetings = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Meeting Bookings",
          hideBack: true,
          autoAction: true,
        ),
        body: communityMeetings
                .communityMeetingsList[widget.index!].bookings!.isEmpty
            ? const Center(
                child: TextWidget(text: "No Bookings Available", textSize: 16))
            : ListView.builder(
                itemCount: communityMeetings
                    .communityMeetingsList[widget.index!].bookings!.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: AppColors.blackCard,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                foregroundImage: NetworkImage(
                                  communityMeetings
                                      .communityMeetingsList[widget.index!]
                                      .bookings![index]
                                      .userId!
                                      .profilePicture
                                      .toString(),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text:
                                    "${communityMeetings.communityMeetingsList[widget.index!].bookings![index].userId!.firstName} ${communityMeetings.communityMeetingsList[widget.index!].bookings![index].userId!.lastName}",
                                textSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              const Spacer(),
                              Card(
                                color: AppColors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(
                                    color: Colors.white38,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: TextWidget(
                                    text: communityMeetings
                                        .communityMeetingsList[widget.index!]
                                        .bookings![index]
                                        .createdAt!,
                                    textSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                          sizedTextfield,
                          TextWidget(
                            text:
                                "Booked ${communityMeetings.communityMeetingsList[widget.index!].bookings![index].slot!.bookedAt}",
                            textSize: 16,
                            maxLine: 2,
                          ),
                          sizedTextfield,
                          sizedTextfield,
                          AppButton.primaryButton(
                              onButtonPressed: () async {
                                await Clipboard.setData(ClipboardData(
                                    text: communityMeetings
                                        .communityMeetingsList[widget.index!]
                                        .bookings![index]
                                        .slot!
                                        .meetingLink!));

                                HelperSnackBar.snackBar(
                                    "Success", "Link copied to clipboard!");
                              },
                              title: "Join Meeting")
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
