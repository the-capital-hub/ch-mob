import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityRegisteredUsersScreen extends StatefulWidget {
  int index;
  CommunityRegisteredUsersScreen({required this.index, super.key});

  @override
  State<CommunityRegisteredUsersScreen> createState() =>
      _CommunityRegisteredUsersScreenState();
}

class _CommunityRegisteredUsersScreenState
    extends State<CommunityRegisteredUsersScreen> {
  CommunityEventsController communityEvents = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "Registered Users",
            hideBack: true,
            autoAction: true,
          ),
          body: communityEvents.communityEventsData.webinars![widget.index]
                  .joinedUsers!.isEmpty
              ? const Center(
                  child: TextWidget(
                      text: "No Registered Users Available", textSize: 16))
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: communityEvents.communityEventsData
                        .webinars![widget.index].joinedUsers!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               CircleAvatar(
                                  backgroundColor: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                                  child: TextWidget(text: communityEvents
                                        .communityEventsData
                                        .webinars![widget.index]
                                        .joinedUsers![index]
                                        .name![0].toUpperCase(), textSize: 16,color: GetStoreData.getStore.read('isInvestor')?AppColors.black:AppColors.white,)),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: communityEvents
                                        .communityEventsData
                                        .webinars![widget.index]
                                        .joinedUsers![index]
                                        .name!,
                                    textSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  sizedTextfield,
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.mail,
                                        color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary
                                      ),
                                      SizedBox(width: 8),
                                      TextWidget(
                                          text: communityEvents
                                              .communityEventsData
                                              .webinars![widget.index]
                                              .joinedUsers![index]
                                              .email!,
                                          textSize: 16),
                                    ],
                                  ),
                                  sizedTextfield,
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                                      ),
                                      SizedBox(width: 8),
                                      TextWidget(
                                          text: communityEvents
                                              .communityEventsData
                                              .webinars![widget.index]
                                              .joinedUsers![index]
                                              .mobile!,
                                          textSize: 16),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ));
  }
}
