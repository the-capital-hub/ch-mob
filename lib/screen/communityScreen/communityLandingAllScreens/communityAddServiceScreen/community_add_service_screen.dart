import 'dart:convert';

import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/controller/exploreController/explore_controller.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/homeScreen/home_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/datePicker/datePicker.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/imagePickerWidget/image_picker_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:capitalhub_crm/widget/timePicker/timePicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommunityAddServiceScreen extends StatefulWidget {
  const CommunityAddServiceScreen({super.key});

  @override
  State<CommunityAddServiceScreen> createState() => _CommunityAddServiceScreenState();
}

class _CommunityAddServiceScreenState extends State<CommunityAddServiceScreen> with SingleTickerProviderStateMixin{
  // ExploreController exploreController = Get.put(ExploreController());
  late final TabController _tabController;
    TextEditingController input = TextEditingController();
  String selectedTimeline = "Hours";
  String base64 = "";
  @override
  void initState() {
    super.initState();
    // exploreController.selectedType = "startup";
    // exploreController.tabController = TabController(length: 4, vsync: this);
    // exploreController.getExploreCollection();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // exploreController.tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
            backgroundColor: AppColors.transparent,
            drawer: GetStoreData.getStore.read('isInvestor')
                ? const DrawerWidgetInvestor()
                : const DrawerWidget(),
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
            body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // MyCustomTextField.textField(
                    //     hintText: "Search",
                    //     controller: searchController,
                    //     borderRadius: 12,
                    //     prefixIcon: Icon(
                    //       Icons.search,
                    //       color: AppColors.white54,
                    //     )),
                    TextWidget(text: "Add New Service", textSize: 20,fontWeight: FontWeight.w500,),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        Expanded(
                          child: TabBar(
                            controller: _tabController,
                            dividerHeight: 0,
                            indicator: BoxDecoration(
                              color: GetStoreData.getStore.read('isInvestor')
                                  ? AppColors.primaryInvestor
                                  : AppColors.primary,
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 4),
                            indicatorPadding: const EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 5.0),
                            indicatorSize: TabBarIndicatorSize.tab,
                            onTap: (val) {
                              
                              // if (val == 0) {
                              //   exploreController.selectedType = "startup";
                              //   // exploreController.getExploreCollection();
                              // } else if (val == 1) {
                              //   exploreController.selectedType = "founder";
                              //   // exploreController.getExploreCollection();
                              // } else if (val == 2) {
                              //   exploreController.selectedType = "investor";
                              //   // exploreController.getExploreCollection();
                              // } else if (val == 3) {
                              //   exploreController.selectedType = "vc";
                              //   // exploreController.getExploreCollection();
                              // }
                            },
                            tabs: const [
                              Tab(text: "Priority DM"),
                              Tab(text: "Meeting"),
                              Tab(text: "Event"),
                              Tab(text: "Webinar"),
                            ],
                            labelColor: GetStoreData.getStore.read('isInvestor')
                                ? AppColors.black
                                : AppColors
                                    .white, // Text color for selected tab
                            unselectedLabelColor:
                                Colors.white, // Text color for unselected tab
                            unselectedLabelStyle:
                                const TextStyle(fontWeight: FontWeight.normal),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                      ],
                    ),
                    const SizedBox(height: 12),

                    // const Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                    //   child: TextWidget(
                    //       text: "Startup Results",
                    //       textSize: 16,
                    //       fontWeight: FontWeight.w500),
                    // ),
                    Expanded(
                      child: 
                      // exploreController.isLoading.value
                      //     ? Helper.pageLoading()
                      //     : 
                          TabBarView(
                              controller: _tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                  priorityDMTab(),
                                  meetingTab(),
                                  eventTab(),
                                  webinarTab(),
                                ]),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: AppButton.outlineButton(
                  borderColor: GetStoreData.getStore.read('isInvestor')? AppColors.primaryInvestor:AppColors.primary,
                  onButtonPressed: () {
                    
                  },
                  title: "Cancel"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton.primaryButton(
                
                  onButtonPressed: () {
                    
                  },
                  title: "Create Service"),
            ),
            
            
          ]),
        ),
            )
    );
  }
  
