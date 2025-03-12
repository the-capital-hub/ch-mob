import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunityYourQuestionsScreen extends StatefulWidget {
  const CommunityYourQuestionsScreen({super.key});

  @override
  State<CommunityYourQuestionsScreen> createState() => _CommunityYourQuestionsScreenState();
}

class _CommunityYourQuestionsScreenState extends State<CommunityYourQuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
            title: "Your Questions",
            hideBack: true,
            autoAction: true,
          ),
          body: ListView.builder(
                             
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: AppColors.blackCard,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: "Question: That",
                                          textSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        sizedTextfield,
                                        TextWidget(text: "Time left:Time expired", textSize: 16,color: AppColors.primary,),
                                        sizedTextfield,
                                        TextWidget(text: "Asked 2 days ago", textSize: 13),
                                        
                                        sizedTextfield
                                        
                                        
                                       
                                       
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