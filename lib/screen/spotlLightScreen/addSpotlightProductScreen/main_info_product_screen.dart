import 'package:capitalhub_crm/controller/spotlightController/spotlight_controller.dart';
import 'package:capitalhub_crm/screen/spotlLightScreen/addSpotlightProductScreen/media_product_screen.dart';
import 'package:capitalhub_crm/screen/spotlLightScreen/addSpotlightProductScreen/steps_header_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit_existing_product.dart';

class MainInfoProductScreen extends StatefulWidget {
  const MainInfoProductScreen({super.key});

  @override
  State<MainInfoProductScreen> createState() => _MainInfoProductScreenState();
}

class _MainInfoProductScreenState extends State<MainInfoProductScreen> {
  final SpotlightController _spotlightController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  void _addTagField() {
    setState(() {
      _spotlightController.tagsControllers.add(TextEditingController());
    });
  }

  void _removeTagField(int index) {
    setState(() {
      _spotlightController.tagsControllers.removeAt(index);
    });
  }

  List<String> getTags() {
    return _spotlightController.tagsControllers
        .map((controller) => controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();
  }

  void _addCoreField() {
    setState(() {
      _spotlightController.corevaluePropositionControllers
          .add(TextEditingController());
    });
  }

  void _removeCoreField(int index) {
    setState(() {
      _spotlightController.corevaluePropositionControllers.removeAt(index);
    });
  }

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Add Product", action: [
          InkWell(
              onTap: () {
                Get.to(() => EditExistingProduct());
              },
              child: const TextWidget(
                  text: "Edit", textSize: 14, color: AppColors.primary)),
          const SizedBox(width: 8),
        ]),
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                StepperHeader(
                  currentStep: 1,
                  onStepTapped: (step) {
                    navigateToProductStep(step);
                  },
                ),
                sizedTextfield,
                MyCustomTextField.textField(
                  hintText: "Enter Product Name",
                  controller: _spotlightController.productNameController,
                  valText: "Please enter product name",
                  lableText: "Product Name",
                ),
                sizedTextfield,
                MyCustomTextField.textField(
                  hintText: "Enter Tagline",
                  controller: _spotlightController.taglineController,
                  lableText: "Tagline",
                  valText: "Please enter tagline",
                ),
                sizedTextfield,
                MyCustomTextField.textField(
                  hintText: "Enter About Company",
                  maxLine: 3,
                  controller: _spotlightController.aboutCompanyController,
                  lableText: "About Company",
                  valText: "Please enter about company",
                ),
                sizedTextfield,
                DropDownWidget(
                    status: _spotlightController.selectIndustry ??
                        "Select Industry",
                    statusList: industries,
                    lable: "industry",
                    onChanged: (v) {
                      _spotlightController.selectIndustry = v!;
                      setState(() {});
                    }),
                sizedTextfield,
                MyCustomTextField.textField(
                  hintText: "Enter Product/Website Url",
                  controller: _spotlightController.productUrlController,
                  prefixIcon:
                      Icon(Icons.link, size: 20, color: AppColors.whiteCard),
                  lableText: "Product Url",
                ),
                sizedTextfield,
                MyCustomTextField.textField(
                  hintText: "Enter Twitter Url",
                  controller: _spotlightController.twitterController,
                  prefixIcon:
                      Icon(Icons.link, size: 20, color: AppColors.whiteCard),
                  lableText: "Twitter Url",
                ),
                sizedTextfield,
                MyCustomTextField.textField(
                  hintText: "Enter Instagram Url",
                  controller: _spotlightController.instagramController,
                  prefixIcon:
                      Icon(Icons.link, size: 20, color: AppColors.whiteCard),
                  lableText: "Instagram Url",
                ),
                sizedTextfield,
                MyCustomTextField.textField(
                  hintText: "Enter LinkedIn Url",
                  controller: _spotlightController.linkedInController,
                  prefixIcon:
                      Icon(Icons.link, size: 20, color: AppColors.whiteCard),
                  lableText: "LinkedIn Url",
                ),
                sizedTextfield,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(
                        text: "Tags",
                        textSize: 14,
                        fontWeight: FontWeight.w500),
                    InkWell(
                        onTap: () {
                          _addTagField();
                        },
                        child: const TextWidget(
                            text: '+ Add Tag',
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                            textSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _spotlightController.tagsControllers.length,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return sizedTextfield;
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: MyCustomTextField.textField(
                            hintText: "Enter Tag (${index + 1})",
                            controller:
                                _spotlightController.tagsControllers[index],
                            valText: "Please enter tags",
                          ),
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                            onTap: () {
                              _removeTagField(index);
                            },
                            child: Icon(Icons.close, color: AppColors.white)),
                      ],
                    );
                  },
                ),
                sizedTextfield,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(
                        text: "Core Value Proposition",
                        textSize: 14,
                        fontWeight: FontWeight.w500),
                    InkWell(
                        onTap: () {
                          _addCoreField();
                        },
                        child: const TextWidget(
                            text: '+ Add Value',
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                            textSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _spotlightController
                      .corevaluePropositionControllers.length,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return sizedTextfield;
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: MyCustomTextField.textField(
                            hintText: "Enter core value (${index + 1})",
                            controller: _spotlightController
                                .corevaluePropositionControllers[index],
                            valText: "Please enter core value",
                          ),
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                            onTap: () {
                              _removeCoreField(index);
                            },
                            child: Icon(Icons.close, color: AppColors.white)),
                      ],
                    );
                  },
                ),
                sizedTextfield,
                MyCustomTextField.textField(
                  hintText: "Enter First Comment",
                  maxLine: 3,
                  controller: _spotlightController.firstCommentController,
                  lableText: "First Comment",
                ),
              ]),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                if (formkey.currentState!.validate()) {
                  if (_spotlightController.selectIndustry == null) {
                    HelperSnackBar.snackBar("Error", "Select an industry");
                    return;
                  }
                  Get.to(() => const MediaProductScreen());
                }
              },
              title: "Next"),
        ),
      ),
    );
  }

  List<String> industries = [
    "AI/ML",
    "Agritech",
    "Consumer",
    "Digital Entertainment",
    "Edtech",
    "Fintech",
    "HealthTech",
    "Media",
    "Mobility",
    "SaaS",
    "IOT",
  ];
}
