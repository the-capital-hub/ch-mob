import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunityMeetingBookingsScreen extends StatefulWidget {
  const CommunityMeetingBookingsScreen({super.key});

  @override
  State<CommunityMeetingBookingsScreen> createState() =>
      _CommunityMeetingBookingsScreenState();
}

class _CommunityMeetingBookingsScreenState
    extends State<CommunityMeetingBookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Meeting Bookings",
          hideBack: true,
          autoAction: true,
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: AppColors.blackCard,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage(PngAssetPath.accountImg),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const TextWidget(
                          text: "Name",
                          textSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
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
                        )
                      ],
                    ),
                    sizedTextfield,
                    const TextWidget(
                      text: "Booked 14 days ago",
                      textSize: 16,
                      maxLine: 2,
                    ),
                    sizedTextfield,
                    sizedTextfield,
                    AppButton.primaryButton(
                        onButtonPressed: () {}, title: "Join Meeting")
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
