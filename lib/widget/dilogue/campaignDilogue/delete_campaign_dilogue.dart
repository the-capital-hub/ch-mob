import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../textWidget/text_widget.dart';

Future<bool> deleteCampaignPopup(
  BuildContext context,
  Function() onDelete,
) async {
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
                  text: "Confirm Delete",
                  textSize: 20,
                  color: AppColors.white,
                  maxLine: 2,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 12),
                CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.redColor,
                    child:
                        Icon(Icons.delete, size: 30, color: AppColors.white)),
                const SizedBox(height: 12),
                const TextWidget(
                    text: "Are you sure want to Delete?", textSize: 14),
                const SizedBox(height: 12),
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
                        onTap: onDelete,
                        child: SizedBox(
                          height: 45,
                          child: Center(
                            child: TextWidget(
                              text: "Delete".toUpperCase(),
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