priorityDMTab(){
  return 
        SingleChildScrollView(
          child: Column(
              children: [
                  MyCustomTextField.textField(hintText: "Enter service title", controller: input,lableText: "Title"),
                  SizedBox(height: 16,),
                  MyCustomTextField.textField(hintText: "Enter service description", controller: input,lableText: "Description",maxLine: 7),
                  SizedBox(height: 16,),
                  MyCustomTextField.textField(hintText: "Enter amount", controller: input,lableText: "Amount (\u{20B9})"),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      
                      
                      Expanded(child: MyCustomTextField.textField(hintText: "Enter Response Timeline", controller: input,lableText: "Response Timeline")),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: DropDownWidget(
                                                  status: selectedTimeline,
                                                  statusList: const [
                                                    'Hours',
                                                    'Days',
                                                    
                                                  ],
                                                  onChanged: (val) {
                                                    setState(() {
                                                      selectedTimeline = val.toString();
                                                    });
                                                  }),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  MyCustomTextField.textField(hintText: "Enter topics, seperated by commas", controller: input,lableText: "Topics (comma-seperated)"),
              ]
            ),
        );
}
meetingTab(){
   return SingleChildScrollView(
     child: Column(
         children: [
             MyCustomTextField.textField(hintText: "Enter service title", controller: input,lableText: "Title"),
             SizedBox(height: 16,),
             MyCustomTextField.textField(hintText: "Enter service description", controller: input,lableText: "Description",maxLine: 7),
            
             SizedBox(height: 16,),
             Row(
               children: [
                 
                 
                  Expanded(child: MyCustomTextField.textField(hintText: "Enter amount", controller: input,lableText: "Amount (\u{20B9})")),
                 SizedBox(width: 8,),
                 Expanded(child: MyCustomTextField.textField(hintText: "Enter duration", controller: input,lableText: "Duration (minutes)")),
               ],
             ),
             SizedBox(height: 16,),
             MyCustomTextField.textField(hintText: "Enter topics, seperated by commas", controller: input,lableText: "Topics (comma-seperated)"),
             SizedBox(height: 16,),
             MyCustomTextField.textField(
                   suffixIcon: Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: Image.asset(
                       PngAssetPath.meetingIcon,
                       color: AppColors.white,
                       height: 0,
                     ),
                   ),
                   hintText: "No dates selected",
                   readonly: true,
                   lableText: "Select Available Days",
                   onTap: () async {
                     final selectedDate =
                         await selectDate(context, DateTime.now());
     
                     if (selectedDate != null) {
                       input.text = Helper.formatDatePost(
                           selectedDate.toString());
                       setState(() {});
                     }
                   },
                   controller: input),
         ]
       ),
   );
        
}
eventTab(){
   return 
        SingleChildScrollView(
          child: Column(
              children: [
                  MyCustomTextField.textField(hintText: "Enter service title", controller: input,lableText: "Title"),
                  SizedBox(height: 16,),
                  MyCustomTextField.textField(hintText: "Enter service description", controller: input,lableText: "Description",maxLine: 7),
                 
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      
                      
                       Expanded(child: MyCustomTextField.textField(hintText: "Enter amount", controller: input,lableText: "Amount (\u{20B9})")),
                      SizedBox(width: 8,),
                      Expanded(child: MyCustomTextField.textField(hintText: "Enter duration", controller: input,lableText: "Duration (minutes)")),
                    ],
                  ),
                  SizedBox(height: 16,),
                  MyCustomTextField.textField(hintText: "Enter discount (%)", controller: input,lableText: "Discount (%)"),
                  
              ]
            ),
        );
}
webinarTab(){
   return 
       SingleChildScrollView(
          child: Column(
            children: [
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Title",
                  hintText: "Enter service title",
                  controller: input),
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Description",
                  hintText: "Enter service description",
                  maxLine: 7,
                  controller: input),
              sizedTextfield,
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
                       AppColors.blackCard,
                  
                                        borderRadius: BorderRadius.circular(7)
                  
                  
                                        ),
                                        child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                  child:  TextWidget(text: "Upload Image", textSize: 13),
                                        ),
                                      ),
                    ]),
                ),
              sizedTextfield,
              Row(
                children: [
                  Expanded(
                    child: MyCustomTextField.textField(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            PngAssetPath.meetingIcon,
                            color: AppColors.white,
                            height: 0,
                          ),
                        ),
                        hintText: "Select date",
                        readonly: true,
                        lableText: "Date",
                        onTap: () async {
                          final selectedDate =
                              await selectDate(context, DateTime.now());
          
                          if (selectedDate != null) {
                            input.text = Helper.formatDatePost(
                                selectedDate.toString());
                            setState(() {});
                          }
                        },
                        controller: input),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: MyCustomTextField.textField(
                hintText: "Enter duration (min.)",
                
                lableText: "Duration (min.)",
                textInputType: TextInputType.number,
                onChange: (value) {
                  
                  // _validateDuration(value, webinarController.durationMinutesController);
                },
                    
                    controller: input,
                  )),
                ],
              ),
              sizedTextfield,
              Row(
                children: [
                  Expanded(
                    child: MyCustomTextField.textField(
                      hintText: "Select start time",
                      readonly: true,
                      lableText: "Start Time",
                      onTap: () async {
                        DateTime? selectedTime =
                            await selectTime(context, false);
          
                        if (selectedTime != null) {
                          input.text =
                              DateFormat('hh:mm a').format(selectedTime);
                              
                        }
                      },
                      controller: input,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyCustomTextField.textField(
                      hintText: "Select end time",
                      readonly: true,
                      lableText: "End Time",
                      onTap: () async {
                        DateTime? selectedTime =
                            await selectTime(context, false);
          
                        if (selectedTime != null) {
                          input.text =
                              DateFormat('hh:mm a').format(selectedTime);
                              
                        }
                      },
                      controller: input,
                    ),
                  ),
                ],
              ),
              
              
              sizedTextfield,
              MyCustomTextField.textField(
                textInputType: TextInputType.number,
                  lableText: "Price",
                  hintText: "Enter price",
                  controller: input),
              sizedTextfield,
              MyCustomTextField.textField(
                textInputType: TextInputType.number,
                  lableText: "Discount (%)",
                  hintText: "Enter discount (%)",
                  controller: input),
              sizedTextfield,
            ],
          ),
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
