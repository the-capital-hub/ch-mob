import "package:capitalhub_crm/controller/resourceController/resource_controller.dart";
import "package:capitalhub_crm/utils/appcolors/app_colors.dart";
import "package:capitalhub_crm/utils/constant/app_var.dart";
import "package:capitalhub_crm/widget/appbar/appbar.dart";
import "package:capitalhub_crm/widget/textwidget/text_widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class ResourceDetailsScreen extends StatefulWidget {
  int index;
  ResourceDetailsScreen({required this.index, super.key});

  @override
  State<ResourceDetailsScreen> createState() => _ResourceDetailsScreenState();
}

class _ResourceDetailsScreenState extends State<ResourceDetailsScreen> {
  final ResourceController resourceController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
            title: "", hideBack: false, autoAction: false),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              TextWidget(
                  text: resourceController.menuItemsName[widget.index],
                  textSize: 16),
              Divider(
                color: AppColors.grey700,
              ),
              Image.asset(
                resourceController.menuItemsIcons[widget.index],
                height: 30,
                width: 30,
              ),
              TextWidget(
                text: resourceController.menuItemsName[widget.index],
                textSize: 16,
                fontWeight: FontWeight.bold,
                maxLine: 9,
              ),
              TextWidget(
                text: resourceController.menuItemsName[widget.index],
                textSize: 16,
                fontWeight: FontWeight.bold,
                maxLine: 9,
              ),
              ListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                contentPadding:
                    const EdgeInsets.only(left: 55, top: 0, bottom: 0),
                title: TextWidget(
                  text: resourceController.menuItemsName[widget.index],
                  textSize: 16,
                  fontWeight: FontWeight.w500,
                  maxLine: 1,
                  color: AppColors.white,
                ),
                onTap: () {
                  // Get.to(communitySubPages[communitySubItemsIndex]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
