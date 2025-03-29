// import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityAboutController/community_about_controller.dart';
// import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
// import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityProductsAndMembersController/community_products_and_members_controller.dart';
// import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
// import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPurchaseScreen/community_purchase_screen.dart';
// import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
// import 'package:capitalhub_crm/utils/constant/app_var.dart';
// import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
// import 'package:capitalhub_crm/utils/helper/helper.dart';
// import 'package:capitalhub_crm/widget/buttons/button.dart';
// import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// import 'package:get/get.dart';

// class CommunityPublicScreen extends StatefulWidget {
//   const CommunityPublicScreen({super.key});

//   @override
//   State<CommunityPublicScreen> createState() => _CommunityAboutScreenState();
// }

// class _CommunityAboutScreenState extends State<CommunityPublicScreen> {
//   List<String> postsFilter = ['All Posts', 'Admin Posts', 'Member Posts'];

//   CommunityProductsAndMembersController communityProducts =
//       Get.put(CommunityProductsAndMembersController());
//   CommunityEventsController communityEvents =
//       Get.put(CommunityEventsController());
//   CommunityAboutController aboutCommunity = Get.put(CommunityAboutController());
//   CommunityController allCommunities = Get.put(CommunityController());

//   @override
//   void initState() {
//     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//       Future.wait([aboutCommunity.getAboutCommunity()]).then((values) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {});
//       });
//     });
//     super.initState();
//   }

