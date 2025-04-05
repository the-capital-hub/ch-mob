import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityAboutController/community_about_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityLandingScreen/community_landing_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CreateCommunityOverScreen extends StatefulWidget {
  const CreateCommunityOverScreen({super.key});

  @override
  State<CreateCommunityOverScreen> createState() =>
      _CreateCommunityOverScreenState();
}

class _CreateCommunityOverScreenState extends State<CreateCommunityOverScreen> {
  CommunityController createdCommunity = Get.put(CommunityController());
  TextEditingController urlController = TextEditingController();
  CommunityAboutController aboutCommunity = Get.put(CommunityAboutController());
  @override
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Future.wait([
        // createdCommunity.getCommunityById(),
        aboutCommunity.getAboutCommunity()
      ]).then((values) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            urlController.text =
                aboutCommunity.aboutCommunityDetailsList[0].shareLink!;
          });
        });
      });
    });
    super.initState();
  }

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
          title: "Create Community",
          hideBack: true,
          autoAction: true,
        ),
        body: Obx(
          () => aboutCommunity.isLoading.value
              ? Helper.pageLoading()
              // : createdCommunity.createdCommunityDetails.isEmpty
              //     ? const Center(
              //         child: TextWidget(
              //             text: "No Community Available", textSize: 16))
              : Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextWidget(
                        align: TextAlign.center,
                          text:
                              "Congrats! ${aboutCommunity.aboutCommunityDetailsList[0].name}\nis live!",
                          textSize: 20,),
                      sizedTextfield,
                      sizedTextfield,
                      CircleAvatar(
                        radius: 60,
                        foregroundImage: NetworkImage(
                          aboutCommunity.aboutCommunityDetailsList[0].image!,
                        ),
                      ),
                      sizedTextfield,
                      TextWidget(
                        text: aboutCommunity.aboutCommunityDetailsList[0].name!,
                        textSize: 20,
                      ),
                      sizedTextfield,
                      aboutCommunity.aboutCommunityList[0].community!
                                  .subscription! ==
                              "free"
                          ? const TextWidget(
                              text: "Any one can join for free", textSize: 13)
                          : TextWidget(
                              text:
                                  "Subscription Amount : \u{20B9}${aboutCommunity.aboutCommunityList[0].community!.amount}",
                              textSize: 13),
                      sizedTextfield,
                      Divider(
                        thickness: 1,
                        color: AppColors.white54,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: MyCustomTextField.textField(
                            lableText: "Community Page URL",
                            hintText: "Capitalhub/Community",
                            controller: urlController,
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.mobile_screen_share_rounded,
                                color: AppColors.whiteCard,
                                size: 22,
                              ),
                              onPressed: () {
                                sharePostPopup(context, "", urlController.text);
                              },
                            )),
                      ),
                    ],
                  ),
                ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 12,
          ),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                communityLogo =
                    aboutCommunity.aboutCommunityList[0].community!.image!;
                communityName =
                    aboutCommunity.aboutCommunityList[0].community!.name!;
                isAdmin = true;
                Get.to(() => const CommunityLandingScreen());
              },
              title: "Continue"),
        ),
      ),
    );
  }
}
