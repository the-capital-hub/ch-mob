import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityProductsAndMembersController/community_products_and_members_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityProductsScreen/community_add_new_product_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityProductsScreen/communityPurchaseScreen/community_purchase_screen.dart';
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
              : communityProducts.communityProductsList.isEmpty
                  ? const Center(
                      child: TextWidget(
                          text: "No Products Available", textSize: 16))
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 4);
                      },
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: communityProducts.communityProductsList.length,
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
                                                  .communityProductsList[index]
                                                  .image,
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
                                                    .communityProductsList[
                                                        index]
                                                    .isFree
                                                ? "Free"
                                                : "\u{20B9}${communityProducts.communityProductsList[index].amount}/-",
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
                                            onTap: () {
                                              Get.to(() => AddNewProductScreen(
                                                    isEdit: true,
                                                    product: communityProducts
                                                            .communityProductsList[
                                                        index]
                                                  ));
                                            },
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
                                                              .communityProductsList[
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
                                                    .communityProductsList[
                                                        index]
                                                    .productSharelink!);
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
                                      .communityProductsList[index].name,
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
                                          .communityProductsList[index]
                                          .description
                                      : communityProducts
                                                  .communityProductsList[index]
                                                  .description
                                                  .length >
                                              200
                                          ? "${communityProducts.communityProductsList[index].description.substring(0, 200)} ..."
                                          : communityProducts
                                              .communityProductsList[index]
                                              .description,
                                  textStyle: TextStyle(
                                      fontSize:
                                          (MediaQuery.of(context).size.width /
                                                  375) *
                                              12,
                                      color: AppColors.white),
                                ),
                                if (communityProducts
                                        .communityProductsList[index]
                                        .description
                                        .length >
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
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: AppButton.primaryButton(
                                        height: 40,
                                        onButtonPressed: () {
                                          if (isAdmin ||
                                              communityProducts
                                                  .communityProductsList[index]
                                                  .isProductPurchased) {
                                            if (communityProducts
                                                    .communityProductsList[
                                                        index]
                                                    .urls
                                                    .isEmpty ||
                                                communityProducts
                                                    .communityProductsList[
                                                        index]
                                                    .urls[0]
                                                    .isEmpty) {
                                              HelperSnackBar.snackBar("Info",
                                                  "No Resource available for this product");
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 12),
                                                    backgroundColor:
                                                        AppColors.blackCard,
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          const SizedBox(
                                                              height: 12),
                                                          Image.asset(
                                                            PngAssetPath
                                                                .resourceUrlImg,
                                                            height: 80,
                                                          ),
                                                          const SizedBox(
                                                              height: 6),
                                                          const TextWidget(
                                                            text:
                                                                'Resource URLs',
                                                            textSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          for (var i = 0;
                                                              i <
                                                                  communityProducts
                                                                      .communityProductsList[
                                                                          index]
                                                                      .urls
                                                                      .length;
                                                              i++)
                                                            Card(
                                                              color: AppColors
                                                                  .white12,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          TextWidget(
                                                                        text: communityProducts
                                                                            .communityProductsList[index]
                                                                            .urls[i],
                                                                        textSize:
                                                                            14,
                                                                        color: AppColors
                                                                            .white,
                                                                        maxLine:
                                                                            4,
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Helper.launchUrl(communityProducts
                                                                            .communityProductsList[index]
                                                                            .urls[i]);
                                                                      },
                                                                      child:
                                                                          Card(
                                                                        color: GetStoreData.getStore.read('isInvestor')
                                                                            ? AppColors.primaryInvestor
                                                                            : AppColors.primary,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8),
                                                                          child: TextWidget(
                                                                              text: "Open",
                                                                              textSize: 10,
                                                                              color: GetStoreData.getStore.read('isInvestor') ? AppColors.black : AppColors.white),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12),
                                                            child: AppButton
                                                                .outlineButton(
                                                              height: 38,
                                                              title: 'Close',
                                                              onButtonPressed:
                                                                  () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          } else if (communityProducts
                                                  .communityProductsList[index]
                                                  .isFree &&
                                              !communityProducts
                                                  .communityProductsList[index]
                                                  .isProductPurchased) {
                                            Helper.loader(context);
                                            communityProducts.buyProduct(
                                                true,
                                                communityProducts
                                                    .communityProductsList[
                                                        index]
                                                    .id);

                                            // showDialog(
                                            //   context: context,
                                            //   builder: (BuildContext context) {
                                            //     return AlertDialog(
                                            //       backgroundColor:
                                            //           AppColors.blackCard,
                                            //       content: Column(
                                            //         crossAxisAlignment:
                                            //             CrossAxisAlignment.center,
                                            //         mainAxisSize:
                                            //             MainAxisSize.min,
                                            //         children: [
                                            //           Image.asset(
                                            //             PngAssetPath
                                            //                 .resourceUrlImg,
                                            //             height: 200,
                                            //           ),
                                            //           const SizedBox(height: 20),
                                            //           const TextWidget(
                                            //             text: 'Resource URLs',
                                            //             textSize: 20,
                                            //             fontWeight:
                                            //                 FontWeight.w500,
                                            //           ),
                                            //           for (var i = 0;
                                            //               i <
                                            //                   communityProducts
                                            //                       .communityProductsList[
                                            //                           index]
                                            //                       .urls
                                            //                       .length;
                                            //               i++)
                                            //             Card(
                                            //               color:
                                            //                   AppColors.white12,
                                            //               child: Padding(
                                            //                 padding:
                                            //                     const EdgeInsets
                                            //                         .all(8.0),
                                            //                 child: Row(
                                            //                   mainAxisAlignment:
                                            //                       MainAxisAlignment
                                            //                           .spaceBetween,
                                            //                   children: [
                                            //                     Expanded(
                                            //                       child:
                                            //                           TextWidget(
                                            //                         text: communityProducts
                                            //                             .communityProductsList[
                                            //                                 index]
                                            //                             .urls[i],
                                            //                         textSize: 16,
                                            //                         color:
                                            //                             AppColors
                                            //                                 .white,
                                            //                         maxLine: 4,
                                            //                       ),
                                            //                     ),
                                            //                     InkWell(
                                            //                       onTap: () {
                                            //                         Helper.launchUrl(communityProducts
                                            //                             .communityProductsList[
                                            //                                 index]
                                            //                             .urls[i]);
                                            //                       },
                                            //                       child:
                                            //                           const Card(
                                            //                         color: AppColors
                                            //                             .primary,
                                            //                         child:
                                            //                             Padding(
                                            //                           padding:
                                            //                               EdgeInsets
                                            //                                   .all(8),
                                            //                           child: TextWidget(
                                            //                               text:
                                            //                                   "Open",
                                            //                               textSize:
                                            //                                   10),
                                            //                         ),
                                            //                       ),
                                            //                     )
                                            //                   ],
                                            //                 ),
                                            //               ),
                                            //             ),
                                            //         ],
                                            //       ),
                                            //       actions: [
                                            //         Padding(
                                            //           padding: const EdgeInsets
                                            //               .symmetric(
                                            //               horizontal: 50),
                                            //           child:
                                            //               AppButton.primaryButton(
                                            //             bgColor:
                                            //                 AppColors.primary,
                                            //             title: 'Close',
                                            //             onButtonPressed: () {
                                            //               Navigator.of(context)
                                            //                   .pop();
                                            //             },
                                            //           ),
                                            //         ),
                                            //       ],
                                            //     );
                                            //   },
                                            // );
                                          } else {
                                            Get.to(() =>
                                                PurchaseScreen(index: index));
                                          }
                                        },
                                        title: isAdmin
                                            ? "Access Resource"
                                            : communityProducts
                                                        .communityProductsList[
                                                            index]
                                                        .isFree &&
                                                    !communityProducts
                                                        .communityProductsList[
                                                            index]
                                                        .isProductPurchased
                                                ? "Buy for free"
                                                : !communityProducts
                                                            .communityProductsList[
                                                                index]
                                                            .isFree &&
                                                        !communityProducts
                                                            .communityProductsList[
                                                                index]
                                                            .isProductPurchased
                                                    ? "Buy \u{20B9} ${communityProducts.communityProductsList[index].amount}"
                                                    : "Access Resource")),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ));
  }
}
