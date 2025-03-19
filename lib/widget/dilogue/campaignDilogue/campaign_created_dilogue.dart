import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../textWidget/text_widget.dart';

Future<bool> campaignCreatedPopup(
  BuildContext context,
  Function() onSaveDraft,
  Function() onSchedule,
  Function() onRunCampaign,
) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: AppColors.blackCard,
            contentPadding: const EdgeInsets.all(12),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                    backgroundColor: AppColors.green700,
                    radius: 25,
                    child: Icon(Icons.check, color: AppColors.white, size: 30)),
                const SizedBox(height: 16),
                const TextWidget(
                  text: "Campaign Created Successfully!",
                  textSize: 16,
                ),
                const SizedBox(height: 8),
                TextWidget(
                  text: "What would you like to do with this campaign?",
                  textSize: 14,
                  maxLine: 2,
                  align: TextAlign.center,
                  color: AppColors.white54,
                ),
                const SizedBox(height: 16),
                _buildButton(
                  text: "Save as Draft",
                  color: Colors.brown,
                  icon: Icons.check,
                  onTap: onSaveDraft,
                ),
                const SizedBox(height: 12),
                _buildButton(
                  text: "Schedule Campaign",
                  color: AppColors.blue,
                  icon: Icons.schedule,
                  onTap: onSchedule,
                ),
                const SizedBox(height: 12),
                _buildButton(
                  text: "Run Campaign Now",
                  color: AppColors.green700,
                  icon: Icons.play_arrow,
                  onTap: onRunCampaign,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildButton({
  required String text,
  required Color color,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.white),
          const SizedBox(width: 8),
          TextWidget(
            text: text,
            textSize: 14,
          ),
        ],
      ),
    ),
  );
}
