import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunityWebinarsScreen extends StatefulWidget {
  const CommunityWebinarsScreen({super.key});

  @override
  State<CommunityWebinarsScreen> createState() => _CommunityWebinarsScreenState();
}

class _CommunityWebinarsScreenState extends State<CommunityWebinarsScreen> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
            padding:  EdgeInsets.zero,
            itemCount: 5,
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
                                  "https://bettermeetings.expert/wp-content/uploads/engaging-interactive-webinar-best-practices-and-formats.jpg",
                                ),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      sizedTextfield,
                     
                       TextWidget(
                        text: "Title",
                        textSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
          
                      sizedTextfield,
                      TextWidget(
                        text: "Description",
                        textSize: 16,
                        // fontWeight: FontWeight.bold,
                      ),
                      sizedTextfield,
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: AppColors.white,
                            size: 22,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                           TextWidget(
                              text: "7 March 2024", textSize: 16)
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
          
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: AppColors.white,
                            size: 22,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          TextWidget(text: "0 joined", textSize: 16)
                        ],
                      ),
          
                      const SizedBox(
                        height: 15,
                      ),
          
          
                      
                    ],
                  ),
                ),
              );
            },
          );
     
      
    
  }
}