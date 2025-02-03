import 'dart:ffi';

import 'package:capitalhub_crm/controller/meetingController/meeting_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/meetingModel/get_events_model.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/create_events_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

// class _EventsScreenState extends State<EventsScreen> {
//   final List<Color> containerColors = [
//     AppColors.lightBlue,
//     AppColors.navyBlue,
//     AppColors.oliveGreen
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: bgDec,
//       child: Scaffold(
//         drawer: const DrawerWidget(),
//         backgroundColor: AppColors.transparent,
//         appBar: HelperAppBar.appbarHelper(
//             title: "Events", hideBack: true, autoAction: true),
//         body: ListView.builder(
//           padding: const EdgeInsets.all(12.0),
//           itemCount: 3,
//           itemBuilder: (context, index) {
//             Color containerColor =
//                 containerColors[index % containerColors.length];

//             return Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6)),
//               color: containerColor,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const TextWidget(text: "Discovery Call", textSize: 25),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Card(
//                       color: AppColors.white38,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(8.0),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(7),
//                                   color: AppColors.primary),
//                               child: Center(
//                                 child: Image.asset(
//                                   PngAssetPath.meetingIcon,
//                                   color: AppColors.white,
//                                   height: 22,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 8,
//                             ),
//                             const Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 TextWidget(text: "15 Mins", textSize: 15),
//                                 TextWidget(text: "Video Meeting", textSize: 15),
//                               ],
//                             ),
//                             const SizedBox(width: 70),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 5),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                   color: AppColors.white,
//                                   width: 1,
//                                 ),
//                               ),
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const TextWidget(
//                                         text: "Rs 0 +", textSize: 12),
//                                     const SizedBox(width: 5),
//                                     Icon(Icons.arrow_forward,
//                                         color: AppColors.white, size: 12),
//                                   ]),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     sizedTextfield,
//                     Row(
//                       children: [
//                         ElevatedButton.icon(
//                           onPressed: () {},
//                           icon: Icon(Icons.file_copy_outlined,
//                               color: AppColors.white, size: 14),
//                           label:
//                               const TextWidget(text: "Copy Link", textSize: 14),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.blue,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 8,
//                         ),
//                         AppButton.primaryButton(
//                             onButtonPressed: () {},
//                             title: "Delete Event",
//                             bgColor: AppColors.redColor,
//                             width: 140,
//                             height: 40),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.all(14),
//           child: AppButton.primaryButton(
//               onButtonPressed: () {
//                 Get.to(() => const CreateEventsScreen());
//               },
//               title: "+ Create Event"),
//         ),
//       ),
//     );
//   }
// }

class _EventsScreenState extends State<EventsScreen> {
  final List<Color> containerColors = [
    AppColors.lightBlue,
    AppColors.navyBlue,
    AppColors.oliveGreen
  ];
  // late Future<List<Datum>> eventsFuture;
  MeetingController eventController = Get.put(MeetingController());
  ScrollController scrollController = ScrollController();
  

  // @override
  // void initState() {
  //   super.initState();
  //   // eventsFuture = MeetingController().getEvents(context); // Fetch events on screen load
  //   eventController.getEvents();
  // }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      eventController.getEvents().then((v) {
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
        drawer: const DrawerWidget(),
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
            title: "Events", hideBack: true, autoAction: true),
        body: Obx(() => Padding(
            padding: const EdgeInsets.all(12.0),
            child: 
            eventController.isLoading.value
                ? Helper.pageLoading()
                : 
                eventController.eventsList.isEmpty
                      ? Center(child: TextWidget(text: "No Events Available", textSize: 16))
                      :
                 ListView.builder(
                    // padding: const EdgeInsets.all(12.0),
                    itemCount: eventController.eventsList.length,
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
                              TextWidget(text: eventController.eventsList[index].title, textSize: 25),
                              eventController.eventsList[index].isActive?const SizedBox():
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
                                              text: "${eventController.eventsList[index].duration}",
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
                                               text: "Rs ${eventController.eventsList[index].price} +",
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
                                        backgroundColor: eventController.eventsList[index].isActive? AppColors.blue:AppColors.grey,
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
                           content: TextWidget(text: 'No. of People who have booked this event : ${eventController.eventsList[index].bookings.length}', textSize: 16,maxLine: 2,),
                           actions: [
                             // "Cancel Event" button
                             AppButton.primaryButton(
                               title: 'Cancel Event',
                               onButtonPressed: () {
                                 
                                 // Call the delete event function
                                 eventController.disableEvent(eventController.eventsList[index].id);
                                 // Close the dialog after confirming
                                eventController.getEvents();
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
                   },
                                              
                                        
                                        title: "Cancel Event",
                                        bgColor:eventController.eventsList[index].isActive? AppColors.redColor:AppColors.grey
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
          child: AppButton.primaryButton(
            onButtonPressed: () {
              Get.to(() => const CreateEventsScreen());
            },
            title: "+ Create Event",
          ),
        ),
      ),
    );
  }
}
