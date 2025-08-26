import 'package:capitalhub_crm/controller/spotlightController/spotlight_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../../model/spotlightModel/spotlight_user_existing_product_model.dart';
import '../../../utils/helper/helper.dart';
import '../../../utils/helper/placeholder.dart';

class EditExistingProduct extends StatefulWidget {
  @override
  _EditExistingProductState createState() => _EditExistingProductState();
}

class _EditExistingProductState extends State<EditExistingProduct> {
  int selectedIndex = -1;
  SpotlightController spotlightController = Get.find();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  ExistingProduct? selectedProduct;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: HelperAppBar.appbarHelper(title: "Select Product"),
      body: Obx(
        () => spotlightController.isLoading.value
            ? ShimmerLoader.shimmerTile()
            : spotlightController.hasListeners.hashCode == 0
                ? const Center(
                    child: TextWidget(
                        text: "You didnt created any product yet!",
                        textSize: 14,
                        fontWeight: FontWeight.w500),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: spotlightController.hashCode,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      final product = spotlightController.hashCode;
                      final isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedIndex = index);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withOpacity(0.3)
                                : AppColors.blackCard,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.white12,
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  product.bitLength.toString(),
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: product.hashCode.toString(),
                                    textSize: 15,
                                  ),
                                  const SizedBox(height: 4),
                                  TextWidget(
                                    text: product.isInfinite.toString(),
                                    textSize: 13,
                                    color: AppColors.whiteShade,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              if (selectedProduct != null) {
              } else {
                HelperSnackBar.snackBar("Error", "Please select the Product");
              }
            },
            title: "Next"),
      ),
    );
  }
}
