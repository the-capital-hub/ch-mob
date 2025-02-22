import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityProductsAndMembersController/community_products_and_members_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPurchaseScreen/community_purchase_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommunityAboutScreen extends StatefulWidget {
  const CommunityAboutScreen({super.key});

  @override
  State<CommunityAboutScreen> createState() => _CommunityAboutScreenState();
}

class _CommunityAboutScreenState extends State<CommunityAboutScreen> {
  List<String> postsFilter = ['All Posts', 'Admin Posts', 'Member Posts'];
  GlobalKey<PopupMenuButtonState<String>> _popupMenuKey = GlobalKey();
  CommunityProductsAndMembersController communityProducts = Get.put(CommunityProductsAndMembersController());
  CommunityEventsController communityEvents = Get.put(CommunityEventsController());
  
   @override
void initState() {
  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    Future.wait([
      communityProducts.getCommunityProductsandMembers(),
      communityEvents.getCommunityEvents(),
    ]).then((values) {
      // Perform any additional logic after both calls are completed
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Your post-frame callback logic goes here
      });
    });
  });
  super.initState();
}
final List<Color> containerColors = [
    AppColors.lightBlue,
    AppColors.navyBlue,
    AppColors.oliveGreen
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: SafeArea(
        child: Scaffold(
          
            backgroundColor: AppColors.transparent,
            
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [Container(
                          width: double.infinity, // Adjust the width as needed
                          height: 310, // Adjust the height as needed
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.black, // First color
                                AppColors.brown,
                                 // Third color
                                
                                AppColors.purple, // Second color
                                
                                
                              ],
                              begin: Alignment.topCenter, // Start of the gradient
                              end: Alignment.bottomCenter, // End of the gradient
                              stops: [0.0, 0.5, 1.0], // Optional: controls how the colors are distributed
                            ),
                          ),
                          
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              CircleAvatar(
                              radius: 60,
                                                //   foregroundImage: NetworkImage(
                                                //     // createdCommunity.createdCommunityDetails[0].image,
                                                //  "" ),
                                                ),
                                                SizedBox(height: 16,),
                                                TextWidget(text: "Welcome to the", textSize: 20,fontWeight: FontWeight.w500,),
                                                SizedBox(height: 16,),
                                       Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 30),
                                         child: Container(
                                                                       height: 150,
                                                                       decoration: BoxDecoration(
                                                                           image: const DecorationImage(
                                                                               image: NetworkImage(
                                          "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                                                                               ),
                                                                               fit: BoxFit.fill),
                                                                           borderRadius: BorderRadius.circular(10)),
                                                                     ),
                                       ),
                            ],
                          ),
                        ),
                        ]
                      ),
                    ],
                  ),
                   Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                                       
                                       
                            
                            TextWidget(text: "About Community", textSize: 20,color: AppColors.primary,fontWeight: FontWeight.w500,),
                            SizedBox(height: 12,),
                            TextWidget(text: "The Creative Collective is a vibrant online community dedicated to artists, writers, musicians, and other creative individuals who seek to collaborate, share knowledge, and inspire each other. It’s a space where creativity thrives, and members are encouraged to support one another in their artistic endeavors. Whether you're a seasoned professional or just beginning your creative journey, The Creative Collective offers a platform for individuals to share their work, exchange feedback, and discover new ways to grow.", textSize: 14,maxLine: 13,),
                            SizedBox(height: 12,),
                            Column(
                              children: [
                                
                                TextWidget(text: "Community Admin", textSize: 20,color: AppColors.primary,fontWeight: FontWeight.w500,),
                                SizedBox(height: 12,),
                            CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                          '${GetStoreData.getStore.read('profile_image')}'),
                                    ),
                          SizedBox(height: 12,),
                          TextWidget(text: "${GetStoreData.getStore.read('name')}", textSize: 16, fontWeight: FontWeight.w500,),
                          SizedBox(height: 12,),
                          TextWidget(text: "Role", textSize: 16),
                          SizedBox(height: 12,),
                          TextWidget(text: "The Creative Collective is a vibrant online community dedicated to artists, writers, musicians, and other creative individuals who seek to collaborate, share knowledge, and inspire each other. It’s a space where creativity thrives, and members are encouraged to support one another in their artistic endeavors. Whether you're a seasoned professional or just beginning your creative journey, The Creative Collective offers a platform for individuals to share their work, exchange feedback, and discover new ways to grow.", textSize: 14, maxLine: 9,align: TextAlign.center,),

                              ],
                            ),
                            SizedBox(height: 12,),
                          TextWidget(text: "Terms and Conditions", textSize: 20,color: AppColors.primary,fontWeight: FontWeight.w500,),
                          SizedBox(height: 12,),
                          TextWidget(text: "No dealing restricted", textSize: 13),
                          SizedBox(height: 12,),
                          TextWidget(text: "Recent Posts From Admin", textSize: 20,color: AppColors.primary,fontWeight: FontWeight.w500,),
                          SizedBox(height: 12,),
                          Card(
                            margin: EdgeInsets.zero,
                                    color: AppColors.blackCard,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  foregroundImage: NetworkImage(
                                        "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                                      ),
                                ),
                                SizedBox(width: 8,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(text: "Capital Hub", textSize: 16),
                                    TextWidget(text: "1 Day ago", textSize: 14)
                                  ],
                                ),
                                SizedBox(width: 8,),
                                Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                    child: TextWidget(text:"Member", textSize: 11),
                                  ),color: AppColors.primary),
                                  SizedBox(width: 50),
                                  InkWell(
                                    onTap: () {
                                      _popupMenuKey.currentState
                                          ?.showButtonMenu();
                                    },
                                    child: Row(
                                      children: [
                                        PopupMenuButton<String>(
                                            key: _popupMenuKey,
                                            icon: Icon(
                                              Icons.more_vert,
                                              size: 25,
                                            ),
                                            iconColor: AppColors.white,
                                            color: AppColors.blackCard,
                                            offset: Offset(100, 55),
                                            onSelected: (value) {},
                                            itemBuilder: (context) => [
                                                  const PopupMenuItem(
                                                    child: TextWidget(
                                                        text: "All Posts",
                                                        textSize: 14),
                                                  ),
                                                  PopupMenuItem(
                                                    child: TextWidget(
                                                        text: "Admin Posts",
                                                        textSize: 14),
                                                  ),
                                                  const PopupMenuItem(
                                                    child: TextWidget(
                                                        text: "Member Posts",
                                                        textSize: 14),
                                                  ),
                                                ]),
                                        // TextWidget(
                                        //   text: "Filter Post",
                                        //   textSize: 16,
                                        // ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                            Divider(
                              color: AppColors.white38,
                            ),
                            TextWidget(text: "Clean energy expansion requires strategic investments and careful stewardship.....", textSize: 14,maxLine: 2,),
                            SizedBox(height: 12,),
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: NetworkImage(
                                        "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                                      ),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                                   
                                   
                          
                          ],
                                      ),
                                    ),
                          ),
                          SizedBox(height: 12,),
                          TextWidget(text: "Community Products", textSize: 20,color: AppColors.primary,fontWeight: FontWeight.w500,),
                          SizedBox(height: 12,),
                          Obx(()=>
                        communityProducts.isLoading.value
                                     ? SizedBox.shrink()
                                     // Helper.pageLoading()
                                     : 
                                     communityProducts.communityProductsList.isEmpty
                        ? SizedBox(height:100,child:TextWidget(text: "No Products Available", textSize: 16))
                        :
                        
                        SizedBox(
                          
                          
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 12,
                          );},
                            
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: communityProducts.communityProductsList.length,
                            itemBuilder: (context, index) {
                                   return Card(
                                    margin: EdgeInsets.zero,
                                     shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                                     color: AppColors.navyBlue,
                                     child: Padding(
                                       padding: const EdgeInsets.all(0.0),
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
                                     top: -4,
                                     left: -3,
                                     child: Card(
                                     
                                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(12),topLeft: Radius.circular(12)),
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
                        
                          Padding(
                            padding: const EdgeInsets.only(left: 12,right: 16),
                            child: TextWidget(
                                text:
                                    communityProducts.communityProductsList[index].name,
                                textSize: 18,
                                maxLine: 2,
                                fontWeight: FontWeight.w500,
                              ),
                          ),
                            SizedBox(height: 8,),
                            Padding(
                              padding: const EdgeInsets.only(left: 12,right: 16),
                              child: TextWidget(
                                text:
                                    communityProducts.communityProductsList[index].description,
                                textSize: 14,
                                maxLine: 3,
                                
                              ),
                            ),
                            
                        
                      
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
                           padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 12),
                           child: AppButton.primaryButton(
                               onButtonPressed: () {
                                if(
                                  communityProducts.communityProductsList[index].isFree
                                ){
                          
                                
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
                      ),
                      SizedBox(height: 12,),
                      TextWidget(text: "Upcoming Events", textSize: 20,color: AppColors.primary,fontWeight: FontWeight.w500,),
                      SizedBox(height: 12,),
                      Obx(() => 
                      communityEvents.isLoading.value
                          ? SizedBox.shrink()
                          // Helper.pageLoading()
                          : 
                          communityEvents.communityEventsList.isEmpty
                                     ? 
                                     SizedBox(height:100,child: TextWidget(text: "No Community Events Available", textSize: 16))
                                     :
                           SizedBox(
                            // height: 500,
                            // width: 400,
                             child: ListView.separated(
                              separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 12,
                          );},
                                     // padding: const EdgeInsets.all(12.0),
                                     itemCount: communityEvents.communityEventsList[0].webinars.length,
                                     shrinkWrap: true,
                                     itemBuilder: (context, index) {
                                       
                                       Color containerColor =
                        containerColors[index % containerColors.length];
                             
                                       return Card(
                                        margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      color: containerColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(text: communityEvents.communityEventsList[0].webinars[index].title, textSize: 25),
                            communityEvents.communityEventsList[0].webinars[index].isActive?const SizedBox():
                            TextWidget(text: "This meeting is cancelled.", textSize: 16,color: AppColors.grey,),
                            const SizedBox(height: 8),
                            Card(
                              color: AppColors.white38,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: AppColors.primary),
                                      child: Center(
                                        child: Image.asset(
                                          PngAssetPath.meetingIcon,
                                          color: AppColors.white,
                                          height: 22,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                            text: "${communityEvents.communityEventsList[0].webinars[index].duration}",
                                            textSize: 15),
                                        const TextWidget(
                                            text: "Video Meeting",
                                            textSize: 15),
                                      ],
                                    ),
                                    Spacer(),
                                   Container(
                                     padding: const EdgeInsets.symmetric(
                                         horizontal: 5, vertical: 5),
                                     decoration: BoxDecoration(
                                       borderRadius:
                                           BorderRadius.circular(20),
                                       border: Border.all(
                                           color: AppColors.white, width: 1),
                                     ),
                                     child: Row(
                                       mainAxisAlignment:
                                           MainAxisAlignment.center,
                                       children: [
                                         TextWidget(
                                             text: "Rs ${communityEvents.communityEventsList[0].webinars[index].price} +",
                                             textSize: 12),
                                         const SizedBox(width: 5),
                                         Icon(Icons.arrow_forward,
                                             color: AppColors.white,
                                             size: 12),
                                             // const SizedBox(width: 5),
                                   
                                       ],
                                     ),
                                   ),
                                  ],
                                ),
                              ),
                            ),
                            sizedTextfield, // You might want to customize this part
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: communityEvents.communityEventsList[0].webinars[index].isActive 
                         ?  () async {
                             
                                   // Copy the text to the clipboard
                                   await Clipboard.setData(ClipboardData(text: communityEvents.communityEventsList[0].webinars[index].webinarLink));
                     
                                   // Optionally, show a snackbar or a confirmation that the text was copied
                                   HelperSnackBar.snackBar("Success", "Link copied to clipboard!" );
                                   // ScaffoldMessenger.of(context).showSnackBar(
                                   //   SnackBar(content: Text("Link copied to clipboard!")),
                                   // );
                         }:null,
                                    icon: Icon(Icons.file_copy_outlined,
                                        color: AppColors.white, size: 14),
                                    label: const TextWidget(
                                        text: "Copy Link", textSize: 14),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.blue,
                                      disabledBackgroundColor: AppColors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: AppButton.primaryButton(
                                    height: 40,
                                      onButtonPressed: communityEvents.communityEventsList[0].webinars[index].isActive
                         ? () {
                                        
                                        showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return AlertDialog(
                         backgroundColor: AppColors.blackCard,
                         title:  TextWidget(text: 'Are you sure you want to cancel this event?', textSize: 16,maxLine: 2,),
                         content: TextWidget(text: 'No. of People who have booked this event : ${communityEvents.communityEventsList[0].webinars[index].joinedUsers.length}', textSize: 16,maxLine: 2,),
                         actions: [
                           // "Cancel Event" button
                           AppButton.primaryButton(
                             title: 'Cancel Event',
                             onButtonPressed: () {
                               
                               // Call the delete event function
                               communityEvents.disableWebinar(communityEvents.communityEventsList[0].webinars[index].id);
                               // Close the dialog after confirming
                              communityEvents.getCommunityEvents();
                              //  Get.to(() => const EventsScreen(), preventDuplicates: false);
                             },
                             
                           ),
                           sizedTextfield,
                           // "Back" button to close the dialog
                           AppButton.outlineButton(
                             borderColor: AppColors.primary,
                             title: 'Back',
                             onButtonPressed: () {
                               // Close the dialog without performing any action
                               Navigator.of(context).pop();
                             },
                             
                           ),
                         ],
                       );
                     },
                                      );
                                    }: null,
                                            
                                      
                                      title: "Cancel Event",fontSize: 14,
                                      bgColor:communityEvents.communityEventsList[0].webinars[index].isActive? AppColors.redColor:AppColors.grey
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                                       );
                                     },
                                   ),
                           )),
                                   
                        
                          
                        
                        
                        
                        
                        
                                     ],
                                   ),
                   ),
                ]
              )
            ),
        ),
      )
    );
  }
}