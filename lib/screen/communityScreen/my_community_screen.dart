import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class MyCommunityScreen extends StatefulWidget {
  const MyCommunityScreen({super.key});

  @override
  State<MyCommunityScreen> createState() => _MyCommunityScreenState();
}

class _MyCommunityScreenState extends State<MyCommunityScreen> {
  List<String> communityNames = [
    "Capital Hub Community",
    "Hub Community",
    "Hustler's Community",
    "Pixel Community",
    "Monday Community",
    "Monday Community",
    "Monday Community",
    "Monday Community",
    "Monday Community",
    "Monday Community",
    "Monday Community"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          drawer: const DrawerWidget(),
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "Create Community",
            hideBack: true,
            autoAction: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 12,right:12,bottom: 12), // Padding around the card
            child: Card(
               color: AppColors.blackCard,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12), // Rounded corners for the card
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                                  thickness: 1,
                                  color: AppColors.white54,
                                ),
                shrinkWrap:
                    true, // Makes ListView take only as much space as it needs
                padding:
                    EdgeInsets.zero, // Remove extra padding from ListView
                itemCount: communityNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                      ),
                    ),
                    title: TextWidget(text: communityNames[index], textSize: 16),
                  );
                },
              ),
            ),
          ),
          bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 12,
          ),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                // Get.to(() => const CreateNewWebinarScreen());
              },
              title: "Start New Community"),
        ),
        )
        );
  }
}
