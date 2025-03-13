import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunityBookingDetailsScreen extends StatefulWidget {
  const CommunityBookingDetailsScreen({super.key});

  @override
  State<CommunityBookingDetailsScreen> createState() =>
      _CommunityBookingDetailsScreenState();
}

class _CommunityBookingDetailsScreenState
    extends State<CommunityBookingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Booking Details",
          hideBack: true,
          autoAction: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.separated(
              itemCount: 5,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: AppColors.navyBlue,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const TextWidget(
                              text: "Booking #1",
                              textSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            const Spacer(),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: AppColors.green700.withOpacity(0.3),
                              child: const Padding(
                                padding: EdgeInsets.all(12),
                                child: TextWidget(
                                  text: "Confirmed",
                                  textSize: 14,
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.person,
                            color: AppColors.white,
                          ),
                          title: const TextWidget(
                              text: "Dhairya Jain", textSize: 16),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          visualDensity: VisualDensity.compact,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.mail,
                            color: AppColors.white,
                          ),
                          title: const TextWidget(
                              text: "dhairya.jan9@gmail.com", textSize: 16),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          visualDensity: VisualDensity.compact,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.calendar_month,
                            color: AppColors.white,
                          ),
                          title: const TextWidget(
                              text: "March 3, 2024 at 04:37 PM ", textSize: 16),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          visualDensity: VisualDensity.compact,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.schedule,
                            color: AppColors.white,
                          ),
                          title: const TextWidget(
                              text: "Duration:26 mins", textSize: 16),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          visualDensity: VisualDensity.compact,
                        ),
                        Divider(
                          color: AppColors.white38,
                        ),
                        sizedTextfield,
                        const TextWidget(
                          text: "Additional Info:",
                          textSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        sizedTextfield,
                        const TextWidget(text: "Further", textSize: 16),
                        sizedTextfield,
                        AppButton.primaryButton(
                            onButtonPressed: () {}, title: "Join Meeting"),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
