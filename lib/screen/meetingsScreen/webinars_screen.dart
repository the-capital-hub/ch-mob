import 'package:capitalhub_crm/controller/meetingController/meeting_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/create_new_webinar_screen.dart';
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

class WebinarsScreen extends StatefulWidget {
  const WebinarsScreen({super.key});

  @override
  State<WebinarsScreen> createState() => _WebinarsScreenState();
}

class _WebinarsScreenState extends State<WebinarsScreen> {
  MeetingController webinarController = Get.put(MeetingController());
   @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      webinarController.getWebinars().then((v) {
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
          title: "Webinars",
          hideBack: true,
          autoAction: true,
        ),
         
        body: Obx(()=>
        webinarController.isLoading.value
                ? Helper.pageLoading()
                : webinarController.webinarsList.isEmpty
                      ? Center(child: TextWidget(text: "No Webinars Available", textSize: 16))
                      :
           ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: webinarController.webinarsList.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: AppColors.navyBlue,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                  "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                                ),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      sizedTextfield,
                      sizedTextfield,
                       TextWidget(
                        text: webinarController.webinarsList[index].title,
                        textSize: 25,
                        fontWeight: FontWeight.bold,
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
                            width: 5,
                          ),
                           TextWidget(
                              text: webinarController.webinarsList[index].startTime, textSize: 16)
                        ],
                      ),
          
                      sizedTextfield,
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
          
                       Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage(PngAssetPath.accountImg),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          TextWidget(text: webinarController.webinarsList[index].creatorName, textSize: 20)
                        ],
                      ),
          
                      const SizedBox(
                        height: 15,
                      ),
          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppButton.primaryButton(
                                onButtonPressed: webinarController.webinarsList[index].isActive 
    ?  () async {
     
      
    }:null,
                                title: "Join Webinar",
                                bgColor: webinarController.webinarsList[index].isActive? AppColors.brown:AppColors.grey
                                ),
                          ),
                          const SizedBox(width: 8),
                          // const Icon(
                          //   Icons.schedule,
                          //   color: AppColors.redColor,
                          //   size: 22,
                          // ),
                          // const SizedBox(width: 5),
                          //  TextWidget(
                          //   text: webinarController.webinarsList[index].duration,
                          //   textSize: 16,
                          //   color: AppColors.redColor,
                          // ),
                          Expanded(
                            child: AppButton.primaryButton(
                                onButtonPressed: webinarController.webinarsList[index].isActive 
    ? () {
                                          
                                          showDialog(
                       context: context,
                       builder: (BuildContext context) {
                         return AlertDialog(
                           backgroundColor: AppColors.blackCard,
                           title:  TextWidget(text: 'Are you sure you want to cancel this webinar?', textSize: 16,maxLine: 2,),
                           content: TextWidget(text: 'No. of Users who have joined this webinar : ${webinarController.webinarsList[index].joinedUsers.length}', textSize: 16,maxLine: 2,),
                           actions: [
                             // "Cancel Event" button
                             AppButton.primaryButton(
                               title: 'Cancel Webinar',
                               onButtonPressed: () {
                                 
                                 // Call the delete event function
                                 webinarController.disableWebinar(webinarController.webinarsList[index].id);
                                 // Close the dialog after confirming
                                webinarController.getWebinars();
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
                                title: "Cancel Webinar",
                                bgColor: webinarController.webinarsList[index].isActive? AppColors.redColor:AppColors.grey
                                ),
                          ),

                        ],
                      ),
                      // sizedTextfield,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          // child: AppButton.primaryButton(
          //     onButtonPressed: () {
          //       // Get.to(() => const CreateNewWebinarScreen());
          //       print('Current route: ${Get.toString()}'); 
          //       Get.toNamed('/createNewWebinar');
                
          //     },
          //     title: "+ Create Webinars"),
          child: AppButton.primaryButton(
  onButtonPressed: () {
    Get.to(() => const CreateNewWebinarScreen());
  },
  title: "+ Create Webinars"
)
        ),
      ),
    );
  }
}
