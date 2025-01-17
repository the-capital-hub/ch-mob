import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:capitalhub_crm/screen/Auth-Process/desc&socialMediaScreen/description_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../utils/constant/app_var.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/textwidget/text_widget.dart';

class UploadLogoScreen extends StatefulWidget {
  const UploadLogoScreen({super.key});

  @override
  State<UploadLogoScreen> createState() => _UploadLogoScreenState();
}

class _UploadLogoScreenState extends State<UploadLogoScreen> {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration:  bgDec,
      child:
    Scaffold(
      backgroundColor: AppColors.transparent,
      appBar: HelperAppBar.appbarHelper(title: ""),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: "Upload Logo",
              textSize: 22,
              fontWeight: FontWeight.w500,
            ),
            sizedTextfield,
            const TextWidget(
              text: "Upload a logo of your company.",
              textSize: 14,
              maxLine: 3,
            ),
            sizedTextfield,
            sizedTextfield,
            Center(
              child: base64Image != null
                  ? CircleAvatar(
                      radius: 80,
                      backgroundImage: MemoryImage(base64Decode(base64Image!)),
                    )
                  : CircleAvatar(
                      radius: 80,
                      child: Icon(
                        CupertinoIcons.person_alt_circle,
                        size: 160,
                        color: AppColors.black38,
                      ),
                    ),
            ),
            const Spacer(),
            if (base64Image == null)
              AppButton.primaryButton(
                  onButtonPressed: () {
                    uploadBottomSheet();  
                  },
                  title: "Add Logo"),
            if (base64Image != null)
              Column(
                children: [
                  AppButton.primaryButton(
                      onButtonPressed: () {
                        Get.to(DescriptionScreen());
                      },
                      title: "Done"),
                  sizedTextfield,
                  AppButton.outlineButton(
                      onButtonPressed: () {
                        uploadBottomSheet();
                      },
                      title: "Change Logo"),
                ],
              )
          ],
        ),
      ),
    ));
  }

  uploadBottomSheet() {
    return Get.bottomSheet(
        Container(
          height: 350,
          padding: const EdgeInsets.all(12),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedTextfield,
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.close,
                  size: 25,
                  color: AppColors.white,
                ),
              ),
              sizedTextfield,
              const TextWidget(
                  text: "Add picture",
                  textSize: 20,
                  fontWeight: FontWeight.w500),
              sizedTextfield,
              InkWell(
                onTap: () {
                  getImage(false).then((value) {
                    Get.back();
                    setState(() {});
                  });
                },
                child: Container(
                  width: Get.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors.white12,
                      borderRadius: BorderRadius.circular(12)),
                  child: const TextWidget(
                      text: "Choose from Gallery", textSize: 15),
                ),
              ),
              sizedTextfield,
              InkWell(
                onTap: () {
                  getImage(true).then((value) {
                    Get.back();
                    setState(() {});
                  });
                },
                child: Container(
                  width: Get.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors.white12,
                      borderRadius: BorderRadius.circular(12)),
                  child: const TextWidget(text: "Take Photo", textSize: 15),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.blackCard);
  }

  final picker = ImagePicker();
  File? _image;
  String? cropImage;
  String? base64Image;
  Future getImage(bool isCamera) async {
    try {
      final pickedFile = await picker.pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);

      // setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        cropImage = await imgCropper(_image!.path);
        // if (File(cropImage!).lengthSync() > 1 * 1024 * 1024) {
        //   final compressedImage = await _compressImage(File(cropImage!));
        //   cropImage = compressedImage;
        // } else {
        //   cropImage = cropImage;
        // }
        // int compressedImageSize = File(cropImage!).lengthSync();
        // log((compressedImageSize / (1024 * 1024)).toStringAsFixed(2));
        return base64Image = base64Encode(File(cropImage!).readAsBytesSync());
      } else {
        print('No image selected.');
        return null;
      }
    } catch (e) {
      log("message $e");
    }
    // });
  }

  CroppedFile? croppedFile;

  imgCropper(img) async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: img,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop your image',
            toolbarColor: AppColors.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );
    return croppedFile!.path;
  }
}
