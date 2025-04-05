import 'dart:convert';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityAboutController/community_about_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityUpdateSettingsController/community_update_settings_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAboutScreen/communities_about_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/imagePickerWidget/image_picker_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CommunityUpdateSettingsScreen extends StatefulWidget {
  const CommunityUpdateSettingsScreen({super.key});

  @override
  State<CommunityUpdateSettingsScreen> createState() =>
      _UpdateSettingsScreenState();
}

class _UpdateSettingsScreenState extends State<CommunityUpdateSettingsScreen> {
  CommunityUpdateSettingsController updateSettings =
      Get.put(CommunityUpdateSettingsController());
  CommunityAboutController aboutCommunity = Get.put(CommunityAboutController());
  String base64 = "";
  List<TextEditingController> controllers = [TextEditingController()];

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Future.wait([aboutCommunity.getAboutCommunity()]).then((values) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          urlController.text =
              aboutCommunity.aboutCommunityList[0].community!.shareLink!;
          updateSettings.communityNameController.text =
              aboutCommunity.aboutCommunityList[0].community!.name!;

          updateSettings.subscriptionAmountController.text =
              aboutCommunity.aboutCommunityList[0].community!.amount.toString();
          updateSettings.whatsappGroupLinkController.text = aboutCommunity
              .aboutCommunityList[0].community!.whatsappGroupLink!;
          updateSettings.isOpen =
              aboutCommunity.aboutCommunityList[0].community!.isOpen!;
          updateSettings.termsAndConditions = aboutCommunity
              .aboutCommunityList[0].community!.termsAndConditions!;
          // print(aboutCommunity.aboutCommunityList[0].community!.about!);
          setState(() {
            updateSettings.communitySize =
                aboutCommunity.aboutCommunityList[0].community!.communitySize!;
            updateSettings.subscriptionType =
                aboutCommunity.aboutCommunityList[0].community!.subscription!;
          });

          initializeControllers();
        });
      });
    });
    super.initState();
  }

  addAbout() async {
    await updateSettings.aboutCommunityController
        .insertText(aboutCommunity.aboutCommunityList[0].community!.about!);
  }

  TextEditingController urlController = TextEditingController();

  void initializeControllers() {
    setState(() {
      controllers = [];
      for (int i = 0; i < updateSettings.termsAndConditions.length; i++) {
        TextEditingController controller =
            TextEditingController(text: updateSettings.termsAndConditions[i]);

        controller.addListener(() {
          updateSettings.termsAndConditions[i] = controller.text;
        });
        controllers.add(controller);
      }
    });
  }

  void addNewTextField() {
    setState(() {
      controllers.add(TextEditingController());
      updateSettings.termsAndConditions.add("");

      controllers.last.addListener(() {
        int index = controllers.length - 1;
        updateSettings.termsAndConditions[index] = controllers[index].text;
      });
    });
  }

  void removeTextField(int index) {
    if (controllers.isNotEmpty) {
      setState(() {
        controllers[index].dispose();
        controllers.removeAt(index);
        updateSettings.termsAndConditions.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: Obx(() => aboutCommunity.isLoading.value
              ? Helper.pageLoading()
              : aboutCommunity.aboutCommunityList.isEmpty
                  ? const Center(
                      child: TextWidget(
                          text: "Cannot Update Community Settings",
                          textSize: 16))
                  : Padding(
                      padding: const EdgeInsets.all(12),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const TextWidget(
                              text: "Update Community Settings",
                              textSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            base64 != ""
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        MemoryImage(base64Decode(base64)),
                                  )
                                : CircleAvatar(
                                    radius: 60,
                                    foregroundImage: NetworkImage(aboutCommunity
                                        .aboutCommunityList[0]
                                        .community!
                                        .image!),
                                  ),
                            const SizedBox(
                              height: 12,
                            ),

                            InkWell(
                              splashColor: AppColors.transparent,
                              highlightColor: AppColors.transparent,
                              onTap: () {
                                uploadBottomSheet();
                              },
                              child: Column(children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.white12,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 12),
                                    child: TextWidget(
                                        text: "Change community image",
                                        textSize: 13),
                                  ),
                                ),
                              ]),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            MyCustomTextField.textField(
                                hintText: "Enter Community Name",
                                controller:
                                    updateSettings.communityNameController,
                                lableText: "Community Name"),
                            const SizedBox(
                              height: 16,
                            ),
                            DropDownWidget(
                                status: updateSettings.communitySize,
                                lable: "Community Size",
                                statusList: const [
                                  "Less than 10K",
                                  "10K - 100K",
                                  "100K - 500K",
                                  "Over 500K"
                                ],
                                onChanged: (val) {
                                  setState(() {
                                    updateSettings.communitySize =
                                        val.toString();
                                  });
                                }),
                            const SizedBox(
                              height: 16,
                            ),
                            DropDownWidget(
                                status: updateSettings.subscriptionType,
                                lable: "Subscription Type",
                                statusList: const ["free", "paid"],
                                onChanged: (val) {
                                  setState(() {
                                    updateSettings.subscriptionType =
                                        val.toString();
                                  });
                                }),
                            const SizedBox(
                              height: 16,
                            ),
                            if (updateSettings.subscriptionType == "paid")
                              MyCustomTextField.textField(
                                  textInputType: TextInputType.number,
                                  lableText: "Subscription Amount",
                                  hintText: "Enter Amount",
                                  controller: updateSettings
                                      .subscriptionAmountController),
                            if (updateSettings.subscriptionType == "Paid")
                              const SizedBox(
                                height: 16,
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  checkColor:
                                      GetStoreData.getStore.read('isInvestor')
                                          ? AppColors.black
                                          : AppColors.white,
                                  value: updateSettings.isOpen,
                                  activeColor:
                                      GetStoreData.getStore.read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      updateSettings.isOpen = value!;
                                    });
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                const TextWidget(
                                    text: "Is Community Open ?", textSize: 16),
                              ],
                            ),
                            const SizedBox(height: 10),
                            MyCustomTextField.htmlTextField(
                              hintText: "Enter Community description",
                              controller:
                                  updateSettings.aboutCommunityController,
                              lableText: "About Community",
                              onEditorCreated: () async {
                                addAbout();
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            MyCustomTextField.textField(
                                hintText: "Enter whatsapp group link",
                                controller:
                                    updateSettings.whatsappGroupLinkController,
                                lableText: "Whatsapp Group Link"),
                            //  SizedBox(height: 16,),
                            //  Align(child: TextWidget(text: "Terms and conditions", textSize: 13),alignment: Alignment.centerLeft,),
                            ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 12),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: controllers.length,
                              itemBuilder: (context, index) {
                                return MyCustomTextField.textField(
                                  hintText: "Enter Terms and conditions",
                                  controller: controllers[index],
                                  lableText: "Terms and conditions",
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: AppColors.redColor,
                                    onPressed: () => removeTextField(index),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(
                              height: 16,
                            ),

                            AppButton.primaryButton(
                                bgColor: AppColors.green700,
                                onButtonPressed: () {
                                  addNewTextField();
                                },
                                title: "Add Term"),
                            const SizedBox(
                              height: 16,
                            ),
                            AppButton.primaryButton(
                                // bgColor: AppColors.primary,
                                onButtonPressed: () {
                                  Helper.loader(context);
                                  updateSettings.updateCommunity(base64);
                                },
                                title: "Update Community"),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 0),
                              child: AppButton.primaryButton(
                                  // bgColor: AppColors.primary,
                                  onButtonPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: AppColors.blackCard,
                                          title: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                foregroundImage: NetworkImage(
                                                  aboutCommunity
                                                      .aboutCommunityList[0]
                                                      .community!
                                                      .image!,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              TextWidget(
                                                text: aboutCommunity
                                                    .aboutCommunityList[0]
                                                    .community!
                                                    .name!,
                                                textSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                          content: const Padding(
                                            padding: EdgeInsets.only(left: 25),
                                            child: TextWidget(
                                              text:
                                                  'Are you sure to delete community',
                                              textSize: 13,
                                            ),
                                          ),
                                          actions: [
                                            AppButton.primaryButton(
                                              bgColor: AppColors.primary,
                                              title: 'Delete Community',
                                              onButtonPressed: () {
                                                Helper.loader(context);
                                                updateSettings
                                                    .deleteCommunity();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  title: "Delete Community"),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    )),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     Get.to(() => const CommunityAboutScreen());
          //   },
          //   backgroundColor: AppColors.primary,
          //   child: Icon(
          //     Icons.info,
          //     size: 30,
          //     color: AppColors.white,
          //   ),
          // ),
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
                  ImagePickerWidget imagePickerWidget = ImagePickerWidget();
                  imagePickerWidget.getImage(false).then((value) {
                    Get.back();

                    base64 = value;
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
            ],
          ),
        ),
        backgroundColor: AppColors.blackCard);
  }
}
