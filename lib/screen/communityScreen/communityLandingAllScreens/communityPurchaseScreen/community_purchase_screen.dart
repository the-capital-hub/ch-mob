import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityProductsAndMembersController/community_products_and_members_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/homeScreen/home_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
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
                // IconButton(
                //   onPressed: () {
                //     Get.back();
                //   },
                //   icon: Icon(
                //     Icons.arrow_back_ios_new_sharp,
                //     size: 20,
                //     color: AppColors.white,
                //   ),
                // ),
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
            title:
                // aboutCommunity.aboutCommunityList.isEmpty
                //       ? CircularProgressIndicator():
                TextWidget(
                    text: communityName,
                    // aboutCommunity.aboutCommunityList[0].community.name,
                    textSize: 16),
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
          // action: [
          //   Row(
          //     children: [
          //       Flexible(
          //         child: ExpansionTile(
          //                   title: Row(
          //         children: [
          //           CircleAvatar(
          //             radius: 20,
          //             backgroundColor: Colors.blue,
          //             child: Icon(
          //               Icons.account_circle,
          //               color: Colors.white,
          //               size: 30,
          //             ),
          //           ),
          //           SizedBox(width: 10),
          //           Text(
          //             'Click to Expand',
          //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //           ),
          //         ],
          //                   ),
          //                   children: [
          //         ListTile(
          //           title: Text('Item 1'),
          //         ),
          //         ListTile(
          //           title: Text('Item 2'),
          //         ),
          //         ListTile(
          //           title: Text('Item 3'),
          //         ),
          //                   ],
          //                 ),
          //       ),
          //     ],
          //   ),
          //   CircleAvatar(
          //         radius: 20,
          //         backgroundColor: Colors.blue,
          //         child: Icon(
          //           Icons.account_circle,

          //           size: 30,
          //         ),
          //       ),
          // ]

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
              child: Column(children: [
                Image.asset(
                  PngAssetPath.puechaseProductImg,
                  height: 250,
                ),
                TextWidget(
                  text: "Purchase Product",
                  textSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 8),
                // TextWidget(text: "Please fill these details for purchase confirmation and further communication.", textSize: 13,maxLine: 2,align: TextAlign.center,),
                // SizedBox(height: 12),
                // TextWidget(text: "Details", textSize: 20,fontWeight: FontWeight.w500,),
                // SizedBox(height: 8),
                // MyCustomTextField.textField(hintText: "Enter Name", controller: urlController, lableText: "Name"),
                // SizedBox(height: 12),
                // MyCustomTextField.textField(hintText: "Enter Email", controller: urlController, lableText: "Email"),
                // SizedBox(height: 12),
                // MyCustomTextField.textField(hintText: "Enter Mobile Number", controller: urlController, lableText: "Mobile Number"),
                // SizedBox(height: 12),
                Card(
                  margin: EdgeInsets.zero,
                  color: AppColors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: "Details",
                          textSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        Divider(
                          color: AppColors.white38,
                        ),
                        SizedBox(height: 8),
                        TextWidget(
                          text: "Name:",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 8),
                        TextWidget(
                            text: communityProducts
                                .communityProductsList[widget.index].name,
                            textSize: 13),
                        SizedBox(height: 8),
                        Divider(
                          color: AppColors.white38,
                        ),
                        SizedBox(height: 8),
                        TextWidget(
                          text: "Description:",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 8),
                        HtmlWidget(
                          communityProducts
                              .communityProductsList[widget.index].description,
                          textStyle:
                              TextStyle(fontSize: 13, color: AppColors.white),
                        ),
                        SizedBox(height: 8),
                        Divider(
                          color: AppColors.white38,
                        ),
                        SizedBox(height: 8),
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
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: 8),
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
                                  color: AppColors.primary,
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
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: 8),
                                TextWidget(
                                    text: communityProducts
                                            .communityProductsList[widget.index]
                                            .isFree
                                        ? "Free"
                                        : "\u{20B9}${communityProducts.communityProductsList[widget.index].amount}/-",
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
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: AppButton.outlineButton(
                    borderColor: AppColors.primary,
                    onButtonPressed: () {
                      // titleController.clear();
                      // descriptionController.clear();

                      // durationMinutesController.clear();

                      // priceController.clear();
                      // priceDiscountController.clear();
                      // setState(() {
                      //   privacyStatus = "Public";
                      // });
                    },
                    title: "Cancel"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      if (!communityProducts.communityProductsList[widget.index]
                          .isProductPurchased)
                        communityProducts.buyProduct(
                            context,
                            communityProducts
                                .communityProductsList[widget.index].id);
                    },
                    // async {
                    //   await MeetingController().createEvent(
                    //     context: context,
                    //     title: titleController.text,
                    //     description: descriptionController.text,
                    //     duration: durationMinutesController.text,
                    //     eventType: privacyStatus,
                    //     price: priceController.text,
                    //     discount: priceDiscountController.text,
                    //   );
                    //   Get.to(() => const EventsScreen(), preventDuplicates: false);
                    // },
                    title: "Proceed to Payment"),
              ),
            ]),
          ),
        ));
  }
}
