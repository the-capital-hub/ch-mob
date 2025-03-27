import 'package:capitalhub_crm/screen/campaignsScreen/campaignsListScreen/create_new_list.dart';
import 'package:capitalhub_crm/screen/campaignsScreen/campaignsListScreen/view_list_Screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/campaignDilogue/delete_campaign_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../../controller/campaignsController/campaigns_controller.dart';
import '../../../utils/helper/placeholder.dart';

class CampaignsListScreen extends StatefulWidget {
  const CampaignsListScreen({super.key});

  @override
  State<CampaignsListScreen> createState() => _CampaignsListScreenState();
}

class _CampaignsListScreenState extends State<CampaignsListScreen> {
  CampaignsController campaignsController = Get.find();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      campaignsController.listIds.clear();
      campaignsController.getCampaignLists();
    });
    super.initState();
  }

  bool isAllChecked = false;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => campaignsController.isLoading.value
          ? ShimmerLoader.buildShimmerTable()
          : Scaffold(
              backgroundColor: AppColors.transparent,
              floatingActionButton: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                onPressed: () {
                  Get.to(CreateNewList(isEdit: false));
                },
                backgroundColor: AppColors.primary,
                child: Icon(Icons.add, color: AppColors.white, size: 25),
              ),
              body: campaignsController.campaignList.isEmpty
                  ? const Center(
                    child: TextWidget(
                        text: "No Data Found",
                        textSize: 15,
                        fontWeight: FontWeight.w500),
                  )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: isAllChecked,
                              onChanged: (value) {
                                setState(() {
                                  isAllChecked = value!;
                                  campaignsController.listIds.clear();

                                  for (var campaignList
                                      in campaignsController.campaignList) {
                                    campaignList.isSelected = isAllChecked;
                                    if (isAllChecked) {
                                      campaignsController.listIds
                                          .add(campaignList.listId!);
                                    }
                                  }
                                });
                              },
                              side:
                                  BorderSide(color: AppColors.grey, width: 1.5),
                              activeColor: AppColors.primary,
                              checkColor: AppColors.white,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                            const TextWidget(
                              text: "Select All",
                              textSize: 12,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: SingleChildScrollView(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 80),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
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
                                              text: "Select", textSize: 15)),
                                      DataColumn(
                                          label: SizedBox(
                                              width: 120,
                                              child: TextWidget(
                                                  text: "List Name",
                                                  align: TextAlign.center,
                                                  textSize: 15))),
                                      DataColumn(
                                          label: TextWidget(
                                              text: "Investors", textSize: 15)),
                                      DataColumn(
                                          label: TextWidget(
                                              text: "VCs", textSize: 15)),
                                      DataColumn(
                                          label: TextWidget(
                                              text: "Created By",
                                              textSize: 15)),
                                      DataColumn(
                                          label: TextWidget(
                                              text: "Sharing", textSize: 15)),
                                      DataColumn(
                                          label: SizedBox(
                                              width: 105,
                                              child: TextWidget(
                                                  text: "Actions",
                                                  align: TextAlign.center,
                                                  textSize: 15))),
                                    ],
                                    rows: List.generate(
                                        campaignsController.campaignList.length,
                                        (index) {
                                      return _buildDataRow(
                                        context,
                                        index,
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              bottomNavigationBar: campaignsController.listIds.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: AppButton.primaryButton(
                        onButtonPressed: () {
                          campaignsController.tabController.animateTo(1);
                        },
                        title:
                            "Proceed (${campaignsController.listIds.length})",
                      ),
                    )
                  : const SizedBox(),
            ),
    );
  }

  DataRow _buildDataRow(BuildContext context, int index) {
    return DataRow(
      color: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return index.isEven ? AppColors.transparent : AppColors.white12;
        },
      ),
      cells: [
        DataCell(
          Checkbox(
              value: campaignsController.campaignList[index].isSelected,
              side: BorderSide(color: AppColors.grey, width: 1.5),
              activeColor: AppColors.primary,
              checkColor: AppColors.white,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              onChanged: (value) {
                setState(() {
                  campaignsController.campaignList[index].isSelected = value!;
                  if (value) {
                    campaignsController.listIds
                        .add(campaignsController.campaignList[index].listId!);
                  } else {
                    campaignsController.listIds.remove(
                        campaignsController.campaignList[index].listId!);
                  }
                  isAllChecked = campaignsController.listIds.length ==
                      campaignsController.campaignList.length;
                });
              }),
        ),
        DataCell(SizedBox(
            width: 120,
            child: TextWidget(
                text: campaignsController.campaignList[index].listName!,
                align: TextAlign.center,
                maxLine: 2,
                textSize: 14))),
        DataCell(Center(
            child: TextWidget(
                text: campaignsController.campaignList[index].peopleCount!,
                textSize: 14))),
        DataCell(Center(
            child: TextWidget(
                text: campaignsController.campaignList[index].vcCount ?? "0",
                textSize: 14))),
        DataCell(Center(
            child: TextWidget(
                text: campaignsController.campaignList[index].createdBy!,
                textSize: 14))),
        DataCell(Center(
            child: TextWidget(
                text: campaignsController.campaignList[index].sharing!.isEmpty
                    ? "NA"
                    : campaignsController.campaignList[index].sharing!
                        .toString(),
                textSize: 14))),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildActionIcon(
                  context, Icons.remove_red_eye, AppColors.blue, "View", index),
              if (campaignsController.campaignList[index].isMyList!)
                const SizedBox(width: 8),
              if (campaignsController.campaignList[index].isMyList!)
                _buildActionIcon(
                    context, Icons.edit, Colors.brown, "Edit", index),
              if (campaignsController.campaignList[index].isMyList!)
                const SizedBox(width: 8),
              if (campaignsController.campaignList[index].isMyList!)
                _buildActionIcon(
                    context, Icons.delete, AppColors.redColor, "Delete", index),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionIcon(BuildContext context, IconData icon, Color color,
      String action, int index) {
    return GestureDetector(
      onTap: () {
        _handleActionTap(context, action, index);
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.2),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }

  void _handleActionTap(BuildContext context, String action, int index) {
    if (action == "View") {
      Get.to(
          ViewListScreen(id: campaignsController.campaignList[index].listId!));
    } else if (action == "Edit") {
      Get.to(CreateNewList(
        isEdit: true,
        index: index,
      ));
    } else {
      deleteCampaignPopup(context, () {
        Helper.loader(context);
        campaignsController
            .deleteList(listId: campaignsController.campaignList[index].listId)
            .then((val) {
          if (val) {
            campaignsController.campaignList.removeAt(index);
            setState(() {});
          }
        });
      });
    }
  }
}
