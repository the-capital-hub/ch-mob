import 'dart:convert';

import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityUpdateSettingsController/community_update_settings_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/getCreatedCommunityModel/get_created_community_model.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityDrawerScreen/community_drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/imagePickerWidget/image_picker_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class UpdateSettingsScreen extends StatefulWidget {
  const UpdateSettingsScreen({super.key});

  @override
  State<UpdateSettingsScreen> createState() => _UpdateSettingsScreenState();
}

class _UpdateSettingsScreenState extends State<UpdateSettingsScreen> {
  CommunityController createdCommunity = Get.put(CommunityController());
  CommunityUpdateSettingsController updateSettings = Get.put(CommunityUpdateSettingsController());
  String base64 = "";
  
  
   @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      createdCommunity.getCommunityById().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
        urlController.text = createdCommunity.createdCommunityDetails[0].shareLink;
        });
      });
    });
    super.initState();
  }
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
        child: Scaffold(
          drawer: const CommunityDrawerWidget(),
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "Update Settings Screen",
            hideBack: false,
            autoAction: true,
          ),
          body:
          Obx(()=>
        createdCommunity.isLoading.value
                ? Helper.pageLoading()
                : 
                // communityProducts.communityProductsList.isEmpty
                //       ? Center(child: TextWidget(text: "No Products Available", textSize: 16))
                //       :
          Padding(padding: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextWidget(text: "Update Community Settings", textSize: 20,fontWeight: FontWeight.w500,),
                SizedBox(height: 12,),
                base64 != ""
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(
                                base64Decode(base64)),
                          )
                        :  CircleAvatar(
                            radius: 60,
                            foregroundImage: NetworkImage(
                  createdCommunity.createdCommunityDetails[0].image,
                ),),
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
                      child:  TextWidget(text: "Change community image", textSize: 13),
                                            ),
                                          ),
                        ]),
                    ),
                    SizedBox(height: 16,),
                     MyCustomTextField.textField(hintText: "Enter Community Name", controller: updateSettings.communityNameController, lableText: "Community Name"),
                     SizedBox(height: 16,),
                     DropDownWidget(
                      status: updateSettings.communitySize,
                      lable: "Community Size",
                      statusList: const ["Less than 10K", "10K - 100K", "100K - 500K", "Over 500K"],
                      onChanged: (val) {
                        setState(() {
                          updateSettings.communitySize = val.toString();
                        });
                      }),
                      SizedBox(height: 16,),
                      DropDownWidget(
                      status: updateSettings.subscriptionType,
                      lable: "Subscription Type",
                      statusList: const ["Free", "Paid"],
                      onChanged: (val) {
                        setState(() {
                          updateSettings.subscriptionType = val.toString();
                        });
                      }),
                      SizedBox(height: 16,),
                      if (updateSettings.subscriptionType=="Paid")
                  
                  MyCustomTextField.textField(
                    textInputType: TextInputType.number,
                      lableText: "Subscription Amount",
                      hintText: "Enter Amount",
                      controller: updateSettings.subscriptionAmountController),
                      if (updateSettings.subscriptionType=="Paid")
                      SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Checkbox( 
                                                    value: updateSettings.isOpen,
                                                    activeColor: AppColors.primary,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        updateSettings.isOpen = value!;
                                                      });
                                                    },
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                  ),
                                                  
                                             
                                                 TextWidget(text: "Is Community Open ?", textSize: 16),
                      ],),
                      SizedBox(height: 10),
                     MyCustomTextField.textField(hintText: "Enter Community description", controller:updateSettings.aboutCommunityController, lableText: "About Community",maxLine: 5),
                     SizedBox(height: 16,),
                     MyCustomTextField.textField(hintText: "Enter whatsapp group link", controller: updateSettings.whatsappGroupLinkController, lableText: "Whatsapp Group Link"),
                     SizedBox(height: 16,),
                     Align(child: TextWidget(text: "Terms and conditions", textSize: 13),alignment: Alignment.centerLeft,),
                     SizedBox(height: 16,),
                     AppButton.primaryButton(
                      bgColor: AppColors.green700,
                         onButtonPressed: () {},
                         
                         title: "Add Term"),
                         SizedBox(height: 16,),
              AppButton.primaryButton(
                bgColor: AppColors.primary,
                  onButtonPressed: () {
                    Helper.loader(context);
                    updateSettings.updateCommunity(base64);
                  },
                  
                  title: "Update Community"),
                  SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 0),
                child: AppButton.primaryButton(
                  bgColor: AppColors.primary,
                    onButtonPressed: () {
                      showDialog(
                       context: context,
                       builder: (BuildContext context) {
                         return AlertDialog(
                           backgroundColor: AppColors.blackCard,
                           title:  Column(
                             children: [
                              CircleAvatar(
                radius: 25,
                foregroundImage: NetworkImage(
                  createdCommunity.createdCommunityDetails[0].image,
                ),
                              ),
                              SizedBox(height: 12,),
                               TextWidget(text: createdCommunity.createdCommunityDetails[0].name, textSize: 20,fontWeight: FontWeight.w500,),
                             ],
                           ),
                           content: Padding(
                             padding: const EdgeInsets.only(left: 25),
                             child: TextWidget(text: 'Are you sure to delete community', textSize: 13,),
                           ),
                           actions: [
                             AppButton.primaryButton(
                              bgColor: AppColors.primary,
                               title: 'Delete Community',
                               onButtonPressed: () async{
                                 await updateSettings.deleteCommunity();
                                
                                
                               },
                               
                             ),
                             
                           ],
                         );
                       },
                     );
                      
                    },
                   
                    title: "Delete Community"),
              ),
                  SizedBox(height: 16,),
              ],
            ),
          ),
          )
        )
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