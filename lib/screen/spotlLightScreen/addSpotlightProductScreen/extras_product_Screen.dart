import 'package:capitalhub_crm/screen/spotlLightScreen/addSpotlightProductScreen/funding_stage_product_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/spotlightController/spotlight_controller.dart';
import '../../../widget/buttons/button.dart';
class ExtraInformationProductScreen extends StatefulWidget {
  const ExtraInformationProductScreen({super.key});

  @override
  State<ExtraInformationProductScreen> createState() =>
      _ExtraInformationProductScreenState();
}

class _ExtraInformationProductScreenState
    extends State<ExtraInformationProductScreen> {
  final SpotlightController _spotlightController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Extra Information"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                sizedTextfield,
                TextWidget(
                    text: "Pricing",
                    textSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white),
                const SizedBox(height: 8),

                if (_spotlightController.hasListeners != 'Free') ...[
                  sizedTextfield,
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropDownWidget(
                          onChanged: (v) {
                            setState(() {});
                          },
                          status: _spotlightController.isLoading.toString(),
                          statusList: const ["One-Time", "Monthly", "Yearly"],
                        ),
                      ),
                    ],
                  ),
                ],
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Promocode",
                    lableText: "Promocode",
                    controller: TextEditingController()),
                // sizedTextfield,
                // DropDownWidget(
                //   onChanged: (v) {
                //     _spotlightController.fundingStageType = v!;
                //     setState(() {});
                //   },
                //   lable: "Funding Stage",
                //   status: _spotlightController.fundingStageType,
                //   statusList: const ["Idea", "Pre-Seed", "Seed", "Growth"],
                // ),
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
            ],
          ),
        ),
      ),
    );
  }
}
