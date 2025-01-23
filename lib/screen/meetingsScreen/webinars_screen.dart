import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/create_new_webinar_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebinarsScreen extends StatefulWidget {
  const WebinarsScreen({super.key});

  @override
  State<WebinarsScreen> createState() => _WebinarsScreenState();
}

class _WebinarsScreenState extends State<WebinarsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        drawer: const DrawerWidget(),
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Webinars",
          hideBack: true,
          autoAction: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: AppColors.navyBlue,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                              ),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    sizedTextfield,
                    sizedTextfield,
                    const TextWidget(
                      text: "Weekly Webinar",
                      textSize: 25,
                      fontWeight: FontWeight.bold,
                    ),

                    sizedTextfield,
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: AppColors.white,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const TextWidget(
                            text: "10 : 00 am GMT +5:30", textSize: 16)
                      ],
                    ),

                    sizedTextfield,
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: AppColors.white,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const TextWidget(text: "Online", textSize: 16)
                      ],
                    ),

                    sizedTextfield,

                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage(PngAssetPath.accountImg),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        TextWidget(text: "With Pramod Badiger", textSize: 20)
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppButton.primaryButton(
                            onButtonPressed: () {},
                            title: "Join Webinar",
                            bgColor: AppColors.brown,
                            width: 140,
                            height: 45),
                        const SizedBox(width: 15),
                        const Icon(
                          Icons.schedule,
                          color: AppColors.redColor,
                          size: 22,
                        ),
                        const SizedBox(width: 5),
                        const TextWidget(
                          text: "12:49:00 hrs left",
                          textSize: 16,
                          color: AppColors.redColor,
                        ),
                      ],
                    ),
                    // sizedTextfield,
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                Get.to(() => const CreateNewWebinarScreen());
              },
              title: "+ Create Webinars"),
        ),
      ),
    );
  }
}
