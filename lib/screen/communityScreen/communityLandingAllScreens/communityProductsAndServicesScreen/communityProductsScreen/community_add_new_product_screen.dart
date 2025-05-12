import 'dart:convert';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityAddNewProductController/community_add_new_product_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityProductsAndMembersController/community_products_and_members_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/homeScreen/home_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/imagePickerWidget/image_picker_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../../../../model/communityModel/communityLandingAllModels/getCommunityProductsAndMembersModel/get_community_products_and_members_model.dart';

class AddNewProductScreen extends StatefulWidget {
  bool isEdit;
  CommunityProduct? product;
  AddNewProductScreen({required this.isEdit, this.product, super.key});
  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  CommunityAddNewProductController addNewProduct =
      Get.put(CommunityAddNewProductController());
  TextEditingController urlController = TextEditingController();

  String base64 = "";
  List<TextEditingController> controllers = [TextEditingController()];
  CommunityProductsAndMembersController communityProducts = Get.find();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  void initState() {
    if (!widget.isEdit) {
      addNewProduct.isFree = false;
      base64 = "";
      addNewProduct.productNameController.clear();
      addNewProduct.productDescriptionController.clear();
      addNewProduct.productAmountController.clear();
    } else {
      addNewProduct.productNameController.text = widget.product!.name;
      addNewProduct.productAmountController.text =
          widget.product!.amount.toString();
      addNewProduct.urls = widget.product!.urls;
      addNewProduct.isFree = widget.product!.isFree;
      // base64 = communityProducts.communityProductsList[widget.index!].image;

      initializeControllers();
    }
    super.initState();
  }

  void initializeControllers() {
    setState(() {
      controllers = [];
      for (int i = 0; i < addNewProduct.urls.length; i++) {
        TextEditingController controller =
            TextEditingController(text: addNewProduct.urls[i]);

        controller.addListener(() {
          addNewProduct.urls[i] = controller.text;
        });
        controllers.add(controller);
      }
    });
  }

  void addNewTextField() {
    setState(() {
      controllers.add(TextEditingController());
      addNewProduct.urls.add("");

      controllers.last.addListener(() {
        int index = controllers.length - 1;
        addNewProduct.urls[index] = controllers[index].text;
      });
    });
  }
  // void addNewTextField() {
  //   setState(() {
  //     controllers.add(TextEditingController());
  //   });
  // }

  // void removeTextField(int index) {
  //   if (controllers.length > 1) {
  //     setState(() {
  //       controllers[index].dispose();
  //       controllers.removeAt(index);
  //     });
  //   }
  // }
  void removeTextField(int index) {
    if (controllers.isNotEmpty) {
      setState(() {
        controllers[index].dispose();
        controllers.removeAt(index);
        addNewProduct.urls.removeAt(index);
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

  addDescription() async {
    await addNewProduct.productDescriptionController
        .setText(widget.product!.description);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(title: "Product"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Column(children: [
                // Image.asset(
                //   PngAssetPath.addNewProductImg,
                //   height: 100,
                // ),
                // const SizedBox(
                //   height: 12,
                // ),
                // TextWidget(
                //   text:
                //       widget.isEdit ? "Update the Product" : "Add New Product",
                //   textSize: 20,
                //   fontWeight: FontWeight.w500,
                // ),
                // const SizedBox(
                //   height: 12,
                // ),
                // widget.isEdit
                //     ? CircleAvatar(
                //         radius: 60,
                //         foregroundImage: NetworkImage(communityProducts
                //             .communityProductsList[widget.index!].image),
                //       )
                //     : base64 != ""
                //         ? CircleAvatar(
                //             radius: 60,
                //             backgroundImage: MemoryImage(base64Decode(base64)),
                //           )
                //         : const CircleAvatar(
                //             radius: 60,
                //             child: Icon(Icons.add_photo_alternate_outlined,
                //                 size: 40)),
                widget.isEdit
                    ? base64 != ""
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(base64Decode(base64)),
                          )
                        : CircleAvatar(
                            radius: 60,
                            foregroundImage:
                                NetworkImage(widget.product!.image),
                          )
                    : base64 != ""
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(base64Decode(base64)),
                          )
                        : const CircleAvatar(
                            radius: 60,
                            child: Icon(Icons.add_photo_alternate_outlined,
                                size: 40)),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 12),
                        child: TextWidget(
                            text: widget.isEdit!
                                ? "Change Product Image"
                                : "Upload Product Image",
                            textSize: 13),
                      ),
                    ),
                  ]),
                ),
                Form(
                    key: formkey,
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        MyCustomTextField.textField(
                            valText: "Please enter product name",
                            hintText: "eg : Hub",
                            controller: addNewProduct.productNameController,
                            lableText: "Product Name"),

                        const SizedBox(height: 12),
                        MyCustomTextField.htmlTextField(
                          hintText: "Enter description",
                          controller:
                              addNewProduct.productDescriptionController,
                          lableText: "Description",
                          onEditorCreated: () async {
                            if (widget.isEdit) {
                              addDescription();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: addNewProduct.isFree,
                              checkColor:
                                  GetStoreData.getStore.read('isInvestor')
                                      ? AppColors.black
                                      : AppColors.white,
                              activeColor:
                                  GetStoreData.getStore.read('isInvestor')
                                      ? AppColors.primaryInvestor
                                      : AppColors.primary,
                              onChanged: (bool? value) {
                                setState(() {
                                  addNewProduct.isFree = value!;
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            const TextWidget(
                                text: "Free Resource", textSize: 16),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        if (!addNewProduct.isFree)
                          MyCustomTextField.textField(
                              textInputType: TextInputType.number,
                              hintText: "Enter amount",
                              valText: "Please enter amount",
                              controller: addNewProduct.productAmountController,
                              lableText: "Amount"),
                        if (!addNewProduct.isFree)
                          const SizedBox(
                            height: 12,
                          ),
                        //  ],)),
                        ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: controllers.length,
                          itemBuilder: (context, index) {
                            return MyCustomTextField.textField(
                              hintText: "Enter resource URL",
                              controller: controllers[index],
                              lableText: "Resource URLs",
                              valText: "Please enter resource URL",
                              suffixIcon: index > 0
                                  ? IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: AppColors.redColor,
                                      onPressed: () => removeTextField(index),
                                    )
                                  : null,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        InkWell(
                          child: const TextWidget(
                            text: "+ Add Another URL",
                            textSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          onTap: () {
                            addNewTextField();
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    )),
              ]),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(12),
            child: AppButton.primaryButton(
                onButtonPressed: () {
                  if (formkey.currentState!.validate()) {
                    if (!widget.isEdit && base64 == "") {
                      HelperSnackBar.snackBar(
                          "Error", "Upload an Image for the Product.");
                    } else {
                      List<String> urls = controllers
                          .map((controller) => controller.text)
                          .toList();
                        
                      if (!widget.isEdit) {
                        Helper.loader(context);
                        addNewProduct.addProductToCommunity(base64, urls);
                      } else {
                        Helper.loader(context);
                        
                        addNewProduct.updateCommunityProduct(
                            base64, widget.product!.id);
                      }
                    }
                  }
                },
                title: widget.isEdit ? "Update Product" : "+ Add Product"),
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
