import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAboutScreen/communities_about_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityLandingScreen/community_landing_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPublicScreen/community_public_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/dilogue/community_details.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ExploreCommunityScreen extends StatefulWidget {
  const ExploreCommunityScreen({super.key});

  @override
  State<ExploreCommunityScreen> createState() => _ExploreCommunityScreenState();
}

class _ExploreCommunityScreenState extends State<ExploreCommunityScreen> {
  TextEditingController searchController = TextEditingController();
  CommunityController allCommunities = Get.put(CommunityController());
   @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      allCommunities.getAllCommunities().then((v) {
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
        drawer: DrawerWidget(),
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
            title: "Explore Community",
            hideBack: true,
            autoAction: true,
          ),
          body: Obx(() => allCommunities.isLoading.value
                ? Helper.pageLoading()
                : allCommunities.allCommunitiesDetails.isEmpty
                      ? Center(child: TextWidget(text: "No Community Available", textSize: 16))
                      :
          
          
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
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
                                                            child: GridView.builder(
                                                                      itemCount: allCommunities.allCommunitiesDetails.length,  // Number of items in the grid
                                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                        
                                                                        crossAxisCount: 2, // Number of columns
                                                                        crossAxisSpacing: 7, // Space between columns
                                                                        mainAxisSpacing: 7, // Space between rows
                                                                        childAspectRatio: 0.8, // Adjust the aspect ratio to fit the cards
                                                                      ),
                                                                      itemBuilder: (context, index) {
                                                                        return InkWell(
                                                                          onTap: (){
                                                                            if(!allCommunities.allCommunitiesDetails[index].isCommunityMember&&allCommunities.allCommunitiesDetails[index].isOpen)
                                                                             {createdCommunityId = allCommunities.allCommunitiesDetails[index].id;
                                                                             communityLogo = allCommunities.allCommunitiesDetails[index].image;
                                                                                                              communityName = allCommunities.allCommunitiesDetails[index].community;
                   Get.to(() => const CommunityPublicScreen());}
                   else if(
                    !allCommunities.allCommunitiesDetails[index].isCommunityMember&&!allCommunities.allCommunitiesDetails[index].isOpen
                   ){
showCommunityDetailsPopup(context);
                   }else{
createdCommunityId = allCommunities.allCommunitiesDetails[index].id;
                                                                             communityLogo = allCommunities.allCommunitiesDetails[index].image;
                                                                                                              communityName = allCommunities.allCommunitiesDetails[index].community;
                   Get.to(() => const CommunityLandingScreen());
                   }
                                                                          },
                                                                          child: Card(
                                                                            margin: EdgeInsets.zero,
                                                                            color: AppColors.blackCard,
                                                                            
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.only(top: 4,right: 7),
                                                                              child: Column(
                                                                                children: [
                                                                                  SizedBox(height: 5,),
                                                                                  CircleAvatar(
                                                                                                                foregroundImage: NetworkImage(allCommunities.allCommunitiesDetails[index].image.toString()),
                                                                                                              
                                                                                                              ),
                                                                                                               SizedBox(height: 2,),
                                                                                                              TextWidget(text: allCommunities.allCommunitiesDetails[index].community, textSize: 13,fontWeight: FontWeight.w500,),
                                                                                                              SizedBox(height: 3),
                                                                                                              TextWidget(text: allCommunities.allCommunitiesDetails[index].size, textSize: 12,color:  GetStoreData.getStore.read('isInvestor')? AppColors.primaryInvestor:AppColors.primary,),
                                                                                                              SizedBox(height: 3,),
                                                                                                              Row(
                                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                            children: [TextWidget(text: "${allCommunities.allCommunitiesDetails[index].members.length.toString()} Members", textSize: 9), SizedBox(width: 8,),Align(
                                                                                                              alignment: Alignment.centerLeft,
                                                                                                              child: Container(height: 3,width: 3,
                                                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: AppColors.white)),
                                                                                                            ),SizedBox(width: 8,),TextWidget(text: allCommunities.allCommunitiesDetails[index].createdAtTimeAgo, textSize: 9),],
                                                                                                            
                                                                                                          ),
                                                                                                          SizedBox(height: 4,),
                                                                                                           Card(
                                                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),color: AppColors.grey700,
                                                                                                                child: Padding(
                                                                                                                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 6),
                                                                                                                child: TextWidget(text: allCommunities.allCommunitiesDetails[index].isAbleToJoinTag, textSize: 11),
                                                                                                              ),),
                                                                                                              
                                                                                                              
                                                                                                             TextWidget(text: allCommunities.allCommunitiesDetails[index].amount, textSize: 11),
                                                                                                           if(!allCommunities.allCommunitiesDetails[index].isCommunityMember&&allCommunities.allCommunitiesDetails[index].isOpen)
                                                                                                           InkWell(
                                                                                                            onTap: ()async{
                                                                                                              await allCommunities.joinCommunity();
                                                                                                              createdCommunityId = allCommunities.allCommunitiesDetails[index].id;
                                                                                                              communityLogo = allCommunities.allCommunitiesDetails[index].image;
                                                                                                              communityName = allCommunities.allCommunitiesDetails[index].community;
                   Get.to(() =>  const CommunityLandingScreen());
                                                                                                            },
                                                                                                             child: Card(
                                                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                                                      color: GetStoreData.getStore.read('isInvestor')? AppColors.primaryInvestor:AppColors.primary,
                                                                                                                      child: Padding(
                                                                                                                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 6),
                                                                                                                      child: TextWidget(text: "Join Now", textSize: 11,color: GetStoreData.getStore.read('isInvestor')? AppColors.black:AppColors.white,),
                                                                                                                    ),),
                                                                                                           ),

                                                                                ],
                                                                              ),
                                                                            )
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                          ),
                                                          
              ],
            ),
          )
      ),
      )
    );
  }
}