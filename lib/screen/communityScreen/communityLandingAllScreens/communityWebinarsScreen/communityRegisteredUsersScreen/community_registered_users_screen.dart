import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunityRegisteredUsersScreen extends StatefulWidget {
  const CommunityRegisteredUsersScreen({super.key});

  @override
  State<CommunityRegisteredUsersScreen> createState() => _CommunityRegisteredUsersScreenState();
}

class _CommunityRegisteredUsersScreenState extends State<CommunityRegisteredUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Registered Users",
          hideBack: true,
          autoAction: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            // Get first letter
          
            return Card(
              color: AppColors.blackCard,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(backgroundColor: AppColors.primary,child: TextWidget(text: "D", textSize: 16)),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      TextWidget(text: "Dhairya Jain", textSize: 16,fontWeight: FontWeight.bold,),
                      sizedTextfield,
                      Row(children: [
                        Icon(Icons.mail,color: AppColors.primary,),
                        SizedBox(width: 8),
                        TextWidget(text: "dhairya.jan9@gmail.com", textSize: 16),
                      ],),
                          sizedTextfield,
                          Row(children: [
                        Icon(Icons.phone,color: AppColors.primary,),
                        SizedBox(width: 8),
                        TextWidget(text: "9810169977", textSize: 16),
                      ],),
                     
                    ],),
                    
                  ],
                ),
              ),
            );
          },
                ),
        ),
    )
      );
    
  }
}