import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunityQuestionsScreen extends StatefulWidget {
  const CommunityQuestionsScreen({super.key});

  @override
  State<CommunityQuestionsScreen> createState() => _CommunityQuestionsScreenState();
}

class _CommunityQuestionsScreenState extends State<CommunityQuestionsScreen> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  late final TabController _tabController;
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        appBar: HelperAppBar.appbarHelper(
            title: "Questions",
            hideBack: true,
            autoAction: true,
          ),
        backgroundColor: AppColors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                        padding: EdgeInsets.zero,
                        controller: _tabController,
                        isScrollable: true,
                        dividerHeight: 0,
                        tabAlignment: TabAlignment.start,
                        indicator: BoxDecoration(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelPadding: const EdgeInsets.only(left: 12),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: const [
                          
                          Tab(text: "Unanswered (0)"),
                          Tab(text: "Answered (0)")
                        ],
                        labelColor: GetStoreData.getStore.read('isInvestor') 
                      ? AppColors.primaryInvestor 
                      : AppColors.primary,
                        unselectedLabelColor: AppColors.white,
                        unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16),
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16),
                      ),
                      Expanded(
                    child: TabBarView(controller: _tabController, children: [
                  
                          ListView.builder(
                             
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
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 18,
                                              backgroundImage: AssetImage(
                                                  PngAssetPath.accountImg),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            TextWidget(
                                              text: "Name",
                                              textSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                TextWidget(text: "Asked 12 days ago", textSize: 13),
                                                SizedBox(height: 8,),
                                                TextWidget(text: "Time to answer:Time expired", textSize: 13,color: AppColors.primary,),
                                              ],
                                            )
                                          ],
                                        ),
                                        sizedTextfield,
                                        TextWidget(
                                          text: "Question",
                                          textSize: 16,
                                          maxLine: 2,
                                        ),
                                        sizedTextfield,
                                        MyCustomTextField.textField(hintText: "Type your answer...", controller: urlController,borderClr: AppColors.white12),
                                        sizedTextfield,
                                        AppButton.primaryButton(onButtonPressed: (){}, title: "Submit Answer")

                                       
                                       
                                      ],
                                    ),
                                  ),
                                );
                              },
                            
            
          ),
          ListView.builder(
                             
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
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 18,
                                              backgroundImage: AssetImage(
                                                  PngAssetPath.accountImg),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            TextWidget(
                                              text: "Name",
                                              textSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Spacer(),
                                            TextWidget(text: "Asked 16 days ago", textSize: 13),
                                            
                                          ],
                                        ),
                                        sizedTextfield,
                                        TextWidget(
                                          text: "Question",
                                          textSize: 16,
                                          maxLine: 2,
                                        ),
                                        sizedTextfield,
                                        TextWidget(text: "Answer:", textSize: 16),
                                        
                                        TextWidget(text: "Solution", textSize: 16),

                                       
                                       
                                      ],
                                    ),
                                  ),
                                );
                              },
                            
            
          ),
                    ]
                    )
           ) ]
          )
        ),
                
      ), 
    );
  }
}