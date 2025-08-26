import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityProductsAndMembersController/community_products_and_members_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/communityModel/communityLandingAllModels/getCommunityProductsAndMembersModel/get_community_products_and_members_model.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityProductsScreen/community_add_new_product_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityProductsScreen/communityPurchaseScreen/community_product_purchase_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/custom_dialogue.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class CommunityProductsScreen extends StatefulWidget {
  const CommunityProductsScreen({super.key});

  @override
  State<CommunityProductsScreen> createState() =>
      _CommunityProductsScreenState();
}

class _CommunityProductsScreenState extends State<CommunityProductsScreen> {
  CommunityProductsAndMembersController communityProducts =
      Get.put(CommunityProductsAndMembersController());

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      communityProducts.getCommunityProductsandMembers("").then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: isAdmin
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(() => AddNewProductScreen(isEdit: false));
                },
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(Icons.add, color: AppColors.white),
              )
            : null,
        body: Obx(
          () => communityProducts.isLoading.value
              ? Helper.pageLoading()
              : communityProducts.hasListeners
                  ? const Center(
                      child: TextWidget(
                          text: "No Products Available", textSize: 16))
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 4);
                      },
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: communityProducts.hashCode,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: AppColors.blackCard,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              communityProducts
                                                  .communityMembersList[index]
                                                  .profilePicture,
                                            ),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                  Positioned(
                                    top: -4,
                                    left: -4,
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12),
                                            topLeft: Radius.circular(12)),
                                      ),
                                      color: GetStoreData.getStore
                                              .read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          child: TextWidget(
                                            text: communityProducts
                                                    .communityProductsAndMembersList[
                                                        index]
                                                    .products
                                                    .isEmpty
                                                ? "Free"
                                                : "\u{20B9}${communityProducts.communityMembersList[index].id}/-",
                                            textSize: 16,
                                            color: GetStoreData.getStore
                                                    .read('isInvestor')
                                                ? AppColors.black
                                                : AppColors.white,
                                          )),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Row(
                                      children: [
                                        if (isAdmin)
                                          InkWell(
                                            onTap: () {},
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: AppColors
                                                  .green700
                                                  .withOpacity(0.8),
                                              child: Icon(Icons.edit,
                                                  color: AppColors.whiteCard,
                                                  size: 20),
                                            ),
                                          ),
                                        if (isAdmin)
                                          const SizedBox(
                                            width: 8,
                                          ),
                                        if (isAdmin)
                                          InkWell(
                                            onTap: () {
                                              showCustomPopup(
                                                context: context,
                                                title: "Delete this Product",
                                                message:
                                                    "Are you sure you\nwant to delete this Product?",
                                                button1Text: "Cancel",
                                                button2Text: "OK",
                                                icon: Icons.delete,
                                                onButton1Pressed: () {
                                                  Get.back();
                                                },
                                                onButton2Pressed: () {
                                                  Get.back();
                                                  Helper.loader(context);
                                                  communityProducts
                                                      .deleteCommunityProduct(
                                                          communityProducts
                                                              .communityMembersList[
                                                                  index]
                                                              .id);
                                                },
                                              );
                                            },
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: AppColors
                                                  .redColor
                                                  .withOpacity(0.8),
                                              child: Icon(Icons.delete,
                                                  color: AppColors.whiteCard,
                                                  size: 20),
                                            ),
                                          ),
                                        if (isAdmin)
                                          const SizedBox(
                                            width: 8,
                                          ),
                                        InkWell(
                                          onTap: () {
                                            sharePostPopup(
                                                context,
                                                "",
                                                communityProducts
                                                    .communityMembersList[index]
                                                    .id!);
                                          },
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor:
                                                AppColors.blue.withOpacity(0.8),
                                            child: Icon(
                                                Icons
                                                    .mobile_screen_share_rounded,
                                                color: AppColors.whiteCard,
                                                size: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                                const SizedBox(height: 8),
                                TextWidget(
                                  text: communityProducts
                                      .communityMembersList[index].firstName,
                                  textSize: 18,
                                  maxLine: 2,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                HtmlWidget(
                                  _isExpanded
                                      ? communityProducts
                                          .communityMembersList[index].firstName
                                      : communityProducts
                                                  .communityMembersList[index]
                                                  .firstName
                                                  .length >
                                              200
                                          ? "${communityProducts.communityMembersList[index].designation} ..."
                                          : communityProducts
                                              .communityMembersList[index]
                                              .firstName,
                                  textStyle: TextStyle(
                                      fontSize:
                                          (MediaQuery.of(context).size.width /
                                                  375) *
                                              12,
                                      color: AppColors.white),
                                ),
                                if (communityProducts
                                        .communityMembersList[index]
                                        .company!
                                        .length
                                        .toInt() >
                                    200)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isExpanded = !_isExpanded;
                                        });
                                      },
                                      child: Text(
                                        _isExpanded ? "Read Less" : "Read More",
                                        style: const TextStyle(
                                            color: AppColors.blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ));
  }
}
