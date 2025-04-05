import 'package:capitalhub_crm/controller/companyController/company_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textWidget/text_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constant/app_var.dart';
import '../../utils/helper/helper.dart';
import '../../widget/appbar/appbar.dart';

class AddCoreTeamScreen extends StatefulWidget {
  const AddCoreTeamScreen({super.key});

  @override
  State<AddCoreTeamScreen> createState() => _AddCoreTeamScreenState();
}

class _AddCoreTeamScreenState extends State<AddCoreTeamScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController designation = TextEditingController();
  String userId = "";
  CompanyController companyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Add Core Team"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            searchController.text =
                                "${user.firstName} ${user.lastName}";
                            userId = user.userId!;
                            companyController.userData.clear();
                            setState(() {});
                          },
                        );
                      },
                    ),
                  );
                }),
                sizedTextfield,
                MyCustomTextField.textField(
                  hintText: "Enter Designation",
                  lableText: "Designation",
                  controller: designation,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: AppButton.primaryButton(
            onButtonPressed: () {
              if (userId.isEmpty) {
                HelperSnackBar.snackBar("Error", "Please select a user");
                return;
              }
              Helper.loader(context);
              companyController.addTeamMember(
                role: designation.text.trim(),
                userId: userId,
              );
            },
            title: "Add Member",
          ),
        ),
      ),
    );
  }
}
