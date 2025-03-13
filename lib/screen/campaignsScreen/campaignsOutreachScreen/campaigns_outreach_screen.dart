import 'package:capitalhub_crm/screen/campaignsScreen/campaignsOutreachScreen/view_outreach_screen.dart';
import 'package:capitalhub_crm/widget/dilogue/campaignDilogue/delete_campaign_dilogue.dart';
import 'package:capitalhub_crm/widget/dilogue/campaignDilogue/schedule_campaign_dilogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/appcolors/app_colors.dart';
import '../../../widget/textwidget/text_widget.dart';

class CampaignsOutreachScreen extends StatefulWidget {
  const CampaignsOutreachScreen({super.key});

  @override
  State<CampaignsOutreachScreen> createState() =>
      _CampaignsOutreachScreenState();
}

class _CampaignsOutreachScreenState extends State<CampaignsOutreachScreen> {
  List<Map<String, dynamic>> campaigns = [
    {
      "status": "Draft",
      "campaignName": "test (Copy)",
      "emails": true,
      "recipients": "1",
      "openRate": "0%",
      "replyRate": "0%",
    },
    {
      "status": "Active",
      "campaignName": "test (Copy)",
      "emails": true,
      "recipients": "1",
      "openRate": "0%",
      "replyRate": "0%",
    },
    
    {
      "status": "Sent",
      "campaignName": "test (Copy)",
      "emails": true,
      "recipients": "1",
      "openRate": "0%",
      "replyRate": "0%",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const TextWidget(
            text: "Your Email Campaigns",
            textSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: ClipRRect(
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
                        headingRowColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return AppColors.white12;
                          },
                        ),
                        columns: const [
                          DataColumn(
                              label: TextWidget(text: "Status", textSize: 15)),
                          DataColumn(
                              label: SizedBox(
                                  width: 140,
                                  child: TextWidget(
                                      text: "Campaign name",
                                      align: TextAlign.center,
                                      textSize: 15))),
                          DataColumn(
                              label: TextWidget(text: "Emails", textSize: 15)),
                          DataColumn(
                              label:
                                  TextWidget(text: "Recipients", textSize: 15)),
                          DataColumn(
                              label:
                                  TextWidget(text: "Open rate", textSize: 15)),
                          DataColumn(
                              label:
                                  TextWidget(text: "Reply rate", textSize: 15)),
                          DataColumn(
                              label: SizedBox(
                                  width: 194,
                                  child: TextWidget(
                                      text: "Actions",
                                      align: TextAlign.center,
                                      textSize: 15))),
                        ],
                        rows: List.generate(campaigns.length, (index) {
                          final row = campaigns[index];
                          return _buildDataRow(
                            context,
                            row["status"]!,
                            row["campaignName"]!,
                            row["emails"]!,
                            row["recipients"]!,
                            row["openRate"]!,
                            row["replyRate"]!,
                            index,
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
      BuildContext context,
      String status,
      String campaignName,
      bool emails,
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
        DataCell(_buildStatusBadge(status)),
        DataCell(SizedBox(
            width: 140,
            child: TextWidget(
                text: campaignName,
                align: TextAlign.center,
                maxLine: 2,
                textSize: 14))),
        const DataCell(Center(child: Icon(Icons.email, color: Colors.white))),
        DataCell(Center(child: TextWidget(text: recipients, textSize: 14))),
        DataCell(Center(child: TextWidget(text: openRate, textSize: 14))),
        DataCell(Center(child: TextWidget(text: replyRate, textSize: 14))),
        DataCell(_buildActionButtons()),
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
      case "Active":
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

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionIcon(Icons.remove_red_eye, AppColors.blue, () {
          Get.to(() => const ViewOutreachScreen());
        }),
        const SizedBox(width: 6),
        _buildActionIcon(Icons.play_arrow, AppColors.green700, () {}),
        const SizedBox(width: 6),
        _buildActionIcon(Icons.access_time, AppColors.blue, () {
          scheduleCampaignPopup(context, () {});
        }),
        const SizedBox(width: 6),
        _buildActionIcon(Icons.delete, AppColors.redColor, () {
          deleteCampaignPopup(context, () {});
        }),
        const SizedBox(width: 6),
        _buildActionIcon(Icons.copy, AppColors.green700, () {}),
      ],
    );
  }

  Widget _buildActionIcon(IconData icon, Color color, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.2),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}
