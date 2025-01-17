import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';

import '../../../widget/buttons/button.dart';
import '../../../widget/textwidget/text_widget.dart';

class LiveDealScreen extends StatefulWidget {
  const LiveDealScreen({super.key});

  @override
  State<LiveDealScreen> createState() => _LiveDealScreenState();
}

class _LiveDealScreenState extends State<LiveDealScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      drawer: const DrawerWidgetInvestor(),
      appBar: HelperAppBar.appbarHelper(
          title: "Live Deals", autoAction: true, hideBack: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MyCustomTextField.textField(
                hintText: "Search",
                borderRadius: 12,
                controller: searchController),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: AppColors.blackCard,
                    surfaceTintColor: AppColors.blackCard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              FlutterLogo(),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                      text: "The Capital Hub", textSize: 16),
                                  TextWidget(
                                      text:
                                          "The Finance Company | Investment | Start Up",
                                      textSize: 12)
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(height: 0, color: AppColors.white12),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidget(text: "Over View", textSize: 16),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TextWidget(
                                          text: "Website", textSize: 14),
                                      const SizedBox(height: 4),
                                      Card(
                                          margin: const EdgeInsets.all(0),
                                          color: AppColors.white12,
                                          surfaceTintColor: AppColors.white12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.language,
                                                  size: 16,
                                                  color: AppColors.white,
                                                ),
                                                const SizedBox(width: 4),
                                                const TextWidget(
                                                    text: "Infosys",
                                                    textSize: 13),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TextWidget(
                                          text: "Employees", textSize: 14),
                                      const SizedBox(height: 4),
                                      Card(
                                          margin: const EdgeInsets.all(0),
                                          color: AppColors.white12,
                                          surfaceTintColor: AppColors.white12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.groups_2,
                                                  size: 16,
                                                  color: AppColors.white,
                                                ),
                                                const SizedBox(width: 4),
                                                const TextWidget(
                                                    text: "300-500",
                                                    textSize: 13),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TextWidget(
                                          text: "Location", textSize: 14),
                                      const SizedBox(height: 4),
                                      Card(
                                          margin: const EdgeInsets.all(0),
                                          color: AppColors.white12,
                                          surfaceTintColor: AppColors.white12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  size: 16,
                                                  color: AppColors.white,
                                                ),
                                                const SizedBox(width: 4),
                                                const TextWidget(
                                                    text: "Bangalore, India",
                                                    textSize: 13),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const TextWidget(
                                  text:
                                      " Man's all about building great start-ups from a simple idea to an elegant reality. Humbled and honored to have worked with Angels and VC's across the globe.",
                                  maxLine: 5,
                                  textSize: 12),
                              const SizedBox(height: 8),
                              const TextWidget(
                                  text: "Investors Interested", textSize: 16),
                              const SizedBox(height: 8),
                              Wrap(
                                  spacing:
                                      8.0, // Space between each card horizontally
                                  runSpacing:
                                      8.0, // Space between each card vertically
                                  children: List.generate(5, (index) {
                                    return Card(
                                        margin: const EdgeInsets.all(0),
                                        color: AppColors.white12,
                                        surfaceTintColor: AppColors.white12,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const CircleAvatar(
                                                radius: 12,
                                                backgroundImage: NetworkImage(
                                                    'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'), // Replace with your avatar image URL
                                              ),
                                              const SizedBox(width: 4),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const TextWidget(
                                                      text: "Jonny Wick",
                                                      textSize: 12),
                                                  // SizedBox(height: 2),
                                                  TextWidget(
                                                      text: "E-commerce",
                                                      color: AppColors.white54,
                                                      textSize: 10)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ));
                                  })),
                              const SizedBox(height: 8),
                              const TextWidget(
                                  text: "Funds Utilization", textSize: 16),
                              const SizedBox(height: 8),
                              Wrap(
                                  spacing:
                                      8.0, // Space between each card horizontally
                                  runSpacing:
                                      8.0, // Space between each card vertically
                                  children: List.generate(5, (index) {
                                    return Card(
                                        margin: const EdgeInsets.all(0),
                                        color: AppColors.white12,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(22)),
                                        surfaceTintColor: AppColors.white12,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 6),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const CircleAvatar(
                                                radius: 10,
                                                backgroundImage: NetworkImage(
                                                    'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'), // Replace with your avatar image URL
                                              ),
                                              const SizedBox(width: 6),
                                              TextWidget(
                                                  text: index % 2 == 0
                                                      ? "9% Selling"
                                                      : "30% Marketing",
                                                  textSize: 12),
                                            ],
                                          ),
                                        ));
                                  })),
                            ],
                          ),
                        ),
                        Divider(height: 0, color: AppColors.white12),
                        
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: AppButton.primaryButton(
                              onButtonPressed: () {},
                              borderRadius: 8,
                              // width: 200,
                              height: 35,
                              bgColor: AppColors.primaryInvestor,
                              textColor: Colors.black,
                              fontSize: 14,
                              title: "Invest now"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
