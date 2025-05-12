import 'package:capitalhub_crm/controller/campaignsController/campaigns_controller.dart';
import 'package:capitalhub_crm/screen/campaignsScreen/campaignsOutreachScreen/view_outreach_screen.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/dilogue/campaignDilogue/delete_campaign_dilogue.dart';
import 'package:capitalhub_crm/widget/dilogue/campaignDilogue/schedule_campaign_dilogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/campaignModel/outreach_list_model.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/helper/placeholder.dart';
import '../../../widget/textwidget/text_widget.dart';

class CampaignsOutreachScreen extends StatefulWidget {
  const CampaignsOutreachScreen({
    super.key,
  });

  @override
  State<CampaignsOutreachScreen> createState() =>
      _CampaignsOutreachScreenState();
}

class _CampaignsOutreachScreenState extends State<CampaignsOutreachScreen> {
  CampaignsController campaignsController = Get.find();

  @override
  void initState() {
    campaignsController.getOutrechList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent, // Dark background
      body: Obx(
        () => campaignsController.isOutreachLoading.value
            ? ShimmerLoader.buildShimmerTable()
            : campaignsController.outreachList.isEmpty
                ? const Center(
                    child: TextWidget(
                        text: "No Data Found",
                        textSize: 15,
                        fontWeight: FontWeight.w500),
                  )
                : Column(
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
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    headingRowColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        return AppColors.white12;
                                      },
                                    ),
                                    columns: const [
                                      DataColumn(
                                          label: TextWidget(
                                              text: "Status", textSize: 15)),
                                      DataColumn(
                                          label: SizedBox(
                                              width: 140,
                                              child: TextWidget(
                                                  text: "Campaign name",
                                                  align: TextAlign.center,
                                                  textSize: 15))),
                                      DataColumn(
                                          label: TextWidget(
                                              text: "Emails", textSize: 15)),
                                      DataColumn(
                                          label: TextWidget(
                                              text: "Recipients",
                                              textSize: 15)),
                                      DataColumn(
                                          label: TextWidget(
                                              text: "Open rate", textSize: 15)),
                                      DataColumn(
                                          label: TextWidget(
                                              text: "Reply rate",
                                              textSize: 15)),
                                      DataColumn(
                                          label: SizedBox(
                                              width: 194,
                                              child: TextWidget(
                                                  text: "Actions",
                                                  align: TextAlign.center,
                                                  textSize: 15))),
                                    ],
                                    rows: List.generate(
                                        campaignsController.outreachList.length,
                                        (index) {
                                      return _buildDataRow(
                                        context,
                                        index,
                                        campaignsController.outreachList[index],
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
      ),
    );
  }

  DataRow _buildDataRow(
      BuildContext context, int index, OutreachData outreachData) {
    return DataRow(
      color: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return index.isEven ? AppColors.transparent : AppColors.white12;
        },
      ),
      cells: [
        DataCell(_buildStatusBadge(outreachData.status!)),
        DataCell(SizedBox(
            width: 140,
            child: TextWidget(
                text: outreachData.campaignName!,
                align: TextAlign.center,
                maxLine: 2,
                textSize: 14))),
        const DataCell(Center(child: Icon(Icons.email, color: Colors.white))),
        DataCell(Center(
            child: TextWidget(text: outreachData.recipients!, textSize: 14))),
        DataCell(Center(
            child: TextWidget(text: outreachData.openRate!, textSize: 14))),
        DataCell(Center(
            child: TextWidget(text: outreachData.replyRate!, textSize: 14))),
        DataCell(_buildActionButtons(outreachData)),
      ],
    );
  }

  Widget _buildStatusBadge(CurrentStatus status) {
    Color badgeColor;
    Color textColor;

    switch (status) {
      case CurrentStatus.draft:
        badgeColor = Colors.brown;
        textColor = Colors.white;
        break;
      case CurrentStatus.completed:
        badgeColor = AppColors.green700;
        textColor = Colors.white;
        break;
      case CurrentStatus.scheduled:
        badgeColor = AppColors.blue;
        textColor = Colors.white;
        break;
      case CurrentStatus.cancelled:
        badgeColor = AppColors.redColor;
        textColor = Colors.white;
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
          text: status.toFormattedString(),
          color: textColor,
          textSize: 14,
        ),
      ),
    );
  }

  Widget _buildActionButtons(OutreachData outreachData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildActionIcon(Icons.remove_red_eye, AppColors.blue, () {
          Get.to(() => ViewOutreachScreen(id: outreachData.campaignId!))!
              .whenComplete(() {
            setState(() {});
          });
        }),
        const SizedBox(width: 6),
        if (outreachData.status == CurrentStatus.draft ||
            outreachData.status == CurrentStatus.scheduled)
          _buildActionIcon(Icons.play_arrow, AppColors.green700, () {
            Helper.loader(context);
            campaignsController
                .runOutreachCampaign(outreachData.campaignId!, false)
                .then((v) {
              setState(() {});
            });
          }),
        if (outreachData.status == CurrentStatus.draft ||
            outreachData.status == CurrentStatus.scheduled)
          const SizedBox(width: 6),
        if (outreachData.status == CurrentStatus.scheduled)
          _buildActionIcon(Icons.close, AppColors.redColor, () {
            Helper.loader(context);
            campaignsController
                .scheduleOutreachCampaign(
                    isCancel: true,
                    id: outreachData.campaignId!,
                    fromViewScreen: false)
                .then((v) {
              setState(() {});
            });
          }),
        if (outreachData.status == CurrentStatus.scheduled)
          const SizedBox(width: 6),
        if (outreachData.status == CurrentStatus.draft)
          _buildActionIcon(Icons.access_time, AppColors.blue, () {
            scheduleCampaignPopup(context, () {
              Helper.loader(context);
              campaignsController
                  .scheduleOutreachCampaign(
                      isCancel: false,
                      id: outreachData.campaignId!,
                      fromViewScreen: false)
                  .then((v) {
                setState(() {});
              });
            });
          }),
        if (outreachData.status == CurrentStatus.draft)
          const SizedBox(width: 6),
        _buildActionIcon(Icons.delete, AppColors.redColor, () {
          deleteCampaignPopup(context, () {
            Helper.loader(context);
            campaignsController
                .deleteOutreachCampaign(id: outreachData.campaignId)
                .then((v) {
              setState(() {});
            });
          });
        }),
        const SizedBox(width: 6),
        _buildActionIcon(Icons.copy, AppColors.green700, () {
          Helper.loader(context);
          campaignsController
              .duplicateOutreachCampaign(outreachData.campaignId!)
              .then((v) {
            setState(() {});
          });
        }),
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
