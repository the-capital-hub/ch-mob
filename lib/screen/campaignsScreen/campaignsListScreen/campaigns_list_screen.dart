import 'package:capitalhub_crm/screen/campaignsScreen/campaignsListScreen/create_new_list.dart';
import 'package:capitalhub_crm/screen/campaignsScreen/campaignsListScreen/view_list_Screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/dilogue/campaignDilogue/delete_campaign_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/campaignsController/campaigns_controller.dart';

class CampaignsListScreen extends StatefulWidget {
  const CampaignsListScreen({super.key});

  @override
  State<CampaignsListScreen> createState() => _CampaignsListScreenState();
}

class _CampaignsListScreenState extends State<CampaignsListScreen> {
  CampaignsController campaignsController = Get.find();
  final List<Map<String, String>> _data = [
    {
      "listName": "test",
      "investors": "1",
      "createdBy": "You",
      "sharing": "Public"
    },
    {
      "listName": "demo",
      "investors": "5",
      "createdBy": "Admin",
      "sharing": "Private"
    },
    {
      "listName": "demo",
      "investors": "5",
      "createdBy": "Admin",
      "sharing": "Private"
    },
    {
      "listName": "demo",
      "investors": "5",
      "createdBy": "Admin",
      "sharing": "Private"
    },
    {
      "listName": "test demo",
      "investors": "1",
      "createdBy": "You",
      "sharing": "Public"
    },
    {
      "listName": "demo",
      "investors": "5",
      "createdBy": "Admin",
      "sharing": "Private"
    },
    {
      "listName": "demo",
      "investors": "5",
      "createdBy": "Admin",
      "sharing": "Private"
    },
    {
      "listName": "demo",
      "investors": "5",
      "createdBy": "Admin",
      "sharing": "Private"
    },
    {
      "listName": "demo",
      "investors": "5",
      "createdBy": "Admin",
      "sharing": "Private"
    },
    {
      "listName": "demo",
      "investors": "5",
      "createdBy": "Admin",
      "sharing": "Private"
    },
    {
      "listName": "demo",
      "investors": "5",
      "createdBy": "Admin",
      "sharing": "Private"
    },
  ];
  bool isAllChecked = false;
  List<String> listIds = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          Get.to(const CreateNewList());
        },
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: AppColors.white, size: 25),
      ),
      body: Column(
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
                    listIds.clear();

                    // for (var investor
                    //     in exploreController.investorExploreList) {
                    //   investor.isChecked = isAllChecked;
                    //   if (isAllChecked) {
                    //     selectedInvestorIds.add(investor.investorId!);
                    //   }
                    // }
                  });
                },
                side: BorderSide(color: AppColors.grey, width: 1.5),
                activeColor: AppColors.primary,
                checkColor: AppColors.white,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              const TextWidget(
                text: "Select All",
                textSize: 12,
              ),
              Spacer(),
              // if (listIds.isNotEmpty)
              InkWell(
                onTap: () {
                  campaignsController.tabController.animateTo(1);
                },
                child: TextWidget(
                    text: "Proceed (${listIds.length})",
                    textSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary),
              )
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
                          borderRadius: BorderRadius.circular(12)),
                      headingRowColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return AppColors.white12;
                        },
                      ),
                      columns: const [
                        DataColumn(
                            label: TextWidget(text: "Select", textSize: 15)),
                        DataColumn(
                            label: SizedBox(
                                width: 120,
                                child: TextWidget(
                                    text: "List Name",
                                    align: TextAlign.center,
                                    textSize: 15))),
                        DataColumn(
                            label: TextWidget(text: "Investors", textSize: 15)),
                        DataColumn(
                            label:
                                TextWidget(text: "Created By", textSize: 15)),
                        DataColumn(
                            label: TextWidget(text: "Sharing", textSize: 15)),
                        DataColumn(
                            label: SizedBox(
                                width: 110,
                                child: TextWidget(
                                    text: "Actions",
                                    align: TextAlign.center,
                                    textSize: 15))),
                      ],
                      rows: List.generate(_data.length, (index) {
                        final row = _data[index];
                        return _buildDataRow(
                          context,
                          row["listName"]!,
                          row["investors"]!,
                          row["createdBy"]!,
                          row["sharing"]!,
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
    );
  }

  DataRow _buildDataRow(BuildContext context, String listName, String investors,
      String createdBy, String sharing, int index) {
    return DataRow(
      color: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return index.isEven ? AppColors.transparent : AppColors.white12;
        },
      ),
      cells: [
        DataCell(
          Checkbox(
              value: false,
              side: BorderSide(color: AppColors.grey, width: 1.5),
              activeColor: AppColors.primary,
              checkColor: AppColors.white,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              onChanged: (val) {}),
        ),
        DataCell(SizedBox(
            width: 120,
            child: TextWidget(
                text: listName,
                align: TextAlign.center,
                maxLine: 2,
                textSize: 14))),
        DataCell(Center(child: TextWidget(text: investors, textSize: 14))),
        DataCell(Center(child: TextWidget(text: createdBy, textSize: 14))),
        DataCell(Center(child: TextWidget(text: sharing, textSize: 14))),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionIcon(context, Icons.remove_red_eye, AppColors.blue,
                  "View", listName),
              const SizedBox(width: 8),
              _buildActionIcon(
                  context, Icons.edit, Colors.brown, "Edit", listName),
              const SizedBox(width: 8),
              _buildActionIcon(context, Icons.delete, AppColors.redColor,
                  "Delete", listName),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionIcon(BuildContext context, IconData icon, Color color,
      String action, String listName) {
    return GestureDetector(
      onTap: () {
        _handleActionTap(context, action, listName);
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

  void _handleActionTap(BuildContext context, String action, String listName) {
    if (action == "View") {
      Get.to(const ViewListScreen());
    } else if (action == "Edit") {
      Get.to(const CreateNewList());
    } else {
      deleteCampaignPopup(context, () {});
    }
  }
}
