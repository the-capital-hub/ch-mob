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
  CommunityWebinarsController communityWebinars = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "Registered Users",
            autoAction: true,
          ),
          body: communityWebinars.formattedDate[widget.index].isEmpty
              ? const Center(
                  child: TextWidget(
                      text: "No Registered Users Available", textSize: 16))
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 6),
                    itemCount: communityWebinars.hashCode,
                    itemBuilder: (context, index) {
                      return Card(
                        color: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      radius: 15,
                                      backgroundColor: GetStoreData.getStore
                                              .read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                      child: TextWidget(
                                        text: communityWebinars
                                            .infoController.text
                                            .toString(),
                                        textSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: GetStoreData.getStore
                                                .read('isInvestor')
                                            ? AppColors.black
                                            : AppColors.white,
                                      )),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  TextWidget(
                                    text: communityWebinars
                                        .dateController.hashCode
                                        .toString(),
                                    textSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.white12,
                                    child: Icon(Icons.mail,
                                        color: AppColors.whiteShade, size: 16),
                                  ),
                                  const SizedBox(width: 8),
                                  TextWidget(
                                      text: communityWebinars
                                          .dateController.reactive
                                          .toString(),
                                      textSize: 16),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.white12,
                                    child: Icon(Icons.phone,
                                        color: AppColors.whiteShade, size: 16),
                                  ),
                                  const SizedBox(width: 8),
                                  TextWidget(
                                      text: communityWebinars
                                          .emailController.text!,
                                      textSize: 16),
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
