import 'dart:convert';
import 'package:capitalhub_crm/screen/spotlLightScreen/addSpotlightProductScreen/makers_product_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/imagePickerWidget/image_picker_widget.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/spotlightController/spotlight_controller.dart';
import 'steps_header_screen.dart';

class MediaProductScreen extends StatefulWidget {
  const MediaProductScreen({super.key});

  @override
  State<MediaProductScreen> createState() => _MediaProductScreenState();
}

class _MediaProductScreenState extends State<MediaProductScreen> {
  final SpotlightController _spotlightController = Get.find();

  void _addImage() async {
    String? base64Image = await ImagePickerWidget().getImage(false);
    if (base64Image != null) {
      setState(() {
        _spotlightController.productBase64Images.add(base64Image);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _spotlightController.productBase64Images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Media Product"),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepperHeader(
                currentStep: 2,
                onStepTapped: (step) {
                  if (step < 2) {
                    navigateToProductStep(step);
                  }
                },
              ),
              sizedTextfield,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                          text: "Logo",
                          textSize: 14,
                          fontWeight: FontWeight.w500),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () {
                          ImagePickerWidget().getImage(false).then((value) {
                            _spotlightController.base64ImageLogo = value;
                            setState(() {});
                          });
                        },
                        child: _spotlightController.base64ImageLogo != null
                            ? Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        image: MemoryImage(base64Decode(
                                            _spotlightController
                                                .base64ImageLogo!)))),
                              )
                            : _spotlightController.logo != ""
                                ? Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                _spotlightController.logo))),
                                  )
                                : Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.blackCard),
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.white,
                                      size: 30,
                                    ),
                                  ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                          text: "Banner",
                          textSize: 14,
                          fontWeight: FontWeight.w500),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () {
                          ImagePickerWidget().getImage(false).then((value) {
                            _spotlightController.base64ImageBanner = value;
                            setState(() {});
                          });
                        },
                        child: Center(
                          child: _spotlightController.base64ImageBanner != null
                              ? Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          image: MemoryImage(base64Decode(
                                              _spotlightController
                                                  .base64ImageBanner!)))),
                                )
                              : _spotlightController.banner != ""
                                  ? Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  _spotlightController
                                                      .banner))),
                                    )
                                  : Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: AppColors.blackCard),
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.white,
                                        size: 30,
                                      ),
                                    ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_spotlightController.productBase64Images.isNotEmpty) ...[
                const TextWidget(
                    text: "Products",
                    textSize: 14,
                    fontWeight: FontWeight.w500),
                const SizedBox(height: 8)
              ],
              if (_spotlightController.productBase64Images.isNotEmpty)
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          _spotlightController.productBase64Images.length,
                      itemBuilder: (context, index) {
                        final imageStr =
                            _spotlightController.productBase64Images[index];
                        ImageProvider imageProvider;
                        if (imageStr.startsWith('http')) {
                          imageProvider = NetworkImage(imageStr);
                        } else {
                          imageProvider = MemoryImage(base64Decode(imageStr));
                        }
                        return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Stack(
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () => _removeImage(index),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                      child: const Icon(Icons.close,
                                          color: Colors.white, size: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      }),
                ),
              AppButton.outlineButton(
                  onButtonPressed: _addImage, title: "Add Product Images")
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: AppButton.outlineButton(
                    onButtonPressed: () {
                      Get.back();
                    },
                    title: "Back"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      if (_spotlightController.base64ImageLogo == null &&
                          _spotlightController.logo == "") {
                        HelperSnackBar.snackBar("Error", "Please select Logo");
                        return;
                      } else if (_spotlightController.base64ImageBanner ==
                              null &&
                          _spotlightController.banner == "") {
                        HelperSnackBar.snackBar(
                            "Error", "Please select Banner");
                        return;
                      } else if (_spotlightController
                          .productBase64Images.isEmpty) {
                        HelperSnackBar.snackBar(
                            "Error", "Please Add Product Images");
                        return;
                      }
                      Get.to(() => const MakersProductScreen());
                    },
                    title: "Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
