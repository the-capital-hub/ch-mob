import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunitySelectTimeSlotScreen extends StatefulWidget {
  const CommunitySelectTimeSlotScreen({super.key});

  @override
  State<CommunitySelectTimeSlotScreen> createState() =>
      _CommunitySelectTimeSlotScreenState();
}

class _CommunitySelectTimeSlotScreenState
    extends State<CommunitySelectTimeSlotScreen> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "Select Time Slot",
            hideBack: false,
            autoAction: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Card(
                  color: AppColors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colors.white38,
                      width: 1,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: TextWidget(
                      text: "Mar 2, 2024 at 15:45",
                      textSize: 16,
                    ),
                  ),
                ),
                sizedTextfield,
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  },
                  child: Card(
                    color:
                        isSelected ? AppColors.primary : AppColors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.transparent
                            : AppColors.white38,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextWidget(
                        text: "09:00 - 09:30",
                        textSize: 16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                        child: AppButton.primaryButton(
                            onButtonPressed: () {},
                            title: "Back to Calendar",
                            bgColor: AppColors.whiteCard,
                            textColor: AppColors.black)),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: AppButton.primaryButton(
                            onButtonPressed: () {}, title: "Confirm Booking"))
                  ],
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
          )),
    );
  }
}
