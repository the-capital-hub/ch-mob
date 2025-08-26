import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityMeetingsScreen/communityBookAMeetingScreen/community_book_a_meeting_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/calendar/calendar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class CommunityScheduleEventsScreen extends StatefulWidget {
  int index;
  String day;
  String slot;
  String startTime;
  String endTime;
  CommunityScheduleEventsScreen(
      {required this.index,
      required this.day,
      required this.slot,
      super.key,
      required this.startTime,
      required this.endTime});

  @override
  State<CommunityScheduleEventsScreen> createState() =>
      _CommunityScheduleEventsScreenState();
}

class _CommunityScheduleEventsScreenState
    extends State<CommunityScheduleEventsScreen> {
  var communityWebinars = Get.find();
  TextEditingController urlController = TextEditingController();
  int? _selectedIndex;
  List<String> data = [
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
  ];
  bool isDaySelected = false;
  bool isSlotSelected = false;
  int availabilityIndex = 0;
  int? selectedDayIndex;
  String day = "";
  String slot = "";
  String startTime = "";
  String endTime = "";
  @override
  void initState() {
    super.initState();

    autoFillDetails();
  }

  void autoFillDetails() {
    communityWebinars.nameController.text = GetStoreData.getStore.read('name');
    communityWebinars.emailController.text =
        GetStoreData.getStore.read('email');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Book Event",
          hideBack: true,
          autoAction: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              Card(
                margin: EdgeInsets.zero,
                color: AppColors.blackCard,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // const CircleAvatar(
                      //   radius: 30,
                      //   backgroundImage: AssetImage(PngAssetPath.accountImg),
                      // ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // TextWidget(text: "Title", textSize: 20),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // const TextWidget(
                      //     text: "nitinjajoria97@gmail.com", textSize: 16),
                      // sizedTextfield,
                      // Divider(
                      //   color: AppColors.white38,
                      // ),
                      // sizedTextfield,

                      Row(
                        children: [
                          TextWidget(
                              text: communityWebinars
                                  .communityWebinarsList[widget.index].title!,
                              textSize: 20),
                        ],
                      ),
                      sizedTextfield,
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: AppColors.white,
                            size: 22,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          TextWidget(
                              text: communityWebinars
                                  .communityWebinarsList[widget.index].duration
                                  .toString(),
                              textSize: 16)
                        ],
                      ),
                      sizedTextfield,
                      Row(
                        children: [
                          Icon(
                            Icons.video_call,
                            color: AppColors.white,
                            size: 22,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const TextWidget(text: "Google Meet", textSize: 16)
                        ],
                      ),
                      sizedTextfield,
                      Row(
                        children: [
                          Icon(
                            Icons.payment,
                            color: AppColors.white,
                            size: 22,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextWidget(
                              text: communityWebinars
                                          .communityWebinarsList[widget.index]
                                          .price! ==
                                      0
                                  ? "Free"
                                  : "\u{20B9}${communityWebinars.communityWebinarsList[widget.index].price!}",
                              textSize: 16)
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          TextWidget(
                            text: "About this meeting",
                            textSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      sizedTextfield,
                      Row(
                        children: [
                          Expanded(
                            child: HtmlWidget(
                              communityWebinars
                                  .communityWebinarsList[widget.index]
                                  .description!,
                              textStyle: TextStyle(
                                fontSize: 16,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              sizedTextfield,
              Card(
                margin: EdgeInsets.zero,
                color: AppColors.blackCard,
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        // EventCalendar(),
                        // sizedTextfield,
                        // const TextWidget(
                        //   text: "Available Time Slots",
                        //   textSize: 20,
                        //   fontWeight: FontWeight.w500,
                        // ),
                        // sizedTextfield,
                        // Wrap(
                        //   spacing: 4.0,
                        //   runSpacing: 4.0,
                        //   children: List.generate(
                        //     data.length,
                        //     (index) {
                        //       bool isSelected = _selectedIndex == index;

                        //       return InkWell(
                        //         onTap: () {
                        //           setState(() {
                        //             if (_selectedIndex == index) {
                        //               _selectedIndex = null;
                        //             } else {
                        //               _selectedIndex = index;
                        //             }
                        //           });
                        //         },
                        //         child: Card(
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(4),
                        //           ),
                        //           color: isSelected
                        //               ? AppColors.primary
                        //               : AppColors.white12,
                        //           surfaceTintColor: AppColors.white12,
                        //           child: Padding(
                        //             padding: const EdgeInsets.symmetric(
                        //                 horizontal: 12, vertical: 4),
                        //             child: TextWidget(
                        //               text: data[index],
                        //               textSize: 14,
                        //               color: isSelected
                        //                   ? AppColors.white
                        //                   : AppColors.black,
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        // sizedTextfield,
                        // AppButton.primaryButton(
                        //     onButtonPressed: () {
                        //       // Get.to(() => const CommunityBookAMeetingScreen());
                        //     },
                        //     title: "Proceed to Payment"),
                        // sizedTextfield,
                        // AppButton.primaryButton(
                        //     onButtonPressed: () {}, title: "Enter Details"),
                        sizedTextfield,
                        const TextWidget(
                          text: "Additional Details",
                          textSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        sizedTextfield,
                        MyCustomTextField.textField(
                            hintText: "Enter your name",
                            controller: communityWebinars.nameController,
                            lableText: "Name",
                            borderClr: AppColors.white12),
                        const SizedBox(height: 12),
                        MyCustomTextField.textField(
                            hintText: "Enter your email",
                            controller: communityWebinars.emailController,
                            lableText: "Email",
                            borderClr: AppColors.white12),
                        const SizedBox(height: 12),
                        MyCustomTextField.textField(
                            hintText: "Enter additional information",
                            controller: communityWebinars.infoController,
                            lableText: "Additional Information",
                            borderClr: AppColors.white12,
                            maxLine: 3),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton.outlineButton(
                                  borderColor:
                                      GetStoreData.getStore.read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                  onButtonPressed: () {
                                    Get.back();
                                    Get.back();
                                    setState(() {
                                      communityWebinars.formattedDate = "";
                                      communityWebinars.selectedDayName = "";
                                      communityWebinars.selectedDayIndex = 0;
                                      communityWebinars.isDaySelected = false;
                                      communityWebinars.slot = "";
                                      communityWebinars.startTime = "";
                                      communityWebinars.endTime = "";
                                    });
                                  },
                                  title: "Cancel"),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: AppButton.primaryButton(
                                  onButtonPressed: () {
                                    Helper.loader(context);
                                    communityWebinars.communityScheduleEvent(
                                        communityWebinars
                                            .communityWebinarsList[widget.index]
                                            .eventId,
                                        widget.day,
                                        widget.startTime,
                                        widget.endTime);
                                    setState(() {
                                      communityWebinars.formattedDate = "";
                                      communityWebinars.selectedDayName = "";
                                      communityWebinars.selectedDayIndex = 0;
                                      communityWebinars.isDaySelected = false;
                                      communityWebinars.slot = "";
                                      communityWebinars.startTime = "";
                                      communityWebinars.endTime = "";
                                    });
                                  },
                                  title: "Schedule Event"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    )),
              ),
              sizedTextfield,
            ]),
          ),
        ),
      ),
    );
  }
}