//   final List<Color> containerColors = [
//     AppColors.lightBlue,
//     AppColors.navyBlue,
//     AppColors.oliveGreen
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: bgDec,
//         child: SafeArea(
//             child: Scaffold(
//           backgroundColor: AppColors.transparent,
//           body: Obx(
//             () => aboutCommunity.isLoading.value
//                 ? Helper.pageLoading()
//                 : aboutCommunity.aboutCommunityList.isEmpty
//                     ? const Center(
//                         child: TextWidget(
//                             text: "No Public About Community Available",
//                             textSize: 16))
//                     : SingleChildScrollView(
//                         child: Column(children: [
//                         Column(
//                           children: [
//                             Stack(children: [
//                               Container(
//                                 width: double.infinity,
//                                 height: 310,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       AppColors.black,
//                                       AppColors.brown,
//                                       AppColors.purple,
//                                     ],
//                                     begin: Alignment.topCenter,
//                                     end: Alignment.bottomCenter,
//                                     stops: const [0.0, 0.5, 1.0],
//                                   ),
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.center,
//                                 child: Column(
//                                   children: [
//                                     const SizedBox(
//                                       height: 30,
//                                     ),
//                                     CircleAvatar(
//                                       radius: 60,
//                                       foregroundImage: NetworkImage(
//                                           aboutCommunity.aboutCommunityList[0]
//                                               .community!.image.toString()),
//                                     ),
//                                     const SizedBox(
//                                       height: 16,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         const TextWidget(
//                                           text: "Welcome to the ",
//                                           textSize: 20,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                         TextWidget(
//                                           text: aboutCommunity
//                                               .aboutCommunityList[0]
//                                               .community!
//                                               .name.toString(),
//                                           textSize: 20,
//                                           fontWeight: FontWeight.w500,
//                                           color: AppColors.primary,
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 16,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 30),
//                                       child: Container(
//                                         height: 150,
//                                         decoration: BoxDecoration(
//                                             image: DecorationImage(
//                                                 image: NetworkImage(
//                                                   aboutCommunity
//                                                       .aboutCommunityList[0]
//                                                       .community!
//                                                       .image.toString(),
//                                                 ),
//                                                 fit: BoxFit.fill),
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ]),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               AppButton.primaryButton(
//                                   onButtonPressed: () {
//                                     allCommunities.joinCommunity();
//                                   },
//                                   title: "Join Community"),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               const TextWidget(
//                                 text: "About Community",
//                                 textSize: 20,
//                                 color: AppColors.primary,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               HtmlWidget(
//                                 aboutCommunity
//                                     .aboutCommunityList[0].community!.about.toString(),
//                                 textStyle: TextStyle(
//                                   fontSize: 14,
//                                   color: AppColors.white,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               Column(
//                                 children: [
//                                   const TextWidget(
//                                     text: "Community Admin",
//                                     textSize: 20,
//                                     color: AppColors.primary,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   const SizedBox(
//                                     height: 12,
//                                   ),
//                                   CircleAvatar(
//                                     radius: 40,
//                                     backgroundImage: NetworkImage(aboutCommunity
//                                         .aboutCommunityList[0]
//                                         .admin!
//                                         .profilePicture.toString()),
//                                   ),
//                                   const SizedBox(
//                                     height: 12,
//                                   ),
//                                   TextWidget(
//                                     text:
//                                         "${aboutCommunity.aboutCommunityList[0].admin!.firstName} ${aboutCommunity.aboutCommunityList[0].admin!.lastName}",
//                                     textSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   const SizedBox(
//                                     height: 12,
//                                   ),
//                                   TextWidget(
//                                       text: aboutCommunity.aboutCommunityList[0]
//                                           .admin!.designation!,
//                                       textSize: 16),
//                                   const SizedBox(
//                                     height: 12,
//                                   ),
//                                   TextWidget(
//                                     text: aboutCommunity
//                                         .aboutCommunityList[0].admin!.bio!,
//                                     textSize: 14,
//                                     maxLine: 9,
//                                     align: TextAlign.center,
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               const TextWidget(
//                                 text: "Terms and Conditions",
//                                 textSize: 20,
//                                 color: AppColors.primary,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               aboutCommunity.aboutCommunityList[0].community!
//                                       .termsAndConditions!.isEmpty
//                                   ? const SizedBox(
//                                       height: 100,
//                                       child: TextWidget(
//                                           text:
//                                               "No Community Terms and Conditions Available",
//                                           textSize: 16))
//                                   : const SizedBox(
//                                       height: 12,
//                                     ),
//                               for (int i = 0;
//                                   i <
//                                       aboutCommunity.aboutCommunityList[0]
//                                           .community!.termsAndConditions!.length;
//                                   i++)
//                                 TextWidget(
//                                     text:
//                                         "•   ${aboutCommunity.aboutCommunityList[0].community!.termsAndConditions![i]}",
//                                     textSize: 14),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               const TextWidget(
//                                 text: "Recent Posts From Admin",
//                                 textSize: 20,
//                                 color: AppColors.primary,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               aboutCommunity.aboutCommunityPostsList.isEmpty
//                                   ? const SizedBox(
//                                       height: 100,
//                                       child: TextWidget(
//                                           text: "No Community Posts Available",
//                                           textSize: 16))
//                                   : SizedBox(
//                                       height: 300,
//                                       child: ListView.separated(
//                                         separatorBuilder: (context, index) {
//                                           return const SizedBox(
//                                             height: 12,
//                                           );
//                                         },
//                                         padding: EdgeInsets.zero,
//                                         shrinkWrap: true,
//                                         itemCount: aboutCommunity
//                                             .aboutCommunityPostsList.length,
//                                         itemBuilder: (context, index) {
//                                           return Card(
//                                             margin: EdgeInsets.zero,
//                                             color: AppColors.blackCard,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(12.0),
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       CircleAvatar(
//                                                         foregroundImage:
//                                                             NetworkImage(
//                                                           aboutCommunity
//                                                               .aboutCommunityPostsList[
//                                                                   index]
//                                                               .image
//                                                               .toString(),
//                                                         ),
//                                                       ),
//                                                       const SizedBox(
//                                                         width: 8,
//                                                       ),
//                                                       Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           // TextWidget(
//                                                           //     text:
//                                                           //         "${aboutCommunity.aboutCommunityPostsList[index].user} ",
//                                                           //     textSize: 16),
//                                                           TextWidget(
//                                                               text: aboutCommunity
//                                                                   .aboutCommunityPostsList[
//                                                                       index]
//                                                                   .createdAt
//                                                                   .toString(),
//                                                               textSize: 14)
//                                                         ],
//                                                       ),
//                                                       const SizedBox(
//                                                         width: 8,
//                                                       ),
//                                                       const SizedBox(width: 50),
//                                                     ],
//                                                   ),
//                                                   Divider(
//                                                     color: AppColors.white38,
//                                                   ),
//                                                   HtmlWidget(
//                                                     aboutCommunity
//                                                         .aboutCommunityPostsList[
//                                                             index]
//                                                         .description!,
//                                                     textStyle: TextStyle(
//                                                       fontSize: 14,
//                                                       color: AppColors.white,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 12,
//                                                   ),
//                                                   Container(
//                                                     height: 200,
//                                                     decoration: BoxDecoration(
//                                                         image: DecorationImage(
//                                                             image: NetworkImage(
//                                                               aboutCommunity
//                                                                   .aboutCommunityPostsList[
//                                                                       index]
//                                                                   .image
//                                                                   .toString(),
//                                                             ),
//                                                             fit: BoxFit.fill),
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(15)),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               const TextWidget(
//                                 text: "Community Products",
//                                 textSize: 20,
//                                 color: AppColors.primary,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               aboutCommunity.aboutCommunityProductsList.isEmpty
//                                   ? const SizedBox(
//                                       height: 100,
//                                       child: TextWidget(
//                                           text:
//                                               "No Community Products Available",
//                                           textSize: 16))
//                                   : SizedBox(
//                                       height: 300,
//                                       child: ListView.separated(
//                                         separatorBuilder: (context, index) {
//                                           return const SizedBox(
//                                             height: 12,
//                                           );
//                                         },
//                                         padding: EdgeInsets.zero,
//                                         shrinkWrap: true,
//                                         itemCount: aboutCommunity
//                                             .aboutCommunityProductsList.length,
//                                         itemBuilder: (context, index) {
//                                           return Card(
//                                             margin: EdgeInsets.zero,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15)),
//                                             color: AppColors.navyBlue,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(0.0),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Stack(children: [
//                                                     Container(
//                                                       height: 200,
//                                                       decoration: BoxDecoration(
//                                                           image:
//                                                               DecorationImage(
//                                                                   image:
//                                                                       NetworkImage(
//                                                                     aboutCommunity
//                                                                         .aboutCommunityProductsList[
//                                                                             index]
//                                                                         .image,
//                                                                   ),
//                                                                   fit: BoxFit
//                                                                       .fill),
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       15)),
//                                                     ),
//                                                     Positioned(
//                                                       top: -4,
//                                                       left: -3,
//                                                       child: Card(
//                                                         shape:
//                                                             const RoundedRectangleBorder(
//                                                           borderRadius:
//                                                               BorderRadius.only(
//                                                                   bottomRight:
//                                                                       Radius
//                                                                           .circular(
//                                                                               12),
//                                                                   topLeft: Radius
//                                                                       .circular(
//                                                                           12)),
//                                                         ),
//                                                         color:
//                                                             AppColors.primary,
//                                                         child: Padding(
//                                                             padding: const EdgeInsets
//                                                                 .symmetric(
//                                                                 horizontal: 12,
//                                                                 vertical: 4),
//                                                             child: TextWidget(
//                                                                 text: aboutCommunity
//                                                                         .aboutCommunityProductsList[
//                                                                             index]
//                                                                         .isFree
//                                                                     ? "Free"
//                                                                     : "\u{20B9}${aboutCommunity.aboutCommunityProductsList[index].amount}/-",
//                                                                 textSize: 16)),
//                                                       ),
//                                                     ),
//                                                   ]),
//                                                   sizedTextfield,
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 12,
//                                                             right: 16),
//                                                     child: TextWidget(
//                                                       text: aboutCommunity
//                                                           .aboutCommunityProductsList[
//                                                               index]
//                                                           .name,
//                                                       textSize: 18,
//                                                       maxLine: 2,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 8,
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 12,
//                                                             right: 16),
//                                                     child: HtmlWidget(
//                                                       aboutCommunity
//                                                           .aboutCommunityProductsList[
//                                                               index]
//                                                           .description,
//                                                       textStyle: TextStyle(
//                                                         fontSize: 14,
//                                                         color: AppColors.white,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding: const EdgeInsets
//                                                         .symmetric(
//                                                         horizontal: 50,
//                                                         vertical: 12),
//                                                     child:
//                                                         AppButton.primaryButton(
//                                                             onButtonPressed:
//                                                                 () {
//                                                               if (aboutCommunity
//                                                                   .aboutCommunityProductsList[
//                                                                       index]
//                                                                   .isFree) {
//                                                                 showDialog(
//                                                                   context:
//                                                                       context,
//                                                                   builder:
//                                                                       (BuildContext
//                                                                           context) {
//                                                                     return AlertDialog(
//                                                                       backgroundColor:
//                                                                           AppColors
//                                                                               .blackCard,
//                                                                       title: const Align(
//                                                                           alignment: Alignment.center,
//                                                                           child: TextWidget(
//                                                                             text:
//                                                                                 'Resource URLs',
//                                                                             textSize:
//                                                                                 25,
//                                                                             fontWeight:
//                                                                                 FontWeight.bold,
//                                                                           )),
//                                                                       content:
//                                                                           Column(
//                                                                         crossAxisAlignment:
//                                                                             CrossAxisAlignment.start,
//                                                                         mainAxisSize:
//                                                                             MainAxisSize.min,
//                                                                         children: [
//                                                                           for (var i = 0;
//                                                                               i < aboutCommunity.aboutCommunityProductsList[index].urls.length;
//                                                                               i++)
//                                                                             TextWidget(
//                                                                               text: aboutCommunity.aboutCommunityProductsList[index].urls[i],
//                                                                               textSize: 16,
//                                                                               color: AppColors.primary,
//                                                                             ),
//                                                                         ],
//                                                                       ),
//                                                                       actions: [
//                                                                         AppButton
//                                                                             .primaryButton(
//                                                                           bgColor:
//                                                                               AppColors.primary,
//                                                                           title:
//                                                                               'Close',
//                                                                           onButtonPressed:
//                                                                               () {
//                                                                             Navigator.of(context).pop();
//                                                                           },
//                                                                         ),
//                                                                       ],
//                                                                     );
//                                                                   },
//                                                                 );
//                                                               } else {
//                                                                 Get.to(() =>
//                                                                     PurchaseScreen(
//                                                                         index:
//                                                                             index));
//                                                               }
//                                                             },
//                                                             title: aboutCommunity
//                                                                     .aboutCommunityProductsList[
//                                                                         index]
//                                                                     .isFree
//                                                                 ? "Access Resource"
//                                                                 : "Buy \u{20B9}${aboutCommunity.aboutCommunityProductsList[index].amount} "),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               const TextWidget(
//                                 text: "Upcoming Events",
//                                 textSize: 20,
//                                 color: AppColors.primary,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               aboutCommunity.aboutCommunityEventsList.isEmpty
//                                   ? const SizedBox(
//                                       height: 100,
//                                       child: TextWidget(
//                                           text: "No Community Events Available",
//                                           textSize: 16))
//                                   : SizedBox(
//                                       height: 300,
//                                       child: ListView.separated(
//                                         separatorBuilder: (context, index) {
//                                           return const SizedBox(
//                                             height: 12,
//                                           );
//                                         },
//                                         itemCount: aboutCommunity
//                                             .aboutCommunityEventsList.length,
//                                         shrinkWrap: true,
//                                         itemBuilder: (context, index) {
//                                           Color containerColor =
//                                               containerColors[index %
//                                                   containerColors.length];

//                                           return Card(
//                                             margin: EdgeInsets.zero,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(6)),
//                                             color: containerColor,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(12.0),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   TextWidget(
//                                                       text: aboutCommunity
//                                                           .aboutCommunityEventsList[
//                                                               index]
//                                                           .title.toString(),
//                                                       textSize: 25),
//                                                   const SizedBox(height: 8),
//                                                   Card(
//                                                     color: AppColors.white38,
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       child: Row(
//                                                         children: [
//                                                           Container(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .all(8.0),
//                                                             decoration: BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             7),
//                                                                 color: AppColors
//                                                                     .primary),
//                                                             child: Center(
//                                                               child:
//                                                                   Image.asset(
//                                                                 PngAssetPath
//                                                                     .meetingIcon,
//                                                                 color: AppColors
//                                                                     .white,
//                                                                 height: 22,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           const SizedBox(
//                                                               width: 8),
//                                                           Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               TextWidget(
//                                                                   text:
//                                                                       "${aboutCommunity.aboutCommunityEventsList[index].duration}",
//                                                                   textSize: 15),
//                                                               const TextWidget(
//                                                                   text:
//                                                                       "Video Meeting",
//                                                                   textSize: 15),
//                                                             ],
//                                                           ),
//                                                           const Spacer(),
//                                                           Container(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .symmetric(
//                                                                     horizontal:
//                                                                         5,
//                                                                     vertical:
//                                                                         5),
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           20),
//                                                               border: Border.all(
//                                                                   color:
//                                                                       AppColors
//                                                                           .white,
//                                                                   width: 1),
//                                                             ),
//                                                             child: Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .center,
//                                                               children: [
//                                                                 TextWidget(
//                                                                     text:
//                                                                         "Rs ${aboutCommunity.aboutCommunityEventsList[index].price} +",
//                                                                     textSize:
//                                                                         12),
//                                                                 const SizedBox(
//                                                                     width: 5),
//                                                                 Icon(
//                                                                     Icons
//                                                                         .arrow_forward,
//                                                                     color: AppColors
//                                                                         .white,
//                                                                     size: 12),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   sizedTextfield,
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                             ],
//                           ),
//                         ),
//                       ])),
//           ),
//         )));
//   }
// }
