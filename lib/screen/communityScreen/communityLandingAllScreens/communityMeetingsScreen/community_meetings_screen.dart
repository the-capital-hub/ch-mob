import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunityMeetingsScreen extends StatefulWidget {
  const CommunityMeetingsScreen({super.key});

  @override
  State<CommunityMeetingsScreen> createState() => _CommunityMeetingScreenState();
}

class _CommunityMeetingScreenState extends State<CommunityMeetingsScreen> {
  List<String> data = [
    "Sector Agnostic",
    "B2B",
    "B2C",
    "AI/ML",
    "API",
    "AR/VR",
    "Analytics",
    "Automation",
    "BioTech",
    "Cloud",
    "Consumer Tech",
    "Creator Economy",
    "Crypto/Blockchain",
    "D2C",
    "DeepTech",
    "Developer Tools",
    "E-Commerce",
    "Education",];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        drawer: const DrawerWidget(),
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Meetings",
          hideBack: true,
          autoAction: true,
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: AppColors.blackCard,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      
                      
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           TextWidget(
                            text: "Title",
                            textSize: 20,
                            fontWeight: FontWeight.w500,
                                                 ),
                                                 Icon(Icons.share,color: AppColors.white,)
                         ],
                       ),
                 
                      sizedTextfield,
                      TextWidget(
                            text: "Description",
                            textSize: 15,
                            // fontWeight: FontWeight.w500,
                                                 ),
                                                 sizedTextfield,
                        

                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
TextWidget(text: "Response Time: 1 hour", textSize: 16),
Card(
  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
  color: AppColors.white,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextWidget(text: "Free", textSize: 10,color: AppColors.primary,),
  ),
)
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
          
                        Wrap(
                                spacing: 4.0,
                                runSpacing: 4.0,
                                children: List.generate(
                                    data.length,
                                    (index) {
                                  return InkWell(
                                    onTap: () {
                                      // loginMobileController
                                      //         .userNameController.text =
                                      //     loginMobileController
                                      //         .suggestions[index];
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      color: AppColors.white12,
                                      surfaceTintColor: AppColors.white12,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        child: TextWidget(
                                            text: data[index],
                                            textSize: 14),
                                      ),
                                    ),
                                  );
                                }),
                              ),
          
                      const SizedBox(
                        height: 15,
                      ),
          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppButton.primaryButton(
                                onButtonPressed: (){},
                                title: "View Bookings",
                                
                                ),
                          ),
                          SizedBox(width: 8,),
                          IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: AppColors.white,)),
                          const SizedBox(width: 8),
                          IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: AppColors.white,)),
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
    );
  }
}