import 'dart:developer';

import 'package:capitalhub_crm/controller/profileController/profile_controller.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/Auth-Process/authScreen/login_page.dart';
import 'package:capitalhub_crm/screen/Auth-Process/selectWhatYouAreScreen/select_role_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/manageAccountScreen/password_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/campaignDilogue/delete_campaign_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({super.key});

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  List<UserModel> users = GetStoreDataList.getUserList();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      log(users.length.toString());
      bool isInvestor = GetStoreData.getStore.read('isInvestor') ?? false;
      users = GetStoreDataList.getUserList()
          .where((user) => user.isInvestor == isInvestor)
          .toList();
      profileController.getProfile();
    });
    super.initState();
  }

  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          drawer: GetStoreData.getStore.read('isInvestor')
              ? const DrawerWidgetInvestor()
              : const DrawerWidget(),
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
              title: "Manage Account", autoAction: true, hideBack: true),
          body: Obx(
            () => profileController.isLoading.value
                ? Helper.pageLoading()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Card(
                            color: AppColors.blackCard,
                            surfaceTintColor: AppColors.blackCard,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: GetStoreData.getStore
                                                  .read('isInvestor')
                                              ? AppColors.primaryInvestor
                                              : AppColors.primary,
                                          radius: 17,
                                          child: Icon(
                                            Icons.person,
                                            color: GetStoreData.getStore
                                                    .read('isInvestor')
                                                ? AppColors.black
                                                : AppColors.white,
                                            size: 20,
                                          )),
                                      const SizedBox(width: 8),
                                      const TextWidget(
                                          text: "Present account", textSize: 15)
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 0,
                                  thickness: 0.5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundImage: NetworkImage(
                                            GetStoreData.getStore
                                                .read('profile_image')),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: GetStoreData.getStore
                                                .read('name'),
                                            textSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          const SizedBox(height: 4),
                                          TextWidget(
                                              text: GetStoreData.getStore
                                                  .read('email'),
                                              textSize: 12)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: AppButton.primaryButton(
                                      onButtonPressed: () {
                                        deleteCampaignPopup(context, () {
                                          Helper.loader(context);
                                          profileController.delAccount();
                                        });
                                      },
                                      title: "Delete account",
                                      textColor: AppColors.white,
                                      bgColor: AppColors.redColor,
                                      height: 42),
                                ),
                                sizedTextfield,
                              ],
                            ),
                          ),
                          sizedTextfield,
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppColors.white38, width: 1)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: GetStoreData.getStore
                                                .read('isInvestor')
                                            ? AppColors.primaryInvestor
                                            : AppColors.primary,
                                        radius: 17,
                                        child: Icon(
                                          Icons.person,
                                          color: GetStoreData.getStore
                                                  .read('isInvestor')
                                              ? AppColors.black
                                              : AppColors.white,
                                          size: 20,
                                        )),
                                    const SizedBox(width: 8),
                                    const TextWidget(
                                        text: "Accounts", textSize: 15),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const TextWidget(
                                  text:
                                      "Add another account - so you can switch between them easily.",
                                  textSize: 13,
                                  maxLine: 2,
                                ),
                                sizedTextfield,
                                const TextWidget(
                                    text: "Your existing account",
                                    textSize: 13),
                                sizedTextfield,
                                ListView.separated(
                                  itemCount: users.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox();
                                  },
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    UserModel user = users[index];
                                    return InkWell(
                                      onTap: () {
                                        AccountManager.switchAccount(user.id);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        margin: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: AppColors.white38,
                                                width: 1)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              user.id ==
                                                      GetStoreData.getStore
                                                          .read('id')
                                                  ? Icons.radio_button_checked
                                                  : Icons.radio_button_off,
                                              color: GetStoreData.getStore
                                                      .read('isInvestor')
                                                  ? AppColors.primaryInvestor
                                                  : AppColors.primary,
                                            ),
                                            const SizedBox(width: 10),
                                            CircleAvatar(
                                              radius: 16,
                                              backgroundImage: NetworkImage(
                                                  user.profileImage),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  text: user.name,
                                                  textSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                const SizedBox(height: 4),
                                                TextWidget(
                                                    text: user.email,
                                                    textSize: 10)
                                              ],
                                            ),
                                            const Spacer(),
                                            InkWell(
                                                onTap: () {
                                                  if (user.id ==
                                                      GetStoreData.getStore
                                                          .read('id')) {
                                                    HelperSnackBar.snackBar(
                                                        "Error",
                                                        "Switch to another account for remove this");
                                                  } else {
                                                    deleteUser(index);
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.remove_circle_outline,
                                                  color: GetStoreData.getStore
                                                          .read('isInvestor')
                                                      ? AppColors
                                                          .primaryInvestor
                                                      : AppColors.primary,
                                                  size: 18,
                                                )),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                sizedTextfield,
                                AppButton.primaryButton(
                                    onButtonPressed: () {
                                      Get.to(() => const SelectRoleScreen());
                                    },
                                    bgColor: Colors.indigo,
                                    textColor: AppColors.white,
                                    title: "Add another"),
                              ],
                            ),
                          ),
                          sizedTextfield,
                          AppButton.outlineButton(
                              onButtonPressed: () {
                                Get.to(() => const PasswordScreen());
                              },
                              borderColor: AppColors.primary,
                              title: profileController
                                      .profileData.banner!.isPasswordSet
                                  ? "Update Password"
                                  : "Create Password"),
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }

  void deleteUser(int index) async {
    List<UserModel> storedUsers = GetStoreDataList.getUserList();
    if (index >= 0 && index < storedUsers.length) {
      setState(() {
        users.removeAt(index);
      });
      storedUsers.removeAt(index);
      await GetStorage().write(
          'user_list', storedUsers.map((user) => user.toJson()).toList());
    } else {
      log('Invalid index: $index');
    }
  }
}
