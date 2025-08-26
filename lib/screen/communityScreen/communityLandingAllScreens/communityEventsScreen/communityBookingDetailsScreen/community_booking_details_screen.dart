import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommunityBookingDetailsScreen extends StatefulWidget {
  int index;
  CommunityBookingDetailsScreen({required this.index, super.key});

  @override
  State<CommunityBookingDetailsScreen> createState() =>
      _CommunityBookingDetailsScreenState();
}

class _CommunityBookingDetailsScreenState
    extends State<CommunityBookingDetailsScreen> {
  var communityWebinars;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Booking Details",
          hideBack: true,
          autoAction: true,
        ),
        body: communityWebinars
                .communityWebinarsList[widget.index].bookings!.isEmpty
            ? const Center(
                child: TextWidget(text: "No Bookings Available", textSize: 16),
              )
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView.separated(
                    itemCount: communityWebinars
                        .communityWebinarsList[widget.index].bookings!.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: AppColors.navyBlue,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TextWidget(
                                    text: "Booking #$index",
                                    textSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // const Spacer(),
                                  // Card(
                                  //   shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(20),
                                  //   ),
                                  //   color: AppColors.green700.withOpacity(0.3),
                                  //   child: const Padding(
                                  //     padding: EdgeInsets.all(12),
                                  //     child: TextWidget(
                                  //       text: "Confirmed",
                                  //       textSize: 14,
                                  //       color: AppColors.green,
                                  //       fontWeight: FontWeight.w500,
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: AppColors.white,
                                ),
                                title: TextWidget(
                                    text: communityWebinars
                                        .communityWebinarsList[widget.index]
                                        .bookings![index]
                                        .name!,
                                    textSize: 16),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                visualDensity: VisualDensity.compact,
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.mail,
                                  color: AppColors.white,
                                ),
                                title: TextWidget(
                                    text: communityWebinars
                                        .communityWebinarsList[widget.index]
                                        .bookings![index]
                                        .email!,
                                    textSize: 16),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                visualDensity: VisualDensity.compact,
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.calendar_month,
                                  color: AppColors.white,
                                ),
                                title: TextWidget(
                                    text:
                                        "${communityWebinars.communityWebinarsList[widget.index].bookings![index].startTime!} - ${communityWebinars.communityWebinarsList[widget.index].bookings![index].endTime!}",
                                    textSize: 16),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                visualDensity: VisualDensity.compact,
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.schedule,
                                  color: AppColors.white,
                                ),
                                title: TextWidget(
                                    text: communityWebinars
                                        .communityWebinarsList[widget.index]
                                        .bookings![index]
                                        .bookedAt!,
                                    textSize: 16),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                visualDensity: VisualDensity.compact,
                              ),
                              Divider(
                                color: AppColors.white38,
                              ),
                              sizedTextfield,
                              const TextWidget(
                                text: "Additional Info:",
                                textSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              sizedTextfield,
                              TextWidget(
                                  text: communityWebinars
                                      .communityWebinarsList[widget.index]
                                      .bookings![index]
                                      .additionalInfo!,
                                  textSize: 16),
                              sizedTextfield,
                              AppButton.primaryButton(
                                  onButtonPressed: () async {
                                    await Clipboard.setData(ClipboardData(
                                        text: communityWebinars
                                            .communityWebinarsList[widget.index]
                                            .bookings![index]
                                            .meetingLink!));
                                    HelperSnackBar.snackBar(
                                        "Success", "Link copied to clipboard!");
                                  },
                                  title: "Join Meeting"),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}
