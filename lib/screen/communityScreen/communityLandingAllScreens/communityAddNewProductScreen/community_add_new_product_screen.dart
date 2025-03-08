import 'dart:convert';

import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityAddNewProductController/community_add_new_product_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/homeScreen/home_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/imagePickerWidget/image_picker_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  
  CommunityAddNewProductController addNewProduct = Get.put(CommunityAddNewProductController());
  TextEditingController urlController = TextEditingController();
  bool isChecked = false;
  String base64 = "";
  List<TextEditingController> controllers = [TextEditingController()]; // Start with one controller
  void addNewTextField() {
    print("inside");
    // Create a new TextEditingController and add it to the list
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  void removeTextField(int index) {
    if (controllers.length > 1) {
      setState(() {
        // Dispose the controller before removing it from the list
        controllers[index].dispose();
        controllers.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    // Dispose all controllers when the widget is disposed
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
        drawer: const DrawerWidget(),
        backgroundColor: AppColors.transparent,
        appBar: AppBar(
          
          backgroundColor: AppColors.black,
          leading: 
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // IconButton(
              //   onPressed: () {
              //     Get.back();
              //   },
              //   icon: Icon(
              //     Icons.arrow_back_ios_new_sharp,
              //     size: 20,
              //     color: AppColors.white,
              //   ),
              // ),
              InkWell(child: Icon(Icons.arrow_back_ios_new_sharp,color: AppColors.white,),onTap: (){
                Get.back();
              },),
              
              CircleAvatar(
                radius: 16,
                foregroundImage: NetworkImage(communityLogo),
              ),
            ],
          ),
      
          title: 
          // aboutCommunity.aboutCommunityList.isEmpty
          //       ? CircularProgressIndicator():
          TextWidget(
            text: communityName,
            // aboutCommunity.aboutCommunityList[0].community.name, 
            textSize: 16),
          actions: [
            IconButton(onPressed: (){Get.to(() =>  const HomeScreen());}, icon:  Icon(Icons.swap_horizontal_circle_sharp,color: AppColors.white,size: 30,))
          ],
        ),
          body: SingleChildScrollView(
            child: Padding(padding: EdgeInsets.only(left: 12, right: 12, top: 12),
            child: Column(
              children: [
                Image.asset(PngAssetPath.addNewProductImg,height: 200,),
                SizedBox(height: 12,),
                TextWidget(text: "Add New Product", textSize: 20,fontWeight: FontWeight.w500,),
                SizedBox(height: 12,),
                base64 != ""
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(
                                base64Decode(base64)),
                          )
                        : const CircleAvatar(
                            radius: 60,
                            child: Icon(Icons.add_photo_alternate_outlined,
                                size: 40)),
                  
                                  SizedBox(height: 12,),
                  InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      uploadBottomSheet();
                    },
                    child: Column(
                      children: [ 
                                          
                    Container(
                                          decoration: BoxDecoration(
                    color: 
                         AppColors.white12,
                    // color: Color(0xFFC8E0DA),
                                          borderRadius: BorderRadius.circular(20)
                    // border:
                    //     Border.all(color: Colors.redAccent, width: 1)
                                          ),
                                          child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                    child:  TextWidget(text: "Upload Product Image", textSize: 13),
                                          ),
                                        ),
                      ]),
                  ),
                
                
                SizedBox(height: 12),
                MyCustomTextField.textField(hintText: "eg : Hub", controller: addNewProduct.productNameController, lableText: "Product Name"),
                SizedBox(height: 12),
                MyCustomTextField.textField(hintText: "Enter description", controller: addNewProduct.productDescriptionController, lableText: "Description", maxLine: 7),
                SizedBox(height: 12,),
                Row(children: [
                      Checkbox( 
                                                  value: addNewProduct.isFree,
                                                  activeColor: AppColors.primary,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      addNewProduct.isFree = value!;
                                                    });
                                                  },
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                ),
                                               TextWidget(text: "Free Resource", textSize: 16),
                    ],),
                SizedBox(height: 12,),
                if(!addNewProduct.isFree)    
                MyCustomTextField.textField(hintText: "Enter amount", controller: addNewProduct.productAmountController, lableText: "Amount"),
                if(!addNewProduct.isFree) 
                SizedBox(height: 12,),
                // MyCustomTextField.textField(hintText: "", controller: urlController, lableText: "Product Image",suffixIcon: Card(
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                //   color: AppColors.grey700,
                //   child: 
                // Padding(
                //   padding: const EdgeInsets.only(top: 12,left: 15,right: 15),
                //   child: TextWidget(text: "Upload", textSize: 11),
                // ),)),
               
                // SizedBox(height: 12,),
                
               
                ListView.separated(
              separatorBuilder: (context, index) =>SizedBox(height: 12,),
              shrinkWrap:
                  true, // Makes ListView take only as much space as it needs
              padding:
                  EdgeInsets.zero, // Remove extra padding from ListView
              itemCount: controllers.length,
              itemBuilder: (context, index) {
                return  MyCustomTextField.textField(hintText: "Enter resource URL", controller: controllers[index], lableText: "Resource URLs",suffixIcon: index>0?IconButton(
                        icon: Icon(Icons.delete),color: AppColors.primary,
                        onPressed: () => removeTextField(index),
                      ):SizedBox.shrink());
              },
            ),
                SizedBox(height: 12,),
            InkWell(child: TextWidget(text: "+ Add Another URL", textSize: 16, fontWeight: FontWeight.w500,),onTap: (){addNewTextField();},),
            SizedBox(height: 12,),

              ]
          
                
            
            
            
            
            ),
            
            ),
          ),
          bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: AppButton.outlineButton(
                  borderColor: AppColors.primary,
                  onButtonPressed: () {
                    // titleController.clear();
                    // descriptionController.clear();
                    
                    // durationMinutesController.clear();
                   
                    // priceController.clear();
                    // priceDiscountController.clear();
                    // setState(() {
                    //   privacyStatus = "Public";
                    // });
                  },
                  title: "Cancel"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton.primaryButton(
                  onButtonPressed: () {
                    if(base64==""){
                  HelperSnackBar.snackBar("Error", "Upload an Image for the Product.");
                }
                else{
                    List<String> urls = controllers.map((controller) => controller.text).toList();
                    Helper.loader(context);
                    addNewProduct.addProductToCommunity(base64,urls);
                  }
                  },
                  
                  title: "+ Add Product"),
            ),
            
            
          ]),
        ),
      )

    );
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
}