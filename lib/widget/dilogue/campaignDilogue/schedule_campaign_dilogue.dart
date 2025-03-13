import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/helper/helper.dart';
import '../../datePicker/datePicker.dart';
import '../../textWidget/text_widget.dart';
import '../../timePicker/timePicker.dart';

Future<bool> scheduleCampaignPopup(
  BuildContext context,
  Function() onSchedule,
) async {
  TextEditingController dateController = TextEditingController(
      text: Helper.formatDatePost(DateTime.now().toString()));
  TextEditingController timeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));
  return await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: AppColors.blackCard,
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      TextWidget(
                        text: "Schedule Campaign",
                        textSize: 20,
                        color: AppColors.white,
                        maxLine: 2,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 6),
                      TextWidget(
                        text: "Select when you want to send this campaign",
                        textSize: 12,
                        maxLine: 2,
                        color: AppColors.white54,
                      ),
                      const SizedBox(height: 12),
                      MyCustomTextField.textField(
                          hintText: "Select Date",
                          controller: dateController,
                          borderClr: AppColors.white38,
                          onTap: () async {
                            final selectedDate =
                                await selectDate(context, DateTime.now());

                            if (selectedDate != null) {
                              dateController.text = Helper.formatDatePost(
                                  selectedDate.toString());
                              setState(() {});
                            }
                          },
                          lableText: "Date"),
                      const SizedBox(height: 12),
                      MyCustomTextField.textField(
                          hintText: "Select Time",
                          controller: timeController,
                          borderClr: AppColors.white38,
                          onTap: () async {
                            DateTime? selectedTime =
                                await selectTime(context, false);
                            if (selectedTime != null) {
                              setState(() {
                                timeController.text =
                                    DateFormat('hh:mm a').format(selectedTime);
                              });
                            }
                          },
                          lableText: "Time"),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.grey3Color,
                  height: 0,
                  thickness: 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                          height: 45,
                          child: Center(
                            child: TextWidget(
                              text: "Cancel".toUpperCase(),
                              color: Colors.white54,
                              textSize: 14,
                              fontWeight: FontWeight.w500,
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
                        onTap: onSchedule,
                        child: SizedBox(
                          height: 45,
                          child: Center(
                            child: TextWidget(
                              text: "Schedule".toUpperCase(),
                              color: Colors.white,
                              textSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
