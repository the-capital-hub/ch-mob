import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityProductsAndMembersController/community_products_and_members_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityDrawerScreen/community_drawer_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
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
  CommunityProductsAndMembersController communityMembers = Get.put(CommunityProductsAndMembersController());
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
      communityMembers.getCommunityProductsandMembers().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
        
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
        child: Scaffold(
          drawer: const CommunityDrawerWidget(),
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "People",
            hideBack: true,
            autoAction: true,
          ),
          body: 
          Obx(()=>
        communityMembers.isLoading.value
                ? Helper.pageLoading()
                : 
                communityMembers.communityMembersList.isEmpty
                      ? Center(child: TextWidget(text: "No Members Present", textSize: 16))
                      :
          Padding(
            padding: const EdgeInsets.all(12), // Padding around the card
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                MyCustomTextField.textField(
                                    
                                    prefixIcon: Icon(Icons.search,color: AppColors.white54,),
                                    fillColor: AppColors.white,
                                    borderClr: AppColors.white54,
                                    borderRadius: 8,
                                                        
                                                        hintText: "Search",
                                                        controller: searchController),
                                                        SizedBox(height: 12,),
                                                        Expanded(
                                                          child: ListView.separated(itemBuilder: (context, index) {
                                                            return Card(
                                                              margin: EdgeInsets.zero,
                                                              color: AppColors.blackCard,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                         CircleAvatar(
                radius: 25,
                foregroundImage: NetworkImage(
                  communityMembers.communityMembersList[index].profilePicture,
                ),
              ),
                                                                                          SizedBox(width: 12,),
                                                                        Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          
                                                                          children: [
                                                                            TextWidget(text: "${communityMembers.communityMembersList[index].firstName} ${communityMembers.communityMembersList[index].lastName}", textSize: 20),
                                                                            TextWidget(text: communityMembers.communityMembersList[index].designation.toString(), textSize: 13,color: AppColors.primary,),
                                                                            TextWidget(text: communityMembers.communityMembersList[index].company.toString(), textSize: 16),
                                                                            TextWidget(text: communityMembers.communityMembersList[index].location.toString(), textSize: 16),
                                                                            TextWidget(text: communityMembers.communityMembersList[index].joinedDate, textSize: 16),
                                                                            
                                                                          ],
                                                                          
                                                                          
                                                                          
                                                                        ),
                                                                        
                                                                          
                                                                      ],
                                                                      
                                                                    ),
                                                                    // SizedBox(height: 8),
                                                                    // Row(
                                                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                                                    //   children: [
                                                                    //     InkWell(
                                                                    //           onTap: () {
                                                                    //             // Helper.launchUrl(
                                                                    //             //     "https://wa.me/?text=${whatsappMsgController.text}%20${Uri.encodeFull(urlController.text)}");
                                                                    //           },
                                                                    //           child:
                                                                    //               Image.asset(PngAssetPath.whatsappIcon, height: 50),
                                                                    //         ),
                                                                    //         SizedBox(width:8),
                                                                    //         InkWell(
                                                                    //           onTap: () {
                                                                    //             // Helper.launchUrl(
                                                                    //             //     "https://wa.me/?text=${whatsappMsgController.text}%20${Uri.encodeFull(urlController.text)}");
                                                                    //           },
                                                                    //           child:
                                                                    //               Image.asset(PngAssetPath.instagramColorIcon, height: 40),
                                                                    //         )
                                                                        
                                                                
                                                                    //   ],
                                                                    // )
                                                                    SizedBox(height: 16,),
                                                                  ],
                                                                ),
                                                              ),
                                                                    
                                                            );
                                                                    
                                                            
                                                          }, separatorBuilder: (context, index) =>SizedBox(height: 12,), itemCount: communityMembers.communityMembersList.length),
                                                        )
          
                                                        
                
              ],
            ),
          ),
          
        )
        )
        );
  }

}
