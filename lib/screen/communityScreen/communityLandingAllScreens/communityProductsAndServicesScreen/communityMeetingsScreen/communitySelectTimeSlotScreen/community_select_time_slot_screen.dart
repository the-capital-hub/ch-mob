// import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityMeetingsController/community_meetings_controller.dart';
// import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityMeetingsScreen/communityBookAMeetingScreen/community_book_a_meeting_screen.dart';
// import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
// import 'package:capitalhub_crm/utils/constant/app_var.dart';
// import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
// import 'package:capitalhub_crm/widget/appbar/appbar.dart';
// import 'package:capitalhub_crm/widget/buttons/button.dart';
// import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CommunitySelectTimeSlotScreen extends StatefulWidget {
//   int index;
//   CommunitySelectTimeSlotScreen({required this.index, super.key});

//   @override
//   State<CommunitySelectTimeSlotScreen> createState() =>
//       _CommunitySelectTimeSlotScreenState();
// }

// class _CommunitySelectTimeSlotScreenState
//     extends State<CommunitySelectTimeSlotScreen> {
//   CommunityMeetingsController communityMeetings = Get.find();
  
//   bool isSlotSelected = false;
  
//   int? _selectedIndex;
//   int? selectedDayIndex;
  
//   String slot = "";
//   String startTime = "";
//   String endTime = "";
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: bgDec,
//       child: Scaffold(
//           backgroundColor: AppColors.transparent,
//           appBar: HelperAppBar.appbarHelper(
//             title: "Select Time Slot",
//             hideBack: false,
//             autoAction: true,
//           ),
//           body: communityMeetings
//                   .communityMeetingsList[widget.index].availability!.isEmpty
//               ? const Center(
//                   child: TextWidget(
//                       text: "No Time Slot Available", textSize: 16),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     children: [
                      
//                       ListView.builder(
//                           shrinkWrap: true,
//                           padding: EdgeInsets.zero,
//                           itemCount: communityMeetings
//                               .communityMeetingsList[widget.index]
//                               .availability!
//                               .length,
//                           itemBuilder: (context, index) {
//                             return InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   communityMeetings.isDaySelected = !communityMeetings.isDaySelected;

//                                   communityMeetings.day = communityMeetings.isDaySelected
//                                       ? communityMeetings
//                                           .communityMeetingsList[widget.index]
//                                           .availability![index]
//                                           .day!
//                                       : "";
                           
//                                 });
//                               },
//                               child: Center(
//                                 child: Card(
//                                     color: AppColors.transparent,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                       side: const BorderSide(
//                                         color: Colors.white38,
//                                         width: 1,
//                                       ),
//                                     ),
//                                     child: Padding(
//                                       padding: EdgeInsets.all(12),
//                                       child: TextWidget(
//                                         text: communityMeetings
//                                             .communityMeetingsList[widget.index]
//                                             .availability![index]
//                                             .day!,
//                                         textSize: 16,
//                                       ),
//                                     )),
//                               ),
//                             );
//                           }),
//                       if (communityMeetings.isDaySelected)
//                         Wrap(
//                           spacing: 4.0,
//                           runSpacing: 4.0,
//                           children: List.generate(
//                             communityMeetings
//                                 .communityMeetingsList[widget.index]
//                                 .availability![0]
//                                 .slots!
//                                 .length,
//                             (index) {
//                               bool isSlotSelected = _selectedIndex == index;
//                               return !communityMeetings
//                                       .communityMeetingsList[widget.index]
//                                       .availability![0]
//                                       .slots![index]
//                                       .isBooked!
//                                   ? InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           isSlotSelected = !isSlotSelected;
//                                           if (_selectedIndex == index) {
//                                             _selectedIndex = null;
//                                           } else {
//                                             _selectedIndex = index;
//                                           }

