import 'package:capitalhub_crm/screen/communityScreen/communityDrawerScreen/community_drawer_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAboutScreen/communities_about_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/createCommunityAllScreens/createCommunityOverScreen/create_community_over_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityUpdateSettingsScreen/community_update_settings_screen.dart';
import 'package:capitalhub_crm/screen/manageAccountScreen/manage_account_Screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/personal_info_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/profile_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      decoration: bgDec,
        child: Scaffold(
          drawer: const CommunityDrawerWidget(),
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "Settings",
            hideBack: true,
            autoAction: true,
          ),
          body: Padding(padding: EdgeInsets.all(12),
          child: Column(
children: [
  CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    '${GetStoreData.getStore.read('profile_image')}'),
                              ),
  SizedBox(height: 8,),
  TextWidget(text: "${GetStoreData.getStore.read('name')}", textSize: 16, fontWeight: FontWeight.w500,),
  SizedBox(height: 8,),
  InkWell(
    onTap: (){
      Get.to(() =>   ProfileScreen());
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextWidget(text: "Edit Profile", textSize: 13),
      ),
      color: AppColors.brown,
    ),
  ),
  SizedBox(height: 8,),
  Divider(),

  ListTile(title: TextWidget(text: "Account Settings", textSize: 16,color: AppColors.white54,),visualDensity: VisualDensity.compact,),
  
  
  ListTile(title: TextWidget(text: "Edit Profile", textSize: 16),trailing: IconButton(onPressed: (){Get.to(() =>   ProfileScreen());}, icon: Icon(Icons.chevron_right,color: AppColors.white,)),visualDensity: VisualDensity.compact,),
  
  ListTile(title: TextWidget(text: "Change Password", textSize: 16),trailing: IconButton(onPressed: (){Get.to(() =>  const ManageAccountScreen());}, icon: Icon(Icons.chevron_right,color: AppColors.white,)),visualDensity: VisualDensity.compact,),
  
  ListTile(title: TextWidget(text: "Community Settings", textSize: 16),trailing: IconButton(onPressed: (){
    Get.to(() =>  const UpdateSettingsScreen());
  }, icon: Icon(Icons.chevron_right,color: AppColors.white,))),
  
  Divider(),
  SizedBox(height: 8,),
  
  ListTile(title: TextWidget(text: "More", textSize: 16,color: AppColors.white54,),visualDensity: VisualDensity.compact,),
  
  ListTile(title: TextWidget(text: "About Us", textSize: 16),trailing: IconButton(onPressed: (){Get.to(() =>  const CommunityAboutScreen());}, icon: Icon(Icons.chevron_right,color: AppColors.white,)),visualDensity: VisualDensity.compact,),
  
  ListTile(title: TextWidget(text: "Privacy Policy", textSize: 16),trailing: IconButton(onPressed: (){
    Helper.launchUrl(
                                                                                    "https://www.thecapitalhub.in/privacy");
                                                                              
    
  }, icon: Icon(Icons.chevron_right,color: AppColors.white,)),visualDensity: VisualDensity.compact,),
  
  ListTile(title: TextWidget(text: "Terms and conditions", textSize: 16),trailing: IconButton(onPressed: (){Helper.launchUrl(
                                                                                    "https://www.thecapitalhub.in/terms-and-conditions");}, icon: Icon(Icons.chevron_right,color: AppColors.white,))),



],
          ) ,
          ),
        )
    );
  }
}