import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityDrawerScreen/community_drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommunityEventsScreen extends StatefulWidget {
  const CommunityEventsScreen({super.key});

  @override
  State<CommunityEventsScreen> createState() => _CommunityEventsScreenState();
}

class _CommunityEventsScreenState extends State<CommunityEventsScreen> with SingleTickerProviderStateMixin {
  CommunityEventsController communityEvents = Get.put(CommunityEventsController());
  late final TabController _tabController;
  int activeTabIndex = 1;

  // @override
  // void initState() {
  //   super.initState();
    
  //   _tabController = TabController(length: 2, vsync: this, initialIndex: 1,);
  //   _tabController.addListener(() {
  //     setState(() {
  //       activeTabIndex = _tabController.index;
  //     });
  //   });
     
   

   
  // }
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      communityEvents.getCommunityEvents().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
        
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
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        drawer: const CommunityDrawerWidget(),
        appBar: HelperAppBar.appbarHelper(
          title: "Events",
          hideBack: true,
          autoAction: true,
        ),
    //     body:Padding(
    //       padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
    //       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //           TabBar(
                
                
    //             controller: _tabController,
    //             isScrollable: true,
               
    //             tabAlignment: TabAlignment.start,
                
    //             dividerHeight: 0,
    //                           indicator: BoxDecoration(
    //                             color: AppColors
    //                               .transparent,// Background color for selected tab
                                  
                              
    //                          borderRadius:
    //                               BorderRadius.circular(5), // Rounded corners
    //                         ),// Adjust the horizontal padding to make the box wider
    //                         indicatorSize: TabBarIndicatorSize.tab,
    //                         labelPadding: EdgeInsets.symmetric(horizontal: 4),
    //                         indicatorPadding: const EdgeInsets.symmetric(
    //                             horizontal: 2.0,
    //                             vertical:
    //                                 5.0), 
    //             tabs: [
    // // Dynamically create Tabs to easily modify the background color
    
    //   Tab(
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     color: activeTabIndex == 0
    //                         ? AppColors.brown
    //                         : AppColors.white12,
    //                     // color: Color(0xFFC8E0DA),
    //                     borderRadius: BorderRadius.circular(20)
                      
