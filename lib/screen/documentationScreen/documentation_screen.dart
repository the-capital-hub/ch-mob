import 'package:capitalhub_crm/screen/documentationScreen/selected_document_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../controller/documentController/document_controller.dart';
import '../../utils/constant/app_var.dart';

class DocumentationScreen extends StatefulWidget {
  const DocumentationScreen({super.key});

  @override
  State<DocumentationScreen> createState() => _DocumentationScreenState();
}

class _DocumentationScreenState extends State<DocumentationScreen> {
  DocumentController documentController = Get.put(DocumentController());

  List<Color> bgcolor = [
    const Color(0xff42A76F),
    const Color(0xffCE9644),
    const Color(0xffAA594D),
    const Color(0xff3F8CFF),
    const Color(0xff495EB1),
  ];
  List<String> title = [
    'Business',
    'KYC Details',
    'Legal & Compliance',
    'Pitch Deck',
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          drawer: const DrawerWidget(),
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
              title: "Documentation", autoAction: true, hideBack: true),
          body:  Column(
                  children: [
                    ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            delay: const Duration(milliseconds: 100),
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                                horizontalOffset: 1000,
                                verticalOffset: 50.0,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: AppColors.white38,
                                          width: 0.5)),
                                  child: ListTile(
                                      onTap: () {
                                        Get.to(() => SelectedDocumentScreen(
                                              title: title[index],
                                            ));
                                      },
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                      leading: Card(
                                        color: bgcolor[index],
                                        surfaceTintColor: bgcolor[index],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            PngAssetPath.documentIcon,
                                            height: 22,
                                          ),
                                        ),
                                      ),
                                      horizontalTitleGap: 8,
                                      title: TextWidget(
                                          text: title[index], textSize: 15),
                                      trailing: AppButton.primaryButton(
                                          onButtonPressed: () {},
                                          title: "Upload",
                                          width: 81,
                                          height: 25,
                                          bgColor: AppColors.blackCard,
                                          fontSize: 11)),
                                )));
                      },
                    ),
                  ],
                ),
        ));
  }
}
