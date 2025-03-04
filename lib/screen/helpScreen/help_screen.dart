import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          drawer: const DrawerWidget(),
          backgroundColor: AppColors.black,
          appBar: HelperAppBar.appbarHelper(
              title: "Help", hideBack: true, autoAction: true),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.help_outline, color: AppColors.primary),
                      SizedBox(width: 12),
                      TextWidget(text: "Help Center", textSize: 16),
                    ],
                  ),
                  sizedTextfield,
                  const TextWidget(
                      text: "Hello, how can we help ?",
                      textSize: 22,
                      fontWeight: FontWeight.w500),
                  sizedTextfield,
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: 4,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: AppColors.blackCard,
                        surfaceTintColor: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Image.asset(imageList[index], height: 85),
                              sizedTextfield,
                              TextWidget(
                                  text: titleList[index],
                                  maxLine: 2,
                                  align: TextAlign.center,
                                  textSize: 15)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  sizedTextfield,
                  const Row(
                    children: [
                      Icon(Icons.article_outlined, color: AppColors.primary),
                      SizedBox(width: 8),
                      TextWidget(
                          text: "Featured Articles",
                          textSize: 16,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                  sizedTextfield,
                  Card(
                    color: AppColors.blackCard,
                    surfaceTintColor: AppColors.blackCard,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Card(
                        color: AppColors.white12,
                        child: ListView.separated(
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return const Divider(height: 0);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                                position: index,
                                delay: const Duration(milliseconds: 100),
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                    // horizontalOffset: 1000,
                                    verticalOffset: 50.0,
                                    child: ListTile(
                                      visualDensity: VisualDensity.compact,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12),
                                      title: const TextWidget(
                                          text: "Guide: How to use management",
                                          textSize: 14),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.whiteCard,
                                        size: 18,
                                      ),
                                    )));
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  var imageList = [
    PngAssetPath.contactusImg,
    PngAssetPath.mailImg,
    PngAssetPath.accountImg,
    PngAssetPath.helpImg
  ];
  var titleList = [
    "Contact us",
    "Mail us",
    "Account, Profile and Network",
    "Get Help"
  ];
}
