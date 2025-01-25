import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CreateCommunityOverScreen extends StatefulWidget {
  const CreateCommunityOverScreen({super.key});

  @override
  State<CreateCommunityOverScreen> createState() =>
      _CreateCommunityOverScreenState();
}

class _CreateCommunityOverScreenState extends State<CreateCommunityOverScreen> {
  TextEditingController urlController = TextEditingController();
  List<String> imgURL = [
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1"
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1"
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
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                ),
              ),
              sizedTextfield,
              const TextWidget(text: "Capital Hub", textSize: 18),
              sizedTextfield,
              const TextWidget(text: "Hosted By You", textSize: 13),
              sizedTextfield,
              Divider(
                thickness: 1,
                color: AppColors.white54,
              ),
              // SizedBox(height: 5,),
          
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          // "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                          imgURL[index]
                        ),
                      ),
                    );
                  },
                ),
              ),
              sizedTextfield,
              const TextWidget(text: "Any one can join for free", textSize: 13),
              sizedTextfield,
              sizedTextfield,
              Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                    text: "Congrats! Capital Hub is live!", textSize: 20),
              ),
              sizedTextfield,
              Flexible(
                child: MyCustomTextField.textField(
                    lableText: "Community Page URL",
                    hintText: "Capitalhub/Community",
                    controller: urlController),
              )
            ],
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
              title: "Continue"),
        ),
      ),
    );
  }
}
