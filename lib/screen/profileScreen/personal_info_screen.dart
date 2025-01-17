import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:capitalhub_crm/controller/profileController/profile_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/constant/app_var.dart';
import '../../widget/text_field/text_field.dart';

class PersonalInfoScreen extends StatefulWidget {
  bool? isEdit;
  PersonalInfoScreen({super.key, this.isEdit});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    profileController.companyController.text =
        profileController.profileData.companyName!;
    profileController.designationController.text =
        profileController.profileData.designation!;
    profileController.experienceController.text =
        profileController.profileData.experience!;
    profileController.educationController.text =
        profileController.profileData.education!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(title: "Personal Information"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // const TextWidget(
                  //     text:
                  //         "Add your personal details to help us to find out the other’s",
                  //     maxLine: 2,
                  //     textSize: 16),
            
                  InkWell(
                    onTap: () {
                      uploadBottomSheet();
                    },
                    child: Center(
                      child: base64Image != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  MemoryImage(base64Decode(base64Image!)),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                  "${profileController.profileData.profilePicture}"),
                            ),
                    ),
                  ),
            
                  sizedTextfield,
                  sizedTextfield,
                  MyCustomTextField.textField(
                      lableText: "Company",
                      readonly: widget.isEdit == true ? true : false,
                      hintText: "Enter Company Name",
                      controller: profileController.companyController),
                  sizedTextfield,
                  MyCustomTextField.textField(
                      lableText: "Designation",
                      hintText: "Enter Designation",
                      controller: profileController.designationController),
                  sizedTextfield,
                  MyCustomTextField.textField(
                      lableText: "Email Education",
                      hintText: "Enter Education",
                      controller: profileController.educationController),
                  sizedTextfield,
                  MyCustomTextField.textField(
                      lableText: "Experience",
                      hintText: "Enter Experience",
                      controller: profileController.experienceController),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                    child: AppButton.primaryButton(
                        onButtonPressed: () {
                          Get.back();
                        },
                        bgColor: AppColors.white12,
                        title: "Cancel")),
                const SizedBox(width: 12),
                Expanded(
                    child: AppButton.primaryButton(
                        onButtonPressed: () {
                          profileController.updateProfile(base64Image, context);
                        },
                        title: "Save"))
              ],
            ),
          ),
        ));
  }

  uploadBottomSheet() {
    return Get.bottomSheet(
        Container(
          height: 250,
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
                    // loginController.profilePicBase64 = base64Image ?? "";
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
              // sizedTextfield,
              // InkWell(
              //   onTap: () {
              //     getImage(true).then((value) {
              //       Get.back();
              //       setState(() {});
              //     });
              //   },
              //   child: Container(
              //     width: Get.width,
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              //     decoration: BoxDecoration(
              //         color: AppColors.white12,
              //         borderRadius: BorderRadius.circular(12)),
              //     child: const TextWidget(text: "Take Photo", textSize: 15),
              //   ),
              // ),
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
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        cropImage = await imgCropper(_image!.path);
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
