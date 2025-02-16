import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class MyCommunityScreen extends StatefulWidget {
  const MyCommunityScreen({super.key});

  @override
  State<MyCommunityScreen> createState() => _MyCommunityScreenState();
}

class _MyCommunityScreenState extends State<MyCommunityScreen> {
  
  CommunityController myCommunities = Get.put(CommunityController());
   @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      myCommunities.getMyCommunities().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
         
        });
      });
    });
    super.initState();
  }
  List<String> communityNames = [
    "Capital Hub Community",
    "Hub Community",
    "Hustler's Community",
    "Pixel Community",
    "Monday Community",
    "Monday Community",
    "Monday Community",
    "Monday Community",
    "Monday Community",
    "Monday Community",
    "Monday Community"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          drawer: const DrawerWidget(),
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "My Community",
            hideBack: true,
            autoAction: true,
          ),
          body: Obx(() => myCommunities.isLoading.value
                ? Helper.pageLoading()
                // : createdCommunity.createdCommunityDetails.isEmpty
                //       ? Center(child: TextWidget(text: "No Community Available", textSize: 16))
                      :
          
          Padding(
            padding: const EdgeInsets.only(left: 12,right:12,bottom: 12), // Padding around the card
            child: ListView.separated(
              separatorBuilder: (context, index) =>SizedBox(height: 12,),
              shrinkWrap:
                  true, // Makes ListView take only as much space as it needs
              padding:
                  EdgeInsets.zero, // Remove extra padding from ListView
              itemCount: myCommunities.myCommunitiesDetails.length,
              itemBuilder: (context, index) {
                return Card(
                  color: AppColors.blackCard,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12,top: 12,bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  foregroundImage: NetworkImage(myCommunities.myCommunitiesDetails[index].image),
                                
                                ),
                                SizedBox(width: 10,),
                                TextWidget(text: myCommunities.myCommunitiesDetails[index].name, textSize: 20,fontWeight: FontWeight.w500,),
                                SizedBox(width: 4,),
                                Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                  child: TextWidget(text: myCommunities.myCommunitiesDetails[index].role, textSize: 11),
                                ),color: AppColors.green700)
                              ],
                            ),
                            SizedBox(height: 12,),
                            TextWidget(text: myCommunities.myCommunitiesDetails[index].size, textSize: 13,color: AppColors.primary,),
                            SizedBox(height: 12,),
                            Row(
                              children: [TextWidget(text: "${myCommunities.myCommunitiesDetails[index].members.length.toString()} Members", textSize: 14), SizedBox(width: 8,),Container(height: 5,width: 5,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: AppColors.white)),SizedBox(width: 8,),TextWidget(text: myCommunities.myCommunitiesDetails[index].createdAtTimeAgo, textSize: 14),],
                            )
                    
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(icon: Icon(
                            Icons.mobile_screen_share_rounded,
                            color: AppColors.whiteCard,
                            // size: 22,
                          ),onPressed: (){
                            sharePostPopup(context,"",myCommunities.myCommunitiesDetails[index].shareLink);
                          },),
                            IconButton(icon: Icon(Icons.logout),color: AppColors.primary,onPressed: (){
                              myCommunities.leaveCommunity(context,myCommunities.myCommunitiesDetails[index].id);
                            },),
                            
                          ],
                        )
                      ],
                      
                    ),
                  ));
              },
            ),
          )
          ),
          bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 12,
          ),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                // Get.to(() => const CreateNewWebinarScreen());
              },
              title: "Create new Community"),
        ),
        )
        );
  }
}
