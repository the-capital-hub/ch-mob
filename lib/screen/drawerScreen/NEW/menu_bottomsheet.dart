import 'dart:ui';
import 'package:capitalhub_crm/model/paymentTransactionModel/payment_transaction_model.dart';
import 'package:capitalhub_crm/screen/campaignsScreen/campaign_landing_screen.dart';
import 'package:capitalhub_crm/screen/chatScreen/chat_member_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/myCommunityScreen/my_community_screen.dart';

import 'package:capitalhub_crm/screen/exploreScreen/explore_screen.dart';
import 'package:capitalhub_crm/screen/helpScreen/help_screen.dart';
import 'package:capitalhub_crm/screen/logoutScreen/logout_Screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/events_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/profile_screen.dart';
import 'package:capitalhub_crm/screen/resourceScreen/resource_screen.dart';
import 'package:capitalhub_crm/screen/savedPostScreen/saved_post_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../manageAccountScreen/manage_account_Screen.dart';
import '../../paymentTransactionScreen/payment_transaction_screen.dart';

showMenuBottomSheet() {
  Get.bottomSheet(
    barrierColor: AppColors.transparent,
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              color: AppColors.white12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.2,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _menuItem(PngAssetPath.explore, 'Explore', () {
                        Get.back(closeOverlays: true);
                        Get.to(() => const ExploreScreen());
                      }),
                      _menuItem(PngAssetPath.documentation, 'Documentation',
                          () {
                        Get.back(closeOverlays: true);
                      }),
                      _menuItem(PngAssetPath.savedPosts, 'Saved Posts', () {
                        Get.back(closeOverlays: true);
                        Get.to(() => const SavedPostScreen());
                      }),
                      _menuItem(PngAssetPath.resources, 'Resources', () {
                        Get.back(closeOverlays: true);
                        Get.to(() => const ResourceScreen());
                      }),
                      _menuItem(PngAssetPath.campaign, 'Campaign', () {
                        Get.back(closeOverlays: true);
                        Get.to(() => const CampaignLandingScreen());
                      }),
                      _menuItem(PngAssetPath.communitiesMenu, 'Communities',
                          () {
                        Get.back(closeOverlays: true);
                        Get.to(() => const MyCommunityScreen());
                      }),
                      _menuItem(PngAssetPath.meetings, 'Meetings', () {
                        Get.back(closeOverlays: true);
                        Get.to(() => const EventsScreen());
                      }),
                      _menuItem(PngAssetPath.payments, 'Payments', () {
                        Get.back(closeOverlays: true);
                        Get.to(() => const PaymentTransactionScreen());
                      }),
                      _menuItem(PngAssetPath.help, 'Help', () {
                        Get.back(closeOverlays: true);
                        Get.to(() => const HelpScreen());
                      }),
                      _menuItem(PngAssetPath.manageAcc, 'Manage Account', () {
                        Get.back(closeOverlays: true);
                        Get.to(() => const ManageAccountScreen());
                      }),
                      _menuItem(PngAssetPath.chat, 'Chat', () {
                        Get.back(closeOverlays: true);
                        Get.to(() => const ChatMemberScreen());
                      }),
                      _menuItem(PngAssetPath.logout, 'Logout', () {
                        Get.back(closeOverlays: true);
                        Get.to(() => const LogoutScreen());
                      }),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back(closeOverlays: true);
                      Get.to(() => const ProfileScreen());
                    },
                    icon: CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                          GetStoreData.getStore.read('profile_image')),
                    ),
                    label: const TextWidget(
                        text: "  View Profile",
                        fontWeight: FontWeight.w500,
                        textSize: 16),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6600),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // InkWell(onTap: (){
        //   Get.back();
        // }, child: Container(height: 70, color: AppColors.transparent))
      ],
    ),
    isScrollControlled: true,
  );
}

Widget _menuItem(String iconPath, String label, Function() ontap) {
  return InkWell(
    onTap: ontap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          iconPath,
          width: 32,
          height: 32,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8),
        TextWidget(text: label, color: AppColors.white, textSize: 12),
      ],
    ),
  );
}
