import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:capitalhub_crm/controller/chatController/chat_controller.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/appcolors/app_colors.dart';
import '../../utils/constant/app_var.dart';
import '../../widget/textwidget/text_widget.dart';

class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ChatController chatController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Create Community",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: base64Image != null
                      ? InkWell(
                          splashColor: AppColors.transparent,
                          onTap: () {
                            uploadBottomSheet();
                          },
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                MemoryImage(base64Decode(base64Image!)),
                          ),
                        )
                      : InkWell(
                          splashColor: AppColors.transparent,
                          onTap: () {
                            uploadBottomSheet();
                          },
                          child: CircleAvatar(
                            radius: 80,
                            child: Icon(
                              CupertinoIcons.person_alt_circle,
                              size: 160,
                              color: AppColors.black38,
                            ),
                          ),
                        ),
                ),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Name",
                    controller: nameController,
                    lableText: "Enter Name"),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter description",
                    controller: descriptionController,
                    lableText: "Description")
                // const TextWidget(
                //     text: "How big your community is?", textSize: 12),
                // sizedTextfield,
                // ListView.separated(
                //   itemCount: 4,
                //   shrinkWrap: true,
                //   separatorBuilder: (context, index) {
                //     return SizedBox(height: 8);
                //   },
                //   itemBuilder: (BuildContext context, int index) {
                //     return ListTile(
                //       onTap: () {
                //         selectedSizeIndex = index;
                //         setState(() {});
                //       },
                //       tileColor: AppColors.blackCard,
                //       title: TextWidget(text: "text", textSize: 14),
                //       trailing: Icon(
                //         selectedSizeIndex == index
                //             ? Icons.radio_button_checked
                //             : Icons.radio_button_off,
                //         color: AppColors.primary,
                //       ),
                //     );
                //   },
                // ),
                // sizedTextfield,
                // Row(
                //   children: [
                //     Checkbox(
                //       visualDensity: VisualDensity.compact,
                //       value: isFree,
                //       activeColor: AppColors.primary,
                //       onChanged: (val) {
                //         isFree = val!;
                //         setState(() {});
                //       },
                //     ),
                //     const SizedBox(width: 12),
                //     const TextWidget(text: "Free Community", textSize: 13),
                //   ],
                // ),
                // sizedTextfield,
                // if(!isFree)
                // MyCustomTextField.textField(
                //     hintText: "Enter Subscription Amount",
                //     lableText: "Subscription Amount",
                //     controller: subscriptionAmount),
                // sizedTextfield,
                // AppButton.primaryButton(
                // onButtonPressed: () {}, title: "Create community"),
                // MyCustomTextField.textField(
                //     hintText: "Search your network",
                //     controller: searchController,
                //     prefixIcon: Icon(
                //       Icons.search,
                //       color: AppColors.white54,
                //     ),
                //     lableText: "Search your network")
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(14),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                Helper.loader(context);
                chatController
                    .createGroup(base64Image, nameController.text,
                        descriptionController.text)
                    .then((val) {
                  Get.back(closeOverlays: true);
                  Get.back();
                });
              },
              title: "Create community"),
        ),
      ),
    );
  }

  bool isFree = true;
  TextEditingController subscriptionAmount = TextEditingController();
  int selectedSizeIndex = 0;
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
