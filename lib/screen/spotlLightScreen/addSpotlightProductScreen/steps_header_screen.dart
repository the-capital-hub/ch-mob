import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'extras_product_Screen.dart';
import 'main_info_product_screen.dart';
import 'makers_product_screen.dart';
import 'media_product_screen.dart';

class StepperHeader extends StatelessWidget {
  final int currentStep;
  final Function(int) onStepTapped;

  const StepperHeader({
    super.key,
    required this.currentStep,
    required this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    const totalSteps = 4;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index.isEven) {
          int step = index ~/ 2 + 1;
          bool isActive = step == currentStep;
          bool isCompleted = step < currentStep;

          Widget circle = CircleAvatar(
            radius: 18,
            backgroundColor:
                isActive || isCompleted ? AppColors.blue : Colors.grey,
            child: TextWidget(
              text: '$step',
              color: AppColors.white,
              textSize: 14,
            ),
          );

          if (isCompleted) {
            return GestureDetector(
              onTap: () => onStepTapped(step),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: circle,
              ),
            );
          } else {
            return circle;
          }
        } else {
          int leftStep = index ~/ 2 + 1;
          Color lineColor =
              leftStep < currentStep ? Colors.blue : AppColors.grey;

          return Container(
            width: 30,
            height: 2,
            color: lineColor,
          );
        }
      }),
    );
  }
}

void navigateToProductStep(int step) {
  switch (step) {
    // case 1:
    //   Get.off(const MainInfoProductScreen());
    //   break;
    // case 2:
    //   Get.off(const MediaProductScreen());
    //   break;
    // case 3:
    //   Get.off(const MakersProductScreen());
    //   break;
    // case 4:
    //   Get.off(const ExtraInformationProductScreen());
    //   break;
  }
}
