import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityProductsAndMembersController/community_products_and_members_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/communityModel/communityLandingAllModels/getCommunityProductsAndMembersModel/get_community_products_and_members_model.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/homeScreen/home_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class PurchaseScreen extends StatefulWidget {
  int index;
  PurchaseScreen({required this.index, super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  TextEditingController urlController = TextEditingController();
  CommunityProductsAndMembersController communityProducts =
      Get.put(CommunityProductsAndMembersController());
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
            drawer: const DrawerWidget(),
            backgroundColor: AppColors.transparent,
            appBar: AppBar(
              backgroundColor: AppColors.black,
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: AppColors.white,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  CircleAvatar(
                    radius: 16,
                    foregroundImage: NetworkImage(communityLogo),
                  ),
                ],
              ),
              title: TextWidget(text: communityName, textSize: 16),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.to(() => const HomeScreen());
                    },
                    icon: Icon(
                      Icons.swap_horizontal_circle_sharp,
                      color: AppColors.white,
                      size: 30,
                    ))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
                child: Column(children: [
                  Image.asset(
                    PngAssetPath.puechaseProductImg,
                    height: 100,
                  ),
                  const TextWidget(
                    text: "Purchase Product",
                    textSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 8),
                  Card(
                    margin: EdgeInsets.zero,
                    color: AppColors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(
                            text: "Details",
                            textSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          Divider(
                            color: AppColors.white38,
                          ),
                          const SizedBox(height: 8),
                         TextWidget(
                            text: "Name:",
                            textSize: 16,
                            fontWeight: FontWeight.w500,
                            color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                          ),
                          const SizedBox(height: 8),
                          TextWidget(
                              text: communityProducts
                                  .communityProductsList[widget.index].name,
                              textSize: 13),
                          const SizedBox(height: 8),
                          Divider(
                            color: AppColors.white38,
                          ),
                          const SizedBox(height: 8),
                           TextWidget(
                            text: "Description:",
                            textSize: 16,
                            fontWeight: FontWeight.w500,
                            color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                          ),
                          const SizedBox(height: 8),
                          HtmlWidget(
                            communityProducts
                                .communityProductsList[widget.index]
                                .description,
                            textStyle:
                                TextStyle(fontSize: 13, color: AppColors.white),
                          ),
                          const SizedBox(height: 8),
                          Divider(
                            color: AppColors.white38,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   TextWidget(
                                    text: "Resources",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                                  ),
                                  const SizedBox(height: 8),
                                  TextWidget(
                                      text:
                                          "${communityProducts.communityProductsList[widget.index].urls.length} Files",
                                      textSize: 13),
                                ],
                              ),
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: "Access",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                                  ),
                                  SizedBox(height: 8),
                                  TextWidget(text: "Lifetime", textSize: 13),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: "Price",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                                  ),
                                  const SizedBox(height: 8),
                                  TextWidget(
                                      text:
                                          "\u{20B9}${communityProducts.communityProductsList[widget.index].amount}/-",
                                      textSize: 13),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            bottomNavigationBar: !communityProducts
                    .communityProductsList[widget.index].isProductPurchased
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppButton.outlineButton(
                                borderColor: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                                onButtonPressed: () {
                                  Get.back();
                                },
                                title: "Cancel"),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppButton.primaryButton(
                                onButtonPressed: () {
                                  Helper.loader(context);
                                  communityProducts.buyProduct(
                                     false,
                                      communityProducts
                                          .communityProductsList[widget.index]
                                          .id);
                                },
                                title: "Proceed to Payment"),
                          ),
                        ]),
                  )
                : const SizedBox.shrink()));
  }
}
