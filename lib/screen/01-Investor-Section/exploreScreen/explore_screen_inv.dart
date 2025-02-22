import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../widget/text_field/text_field.dart';

class ExploreScreenInvestor extends StatefulWidget {
  const ExploreScreenInvestor({super.key});

  @override
  State<ExploreScreenInvestor> createState() => _ExploreScreenInvestorState();
}

class _ExploreScreenInvestorState extends State<ExploreScreenInvestor> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          drawer: const DrawerWidgetInvestor(),
          appBar: HelperAppBar.appbarHelper(
              title: "Explore", hideBack: true, autoAction: true),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyCustomTextField.textField(
                    hintText: "Search",
                    controller: searchController,
                    borderRadius: 12,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.white54,
                    )),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                  child: TextWidget(
                      text: "Startup Results",
                      textSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          color: AppColors.blackCard,
                          surfaceTintColor: AppColors.blackCard,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const FlutterLogo(
                                      size: 40,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const TextWidget(
                                                text: "The Capital Hub",
                                                textSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              Icon(
                                                  Icons
                                                      .bookmark_border_outlined,
                                                  color: AppColors.white,
                                                  size: 20)
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          const TextWidget(
                                            text:
                                                "The Finance Company | Investment | Start Up",
                                            textSize: 12,
                                          ),
                                          const SizedBox(height: 4),
                                          const TextWidget(
                                            text:
                                                "Bangalore, India  Founded in, 2014  Last Funding in May, 2023",
                                            textSize: 10,
                                            fontWeight: FontWeight.w300,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 0.5,
                                color: AppColors.white38,
                                height: 0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  color: AppColors.white12,
                                  surfaceTintColor: AppColors.white12,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                            text: "About the company :",
                                            textSize: 14,
                                            fontWeight: FontWeight.w500),
                                        SizedBox(height: 4),
                                        TextWidget(
                                          text:
                                              "Man's all about building great start-ups from a simple idea to an elegant reality. Humbled and honored to have worked with Angels and VC's across ..",
                                          textSize: 12,
                                          maxLine: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 2,
                                        mainAxisSpacing: 2),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Card(
                                      color: AppColors.white12,
                                      surfaceTintColor: AppColors.white12,
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            FlutterLogo(size: 35),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextWidget(
                                                      text: "Investment",
                                                      align: TextAlign.center,
                                                      maxLine: 2,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textSize: 12),
                                                ),
                                              ],
                                            ),
                                            TextWidget(
                                                text: "Rs.584.1 M",
                                                textSize: 12)
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: 4,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: TextWidget(
                                    text: "Revenue Statistics (FY19)",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 2,
                                        childAspectRatio: 1.15,
                                        mainAxisSpacing: 2),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Card(
                                      color: AppColors.white12,
                                      surfaceTintColor: AppColors.white12,
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            FlutterLogo(size: 35),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextWidget(
                                                      text: "Revenue",
                                                      align: TextAlign.center,
                                                      maxLine: 2,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textSize: 11),
                                                ),
                                              ],
                                            ),
                                            TextWidget(
                                                text: "Rs. 4.1 M", textSize: 12)
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: 3,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: TextWidget(
                                    text: "Public Links",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 42,
                                child: ListView.separated(
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 3);
                                  },
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      color: AppColors.white12,
                                      surfaceTintColor: AppColors.white12,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Row(
                                          children: [
                                            FlutterLogo(
                                              size: 20,
                                            ),
                                            SizedBox(width: 8),
                                            TextWidget(
                                                text: "Website", textSize: 12)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: TextWidget(
                                    text: "Feedback",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 130,
                                child: ListView.separated(
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 3);
                                  },
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      color: AppColors.white12,
                                      surfaceTintColor: AppColors.white12,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SizedBox(
                                          width: Get.width / 2,
                                          child: const Column(
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage: NetworkImage(
                                                        'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextWidget(
                                                          text: "Tom Holder",
                                                          textSize: 14),
                                                      SizedBox(height: 2),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                              size: 16),
                                                          TextWidget(
                                                              text: "4.5 (12)",
                                                              textSize: 12)
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              TextWidget(
                                                text:
                                                    "This is my first review and also every website and app working very good not lag on app.",
                                                textSize: 12,
                                                maxLine: 3,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: TextWidget(
                                    text: "Founding Team",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 118,
                                child: ListView.separated(
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 3);
                                  },
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      color: AppColors.white12,
                                      surfaceTintColor: AppColors.white12,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SizedBox(
                                          width: Get.width / 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage: NetworkImage(
                                                        'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextWidget(
                                                          text: "Abhishek Raj",
                                                          textSize: 14),
                                                      SizedBox(height: 2),
                                                      TextWidget(
                                                          text: "28 Years",
                                                          textSize: 12)
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextWidget(
                                                            text: "Designation",
                                                            textSize: 13),
                                                        SizedBox(height: 4),
                                                        TextWidget(
                                                            text:
                                                                "CEO & Founder",
                                                            textSize: 13),
                                                      ],
                                                    ),
                                                  ),
                                                  Card(
                                                    color: AppColors
                                                        .primaryInvestor,
                                                    surfaceTintColor: AppColors
                                                        .primaryInvestor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0,
                                                              vertical: 4),
                                                      child: TextWidget(
                                                          text: "Connect now",
                                                          color: Colors.black,
                                                          textSize: 10),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: TextWidget(
                                    text: "Key Focusing Area",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Wrap(
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: List.generate(4, (index) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      color: AppColors.white12,
                                      surfaceTintColor: AppColors.white12,
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        child: TextWidget(
                                            text: 'Fainance', textSize: 14),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: AppButton.primaryButton(
                                            onButtonPressed: () {},
                                            bgColor: AppColors.primaryInvestor,
                                            textColor: Colors.black,
                                            borderRadius: 12,
                                            height: 40,
                                            title: "Invest now")),
                                    const SizedBox(width: 8),
                                    Expanded(
                                        child: AppButton.outlineButton(
                                            onButtonPressed: () {},
                                            borderColor:
                                                AppColors.primaryInvestor,
                                            borderRadius: 12,
                                            height: 40,
                                            title: "Connect")),
                                  ],
                                ),
                              ),
                              sizedTextfield,
                            ],
                          ));
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
