import 'package:flutter/material.dart';
import '../../utils/appcolors/app_colors.dart';
import '../textWidget/text_widget.dart';

Future<bool> showCustomPopup({
  required BuildContext context,
  required String title,
  required String message,
  required String button1Text,
  required String button2Text,
  required IconData icon,
  required VoidCallback onButton1Pressed,
  required VoidCallback onButton2Pressed,
  Color? buttonColor = AppColors.redColor,
  Widget? body,
}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.redColor,
              border: Border.all(color: AppColors.white, width: 0),
            ),
            child: Icon(
              icon,
              size: 40,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextWidget(
            text: title,
            textSize: 20,
            color: AppColors.black,
            maxLine: 2,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 12),
          TextWidget(
            text: message,
            textSize: 14,
            color: AppColors.black54,
            maxLine: 2,
            fontWeight: FontWeight.w400,
            align: TextAlign.center,
          ),
          if (body != null) ...[
            const SizedBox(height: 16),
            body,
          ],
          const SizedBox(height: 20),
          Divider(
            color: AppColors.grey3Color,
            height: 0,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: onButton1Pressed,
                  child: SizedBox(
                    height: 45,
                    child: Center(
                      child: TextWidget(
                        text: button1Text.toUpperCase(),
                        color: buttonColor ?? AppColors.primary,
                        fontWeight: FontWeight.w500,
                        textSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                width: 1,
                color: AppColors.grey3Color,
              ),
              Expanded(
                child: InkWell(
                  onTap: onButton2Pressed,
                  child: SizedBox(
                    height: 45,
                    child: Center(
                      child: TextWidget(
                        text: button2Text.toUpperCase(),
                        color: buttonColor ?? AppColors.primary,
                        fontWeight: FontWeight.w500,
                        textSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
