import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/documentController/document_controller.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../textWidget/text_widget.dart';

Future<bool> createFolderPopup(
  BuildContext context,
  Function() onSubmit,
) async {
  DocumentController documentController = Get.find();

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      TextWidget(
                        text: "Create Folder",
                        textSize: 20,
                        color: AppColors.white,
                        maxLine: 2,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 6),
                      CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: Icon(CupertinoIcons.folder,
                              color: AppColors.white)),
                      const SizedBox(height: 12),
                      MyCustomTextField.textField(
                          hintText: "Enter Folder Name",
                          controller:
                              documentController.folderNameController,
                          borderClr: AppColors.white38,
                          onTap: () async {},
                          lableText: "Folder"),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
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
                        onTap: onSubmit,
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
