import 'package:capitalhub_crm/screen/documentationScreen/selected_document_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/custom_dialogue.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
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

class _DocumentationScreenState extends State<DocumentationScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController firstNameController = TextEditingController();
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
    _tabController = TabController(length: 2, vsync: this);
  }

  late final TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showCustomPopup(
                  context: context,
                  title: "Select your folder",
                  message: "Select files",
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyCustomTextField.textField(
                        hintText: "Select files",
                        controller: firstNameController,
                        fillColor: AppColors.whiteCard),
                  ),
                  button1Text: "Cancel",
                  button2Text: "Upload",
                  icon: Icons.upload,
                  onButton1Pressed: () {
                    Get.back();
                  },
                  onButton2Pressed: () {
                    Get.back();
                  },
                );
              },
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.upload,
                size: 30,
                color: AppColors.white,
              ),
            ),
            drawer: const DrawerWidget(),
            backgroundColor: AppColors.transparent,
            appBar: HelperAppBar.appbarHelper(
                title: "Documentation", autoAction: true, hideBack: true),
            body: Column(children: [
              TabBar(
                padding: EdgeInsets.zero,
                controller: _tabController,
                isScrollable: false,
                dividerHeight: 0,
                // tabAlignment: TabAlignment.start,
                indicator: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                labelPadding: const EdgeInsets.only(left: 12),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(text: "Pre-Exixting Folders"),
                  Tab(text: "Data Room"),
                ],
                labelColor: GetStoreData.getStore.read('isInvestor')
                    ? AppColors.primaryInvestor
                    : AppColors.primary,
                unselectedLabelColor: AppColors.white,
                unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 16),
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 16),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
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
                                          onButtonPressed: () {
                                            Get.to(() => SelectedDocumentScreen(
                                                  title: title[index],
                                                ));
                                          },
                                          title: "Upload",
                                          width: 85,
                                          height: 25,
                                          bgColor: AppColors.blackCard,
                                          fontSize: 11)),
                                )));
                      },
                    ),
                  ],
                ),
              )
            ])));
  }
}