    //                     // border:
    //                     //     Border.all(color: Colors.redAccent, width: 1)
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(12.0),
    //                     child: Text("Upcoming"),
    //                   ),
    //                 ),
    //               ),
    //               Tab(
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     color: activeTabIndex == 1
    //                         ? AppColors.brown
    //                         : AppColors.white12,
    //                     // color: Color(0xFFC8E0DA),
    //                   borderRadius: BorderRadius.circular(20)
    //                     // border:
    //                     //     Border.all(color: Colors.redAccent, width: 1)
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 12),
    //                     child: Text("Past"),
    //                   ),
    //                 ),
    //               ),
    //             ],
    
    
      
    //             labelColor: AppColors.white,
    //             unselectedLabelColor: AppColors.white,
    //             unselectedLabelStyle:
    //                 const TextStyle(fontWeight: FontWeight.normal),
    //             labelStyle:
    //                 const TextStyle(fontWeight: FontWeight.normal),
    //           ),
    //           Expanded(
    //               child: 
                  
                  
    //               TabBarView(controller: _tabController, children: [
    //                  ListView.builder(
                        
    //                     itemCount: 5,
    //                     shrinkWrap: true,
    //                     itemBuilder: (context, index) {
                          
    //                       Color containerColor =
    //                           containerColors[index % containerColors.length];
                     
    //                       return Card(
    //                         shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(6)),
    //                         color: containerColor,
    //                         child: Padding(
    //                           padding: const EdgeInsets.all(12.0),
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               TextWidget(text: "Discovery Call", textSize: 25),
    //                               const SizedBox(height: 8),
    //                               Card(
    //                                 color: AppColors.white38,
    //                                 child: Padding(
    //                                   padding: const EdgeInsets.all(8.0),
    //                                   child: Row(
    //                                     children: [
    //                                       Container(
    //                                         padding: const EdgeInsets.all(8.0),
    //                                         decoration: BoxDecoration(
    //                                             borderRadius:
    //                                                 BorderRadius.circular(7),
    //                                             color: AppColors.primary),
    //                                         child: Center(
    //                                           child: Image.asset(
    //                                             PngAssetPath.meetingIcon,
    //                                             color: AppColors.white,
    //                                             height: 22,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                       const SizedBox(width: 8),
    //                                       Column(
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           TextWidget(
    //                                               text: "15 Mins",
    //                                               textSize: 15),
    //                                           const TextWidget(
    //                                               text: "Video Meeting",
    //                                               textSize: 15),
    //                                         ],
    //                                       ),
    //                                       Spacer(),
    //                                      Container(
    //                                        padding: const EdgeInsets.symmetric(
    //                                            horizontal: 5, vertical: 5),
    //                                        decoration: BoxDecoration(
    //                                          borderRadius:
    //                                              BorderRadius.circular(20),
    //                                          border: Border.all(
    //                                              color: AppColors.white, width: 1),
    //                                        ),
    //                                        child: Row(
    //                                          mainAxisAlignment:
    //                                              MainAxisAlignment.center,
    //                                          children: [
    //                                            TextWidget(
    //                                                text: "Rs 0 +",
    //                                                textSize: 12),
    //                                            const SizedBox(width: 5),
    //                                            Icon(Icons.arrow_forward,
    //                                                color: AppColors.white,
    //                                                size: 12),
    //                                                // const SizedBox(width: 5),
                                         
    //                                          ],
    //                                        ),
    //                                      ),
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ),
    //                               sizedTextfield, // You might want to customize this part
    //                               Row(
    //                                 children: [
    //                                   Expanded(
    //                                     child: ElevatedButton.icon(
    //                                       onPressed: () {},
    //                                       icon: Icon(Icons.file_copy_outlined,
    //                                           color: AppColors.white, size: 14),
    //                                       label: const TextWidget(
    //                                           text: "Copy Link", textSize: 14),
    //                                       style: ElevatedButton.styleFrom(
    //                                         backgroundColor:AppColors.blue,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   const SizedBox(width: 8),
    //                                   Expanded(
    //                                     child: AppButton.primaryButton(
    //                                         onButtonPressed: () {
                                              
    //                                           showDialog(
    //                        context: context,
    //                        builder: (BuildContext context) {
    //                          return AlertDialog(
    //                            backgroundColor: AppColors.blackCard,
    //                            title:  TextWidget(text: 'Are you sure you want to cancel this event?', textSize: 16,maxLine: 2,),
    //                            content: TextWidget(text: 'No. of People who have booked this event :', textSize: 16,maxLine: 2,),
    //                            actions: [
    //                              // "Cancel Event" button
    //                              AppButton.primaryButton(
    //                                title: 'Cancel Event',
    //                                onButtonPressed: () {
    //                                },
    //                              ),
    //                              sizedTextfield,
    //                              AppButton.outlineButton(
    //                                borderColor: AppColors.primary,
    //                                title: 'Back',
    //                                onButtonPressed: () {
    //                                  // Close the dialog without performing any action
    //                                  Navigator.of(context).pop();
    //                                },
                                   
    //                              ),
    //                            ],
    //                          );
    //                        },
    //                      );
    //                    },
                                                  
                                            
    //                                         title: "Cancel Event",
    //                                         bgColor:AppColors.redColor
    //                                         ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                   ListView.builder(
                        
    //                     itemCount: 5,
    //                     shrinkWrap: true,
    //                     itemBuilder: (context, index) {
                          
    //                       Color containerColor =
    //                           containerColors[index % containerColors.length];
                     
    //                       return Card(
    //                         shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(6)),
    //                         color: containerColor,
    //                         child: Padding(
    //                           padding: const EdgeInsets.all(12.0),
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               TextWidget(text: "Discovery Call", textSize: 25),
    //                               const SizedBox(height: 8),
    //                               Card(
    //                                 color: AppColors.white38,
    //                                 child: Padding(
    //                                   padding: const EdgeInsets.all(8.0),
    //                                   child: Row(
    //                                     children: [
    //                                       Container(
    //                                         padding: const EdgeInsets.all(8.0),
    //                                         decoration: BoxDecoration(
    //                                             borderRadius:
    //                                                 BorderRadius.circular(7),
    //                                             color: AppColors.primary),
    //                                         child: Center(
    //                                           child: Image.asset(
    //                                             PngAssetPath.meetingIcon,
    //                                             color: AppColors.white,
    //                                             height: 22,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                       const SizedBox(width: 8),
    //                                       Column(
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           TextWidget(
    //                                               text: "15 Mins",
    //                                               textSize: 15),
    //                                           const TextWidget(
    //                                               text: "Video Meeting",
    //                                               textSize: 15),
    //                                         ],
    //                                       ),
    //                                       Spacer(),
    //                                      Container(
    //                                        padding: const EdgeInsets.symmetric(
    //                                            horizontal: 5, vertical: 5),
    //                                        decoration: BoxDecoration(
    //                                          borderRadius:
    //                                              BorderRadius.circular(20),
    //                                          border: Border.all(
    //                                              color: AppColors.white, width: 1),
    //                                        ),
    //                                        child: Row(
    //                                          mainAxisAlignment:
    //                                              MainAxisAlignment.center,
    //                                          children: [
    //                                            TextWidget(
    //                                                text: "Rs 0 +",
    //                                                textSize: 12),
    //                                            const SizedBox(width: 5),
    //                                            Icon(Icons.arrow_forward,
    //                                                color: AppColors.white,
    //                                                size: 12),
    //                                                // const SizedBox(width: 5),
                                         
    //                                          ],
    //                                        ),
    //                                      ),
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ),
    //                               sizedTextfield, // You might want to customize this part
    //                               Row(
    //                                 children: [
    //                                   Expanded(
    //                                     child: ElevatedButton.icon(
    //                                       onPressed: () {},
    //                                       icon: Icon(Icons.file_copy_outlined,
    //                                           color: AppColors.white, size: 14),
    //                                       label: const TextWidget(
    //                                           text: "Copy Link", textSize: 14),
    //                                       style: ElevatedButton.styleFrom(
    //                                         backgroundColor:AppColors.blue,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   const SizedBox(width: 8),
    //                                   Expanded(
    //                                     child: AppButton.primaryButton(
    //                                         onButtonPressed: () {
                                              
    //                                           showDialog(
    //                        context: context,
    //                        builder: (BuildContext context) {
    //                          return AlertDialog(
    //                            backgroundColor: AppColors.blackCard,
    //                            title:  TextWidget(text: 'Are you sure you want to cancel this event?', textSize: 16,maxLine: 2,),
    //                            content: TextWidget(text: 'No. of People who have booked this event :', textSize: 16,maxLine: 2,),
    //                            actions: [
    //                              // "Cancel Event" button
    //                              AppButton.primaryButton(
    //                                title: 'Cancel Event',
    //                                onButtonPressed: () {
    //                                },
    //                              ),
    //                              sizedTextfield,
    //                              AppButton.outlineButton(
    //                                borderColor: AppColors.primary,
    //                                title: 'Back',
    //                                onButtonPressed: () {
    //                                  // Close the dialog without performing any action
    //                                  Navigator.of(context).pop();
    //                                },
                                   
    //                              ),
    //                            ],
    //                          );
    //                        },
    //                      );
    //                    },
                                                  
                                            
    //                                         title: "Cancel Event",
    //                                         bgColor:AppColors.redColor
    //                                         ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       );
    //                     },
    //                   ),])
          
            
    //           )
    //           ]
    //           ),
    //     )
    body:Obx(() => Padding(
            padding: const EdgeInsets.all(12.0),
            child: 
            communityEvents.isLoading.value
                ? Helper.pageLoading()
                : 
                communityEvents.communityEventsList.isEmpty
                      ? Center(child: TextWidget(text: "No Community Events Available", textSize: 16))
                      :
                 ListView.builder(
                    // padding: const EdgeInsets.all(12.0),
                    itemCount: communityEvents.communityEventsList[0].webinars.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      
                      Color containerColor =
                          containerColors[index % containerColors.length];
                 
                      return Card(
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
                  ))),
    )
    );
  }
}

