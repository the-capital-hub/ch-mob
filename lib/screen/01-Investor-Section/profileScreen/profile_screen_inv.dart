import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/challengeScreen/challenges_category_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/experience_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/personal_info_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../utils/constant/app_var.dart';

class ProfileScreenInvestor extends StatefulWidget {
  const ProfileScreenInvestor({super.key});

  @override
  State<ProfileScreenInvestor> createState() => _ProfileScreenInvestorState();
}

class _ProfileScreenInvestorState extends State<ProfileScreenInvestor> {
  final double profileCompletion = 0.30;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: DefaultTabController(
          length: 5,
          child: Scaffold(
            backgroundColor: AppColors.transparent,
            drawer: const DrawerWidgetInvestor(),
            appBar: HelperAppBar.appbarHelper(
                title: "Profile", hideBack: true, autoAction: true),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'),
                      ),
                      sizedTextfield,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.mode_edit_outlined,
                            color: AppColors.transparent,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const TextWidget(
                              text: "Pramod Badiger",
                              textSize: 18,
                              fontWeight: FontWeight.w500),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              Get.to(() =>  PersonalInfoScreen());
                            },
                            child: const Icon(
                              Icons.mode_edit_outlined,
                              color: AppColors.primaryInvestor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const TextWidget(text: "Pramodbadiger@21", textSize: 15),
                      const SizedBox(height: 6),
                      const TextWidget(
                          text:
                              "Founder & CEO of capital Hub, Bangalore , India",
                          textSize: 14),
                      const SizedBox(height: 6),
                      const TextWidget(
                          text: "253 Followers  |  248 Connections",
                          color: AppColors.primaryInvestor,
                          textSize: 14),
                      const SizedBox(height: 12),
                      AppButton.primaryButton(
                          onButtonPressed: () {},
                          title: "Connect",
                          height: 28,
                          fontSize: 12,
                          bgColor: AppColors.primaryInvestor,
                          textColor: Colors.black,
                          width: 95),
                      sizedTextfield,
                      Card(
                        color: AppColors.blackCard,
                        surfaceTintColor: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12, top: 8, bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                      value: profileCompletion,
                                      strokeWidth: 4.0,
                                      strokeCap: StrokeCap.round,
                                      backgroundColor: AppColors.white54,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              AppColors.primaryInvestor),
                                    ),
                                  ),
                                  const CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'), // Replace with your avatar image URL
                                  ),
                                  Positioned(
                                    bottom: -10,
                                    child: Card(
                                      color: AppColors.whiteCard,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0, vertical: 1),
                                        child: TextWidget(
                                            text: "30%",
                                            textSize: 10,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(width: 12),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                      text:
                                          "Please complete the remaining profile",
                                      textSize: 14),
                                  Row(
                                    children: [
                                      TextWidget(
                                          text: "Complete the profile",
                                          color: AppColors.primaryInvestor,
                                          textSize: 12),
                                      SizedBox(width: 4),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      sizedTextfield,
                      Card(
                        color: AppColors.blackCard,
                        surfaceTintColor: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextWidget(
                                  text: "Schedule an  appointment now",
                                  textSize: 14),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                color: AppColors.primaryInvestor,
                                // surfaceTintColor: AppColors.primaryInvestor,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  child: TextWidget(
                                      text: "Schedule now",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      textSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      sizedTextfield,
                      Card(
                        color: AppColors.blackCard,
                        surfaceTintColor: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextWidget(
                                    text: "Personal Information",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() =>  PersonalInfoScreen());
                                    },
                                    child: const Icon(
                                      Icons.edit_outlined,
                                      color: AppColors.primaryInvestor,
                                      size: 22,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              const TextWidget(
                                  text: "First Name",
                                  fontWeight: FontWeight.w300,
                                  textSize: 13),
                              const SizedBox(height: 4),
                              const TextWidget(
                                  text: "Pramod",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500),
                              const SizedBox(height: 8),
                              const TextWidget(
                                  text: "Last Name",
                                  fontWeight: FontWeight.w300,
                                  textSize: 13),
                              const SizedBox(height: 4),
                              const TextWidget(
                                  text: "Badiger",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500),
                              const SizedBox(height: 8),
                              const TextWidget(
                                  text: "Email Address",
                                  fontWeight: FontWeight.w300,
                                  textSize: 13),
                              const SizedBox(height: 4),
                              const TextWidget(
                                  text: "Pramodbadiger@gmail.com",
                                  textSize: 15,
                                  fontWeight: FontWeight.w500),
                              const SizedBox(height: 8),
                              const TextWidget(
                                  text: "Mobile Number",
                                  fontWeight: FontWeight.w300,
                                  textSize: 13),
                              const SizedBox(height: 4),
                              const TextWidget(
                                  text: "+91 756917862",
                                  textSize: 15,
                                  maxLine: 3,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ),
                      ),
                      sizedTextfield,
                      Card(
                        color: AppColors.blackCard,
                        surfaceTintColor: AppColors.blackCard,
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                    text: "Bio",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Icon(
                                    Icons.edit_outlined,
                                    color: AppColors.primaryInvestor,
                                    size: 22,
                                  )
                                ],
                              ),
                              SizedBox(height: 8),
                              TextWidget(
                                  text:
                                      "A little about myself. “Dejection is a sign of failure but it becomes the cause of success”. I wrote this when I was 16 years old and that’s exactly when I idealised the reality of life. In this current world, success is defined in many ways, some of which include money, fame and power.",
                                  maxLine: 10,
                                  textSize: 13),
                            ],
                          ),
                        ),
                      ),
                      sizedTextfield,
                      Card(
                        color: AppColors.blackCard,
                        surfaceTintColor: AppColors.blackCard,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextWidget(
                                    text: "Startups Invested",
                                    textSize: 16,
                                  ),
                                  AppButton.primaryButton(
                                      onButtonPressed: () {},
                                      title: "Add new",
                                      width: 92,
                                      bgColor: AppColors.primaryInvestor,
                                      textColor: AppColors.black,
                                      fontSize: 12,
                                      height: 28)
                                ],
                              ),
                            ),
                            Divider(
                              height: 0,
                              thickness: 0.5,
                              color: AppColors.white54,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      SizedBox(width: 4),
                                      FlutterLogo(),
                                      SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: "Capital Hub",
                                            textSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          SizedBox(height: 4),
                                          TextWidget(
                                            text:
                                                "Channing & Barrett industries pvt ltd",
                                            textSize: 12,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Card(
                                    color: AppColors.white12,
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: TextWidget(
                                          text: """Sector :
One classical breakdown of economic activity distinguishes three sectors: Primary: involves the retrieval and production of raw-material commodities, such as corn, coal, wood or iron""",
                                          maxLine: 12,
                                          textSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      sizedTextfield,
                      Card(
                          color: AppColors.blackCard,
                          surfaceTintColor: AppColors.blackCard,
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextWidget(
                                    text: "Sector Interested",
                                    textSize: 16,
                                  ),
                                  AppButton.primaryButton(
                                      onButtonPressed: () {},
                                      title: "Add new",
                                      width: 92,
                                      bgColor: AppColors.primaryInvestor,
                                      textColor: AppColors.black,
                                      fontSize: 12,
                                      height: 28)
                                ],
                              ),
                            ),
                            Divider(
                              height: 0,
                              thickness: 0.5,
                              color: AppColors.white54,
                            ),
                            GridView.builder(
                              padding: const EdgeInsets.all(8),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 3,
                                      crossAxisSpacing: 04,
                                      mainAxisSpacing: 04),
                              itemCount: 4,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  color: AppColors.white12,
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        FlutterLogo(size: 25),
                                        SizedBox(width: 10),
                                        TextWidget(
                                            text: "Link Sector", textSize: 14),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ])),
                      sizedTextfield,
                      Card(
                          color: AppColors.blackCard,
                          surfaceTintColor: AppColors.blackCard,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  child: TextWidget(
                                    text: "Investment Philosophy",
                                    textSize: 16,
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                  thickness: 0.5,
                                  color: AppColors.white54,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                          text: "Description :", textSize: 15),
                                      SizedBox(height: 4),
                                      TextWidget(
                                          text:
                                              "Investing Deploying Capital toward projects or activities that are expected to generate a positive financial return over time.",
                                          maxLine: 5,
                                          textSize: 12),
                                    ],
                                  ),
                                )
                              ])),
                      sizedTextfield,
                      ListView.separated(
                        itemCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 8);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: AppColors.blackCard,
                            surfaceTintColor: AppColors.blackCard,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TextWidget(
                                        text: "Recent Experience",
                                        textSize: 16,
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        color: AppColors.primaryInvestor,
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 8),
                                          child: TextWidget(
                                              text: "Add Experience",
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              textSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                  thickness: 0.5,
                                  color: AppColors.white54,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          FlutterLogo(
                                            size: 40,
                                          ),
                                          SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                text: "Capital Hub",
                                                textSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              SizedBox(height: 4),
                                              TextWidget(
                                                text:
                                                    "Channing & Barrett industries pvt ltd",
                                                textSize: 12,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      sizedTextfield,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                  text: "Location",
                                                  color: AppColors.grey,
                                                  textSize: 14),
                                              const TextWidget(
                                                  text: "Bangalore,India",
                                                  textSize: 15),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                  text: "Role",
                                                  color: AppColors.grey,
                                                  textSize: 14),
                                              const TextWidget(
                                                  text: "UI/UX Designer",
                                                  textSize: 15),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      TextWidget(
                                          text: "Experience",
                                          textSize: 14,
                                          color: AppColors.grey),
                                      const TextWidget(
                                          text:
                                              "2Years 2 months, Present Full Time.",
                                          textSize: 15)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 185,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, crossAxisSpacing: 4),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          padding: const EdgeInsets.only(top: 8),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: AppColors.blackCard,
                              surfaceTintColor: AppColors.blackCard,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                        radius: 34,
                                        foregroundColor: AppColors.whiteCard,
                                        child: CircleAvatar(
                                          radius: 32,
                                          backgroundImage: NetworkImage(
                                              "https://img.lovepik.com/photo/50062/0521.jpg_wh860.jpg"),
                                        )),
                                    const TextWidget(
                                        text: "Total Investment", textSize: 14),
                                    AppButton.primaryButton(
                                        onButtonPressed: () {},
                                        title: "1Crore",
                                        fontSize: 12,
                                        bgColor: AppColors.primaryInvestor,
                                        textColor: AppColors.black,
                                        width: 100,
                                        height: 32)
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppButton.primaryButton(
                            onButtonPressed: () {},
                            bgColor: AppColors.primaryInvestor,
                            textColor: Colors.black,borderRadius: 12,
                            title: "Book your appointment now"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
