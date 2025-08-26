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

import '../../../../../../controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';

class CommunityBookingDetailsScreen extends StatefulWidget {
  int index;
  CommunityBookingDetailsScreen({required this.index, super.key});

  @override
  State<CommunityBookingDetailsScreen> createState() =>
      _CommunityBookingDetailsScreenState();
}

class _CommunityBookingDetailsScreenState
    extends State<CommunityBookingDetailsScreen> {
  CommunityEventsController communityEvents = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Booking Details",
          autoAction: true,
        ),
        body: communityEvents.descriptionController.isEnable
            ? const Center(
                child: TextWidget(text: "No Bookings Available", textSize: 16),
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.separated(
                    itemCount: 16,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 6,
                      );
                    },
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
                              TextWidget(
                                text: "Booking #$index",
                                textSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              if (communityEvents
                                  .dateController.hashCode.isEven)
                                ListTile(
                                  leading: Icon(
                                    Icons.mail,
                                    color: AppColors.white,
                                  ),
                                  title: TextWidget(
                                      text: communityEvents.dateController.text,
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
                                        "${communityEvents.dateController.hashCode}",
                                    textSize: 16),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                visualDensity: VisualDensity.compact,
                              ),
                              Divider(
                                color: AppColors.white38,
                              ),
                              const SizedBox(height: 10),
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
