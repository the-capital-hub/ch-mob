import 'dart:async';

import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityProductsAndMembersController/community_products_and_members_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CommunityPeopleScreen extends StatefulWidget {
  const CommunityPeopleScreen({super.key});

  @override
  State<CommunityPeopleScreen> createState() => _CommunityPeopleScreenState();
}

class _CommunityPeopleScreenState extends State<CommunityPeopleScreen> {
  CommunityProductsAndMembersController communityMembers =
      Get.put(CommunityProductsAndMembersController());
  TextEditingController searchController = TextEditingController();
  List<String> communityNames = [
    "Capital Hub Community",
    "Hub Community",
    "Hustler's Community",
    "Pixel Community",
    "Monday Community",
    "Capital Hub Community",
    "Hub Community",
    "Hustler's Community",
    "Pixel Community",
    "Monday Community",
  ];

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      communityMembers.getCommunityProductsandMembers("").then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  Timer? _debounce;
  void onMemberNameChanged(String name) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      await communityMembers.getCommunityProductsandMembers(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
            backgroundColor: AppColors.transparent,
            body: Obx(
              () => Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyCustomTextField.textField(
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.white54,
                        ),
                        borderClr: AppColors.white54,
                        borderRadius: 8,
                        hintText: "Search",
                        onChange: (String name) {
                          onMemberNameChanged(name);
                        },
                        controller: searchController),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: communityMembers.isLoading.value
                          ? Helper.pageLoading()
                          : communityMembers.communityMembersList.isEmpty
                              ? const Center(
                                  child: TextWidget(
                                      text: "No Members Present", textSize: 16))
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Card(
                                      margin: EdgeInsets.zero,
                                      color: AppColors.blackCard,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                              foregroundImage: NetworkImage(
                                                communityMembers
                                                    .communityMembersList[index]
                                                    .profilePicture,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                    text:
                                                        "${communityMembers.communityMembersList[index].firstName} ${communityMembers.communityMembersList[index].lastName}",
                                                    textSize: 18),
                                                if (communityMembers
                                                    .communityMembersList[index]
                                                    .designation
                                                    .toString()
                                                    .isNotEmpty)
                                                  TextWidget(
                                                    text: communityMembers
                                                        .communityMembersList[
                                                            index]
                                                        .designation
                                                        .toString(),
                                                    textSize: 14,
                                                    color: GetStoreData.getStore
                                                            .read('isInvestor')
                                                        ? AppColors
                                                            .primaryInvestor
                                                        : AppColors.primary,
                                                  ),
                                                if (communityMembers
                                                    .communityMembersList[index]
                                                    .company
                                                    .toString()
                                                    .isNotEmpty)
                                                  TextWidget(
                                                      text: communityMembers
                                                          .communityMembersList[
                                                              index]
                                                          .company
                                                          .toString(),
                                                      textSize: 14),
                                                if (communityMembers
                                                    .communityMembersList[index]
                                                    .location
                                                    .toString()
                                                    .isNotEmpty)
                                                  TextWidget(
                                                      text: communityMembers
                                                          .communityMembersList[
                                                              index]
                                                          .location
                                                          .toString(),
                                                      textSize: 14),
                                                if (communityMembers
                                                    .communityMembersList[index]
                                                    .joinedDate
                                                    .isNotEmpty)
                                                  TextWidget(
                                                      text: communityMembers
                                                          .communityMembersList[
                                                              index]
                                                          .joinedDate,
                                                      textSize: 14),
                                              ],
                                            ),
                                            const Spacer(),
                                            if (isAdmin)
                                              InkWell(
                                                  onTap: () {
                                                    Helper.loader(context);
                                                    communityMembers
                                                        .removeCommunityMember(
                                                            communityMembers
                                                                .communityMembersList[
                                                                    index]
                                                                .id);
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor: AppColors
                                                        .redColor
                                                        .withOpacity(0.2),
                                                    radius: 20,
                                                    child: Icon(
                                                      Icons.person_remove,
                                                      color:
                                                          AppColors.whiteCard,
                                                      size: 20,
                                                    ),
                                                  ))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 12,
                                      ),
                                  itemCount: communityMembers
                                      .communityMembersList.length),
                    )
                  ],
                ),
              ),
            )));
  }
}
