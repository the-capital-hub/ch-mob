import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityProductsAndMembersController/community_products_and_members_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddNewProductScreen/community_add_new_product_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityDrawerScreen/community_drawer_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddServiceScreen/community_add_service_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPurchaseScreen/community_purchase_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class CommunityProductsScreen extends StatefulWidget {
  const CommunityProductsScreen({super.key});

  @override
  State<CommunityProductsScreen> createState() => _CommunityProductsScreenState();
}

class _CommunityProductsScreenState extends State<CommunityProductsScreen> {
  CommunityProductsAndMembersController communityProducts = Get.put(CommunityProductsAndMembersController());
  
   @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      communityProducts.getCommunityProductsandMembers().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
        
        });
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        
        body:Obx(()=>
        communityProducts.isLoading.value
                ? Helper.pageLoading()
                : 
                communityProducts.communityProductsList.isEmpty
                      ? Center(child: TextWidget(text: "No Products Available", textSize: 16))
                      :
        
        ListView.separated(
          separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 12,
                      );},
          
          padding: const EdgeInsets.all(12),
          shrinkWrap: true,
          itemCount: communityProducts.communityProductsList.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: AppColors.navyBlue,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        
                        Container(
                         
                        height: 200,
                        // width : 300,
                        // color: AppColors.brown,
                        decoration: BoxDecoration(
                            image:  DecorationImage(
                                image: NetworkImage(
                                  communityProducts.communityProductsList[index].image,
                                ),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(15)),
                      ),
            Positioned(
              top: 0,
              right: 0,
              child: Card(
              
                            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                            color: AppColors.primary,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                              child: TextWidget(text: communityProducts.communityProductsList[index].isFree?"Free":"\u{20B9}${communityProducts.communityProductsList[index].amount}/-", textSize: 16)
                            ),
                          ),
            ),
                      ]
                    ),
                    sizedTextfield,
              //       Row(
              //         children: [
                        
              //           Card(
              //             shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(12),
              // ),
              //             color: AppColors.primary,
              //             child: Padding(
              //               padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
              //               child: Icon(Icons.description,color: AppColors.white,),
              //             ),
              //           ),
                        
                        
              //         ],
              //       ),
                    
                      TextWidget(
                          text:
                              communityProducts.communityProductsList[index].name,
                          textSize: 18,
                          maxLine: 2,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 8,),
                         HtmlWidget(
                              communityProducts.communityProductsList[index].description,
                              textStyle: TextStyle(fontSize: 14, color: AppColors.white,),
                            ),
                        // TextWidget(
                        //   text:
                        //       communityProducts.communityProductsList[index].description,
                        //   textSize: 14,
                        //   maxLine: 3,
                          
                        // ),
                        SizedBox(height: 12,),
                    
                  
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.language,
                    //       color: AppColors.white,
                    //       size: 22,
                    //     ),
                    //     const SizedBox(
                    //       width: 5,
                    //     ),
                    //     const TextWidget(text: "Online", textSize: 16)
                    //   ],
                    // ),
                    
                    // sizedTextfield,
                    
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 50),
                       child: AppButton.primaryButton(
                           onButtonPressed: () {
                            if(
                              communityProducts.communityProductsList[index].isFree && !communityProducts.communityProductsList[index].isProductPurchased
                            ){
                             communityProducts.buyProduct(context,communityProducts.communityProductsList[index].id);

                            
                              showDialog(
                       context: context,
                       builder: (BuildContext context) {
                         return AlertDialog(
                           backgroundColor: AppColors.blackCard,
                           title:  Align(alignment:Alignment.center, child: TextWidget(text: 'Resource URLs', textSize: 25,fontWeight: FontWeight.bold,)),
                           content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                             children: [
                               for (var i = 0; i < communityProducts.communityProductsList[index].urls.length; i++)
                                 TextWidget(
                                   text: communityProducts.communityProductsList[index].urls[i],
                                   textSize: 16,
                                   color: AppColors.primary,
                                 ),
                             ],
                           ),
                           actions: [
                             AppButton.primaryButton(
                              bgColor: AppColors.primary,
                               title: 'Close',
                               onButtonPressed: () {
                                 Navigator.of(context).pop();
                                
                               },
                               
                             ),
                             
                           ],
                         );
                       },
                     );
                            }
                            else{
                              Get.to(() =>  PurchaseScreen(index: index));
                            }
                                   
                                   
                           }, title: communityProducts.communityProductsList[index].isFree?"Access Resource":"Buy \u{20B9}${communityProducts.communityProductsList[index].amount} "),
                     ),
                    
                 
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 12,
          ),
          child: Row(
            children: [
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      Get.to(() =>  const AddNewProductScreen());
                    },
                    title: "Add New Product"),
              ),
              SizedBox(width: 12,),
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      Get.to(() =>  const CommunityAddServiceScreen());
                    },
                    title: "Add New Service"),
              ),
            ],
          ),
        ),
      )
    );
  }
}