//                                           slot = isSlotSelected
//                                               ? "${communityMeetings.communityMeetingsList[widget.index].availability![0].slots![index].startTime} - ${communityMeetings.communityMeetingsList[widget.index].availability![0].slots![index].endTime}"
//                                               : "";
//                                           startTime = communityMeetings
//                                               .communityMeetingsList[
//                                                   widget.index]
//                                               .availability![0]
//                                               .slots![index]
//                                               .startTime!;
//                                           endTime = communityMeetings
//                                               .communityMeetingsList[
//                                                   widget.index]
//                                               .availability![0]
//                                               .slots![index]
//                                               .endTime!;
//                                         });
//                                       },
//                                       child: Card(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                         ),
//                                         color: isSlotSelected
//                                             ? AppColors.primary
//                                             : AppColors.white12,
//                                         surfaceTintColor: AppColors.white12,
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 12, vertical: 4),
//                                           child: TextWidget(
//                                             text:
//                                                 "${communityMeetings.communityMeetingsList[widget.index].availability![0].slots![index].startTime} - ${communityMeetings.communityMeetingsList[widget.index].availability![0].slots![index].endTime}",
//                                             textSize: 14,
//                                             color: isSlotSelected
//                                                 ? AppColors.white
//                                                 : AppColors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : const SizedBox.shrink();
//                             },
//                           ),
//                         ),
//                       // ListView.builder(
//                       //     shrinkWrap: true,
//                       //     padding: EdgeInsets.zero,
//                       //     itemCount: communityMeetings
//                       //         .communityMeetingsList[widget.index]
//                       //         .availability![index]
//                       //         .slots!
//                       //         .length,
//                       //     itemBuilder: (context, innerIndex) {
//                       //       return !communityMeetings
//                       //               .communityMeetingsList[widget.index]
//                       //               .availability![index]
//                       //               .slots![innerIndex]
//                       //               .isBooked!
//                       //           ? InkWell(
//                       //               onTap: () {
//                       //                 setState(() {
//                       //                   isSelected = !isSelected;
//                       //                   day = isSelected
//                       //                       ? communityMeetings
//                       //                           .communityMeetingsList[
//                       //                               widget.index]
//                       //                           .availability![index]
//                       //                           .day!
//                       //                       : "";
//                       //                   slot = isSelected
//                       //                       ? "${communityMeetings.communityMeetingsList[widget.index].availability![index].slots![innerIndex].startTime} - ${communityMeetings.communityMeetingsList[widget.index].availability![index].slots![innerIndex].endTime}"
//                       //                       : "";
//                       //                 });
//                       //               },
//                       //               child: Center(
//                       //                 child: Card(
//                       //                   color: isSelected
//                       //                       ? AppColors.primary
//                       //                       : AppColors.transparent,
//                       //                   shape: RoundedRectangleBorder(
//                       //                     borderRadius:
//                       //                         BorderRadius.circular(20),
//                       //                     side: BorderSide(
//                       //                       color: isSelected
//                       //                           ? AppColors.transparent
//                       //                           : AppColors.white38,
//                       //                       width: 1,
//                       //                     ),
//                       //                   ),
//                       //                   child: Padding(
//                       //                     padding: const EdgeInsets.all(12),
//                       //                     child: TextWidget(
//                       //                       text:
//                       //                           "${communityMeetings.communityMeetingsList[widget.index].availability![index].slots![innerIndex].startTime} - ${communityMeetings.communityMeetingsList[widget.index].availability![index].slots![innerIndex].endTime}",
//                       //                       textSize: 16,
//                       //                       color: AppColors.white,
//                       //                     ),
//                       //                   ),
//                       //                 ),
//                       //               ),
//                       //             )
//                       //           : const SizedBox.shrink();
//                       //     }),
//                       // ],
//                       // );
//                       // }),
//                       sizedTextfield,
//                       Row(
//                         children: [
//                           Expanded(
//                             child: AppButton.outlineButton(
//                                 borderColor: AppColors.primary,
//                                 onButtonPressed: () {
//                                   Get.back();
//                                 },
//                                 title: "Cancel"),
//                           ),
//                           const SizedBox(
//                             width: 12,
//                           ),
//                           Expanded(
//                               child: AppButton.primaryButton(
//                                   onButtonPressed: () {
//                                     communityMeetings.day != "" && slot != ""
//                                         ? Get.to(
//                                             () => CommunityBookAMeetingScreen(
//                                                   day: communityMeetings.day,
//                                                   slot: slot,
//                                                   index: widget.index,
//                                                   startTime: startTime,
//                                                   endTime: endTime,
//                                                 ))
//                                         : HelperSnackBar.snackBar("Error",
//                                             "Select a Time Slot for Booking");
//                                   },
//                                   title: "Confirm Booking"))
//                         ],
//                       ),
//                       const SizedBox(
//                         width: 12,
//                       ),
//                     ],
//                   ),
//                 )),
//     );
//   }
// }
