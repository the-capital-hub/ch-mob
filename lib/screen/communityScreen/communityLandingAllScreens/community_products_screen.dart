import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/community_drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunityProductsScreen extends StatefulWidget {
  const CommunityProductsScreen({super.key});

  @override
  State<CommunityProductsScreen> createState() => _CommunityProductsScreenState();
}

class _CommunityProductsScreenState extends State<CommunityProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        drawer: const CommunityDrawerWidget(),
        appBar: HelperAppBar.appbarHelper(
          title: "Products",
          hideBack: true,
          autoAction: true,
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 12,
                      );},
          
          padding: const EdgeInsets.all(12),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
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
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    sizedTextfield,
                    Row(
                      children: [
                        
                        Card(
                          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
                          color: AppColors.primary,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                            child: Icon(Icons.description,color: AppColors.white,),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
                          color: AppColors.primary,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                            child: TextWidget(text: "Paid", textSize: 16)
                          ),
                        ),
                        
                      ],
                    ),
                    
                     const TextWidget(
                          text:
                              "What is Generative AI and how is it used in various industries?",
                          textSize: 18,
                          maxLine: 2,
                          fontWeight: FontWeight.bold,
                        ),
                        sizedTextfield,
                        TextWidget(
                          text:
                              "Thank you for your question! When the founder answers your query, we will notify you via email.",
                          textSize: 16,
                          maxLine: 3,
                          
                        ),
        
                  
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