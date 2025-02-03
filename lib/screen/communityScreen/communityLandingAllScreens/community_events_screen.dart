import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/community_drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunityEventsScreen extends StatefulWidget {
  const CommunityEventsScreen({super.key});

  @override
  State<CommunityEventsScreen> createState() => _CommunityEventsScreenState();
}

class _CommunityEventsScreenState extends State<CommunityEventsScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int activeTabIndex = 1;

  @override
  void initState() {
    super.initState();
    
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1,);
    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
      });
    });
    
   

   
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
        body:Padding(
          padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TabBar(
                
                
                controller: _tabController,
                isScrollable: true,
               
                tabAlignment: TabAlignment.start,
                
                dividerHeight: 0,
                              indicator: BoxDecoration(
                                color: AppColors
                                  .transparent,// Background color for selected tab
                                  
                              
                             borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),// Adjust the horizontal padding to make the box wider
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelPadding: EdgeInsets.symmetric(horizontal: 4),
                            indicatorPadding: const EdgeInsets.symmetric(
                                horizontal: 2.0,
                                vertical:
                                    5.0), 
                tabs: [
    // Dynamically create Tabs to easily modify the background color
    
      Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        color: activeTabIndex == 0
                            ? AppColors.brown
                            : AppColors.white12,
                        // color: Color(0xFFC8E0DA),
                        borderRadius: BorderRadius.circular(20)
                      
                        // border:
                        //     Border.all(color: Colors.redAccent, width: 1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Upcoming"),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        color: activeTabIndex == 1
                            ? AppColors.brown
                            : AppColors.white12,
                        // color: Color(0xFFC8E0DA),
                      borderRadius: BorderRadius.circular(20)
                        // border:
                        //     Border.all(color: Colors.redAccent, width: 1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 12),
                        child: Text("Past"),
                      ),
                    ),
                  ),
                ],
    
    
      
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.white,
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.normal),
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.normal),
              ),
              Expanded(
                  child: 
                  
                  
                  TabBarView(controller: _tabController, children: [
                     ListView.builder(
                        
                        itemCount: 5,
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
                                  TextWidget(text: "Discovery Call", textSize: 25),
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
                                                  text: "15 Mins",
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
                                                   text: "Rs 0 +",
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
                                          onPressed: () {},
                                          icon: Icon(Icons.file_copy_outlined,
                                              color: AppColors.white, size: 14),
                                          label: const TextWidget(
                                              text: "Copy Link", textSize: 14),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:AppColors.blue,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: AppButton.primaryButton(
                                            onButtonPressed: () {
                                              
                                              showDialog(
                           context: context,
                           builder: (BuildContext context) {
                             return AlertDialog(
                               backgroundColor: AppColors.blackCard,
                               title:  TextWidget(text: 'Are you sure you want to cancel this event?', textSize: 16,maxLine: 2,),
                               content: TextWidget(text: 'No. of People who have booked this event :', textSize: 16,maxLine: 2,),
                               actions: [
                                 // "Cancel Event" button
                                 AppButton.primaryButton(
                                   title: 'Cancel Event',
                                   onButtonPressed: () {
                                   },
                                 ),
                                 sizedTextfield,
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
                       },
                                                  
                                            
                                            title: "Cancel Event",
                                            bgColor:AppColors.redColor
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
                      ListView.builder(
                        
                        itemCount: 5,
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
                                  TextWidget(text: "Discovery Call", textSize: 25),
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
                                                  text: "15 Mins",
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
                                                   text: "Rs 0 +",
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
                                          onPressed: () {},
                                          icon: Icon(Icons.file_copy_outlined,
                                              color: AppColors.white, size: 14),
                                          label: const TextWidget(
                                              text: "Copy Link", textSize: 14),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:AppColors.blue,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: AppButton.primaryButton(
                                            onButtonPressed: () {
                                              
                                              showDialog(
                           context: context,
                           builder: (BuildContext context) {
                             return AlertDialog(
                               backgroundColor: AppColors.blackCard,
                               title:  TextWidget(text: 'Are you sure you want to cancel this event?', textSize: 16,maxLine: 2,),
                               content: TextWidget(text: 'No. of People who have booked this event :', textSize: 16,maxLine: 2,),
                               actions: [
                                 // "Cancel Event" button
                                 AppButton.primaryButton(
                                   title: 'Cancel Event',
                                   onButtonPressed: () {
                                   },
                                 ),
                                 sizedTextfield,
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
                       },
                                                  
                                            
                                            title: "Cancel Event",
                                            bgColor:AppColors.redColor
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),])
          
            
              )
              ]
              ),
        )
    )
    );
  }
}

