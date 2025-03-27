import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:capitalhub_crm/widget/imagePickerWidget/image_picker_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/documentController/document_controller.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../textWidget/text_widget.dart';

Future<bool> createPitchRecording(
  BuildContext context,
  Function() onSubmit,
) async {
  DocumentController documentController = Get.find();
  final picker = ImagePicker();
  File? _image;
  String? cropImage;
  Future getImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        cropImage = await ImagePickerWidget().imgCropper(_image!.path);
        return documentController.base64Image = base64Encode(File(cropImage!).readAsBytesSync());
      } else {
        return null;
      }
    } catch (e) {
      log("message $e");
    }
    // });
  }

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
                        text: "Pitch Recording",
                        textSize: 20,
                        color: AppColors.white,
                        maxLine: 2,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 12),
                      InkWell(splashColor: AppColors.transparent,
                        onTap: () {
                          getImage().then((v) {
                            setState(() {});
                          });
                        },
                        child: Center(
                          child: documentController.base64Image != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      MemoryImage(base64Decode(documentController.base64Image!)),
                                )
                              : const CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  radius: 50,
                                  child: TextWidget(
                                      text: "Add\nThumbnail",
                                      align: TextAlign.center,
                                      textSize: 14),
                                ),
                        ),
                      ),
                      MyCustomTextField.textField(
                          hintText: "Enter Video Url",
                          controller: documentController.videoUrlController,
                          borderClr: AppColors.white38,
                          lableText: "Url"),
                      const SizedBox(height: 16),
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
