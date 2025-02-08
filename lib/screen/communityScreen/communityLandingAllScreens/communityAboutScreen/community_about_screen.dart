import 'package:capitalhub_crm/screen/communityScreen/communityDrawerScreen/community_drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunityAboutScreen extends StatefulWidget {
  const CommunityAboutScreen({super.key});

  @override
  State<CommunityAboutScreen> createState() => _CommunityAboutScreenState();
}

class _CommunityAboutScreenState extends State<CommunityAboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        drawer: const CommunityDrawerWidget(),
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "About",
            hideBack: true,
            autoAction: true,
          ),
          body: Padding(
            padding:EdgeInsets.all(12),
            child:SingleChildScrollView(
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
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      sizedTextfield,
                      Row(children:[
                       
                        CircleAvatar(
                                      backgroundImage: NetworkImage(
                                      "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                                      ),
                                      radius: 25,
                                    //  backgroundColor: AppColors.blue,
                                    ),
                                     SizedBox(width: 12,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        TextWidget(text: "Hustler's Club", textSize: 25,fontWeight: FontWeight.bold,),
                                        TextWidget(text: "By Pramod Badiger", textSize: 16,)
              
                                      ]
                                    )
                      ]),
                      sizedTextfield,
                      Divider(
                                                  thickness: 2,
                                                  color: AppColors.white38,
                                                ),
                                                
                                                TextWidget(text: "Your Membership", textSize: 20,fontWeight: FontWeight.bold,),
                                                SizedBox(height: 8,),
                                                Row(
                        children: [
                          
                          
                          Card(
                            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                            color: AppColors.primary,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                              child: TextWidget(text: "Free", textSize: 16)
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                            color: AppColors.white12,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                              child: TextWidget(text: "Manage", textSize: 16)
                            ),
                          ),
                          
                        ],
                      ),
                      Divider(
                                                  thickness: 2,
                                                  color: AppColors.white38,
                                                ),
                      TextWidget(text: "About", textSize: 20,fontWeight: FontWeight.bold,),
                       SizedBox(height: 8,),
                      TextWidget(text: "An invite only Community of hustlers across India who are building the future. We need more innovators, Entrepreneurs and Investor's under the same roof. To learn, build and scale with like minded crowd.", textSize: 13,maxLine: 3,),
              SizedBox(height: 12,),
              TextWidget(text: "An initiative by CapitalHUB.", textSize: 16,color: AppColors.primary,),
              SizedBox(height: 12,),
              TextWidget(text: "A Networking platform built for startups and angel investors across India 🇮🇳 Join and get your One link now", textSize: 13,maxLine: 2,),
              SizedBox(height: 8,),
              Row(children: [
              Card(
                            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                            color: AppColors.primary,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                              child: Icon(Icons.link,color: AppColors.white,),
                            ),
                          ),
                          SizedBox(width: 4,),
                          TextWidget(text: "https://thecapitalhub.in/signup", textSize: 16,color: AppColors.primary,),
              ],),
              SizedBox(height: 8,),
              TextWidget(text: "Pitch your idea and get a chance to raise funds by joining our free WhatsApp group", textSize: 13,maxLine: 2,),
              SizedBox(height: 8,),
              Row(children: [
              Card(
                            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                            color: AppColors.transparent,
                            child: Padding(
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.mail,color: AppColors.white,size: 35,),
                            ),
                          ),
                          SizedBox(width: 4,),
                          TextWidget(text: "investments@thecapitalhub.in", textSize: 16,color: AppColors.primary,),
              ],),
                ],
              ),
            )
          ),
      ),
    );
  }
}