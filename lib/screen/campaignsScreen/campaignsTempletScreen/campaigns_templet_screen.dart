import 'package:capitalhub_crm/controller/campaignsController/campaigns_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/placeholder.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/campaignDilogue/delete_campaign_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helper/helper.dart';
import '../campaignsOutreachScreen/create_campaigns_screen.dart';
import 'create_new_template.dart';

class CampaignsTempletScreen extends StatefulWidget {
  const CampaignsTempletScreen({super.key});

  @override
  _CampaignsTempletScreenState createState() => _CampaignsTempletScreenState();
}

class _CampaignsTempletScreenState extends State<CampaignsTempletScreen> {
  String? selectedTemp;
  CampaignsController campaignsController = Get.find();
  void toggleSelection(String templateId) {
    setState(() {
      selectedTemp = templateId;
    });
  }

  @override
  void initState() {
    campaignsController.getTemplateView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => campaignsController.isTemplateLoading.value
          ? ShimmerLoader.shimmerTile()
          : Scaffold(
              floatingActionButton: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                onPressed: () {
                  Get.to(CreateNewTemplate(isEdit: false));
                },
                backgroundColor: AppColors.primary,
                child: Icon(Icons.add, color: AppColors.white, size: 25),
              ),
              backgroundColor: AppColors.transparent,
              body: campaignsController.templateList.isEmpty
                  ? const Center(
                      child: TextWidget(
                          text: "No Data Found",
                          textSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  : Column(
                      children: [
                        sizedTextfield,
                        Expanded(
                          child: ListView.separated(
                            itemCount: campaignsController.templateList.length,
                            padding: const EdgeInsets.only(bottom: 80),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final isSelected = selectedTemp ==
                                  campaignsController
                                      .templateList[index].templateId!;
                              return InkWell(
                                onTap: () => toggleSelection(campaignsController
                                    .templateList[index].templateId!),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[850],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                          text: campaignsController
                                              .templateList[index]
                                              .templateName!,
                                          textSize: 14,
                                          maxLine: 2),
                                      const SizedBox(height: 2),
                                      TextWidget(
                                        text:
                                            "Subject: ${campaignsController.templateList[index].templateSubject!}",
                                        textSize: 13,
                                        maxLine: 2,
                                      ),
                                      const SizedBox(height: 2),
                                      TextWidget(
                                          text:
                                              "Created by: ${campaignsController.templateList[index].createdBy!}",
                                          textSize: 12),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppColors.primary
                                                  : AppColors.grey700,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: TextWidget(
                                              text: isSelected
                                                  ? 'Selected'
                                                  : 'Select',
                                              textSize: 12,
                                            ),
                                          ),
                                          if (campaignsController
                                                  .templateList[index]
                                                  .createdBy ==
                                              "You")
                                            Row(
                                              children: [
                                                _buildActionIcon(
                                                    context,
                                                    Icons.edit,
                                                    AppColors.primary,
                                                    "Edit",
                                                    index),
                                                const SizedBox(width: 8),
                                                _buildActionIcon(
                                                    context,
                                                    Icons.delete,
                                                    AppColors.redColor,
                                                    "Delete",
                                                    index),
                                              ],
                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
              bottomNavigationBar: selectedTemp != null
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: AppButton.primaryButton(
                          onButtonPressed: () {
                            if (campaignsController.listIds.isNotEmpty) {
                              Helper.loader(context);
                              campaignsController
                                  .proceedWithTemplate(selectedTemp!)
                                  .then((val) {
                                if (val) {
                                  Get.to(() => CreateCampaignsScreen(
                                      templateId: selectedTemp!));
                                }
                              });
                            } else {
                              campaignsController.tabController.animateTo(0);
                            }
                          },
                          title: "Proceed with Template"),
                    )
                  : const SizedBox.shrink(),
            ),
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
    if (action == "Edit") {
      Get.to(() => CreateNewTemplate(
            isEdit: true,
            index: index,
          ));
    } else if (action == "Delete") {
      deleteCampaignPopup(context, () {
        Helper.loader(context);
        campaignsController
            .deleteTemplet(
                id: campaignsController.templateList[index].templateId!)
            .then((val) {
          if (val) {
            campaignsController.templateList.removeAt(index);
            setState(() {});
          }
        });
      });
    }
  }
}