// Row(mainAxisAlignment: MainAxisAlignment.center,
//                     children: [TextWidget(text: "At a ", textSize: 25,fontWeight: FontWeight.bold,),TextWidget(text: "Glance", textSize: 25,color: AppColors.primary,fontWeight: FontWeight.bold,)],),
//                     SizedBox(height: 8,),
//                   Card(
                    
//                      color: AppColors.blackCard,
//                     shape: RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius.circular(12), // Rounded corners for the card
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: Column(
                        
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TextWidget(text: "20", textSize: 25),
//                           TextWidget(text: "Total Member", textSize: 13),
//                           Divider(thickness: 1,color: AppColors.white38,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
                            
//                             children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
                              
//                               children:[
//             TextWidget(text: "3", textSize: 25),
//                           TextWidget(text: "Country", textSize: 13),
//                             ]),
//                             PopupMenuButton<String>(
//                             icon: Icon(Icons.keyboard_arrow_down),
//                           iconColor: AppColors.white,
//                           color: AppColors.blackCard,
//                           offset: Offset(0, 55),
//                           onSelected: (value) {
                           
//                             },
                          
//                           itemBuilder: (context) => [
//                                 const PopupMenuItem(
                                  
//                                   child: TextWidget(text: "All Posts", textSize: 14),
//                                 ),
//                                 PopupMenuItem(
                                  
//                                   child: TextWidget(text:
//                                        "Admin Posts",
                                        
//                                       textSize: 14),
//                                 ),
//                                 const PopupMenuItem(
                                  
//                                   child: TextWidget(text: "Member Posts", textSize: 14),
//                                 ),
//                               ]),
//                           ],),
                          
                          
//                           Divider(thickness: 1,color: AppColors.white38,),
//                           TextWidget(text: "Chat On", textSize: 13),
//                           Divider(thickness: 1,color: AppColors.white38,),
//                           Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         // SizedBox(width: 8),
//                                   Expanded(
//                                     child: MyCustomTextField.textField(
                                      
//                                       prefixIcon: Icon(Icons.search),
//                                       fillColor: AppColors.white,
//                                       borderClr: AppColors.white38,
//                                       borderRadius: 20,
                                                          
//                                                           hintText: "Search for member",
//                                                           controller: searchController),
//                                   ),
//                         SizedBox(width: 8),
                      
                       
//                                   // SizedBox(width: 8),
//                                   //                   InkWell(
//                                   //                     child: CircleAvatar(
//                                   //                       radius: 25,
//                                   //                       backgroundColor: AppColors.primary,
//                                   //                       child: Icon(Icons.filter_list,color: AppColors.white,)
//                                   //                     ),
//                                   //                     onTap: (){
//                                   //         //               DropDownWidget(
//                                   //         // status: postType,
//                                   //         // lable: "Filter",
//                                   //         // statusList: const ["Public", "Private", "Pitch Day"],
//                                   //         // onChanged: (val) {
//                                   //         //   setState(() {
//                                   //         //     privacyStatus = val.toString();
//                                   //         //   });
//                                   //         // });
//                                   //           DropdownButton<String>(
//                                   //   value: selectedItem,
//                                   //   onChanged: (String? newValue) {
//                                   //     setState(() {
//                                   //       selectedItem = newValue!;
//                                   //     });
//                                   //   },
//                                   //   items: postType.map<DropdownMenuItem<String>>((String value) {
//                                   //     return DropdownMenuItem<String>(
//                                   //       value: value,
//                                   //       child: Text(value),
//                                   //     );
//                                   //   }).toList(),
//                                   // ),
//                                   //         }
//                                   //                   ),
//                         CircleAvatar(
//                           radius: 20,
//                                     backgroundColor: AppColors.primary,
//                           child: PopupMenuButton<String>(
//                             icon: Icon(Icons.filter_list),
//                           iconColor: AppColors.white,
//                           color: AppColors.blackCard,
//                           offset: Offset(0, 55),
//                           onSelected: (value) {
                           
//                             },
                          
//                           itemBuilder: (context) => [
//                                 const PopupMenuItem(
                                  
//                                   child: TextWidget(text: "All Posts", textSize: 14),
//                                 ),
//                                 PopupMenuItem(
                                  
//                                   child: TextWidget(text:
//                                        "Admin Posts",
                                        
//                                       textSize: 14),
//                                 ),
//                                 const PopupMenuItem(
                                  
//                                   child: TextWidget(text: "Member Posts", textSize: 14),
//                                 ),
//                               ]),
//                         )
                        
//                         ],),
//                           SizedBox(
//                             child: ListView.separated(
                              
//                               separatorBuilder: (context, index) => Divider(
//                                                 thickness: 1,
//                                                 color: AppColors.white54,
//                                               ),
                                              
//                               shrinkWrap:
//                                   true, // Makes ListView take only as much space as it needs
//                               padding:
//                                   EdgeInsets.zero, // Remove extra padding from ListView
//                               itemCount: communityNames.length,
//                               itemBuilder: (context, index) {
//                                 return ListTile(
//                                   leading: const CircleAvatar(
//                                     backgroundImage: NetworkImage(
//                                     "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
//                                     ),
//                                   //  backgroundColor: AppColors.blue,
//                                   ),
//                                   title: TextWidget(text: communityNames[index], textSize: 16),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),