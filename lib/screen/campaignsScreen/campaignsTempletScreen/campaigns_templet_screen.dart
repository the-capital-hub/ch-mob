import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/campaignDilogue/delete_campaign_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../campaignsOutreachScreen/create_campaigns_screen.dart';
import 'create_new_template.dart';

class CampaignsTempletScreen extends StatefulWidget {
  const CampaignsTempletScreen({super.key});

  @override
  _CampaignsTempletScreenState createState() => _CampaignsTempletScreenState();
}

class _CampaignsTempletScreenState extends State<CampaignsTempletScreen> {
  int? selectedTemp;

  void toggleSelection(int index) {
    setState(() {
      selectedTemp = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () {
            Get.to(const CreateNewTemplate());
          },
          backgroundColor: AppColors.primary,
          child: Icon(Icons.add, color: AppColors.white, size: 25),
        ),
        backgroundColor: AppColors.transparent,
        body: Column(
          children: [
            sizedTextfield,
            Expanded(
              child: ListView.separated(
                itemCount: 8,
                padding: const EdgeInsets.only(bottom: 80),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final isSelected = selectedTemp==index;

                  return InkWell(
                    onTap: () => toggleSelection(index),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(
                              text: "CH", textSize: 14, maxLine: 2),
                          const SizedBox(height: 2),
                          const TextWidget(
                              text: "Subject: Ch sub", textSize: 13),
                          const SizedBox(height: 2),
                          const TextWidget(
                              text: "Created by: You", textSize: 12),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.grey700,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: TextWidget(
                                  text: isSelected ? 'Selected' : 'Select',
                                  textSize: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  _buildActionIcon(context, Icons.edit,
                                      AppColors.primary, "Edit"),
                                  const SizedBox(width: 8),
                                  _buildActionIcon(context, Icons.delete,
                                      AppColors.redColor, "Delete"),
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
        bottomNavigationBar: selectedTemp!=null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      Get.to(() => const CreateCampaignsScreen());
                    },
                    title: "Proceed with Template"),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildActionIcon(
      BuildContext context, IconData icon, Color color, String action) {
    return GestureDetector(
      onTap: () {
        _handleActionTap(context, action);
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

  void _handleActionTap(BuildContext context, String action) {
    if (action == "Edit") {
      Get.to(() => const CreateNewTemplate());
    } else if (action == "Delete") {
      deleteCampaignPopup(context, () {});
    }
  }
}
