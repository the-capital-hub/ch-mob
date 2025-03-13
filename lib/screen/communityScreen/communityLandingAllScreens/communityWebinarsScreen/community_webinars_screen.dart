import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddNewProductScreen/community_add_new_product_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityWebinarsScreen/communityRegisterNowScreen/community_register_now_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityWebinarsScreen/communityRegisteredUsersScreen/community_registered_users_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/custom_dialogue.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityWebinarsScreen extends StatefulWidget {
  const CommunityWebinarsScreen({super.key});

  @override
  State<CommunityWebinarsScreen> createState() => _CommunityWebinarsScreenState();
}

class _CommunityWebinarsScreenState extends State<CommunityWebinarsScreen> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
            padding:  EdgeInsets.zero,
            itemCount: 5,
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
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                  "https://bettermeetings.expert/wp-content/uploads/engaging-interactive-webinar-best-practices-and-formats.jpg",
                                ),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      sizedTextfield,
                     
                       Row(
                         children: [
                           TextWidget(
                            text: "Title",
                            textSize: 20,
                            fontWeight: FontWeight.bold,
                                                 ),
                                                 Spacer(),
                                    if(isAdmin)...[
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                        
                                      Icons.edit,
                                      color: AppColors.whiteCard,
                                      size: 20,
                                      // size: 22,
                                    ),onPressed: (){
                                     Get.to(() => const AddNewProductScreen());
                                    },),
                                     
                        
                        IconButton(onPressed: (){
                          showCustomPopup(
      context: context,  // Pass the context
      title: "Delete this webinar",  // Dialog Title
      message: "Are you sure you\nwant to delete this webinar?",  // Dialog Message
      button1Text: "Cancel",  // First button text
      button2Text: "OK",  // Second button text
      icon: Icons.delete,  // Icon to display in the popup
      onButton1Pressed: () {
        // Action for the first button (e.g., Cancel)
        Get.back();  // Close the dialog
      },
      onButton2Pressed: () {
        // Action for the second button (e.g., OK)
        Get.back();  // Close the dialog
      },
    );
                        }, icon: Icon(Icons.delete,color: AppColors.white,)),
                                    IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                  
                                Icons.mobile_screen_share_rounded,
                                color: AppColors.whiteCard,
                                // size: 22,
                              ),onPressed: (){
                                sharePostPopup(context,"","share webinar detail");
                              },),],
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                  
                                Icons.mobile_screen_share_rounded,
                                color: AppColors.whiteCard,
                                // size: 22,
                              ),onPressed: (){
                                sharePostPopup(context,"","share webinar detail");
                              },),
                                  
                         ],
                       ),
          
                      sizedTextfield,
                      TextWidget(
                        text: "Description",
                        textSize: 16,
                        // fontWeight: FontWeight.bold,
                      ),
                      sizedTextfield,
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: AppColors.white,
                            size: 22,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                           TextWidget(
                              text: "7 March 2024", textSize: 16)
                        ],
                      ),
          
                      sizedTextfield,
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
          
                       Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: AppColors.white,
                            size: 22,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          TextWidget(text: "30 mins", textSize: 16)
                        ],
                      ),
          
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: AppColors.white,
                            size: 22,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          TextWidget(text: "0 joined", textSize: 16)
                        ],
                      ),
          
                      const SizedBox(
                        height: 15,
                      ),
          Row(
                        children: [
                          Icon(
                            Icons.payment,
                            color: AppColors.white,
                            size: 22,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          TextWidget(text: "\u{20B9}450", textSize: 16)
                        ],
                      ),
                      sizedTextfield,
          AppButton.primaryButton(onButtonPressed: (){
            Get.to(() => const CommunityRegisteredUsersScreen());
          }, title: "View Guests"),
          AppButton.primaryButton(onButtonPressed: (){
            Get.to(() => const CommunityRegisterNowScreen());

          }, title: "+ Register Now")
          
                      
                    ],
                  ),
                ),
              );
            },
          );
     
      
    
  }
}