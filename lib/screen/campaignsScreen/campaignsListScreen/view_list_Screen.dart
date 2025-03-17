import 'package:capitalhub_crm/controller/campaignsController/campaigns_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewListScreen extends StatefulWidget {
  String id;
  ViewListScreen({super.key, required this.id});

  @override
  _ViewListScreenState createState() => _ViewListScreenState();
}

class _ViewListScreenState extends State<ViewListScreen> {
  CampaignsController campaignsController = Get.find();

  List<String> selectedIndices = [];

  void toggleSelection(String id) {
    setState(() {
      if (selectedIndices.contains(id)) {
        selectedIndices.remove(id);
      } else {
        selectedIndices.add(id);
      }
    });
  }

  @override
  void initState() {
    campaignsController.getCampaignView(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Obx(
        () => campaignsController.isListViewLoading.value
            ? Helper.pageLoading()
            : Scaffold(
                backgroundColor: AppColors.transparent,
                appBar: HelperAppBar.appbarHelper(
                    title: "${campaignsController.viewCampaignData.listName}"),
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                              text:
                                  "${campaignsController.viewCampaignData.peopleCount} Investor",
                              textSize: 14),
                          TextWidget(
                              text:
                                  "Created by ${campaignsController.viewCampaignData.createdBy}",
                              textSize: 14),
                        ],
                      ),
                      sizedTextfield,
                      Expanded(
                        child: ListView.separated(
                          itemCount: campaignsController
                              .viewCampaignData.investors!.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final investor = campaignsController
                                .viewCampaignData.investors![index];
                            final isSelected =
                                selectedIndices.contains(investor.investorId);

                            return Container(
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
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        investor.investorProfilePicture!),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                            text: investor.investorName!,
                                            textSize: 14,
                                            maxLine: 2),
                                        TextWidget(
                                            text:
                                                "Investor (${investor.investorCompany!})",
                                            textSize: 13),
                                        TextWidget(
                                            text: investor.investorLocation!,
                                            textSize: 12),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        toggleSelection(investor.investorId!),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColors.primary
                                            : AppColors.grey700,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: TextWidget(
                                        text:
                                            isSelected ? 'Selected' : 'Select',
                                        textSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: selectedIndices.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AppButton.primaryButton(
                            onButtonPressed: () {
                              Helper.loader(context);
                              campaignsController
                                  .removeInvFromViewList(
                                      invIds: selectedIndices,
                                      listId: widget.id)
                                  .then((val) {
                                if (val) {
                                  selectedIndices.clear();
                                }
                              });
                            },
                            title:
                                "Remove Selected (${selectedIndices.length})"),
                      )
                    : const SizedBox.shrink(),
              ),
      ),
    );
  }
}
