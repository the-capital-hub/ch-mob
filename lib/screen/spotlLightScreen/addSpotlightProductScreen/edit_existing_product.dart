import 'package:capitalhub_crm/controller/spotlightController/spotlight_controller.dart';
import 'package:capitalhub_crm/screen/spotlLightScreen/addSpotlightProductScreen/main_info_product_screen.dart';
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      spotlightController.getUserProductList();
    });
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
            : spotlightController.userProduct.isEmpty
                ? const Center(
                    child: TextWidget(
                        text: "You didnt created any product yet!",
                        textSize: 14,
                        fontWeight: FontWeight.w500),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: spotlightController.userProduct.length,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      final product = spotlightController.userProduct[index];
                      final isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedIndex = index);
                          selectedProduct = product;
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
                                  product.logo!,
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
                                    text: product.title!,
                                    textSize: 15,
                                  ),
                                  const SizedBox(height: 4),
                                  TextWidget(
                                    text: product.tagline!,
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
                spotlightController.selectedProductId =
                    selectedProduct!.existingProductId!;
                spotlightController.populateProductData(selectedProduct!);
                Get.back();
                Get.to(() => const MainInfoProductScreen());
              } else {
                HelperSnackBar.snackBar("Error", "Please select the Product");
              }
            },
            title: "Next"),
      ),
    );
  }
}
