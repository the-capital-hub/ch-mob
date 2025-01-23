import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class PriorityDMScreen extends StatefulWidget {
  const PriorityDMScreen({super.key});

  @override
  State<PriorityDMScreen> createState() => _PriorityDMScreenState();
}

class _PriorityDMScreenState extends State<PriorityDMScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  late final TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        drawer: const DrawerWidget(),
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Priority DM",
          hideBack: true,
          autoAction: true,
        ),
        body: Column(
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
                Tab(text: "My Questions"),
                Tab(text: "Unanswered"),
                Tab(text: "Answered")
              ],
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.white,
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            Expanded(
                child: TabBarView(controller: _tabController, children: [
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: 2,
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
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage:
                                    AssetImage(PngAssetPath.accountImg),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: "Suresh Kumar",
                                textSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              TextWidget(
                                text: "4.5/5",
                                textSize: 16,
                              )
                            ],
                          ),
                          sizedTextfield,
                          const TextWidget(
                            text:
                                "What is Generative AI and how is it used in various industries?",
                            textSize: 16,
                            maxLine: 2,
                          ),
                          sizedTextfield,
                          TextWidget(
                            text:
                                "Thank you for your question! When the founder answers your query, we will notify you via email.",
                            textSize: 16,
                            maxLine: 3,
                            color: AppColors.white54,
                          ),
                          sizedTextfield,
                          TextWidget(
                            text: "Unanswered",
                            textSize: 16,
                            maxLine: 3,
                            color: AppColors.white54,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: 2,
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
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage:
                                    AssetImage(PngAssetPath.accountImg),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: "Suresh Kumar",
                                textSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              TextWidget(
                                text: "4.5/5",
                                textSize: 16,
                              )
                            ],
                          ),
                          sizedTextfield,
                          const TextWidget(
                            text:
                                "What is Generative AI and how is it used in various industries?",
                            textSize: 16,
                            maxLine: 2,
                          ),
                          sizedTextfield,
                          TextWidget(
                            text:
                                "Thank you for your question! When the founder answers your query, we will notify you via email.",
                            textSize: 16,
                            maxLine: 3,
                            color: AppColors.white54,
                          ),
                          sizedTextfield,
                          TextWidget(
                            text: "Unanswered",
                            textSize: 16,
                            maxLine: 3,
                            color: AppColors.white54,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: 2,
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
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage:
                                    AssetImage(PngAssetPath.accountImg),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: "Suresh Kumar",
                                textSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              TextWidget(
                                text: "4.5/5",
                                textSize: 16,
                              )
                            ],
                          ),
                          sizedTextfield,
                          const TextWidget(
                            text:
                                "What is Generative AI and how is it used in various industries?",
                            textSize: 16,
                            maxLine: 2,
                          ),
                          sizedTextfield,
                          TextWidget(
                            text:
                                "Thank you for your question! When the founder answers your query, we will notify you via email.",
                            textSize: 16,
                            maxLine: 3,
                            color: AppColors.white54,
                          ),
                          sizedTextfield,
                          const TextWidget(
                            text: "Answered",
                            textSize: 16,
                            maxLine: 3,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ])),
          ],
        ),
      ),
    );
  }
}