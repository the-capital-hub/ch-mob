import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/exploreController/explore_controller.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../textWidget/text_widget.dart';

Future<bool> addInvestorPopup(
  BuildContext context,
  List<String> invIds,
) async {
  TextEditingController newListNameController = TextEditingController();
  String? selectedList;
  String? selectedId;
  bool isCreatingNewList = false;
  ExploreController exploreController = Get.find();
  return await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: AppColors.blackCard,
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                TextWidget(
                  text: "Add Investor to List",
                  textSize: 20,
                  color: AppColors.white,
                  maxLine: 2,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 12),
                isCreatingNewList
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: MyCustomTextField.textField(
                          borderClr: AppColors.white38,
                          lableText: "New list",
                          hintText: "Enter new list name",
                          controller: newListNameController,
                        ),
                      )
                    : Obx(() => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: exploreController.isListLoading.value
                              ? SizedBox(
                                  height: 55,
                                  child: Center(
                                      child: Helper.pageLoading(
                                          color: AppColors.blackCard)),
                                )
                              : DropDownWidget(
                                  status: selectedList ?? "Select List",
                                  lable: "Choose a list",
                                  borderColor: AppColors.white38,
                                  statusList: exploreController.campaignLists
                                      .map((e) => e.listName!)
                                      .toList(),
                                  onChanged: (v) {
                                    setState(() {
                                      selectedList = v;
                                    });
                                    selectedId = exploreController.campaignLists
                                        .firstWhere((e) => e.listName == v)
                                        .listId!;
                                  },
                                ),
                        )),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      splashColor: AppColors.transparent,
                      onTap: () {
                        setState(() {
                          selectedList = null;
                          selectedId = null;
                          newListNameController.clear();
                          isCreatingNewList = !isCreatingNewList;
                        });
                      },
                      child: TextWidget(
                        text: isCreatingNewList
                            ? "Choose From Existing"
                            : "+ Create New List",
                        textSize: 14,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Divider(
                  color: AppColors.grey3Color,
                  height: 0,
                  thickness: 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                          height: 45,
                          child: Center(
                            child: TextWidget(
                              text: "Cancel".toUpperCase(),
                              color: Colors.white54,
                              textSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: 1,
                      color: AppColors.grey3Color,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (newListNameController.text.isNotEmpty ||
                              selectedId != null) {
                            Helper.loader(context);
                            exploreController
                                .createCampaignList(
                                    listName: newListNameController.text,
                                    listId: selectedId,
                                    selectedInvId: invIds)
                                .then((val) {
                              Get.back(closeOverlays: true);
                              Get.back(result: val);
                              HelperSnackBar.snackBar("Success",
                                  "Investors List created successfully");
                            });
                          }
                        },
                        child: SizedBox(
                          height: 45,
                          child: Center(
                            child: TextWidget(
                              text: "Submit".toUpperCase(),
                              color: Colors.white,
                              textSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
