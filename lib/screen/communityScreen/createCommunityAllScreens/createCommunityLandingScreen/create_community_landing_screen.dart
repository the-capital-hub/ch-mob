import 'package:capitalhub_crm/screen/communityScreen/createCommunityAllScreens/createCommunityStartScreen/create_community_start_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCommunityLandingScreen extends StatefulWidget {
  const CreateCommunityLandingScreen({super.key});

  @override
  State<CreateCommunityLandingScreen> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
            drawer: const DrawerWidget(),
            backgroundColor: AppColors.transparent,
            appBar: HelperAppBar.appbarHelper(
              title: "Create Community",
              hideBack: true,
              autoAction: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage(PngAssetPath.communityImg),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  const SizedBox(height: 20),
                  const TextWidget(
                      text: "Create your own Community", textSize: 20),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: AppButton.primaryButton(
                        onButtonPressed: () {
                          Get.to(() => const CreateCommunityStartScreen());
                        },
                        title: "Create Now"),
                  ),
                ],
              ),
            )));
  }
}
