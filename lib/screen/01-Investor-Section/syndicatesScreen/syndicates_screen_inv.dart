import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

import '../drawerScreen/drawer_screen_inv.dart';

class SyndicatesScreenInvestor extends StatefulWidget {
  const SyndicatesScreenInvestor({super.key});

  @override
  State<SyndicatesScreenInvestor> createState() =>
      _SyndicatesScreenInvestorState();
}

class _SyndicatesScreenInvestorState extends State<SyndicatesScreenInvestor>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      drawer: DrawerWidgetInvestor(),
      appBar: HelperAppBar.appbarHelper(
          title: "Syndicates", hideBack: true, autoAction: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
            child: TabBar(
              controller: _tabController,
              isScrollable: true, tabAlignment: TabAlignment.start,
              indicator: const BoxDecoration(),
              dividerHeight: 0, // No indicator
              tabs: [
                Tab(
                  child: TextWidget(
                    text: 'Companies',
                    color: _tabController.index == 0
                        ? AppColors.primaryInvestor
                        : AppColors.whiteCard,
                    textSize: 14,
                  ),
                ),
                Tab(
                  child: TextWidget(
                    text: 'Membership',
                    color: _tabController.index == 1
                        ? AppColors.primaryInvestor
                        : AppColors.whiteCard,
                    textSize: 14,
                  ),
                ),
              ],
              onTap: (index) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: 6,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                          text: "The Capital Hub",
                                          textSize: 16),
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
                                  const TextWidget(
                                      text: "Over View", textSize: 16),
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
                                              surfaceTintColor:
                                                  AppColors.white12,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 4),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                              surfaceTintColor:
                                                  AppColors.white12,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 4),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                              surfaceTintColor:
                                                  AppColors.white12,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 4),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 16,
                                                      color: AppColors.white,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    const TextWidget(
                                                        text:
                                                            "Bangalore, India",
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
                                      text: "People’s Group", textSize: 16),
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 4),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: NetworkImage(
                                                        'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'), // Replace with your avatar image URL
                                                  ),
                                                  SizedBox(width: 4),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextWidget(
                                                          text: "Jonny Wick",
                                                          textSize: 12),
                                                      // SizedBox(height: 2),
                                                      TextWidget(
                                                          text: "E-commerce",
                                                          color:
                                                              AppColors.white54,
                                                          textSize: 10)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ));
                                      })),
                                ],
                              ),
                            ),
                            Divider(height: 0, color: AppColors.white12),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppButton.primaryButton(
                                    onButtonPressed: () {},
                                    borderRadius: 8,
                                    width: 103,
                                    height: 35,
                                    bgColor: AppColors.primaryInvestor,
                                    textColor: Colors.black,
                                    fontSize: 12,
                                    title: "Join Group"),
                                SizedBox(width: 8)
                              ],
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 6,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                          text: "The Capital Hub",
                                          textSize: 16),
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
                                  const TextWidget(
                                      text: "Over View", textSize: 16),
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
                                              surfaceTintColor:
                                                  AppColors.white12,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 4),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                              surfaceTintColor:
                                                  AppColors.white12,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 4),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                              surfaceTintColor:
                                                  AppColors.white12,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 4),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 16,
                                                      color: AppColors.white,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    const TextWidget(
                                                        text:
                                                            "Bangalore, India",
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
                                      text: "People’s Group", textSize: 16),
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 4),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: NetworkImage(
                                                        'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'), // Replace with your avatar image URL
                                                  ),
                                                  SizedBox(width: 4),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextWidget(
                                                          text: "Jonny Wick",
                                                          textSize: 12),
                                                      // SizedBox(height: 2),
                                                      TextWidget(
                                                          text: "E-commerce",
                                                          color:
                                                              AppColors.white54,
                                                          textSize: 10)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ));
                                      })),
                                ],
                              ),
                            ),
                            Divider(height: 0, color: AppColors.white12),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppButton.primaryButton(
                                    onButtonPressed: () {},
                                    borderRadius: 8,
                                    width: 103,
                                    height: 35,
                                    bgColor: AppColors.primaryInvestor,
                                    textColor: Colors.black,
                                    fontSize: 12,
                                    title: "Join Group"),
                                SizedBox(width: 8)
                              ],
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
