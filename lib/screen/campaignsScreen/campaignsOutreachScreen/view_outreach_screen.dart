// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class ViewOutreachScreen extends StatefulWidget {
  const ViewOutreachScreen({super.key});

  @override
  State<ViewOutreachScreen> createState() => _ViewOutreachScreenState();
}

class _ViewOutreachScreenState extends State<ViewOutreachScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Test 117"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              TextWidget(
                  text: "Created: 3/11/2025, 11:42:48 AM",
                  color: AppColors.whiteShade,
                  align: TextAlign.right,
                  textSize: 14),
              sizedTextfield,
              Row(
                children: [
                  Expanded(
                      child: AppButton.primaryButton(
                          borderRadius: 8,
                          bgColor: AppColors.blue,
                          onButtonPressed: () {},
                          title: "Schedule")),
                  SizedBox(width: 12),
                  Expanded(
                      child: AppButton.primaryButton(
                          borderRadius: 8,
                          bgColor: AppColors.green700,
                          onButtonPressed: () {},
                          title: "Send Now")),
                ],
              ),
              sizedTextfield,
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white12),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  indicatorPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.white,
                  dividerColor: AppColors.transparent,
                  dividerHeight: 0,
                  unselectedLabelColor: AppColors.whiteShade,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                  tabs: const [
                    Tab(text: "Overview"),
                    Tab(text: "Recipients"),
                    Tab(text: "Content"),
                  ],
                ),
              ),
              sizedTextfield,
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [overview(), recipients(), content()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> items = [
    {"title": "Sent", "icon": Icons.mail, "color": Colors.blue},
    {"title": "Opened", "icon": Icons.remove_red_eye, "color": Colors.green},
    {"title": "Clicked", "icon": Icons.mouse, "color": Colors.amber},
    {"title": "Replied", "icon": Icons.reply, "color": Colors.purple},
    {"title": "Bounced", "icon": Icons.error, "color": Colors.red},
    {
      "title": "Failed",
      "icon": Icons.cancel,
      "color": Colors.grey
    }, // Extra item
  ];
  Widget _buildGridItem(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blackCard,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: CircleAvatar(
              backgroundColor: item["color"],
              radius: 23,
              child: Icon(item["icon"], color: Colors.white, size: 26),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextWidget(textSize: 14, text: item["title"]),
                const SizedBox(height: 6),
                TextWidget(textSize: 14, text: "0"),
                const SizedBox(height: 4),
                TextWidget(textSize: 14, text: "0 %"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  overview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: 1.6,
          children: items.map((item) => _buildGridItem(item)).toList(),
        ),
        sizedTextfield,
        TextWidget(
            text: "Investor Lists", textSize: 16, fontWeight: FontWeight.w500),
        sizedTextfield,
        SizedBox(
          height: 55,
          child: ListView.separated(
            itemCount: 5,
            separatorBuilder: (context, index) => SizedBox(width: 12),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 150,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: AppColors.blackCard,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: TextWidget(
                    text: "text",
                    maxLine: 2,
                    align: TextAlign.left,
                    textSize: 14),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> campaigns = [
    {
      "investor": "Meet inv",
      "emails": "dhairya.jan9@gmail.com",
      "status": "Pending",
      "opened": "No",
      "clicked": "No",
      "replied": "No",
    },
    {
      "investor": "Meet inv",
      "emails": "dhairya.jan9@gmail.com",
      "status": "Pending",
      "opened": "No",
      "clicked": "No",
      "replied": "No",
    },
    {
      "investor": "Meet inv",
      "emails": "dhairya.jan9@gmail.com",
      "status": "Sent",
      "opened": "No",
      "clicked": "No",
      "replied": "No",
    },
  ];
  recipients() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 25,
          headingRowHeight: 50,
          dataRowHeight: 45,
          dividerThickness: 0.4,
          horizontalMargin: 20,
          border: TableBorder.all(
              color: AppColors.white38,
              width: 1,
              borderRadius: BorderRadius.circular(12)),
          headingRowColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return AppColors.white12;
            },
          ),
          columns: const [
            DataColumn(
                label: SizedBox(
                    width: 140,
                    child: TextWidget(
                        text: "Investor",
                        align: TextAlign.center,
                        textSize: 15))),
            DataColumn(
                label: SizedBox(
                    width: 165,
                    child: TextWidget(
                        text: "Email", align: TextAlign.center, textSize: 15))),
            DataColumn(
                label: SizedBox(
                    width: 80,
                    child: TextWidget(
                        text: "Status",
                        align: TextAlign.center,
                        textSize: 15))),
            DataColumn(label: TextWidget(text: "Opened", textSize: 15)),
            DataColumn(label: TextWidget(text: "Clicked", textSize: 15)),
            DataColumn(label: TextWidget(text: "Replied", textSize: 15)),
          ],
          rows: List.generate(campaigns.length, (index) {
            final row = campaigns[index];
            return _buildDataRow(
              context,
              row["investor"]!,
              row["emails"]!,
              row["status"]!,
              row["opened"]!,
              row["clicked"]!,
              row["replied"]!,
              index,
            );
          }),
        ),
      ),
    );
  }

  DataRow _buildDataRow(
      BuildContext context,
      String campaignName,
      String emails,
      String status,
      String recipients,
      String openRate,
      String replyRate,
      int index) {
    return DataRow(
      color: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return index.isEven ? AppColors.transparent : AppColors.white12;
        },
      ),
      cells: [
        DataCell(SizedBox(
            width: 140,
            child: TextWidget(
                text: campaignName,
                align: TextAlign.center,
                maxLine: 2,
                textSize: 14))),
        DataCell(SizedBox(
            width: 165,
            child: TextWidget(
                text: emails,
                align: TextAlign.center,
                maxLine: 2,
                textSize: 14))),
        DataCell(_buildStatusBadge(status)),
        DataCell(Center(child: TextWidget(text: recipients, textSize: 14))),
        DataCell(Center(child: TextWidget(text: openRate, textSize: 14))),
        DataCell(Center(child: TextWidget(text: replyRate, textSize: 14))),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color badgeColor;
    Color textColor;

    switch (status) {
      case "Draft":
        badgeColor = Colors.brown;
        textColor = AppColors.white;
        break;
      case "Sent":
        badgeColor = AppColors.green700;
        textColor = AppColors.white;
        break;
      default:
        badgeColor = AppColors.grey700;
        textColor = AppColors.white;
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        decoration: BoxDecoration(
          color: badgeColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: TextWidget(
          text: status,
          color: textColor,
          textSize: 14,
        ),
      ),
    );
  }

  content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedTextfield,
        Card(
          color: AppColors.blackCard,
          surfaceTintColor: AppColors.blackCard,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: "Subject", textSize: 14),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        text: "Test sbhsbhsdb",
                        textSize: 16,
                        maxLine: 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        sizedTextfield,
        Card(
          color: AppColors.blackCard,
          surfaceTintColor: AppColors.blackCard,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: "Body", textSize: 14),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        text: "Just Checking",
                        textSize: 16,
                        maxLine: 100,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
