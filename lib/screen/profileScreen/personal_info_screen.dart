import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:capitalhub_crm/controller/profileController/profile_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/constant/app_var.dart';
import '../../utils/helper/helper.dart';
import '../../widget/datePicker/datePicker.dart';
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
    populateData();
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
                  InkWell(
                    onTap: () {
                      uploadBottomSheet("profile");
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
                                  "${profileController.profileData.user!.profilePicture}"),
                            ),
                    ),
                  ),
                  sizedTextfield,
                  sizedTextfield,
                  MyCustomTextField.textField(
                      lableText: "First name",
                      hintText: "Enter First Name",
                      controller: profileController.firstNameController),
                  sizedTextfield,
                  MyCustomTextField.textField(
                      lableText: "Last Name",
                      hintText: "Enter Last Name",
                      controller: profileController.lastNameController),
                  sizedTextfield,
                  MyCustomTextField.textField(
                      lableText: "User Name",
                      hintText: "Enter User Name",
                      controller: profileController.userNameController),
                  sizedTextfield,
                  ExpansionTile(
                    tilePadding: const EdgeInsets.all(0),
                    iconColor: AppColors.whiteCard,
                    collapsedIconColor: AppColors.whiteCard,
                    title: const TextWidget(text: "Experience", textSize: 14),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
                    children: [
                      ListView.separated(
                        itemCount: companyInfo.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const Divider(
                          height: 28,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    companyInfo.removeAt(index);
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.remove_circle,
                                      color: AppColors.redColor),
                                ),
                              ),
                              MyCustomTextField.textField(
                                  lableText: "Company",
                                  hintText: "Enter Company Name",
                                  controller: companyInfo[index].companyName),
                              sizedTextfield,
                              MyCustomTextField.textField(
                                  lableText: "Location",
                                  hintText: "Enter Location",
                                  controller:
                                      companyInfo[index].companyLocation),
                              sizedTextfield,
                              MyCustomTextField.textField(
                                  lableText: "Role",
                                  hintText: "Enter Role",
                                  controller: companyInfo[index].companyRole),
                              sizedTextfield,
                              Row(
                                children: [
                                  Expanded(
                                    child: MyCustomTextField.textField(
                                        hintText: "Start Date",
                                        readonly: true,
                                        lableText: "Start Date",
                                        onTap: () async {
                                          final selectedDate = await selectDate(
                                              context, DateTime.now());
                                          if (selectedDate != null) {
                                            companyInfo[index]
                                                    .companyStartDate
                                                    .text =
                                                Helper.formatDatePost(
                                                    selectedDate.toString());
                                            setState(() {});
                                          }
                                        },
                                        controller: companyInfo[index]
                                            .companyStartDate),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: MyCustomTextField.textField(
                                        hintText: "End Date",
                                        readonly: true,
                                        lableText: "End Date",
                                        onTap: () async {
                                          final selectedDate = await selectDate(
                                              context, DateTime.now());
                                          if (selectedDate != null) {
                                            companyInfo[index]
                                                    .companyEndDate
                                                    .text =
                                                Helper.formatDatePost(
                                                    selectedDate.toString());
                                            setState(() {});
                                          }
                                        },
                                        controller:
                                            companyInfo[index].companyEndDate),
                                  ),
                                ],
                              ),
                              sizedTextfield,
                              MyCustomTextField.textField(
                                  lableText: "Description",
                                  hintText: "Enter Description",
                                  controller:
                                      companyInfo[index].companyDescription),
                              sizedTextfield,
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child:
                                      TextWidget(text: " Image", textSize: 14)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      uploadBottomSheet("company",
                                          index: index);
                                    },
                                    child: Center(
                                      child: companyInfo[index]
                                              .companyLogo!
                                              .contains("http")
                                          ? CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                  companyInfo[index]
                                                      .companyLogo!),
                                            )
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundImage: MemoryImage(
                                                  base64Decode(
                                                      companyInfo[index]
                                                          .companyLogo!)),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      sizedTextfield,
                      sizedTextfield,
                      InkWell(
                        onTap: () {
                          companyInfo.add(CompanyInfo(
                              companyName: TextEditingController(),
                              companyLocation: TextEditingController(),
                              companyRole: TextEditingController(),
                              companyStartDate: TextEditingController(),
                              companyEndDate: TextEditingController(),
                              companyDescription: TextEditingController(),
                              companyLogo:
                                  "https://res.cloudinary.com/drjt9guif/image/upload/v1737795495/undefined/startUps/logos/tjuzpjghxiyarfwihzkh.webp"));
                          setState(() {});
                        },
                        child: const TextWidget(
                          text: "+ Add",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      sizedTextfield,
                    ],
                  ),
                  sizedTextfield,
                  ExpansionTile(
                    tilePadding: const EdgeInsets.all(0),
                    iconColor: AppColors.whiteCard,
                    collapsedIconColor: AppColors.whiteCard,
                    title: const TextWidget(text: "Education", textSize: 14),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
                    children: [
                      ListView.separated(
                          itemCount: educationInfo.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const Divider(
                                height: 28,
                              ),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                MyCustomTextField.textField(
                                    lableText: "School",
                                    hintText: "Enter School Name",
                                    controller:
                                        educationInfo[index].educationSchool),
                                sizedTextfield,
                                MyCustomTextField.textField(
                                    lableText: "Location",
                                    hintText: "Enter Location",
                                    controller:
                                        educationInfo[index].educationLocation),
                                sizedTextfield,
                                MyCustomTextField.textField(
                                    lableText: "Cource",
                                    hintText: "Enter Cource Name",
                                    controller:
                                        educationInfo[index].educationCourse),
                                sizedTextfield,
                                MyCustomTextField.textField(
                                    hintText: "Passout Date",
                                    readonly: true,
                                    lableText: "Passout Date",
                                    onTap: () async {
                                      final selectedDate = await selectDate(
                                          context, DateTime.now());
                                      if (selectedDate != null) {
                                        educationInfo[index]
                                                .educationPassoutDate
                                                .text =
                                            Helper.formatDatePost(
                                                selectedDate.toString());
                                        setState(() {});
                                      }
                                    },
                                    controller: educationInfo[index]
                                        .educationPassoutDate),
                                sizedTextfield,
                                MyCustomTextField.textField(
                                    lableText: "Description",
                                    hintText: "Enter Description",
                                    controller: educationInfo[index]
                                        .educationDescription),
                                sizedTextfield,
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextWidget(
                                        text: " Image", textSize: 14)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        uploadBottomSheet("education",
                                            index: index);
                                      },
                                      child: educationInfo[index]
                                              .educationLogo!
                                              .contains("http")
                                          ? CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                  educationInfo[index]
                                                      .educationLogo!),
                                            )
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundImage: MemoryImage(
                                                  base64Decode(
                                                      educationInfo[index]
                                                          .educationLogo!)),
                                            ),
                                    ),
                                  ],
                                ),
                                sizedTextfield
                              ],
                            );
                          }),
                      sizedTextfield,
                      sizedTextfield,
                      InkWell(
                        onTap: () {
                          educationInfo.add(EducationInfo(
                              educationSchool: TextEditingController(),
                              educationLocation: TextEditingController(),
                              educationCourse: TextEditingController(),
                              educationPassoutDate: TextEditingController(),
                              educationDescription: TextEditingController(),
                              educationLogo:
                                  "https://res.cloudinary.com/drjt9guif/image/upload/v1737795495/undefined/startUps/logos/vnzjvdh52sd16mo6rge7.webp"));
                          setState(() {});
                        },
                        child: const TextWidget(
                          text: "+ Add",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      sizedTextfield,
                    ],
                  ),
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
                          profileController.updateProfile(
                              base64Image, companyInfo, educationInfo, context);
                        },
                        title: "Save"))
              ],
            ),
          ),
        ));
  }

  uploadBottomSheet(String type, {int? index}) {
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
                  getImage(false, type, index).then((value) {
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
  Future getImage(bool isCamera, String type, int? index) async {
    try {
      final pickedFile = await picker.pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        cropImage = await imgCropper(_image!.path);
        if (type == "profile") {
          return base64Image = base64Encode(File(cropImage!).readAsBytesSync());
        } else if (type == "company") {
          return companyInfo[index!].companyLogo =
              base64Encode(File(cropImage!).readAsBytesSync());
        } else if (type == "education") {
          return educationInfo[index!].educationLogo =
              base64Encode(File(cropImage!).readAsBytesSync());
        }
      } else {
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

  List<CompanyInfo> companyInfo = [];
  List<EducationInfo> educationInfo = [];
  populateData() {
    for (var i = 0; i < profileController.profileData.user!.education!.length; i++) {
      educationInfo.add(EducationInfo(
          educationSchool: TextEditingController(
              text: profileController
                  .profileData.user!.education![i].educationSchoolName),
          educationLocation: TextEditingController(
              text: profileController
                  .profileData.user!.education![i].educationLocation),
          educationCourse: TextEditingController(
              text:
                  profileController.profileData.user!.education![i].educationCourse),
          educationPassoutDate: TextEditingController(
              text: profileController
                  .profileData.user!.education![i].educationPassYear),
          educationDescription: TextEditingController(
              text: profileController
                  .profileData.user!.education![i].educationDescription),
          educationLogo:
              profileController.profileData.user!.education![i].educationLogo));
    }
    for (var i = 0; i < profileController.profileData.user!.experience!.length; i++) {
      companyInfo.add(CompanyInfo(
          companyName: TextEditingController(
              text: profileController.profileData.user!.experience![i].companyName),
          companyLocation: TextEditingController(
              text: profileController.profileData.user!.experience![i].location),
          companyRole: TextEditingController(
              text: profileController.profileData.user!.experience![i].role),
          companyStartDate: TextEditingController(
              text: profileController.profileData.user!.experience![i].startYear),
          companyEndDate: TextEditingController(
              text: profileController.profileData.user!.experience![i].endYear),
          companyDescription: TextEditingController(
              text: profileController.profileData.user!.experience![i].description),
          companyLogo:
              profileController.profileData.user!.experience![i].companyLogo));
    }
  }
}

class CompanyInfo {
  TextEditingController companyName;
  TextEditingController companyLocation;
  TextEditingController companyRole;
  TextEditingController companyStartDate;
  TextEditingController companyEndDate;
  TextEditingController companyDescription;
  String? companyLogo;

  CompanyInfo({
    required this.companyName,
    required this.companyLocation,
    required this.companyRole,
    required this.companyStartDate,
    required this.companyEndDate,
    required this.companyDescription,
    this.companyLogo,
  });

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName.text,
      'companyLocation': companyLocation.text,
      'companyRole': companyRole.text,
      'companyStartDate': companyStartDate.text,
      'companyEndDate': companyEndDate.text,
      'companyDescription': companyDescription.text,
      'companyLogo': companyLogo,
    };
  }
}

class EducationInfo {
  TextEditingController educationSchool;
  TextEditingController educationLocation;
  TextEditingController educationCourse;
  TextEditingController educationPassoutDate;
  TextEditingController educationDescription;
  String? educationLogo;

  EducationInfo({
    required this.educationSchool,
    required this.educationLocation,
    required this.educationCourse,
    required this.educationPassoutDate,
    required this.educationDescription,
    this.educationLogo,
  });

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'educationSchool': educationSchool.text,
      'educationLocation': educationLocation.text,
      'educationCource': educationCourse.text,
      'educationPassoutDate': educationPassoutDate.text,
      'educationDescription': educationDescription.text,
      'educationLogo': educationLogo,
    };
  }
}
