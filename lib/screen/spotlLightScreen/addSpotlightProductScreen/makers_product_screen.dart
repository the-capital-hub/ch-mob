import 'package:capitalhub_crm/controller/companyController/company_controller.dart';
import 'package:capitalhub_crm/screen/spotlLightScreen/addSpotlightProductScreen/extras_product_Screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/spotlightController/spotlight_controller.dart';
import '../../../model/companyModel/search_user_model.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/text_field/text_field.dart';
import '../../../widget/textwidget/text_widget.dart';
import 'media_product_screen.dart';
import 'steps_header_screen.dart';

class MakersProductScreen extends StatefulWidget {
  const MakersProductScreen({super.key});

  @override
  State<MakersProductScreen> createState() => _MakersProductScreenState();
}

class _MakersProductScreenState extends State<MakersProductScreen> {
  final SpotlightController _spotlightController = Get.find();

  TextEditingController searchController = TextEditingController();
  CompanyController companyController = Get.put(CompanyController());
  void addUser(UserData user) {
    if (!_spotlightController.selectedUsers
        .any((u) => u.userId == user.userId)) {
      setState(() {
        _spotlightController.selectedUsers.add(user);
        searchController.clear();
        companyController.userData.clear();
      });
    }
  }

  void removeUser(UserData user) {
    setState(() {
      _spotlightController.selectedUsers
          .removeWhere((u) => u.userId == user.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Makers Product"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StepperHeader(
                  currentStep: 3,
                  onStepTapped: (step) {
                    if (step < 3) {
                      navigateToProductStep(step);
                    }
                  },
                ),
                sizedTextfield,
                MyCustomTextField.textField(
                  hintText: "Search Team Member",
                  lableText: "Team Member",
                  controller: searchController,
                  textInputType: TextInputType.text,
                  onChange: (value) async {
                    if (value.trim().isEmpty) {
                      setState(() {
                        companyController.userData.clear();
                      });
                    } else {
                      await companyController.searchUsers(value);
                    }
                  },
                ),
                Obx(() {
                  if (companyController.isUserLoading.value) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: AppColors.white54,
                      )),
                    );
                  }

                  if (companyController.userData.isEmpty) {
                    return const SizedBox();
                  }

                  return Container(
                    height: 200,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: AppColors.blackCard,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.white12,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: companyController.userData.length,
                      separatorBuilder: (context, index) => Divider(
                        color: AppColors.white12,
                        height: 0,
                      ),
                      itemBuilder: (context, index) {
                        final user = companyController.userData[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePicture!),
                          ),
                          title: TextWidget(
                              text: "${user.firstName} ${user.lastName}",
                              textSize: 14),
                          onTap: () {
                            addUser(user);
                          },
                        );
                      },
                    ),
                  );
                }),
                if (_spotlightController.selectedUsers.isNotEmpty) ...[
                  const SizedBox(height: 22),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.blackCard,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.white12,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        sizedTextfield,
                        const TextWidget(
                            text: "Selected Users",
                            textSize: 14,
                            fontWeight: FontWeight.w500),
                        sizedTextfield,
                        Divider(),
                        ListView.separated(
                          itemCount: _spotlightController.selectedUsers.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => Divider(
                            color: AppColors.white12,
                            height: 0,
                          ),
                          itemBuilder: (context, index) {
                            final user =
                                _spotlightController.selectedUsers[index];
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(user.profilePicture ?? ''),
                              ),
                              title: TextWidget(
                                text: "${user.firstName} ${user.lastName}",
                                textSize: 14,
                              ),
                              trailing: IconButton(
                                icon:
                                    Icon(Icons.close, color: AppColors.white54),
                                onPressed: () => removeUser(user),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
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
                      Get.to(() => const ExtraInformationProductScreen());
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
