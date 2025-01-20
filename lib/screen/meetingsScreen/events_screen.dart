import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/create_events_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
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
        drawer: const DrawerWidget(),
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
            title: "Events", hideBack: true, autoAction: true),
        body: ListView.builder(
            padding: EdgeInsets.all(12.0),
            itemCount: 3, 
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
                      SizedBox(
                        height: 8,
                      ),
                      Card(
                        color: AppColors.white38,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: AppColors.orange),
                                child: Center(
                                  child: Image.asset(
                                    PngAssetPath.meetingIcon,
                                    color: AppColors.white,
                                    height: 22,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(text: "15 Mins", textSize: 15),
                                  TextWidget(
                                      text: "Video Meeting", textSize: 15),
                                ],
                              ),
                              SizedBox(width: 70),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextWidget(text: "Rs 0 +", textSize: 12),
                                      SizedBox(width:5),
                                      Icon(Icons.arrow_forward,color: AppColors.white,size: 12),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      sizedTextfield,
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.copy,color: AppColors.white,size: 14),
                            label: TextWidget(text: "Copy Link", textSize: 14),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.blue,
                            ),
                          ),
                          SizedBox(width: 8,),
                          AppButton.primaryButton(
                              onButtonPressed: () {},
                              title: "Cancel Meeting",
                              bgColor: AppColors.redColor,
                              width: 140,
                              height: 40),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(14),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                Get.to(() => const CreateEventsScreen());
              },
              title: "+ Create Event"),
        ),
      ),
    );
  }
}
