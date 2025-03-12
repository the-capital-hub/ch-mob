import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityMeetingsScreen/communityBookAMeetingScreen/community_book_a_meeting_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/calendar/calendar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityScheduleEventsScreen extends StatefulWidget {
  const CommunityScheduleEventsScreen({super.key});

  @override
  State<CommunityScheduleEventsScreen> createState() => _CommunityScheduleEventsScreenState();
}

class _CommunityScheduleEventsScreenState extends State<CommunityScheduleEventsScreen> {
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
          child: Padding(padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.zero,
                color: AppColors.blackCard,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 30,
                                      backgroundImage: AssetImage(PngAssetPath.accountImg),
                      ),
                  SizedBox(height: 8,),
                  TextWidget(text: "Title", textSize: 20),
                  SizedBox(height: 8,),
                  TextWidget(text: "nitinjajoria97@gmail.com", textSize: 16),
                  sizedTextfield,
                  Divider(color: AppColors.white38,),
                  sizedTextfield,
                  Row(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      color: AppColors.white,
                                      size: 22,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    TextWidget(text: "30 mins", textSize: 16)
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
                                       TextWidget(
                                          text: "Google Meet", textSize: 16)
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
                                          text: "Free", textSize: 16)
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      TextWidget(text: "About this meeting", textSize: 20, fontWeight: FontWeight.bold,),
                                    ],
                                  ),
                                  sizedTextfield,
                                  Row(
                                    children: [
                                      TextWidget(text: "Description", textSize: 16),
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
                child: Padding(padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    EventCalendar(),
                     sizedTextfield,
                                  TextWidget(text: "Available Time Slots", textSize: 20, fontWeight: FontWeight.w500,),
                                  sizedTextfield,
// Wrap(
//                                 spacing: 4.0,
//                                 runSpacing: 4.0,
//                                 children: List.generate(
//                                     data.length,
//                                     (index) {
//                                   return InkWell(
//                                     onTap: () {
//                                       // loginMobileController
//                                       //         .userNameController.text =
//                                       //     loginMobileController
//                                       //         .suggestions[index];
//                                     },
//                                     child: Card(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(4)),
//                                       color: AppColors.white12,
//                                       surfaceTintColor: AppColors.white12,
//                                       child: Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 12, vertical: 4),
//                                         child: TextWidget(
//                                             text: data[index],
//                                             textSize: 14),
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                               ),
Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: List.generate(
        data.length,
        (index) {
          // Check if this card is selected
          bool isSelected = _selectedIndex == index;

          return InkWell(
            onTap: () {
              setState(() {
                // Toggle the selection of this card
                if (_selectedIndex == index) {
                  _selectedIndex = null; // Deselect if it's already selected
                } else {
                  _selectedIndex = index;
                }
              });
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              color: isSelected ? AppColors.primary : AppColors.white12, // Change color if selected
              surfaceTintColor: AppColors.white12,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TextWidget(
                  text: data[index],
                  textSize: 14,
                  color: isSelected ? AppColors.white : AppColors.black, // Change text color if selected
                ),
              ),
            ),
          );
        },
      ),
    ),
                              sizedTextfield,
                               
              AppButton.primaryButton(onButtonPressed: (){
                Get.to(() => const CommunityBookAMeetingScreen());
              }, title: "Proceed to Payment"),
              sizedTextfield,
              AppButton.primaryButton(onButtonPressed: (){}, title: "Enter Details"),
              sizedTextfield,
              TextWidget(text: "Additional Details", textSize: 20,fontWeight: FontWeight.bold,),
              sizedTextfield,
              MyCustomTextField.textField(hintText: "Enter your name", controller: urlController, lableText: "Name",borderClr: AppColors.white12),
                                     SizedBox(height: 12),
                                     MyCustomTextField.textField(hintText: "Enter your email", controller: urlController, lableText: "Email",borderClr: AppColors.white12),
                                     SizedBox(height: 12),
                                     MyCustomTextField.textField(hintText: "Enter additional information", controller: urlController, lableText: "Additional Information",borderClr: AppColors.white12,maxLine: 3),
                                     SizedBox(height: 12),
                                     AppButton.primaryButton(onButtonPressed: (){}, title: "Schedule Event"),
                                     SizedBox(height: 12),

                  ],
                )
                ),
              ),
              sizedTextfield,
              
            
            ]   
          ),
          
          ),
        ),
      ),
    );
  }
}