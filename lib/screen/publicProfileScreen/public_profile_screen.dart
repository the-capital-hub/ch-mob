import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import '../../controller/publicProfileController/public_profile_controller.dart';
import '../../utils/helper/helper.dart';

class PublicProfileScreen extends StatefulWidget {
  String id;
  PublicProfileScreen({super.key, required this.id});

  @override
  State<PublicProfileScreen> createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen> {
  PublicProfileController publicProfileController =
      Get.put(PublicProfileController());
  @override
  void initState() {
    publicProfileController.getPublicProfile(widget.id);
    super.initState();
  }

  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(title: "Profile"),
          body: Obx(
            () => publicProfileController.isLoading.value
                ? Helper.pageLoading()
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                publicProfileController
                                    .publicData.userProfile!.profilePicture!),
                          ),
                          const SizedBox(height: 12),
                          TextWidget(
                              text:
                                  "${publicProfileController.publicData.userProfile!.firstName} ${publicProfileController.publicData.userProfile!.lastName}",
                              textSize: 18,
                              fontWeight: FontWeight.w500),
                          TextWidget(
                              text: publicProfileController
                                  .publicData.userProfile!.designation!,
                              textSize: 14),
                          const SizedBox(height: 8),
                          Divider(
                            color: AppColors.white12,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextWidget(
                                  text: "Experience", textSize: 15),
                              TextWidget(
                                  text:
                                      "${publicProfileController.publicData.userProfile!.totalExperience}",
                                  textSize: 15),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextWidget(
                                  text: "Connections", textSize: 15),
                              TextWidget(
                                  text:
                                      "${publicProfileController.publicData.userProfile!.connections}",
                                  textSize: 15),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextWidget(text: "Company", textSize: 15),
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                    publicProfileController
                                        .publicData.userProfile!.companyLogo!),
                              ),
                            ],
                          ),
                          sizedTextfield,
                          Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: AppButton.primaryButton(
                                    onButtonPressed: () {},
                                    bgColor: AppColors.blue,
                                    height: 40,
                                    title: "Request Sent"),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AppButton.primaryButton(
                                    height: 40,
                                    onButtonPressed: () {},
                                    title: "Message"),
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Divider(
                            color: AppColors.white12,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.blackCard,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(
                                    text: "Email",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                        child: TextWidget(
                                            text: publicProfileController
                                                    .publicData
                                                    .userEmail!
                                                    .isAccessible!
                                                ? publicProfileController
                                                    .publicData
                                                    .userEmail!
                                                    .email!
                                                : "xxxxx@xxx.com",
                                            maxLine: 3,
                                            textSize: 14)),
                                    const SizedBox(width: 8),
                                    if (!publicProfileController
                                        .publicData.userEmail!.isAccessible!)
                                      InkWell(
                                        onTap: () {
                                          publicProfileController
                                              .addEmailToFounder(
                                                  context, widget.id)
                                              .then((v) {
                                            setState(() {});
                                          });
                                        },
                                        child: const TextWidget(
                                            text: "Show Mail",
                                            textSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primary),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          sizedTextfield,
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.blackCard,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextWidget(
                                      text: "Bio",
                                      textSize: 16,
                                      fontWeight: FontWeight.w500),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextWidget(
                                            text:
                                                "${publicProfileController.publicData.userProfile!.bio}",
                                            maxLine: 100,
                                            textSize: 12),
                                      ),
                                    ],
                                  )
                                ]),
                          ),
                          sizedTextfield,
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                                text: "Priority DM",
                                textSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.blackCard,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 4),
                                    TextWidget(
                                        text:
                                            "${publicProfileController.publicData.priorityDm!.rating}",
                                        textSize: 16),
                                    Container(
                                      margin: const EdgeInsets.only(left: 16),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 22, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: AppColors.grey700,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: TextWidget(
                                          text:
                                              "${publicProfileController.publicData.priorityDm!.tag}",
                                          textSize: 14),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                TextWidget(
                                    text:
                                        "${publicProfileController.publicData.priorityDm!.title}",
                                    textSize: 22,
                                    fontWeight: FontWeight.w500),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.grey700,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.rocket_launch,
                                              color: AppColors.primary),
                                          const SizedBox(height: 4),
                                          const TextWidget(
                                              text: "Quick Reply",
                                              textSize: 14),
                                          const SizedBox(height: 4),
                                          TextWidget(
                                              text:
                                                  "${publicProfileController.publicData.priorityDm!.description}",
                                              textSize: 14),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 6),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.5,
                                                color: AppColors.whiteCard),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Row(
                                          children: [
                                            TextWidget(
                                                text:
                                                    "Rs ${publicProfileController.publicData.priorityDm!.amount}",
                                                textSize: 14),
                                            const SizedBox(width: 4),
                                            Icon(
                                              Icons.arrow_forward,
                                              size: 18,
                                              color: AppColors.whiteCard,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          sizedTextfield,
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                                text: "Communities",
                                textSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                              itemCount: publicProfileController
                                  .publicData.communities!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: Get.width / 1.5,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.blackCard,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    publicProfileController
                                                        .publicData
                                                        .communities![index]
                                                        .image!),
                                                fit: BoxFit.cover)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                                text:
                                                    "${publicProfileController.publicData.communities![index].community}",
                                                textSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.white),
                                            const SizedBox(height: 3),
                                            TextWidget(
                                                text:
                                                    "${publicProfileController.publicData.communities![index].size}",
                                                textSize: 16,
                                                color: AppColors.grey),
                                            const SizedBox(height: 3),
                                            TextWidget(
                                                text:
                                                    "${publicProfileController.publicData.communities![index].members} . ${publicProfileController.publicData.communities![index].createdAtTimeAgo}",
                                                textSize: 14),
                                            const SizedBox(height: 8),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: AppButton.primaryButton(
                                                  height: 36,
                                                  onButtonPressed: () {},
                                                  title: "Free to Join"),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          sizedTextfield,
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                                text: "Events",
                                textSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            height: 185,
                            child: ListView.builder(
                              itemCount: publicProfileController
                                  .publicData.events!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: Get.width / 1.4,
                                  padding: const EdgeInsets.all(12.0),
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.cream,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                          text:
                                              "${publicProfileController.publicData.events![index].title}",
                                          textSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black),
                                      const SizedBox(height: 3),
                                      TextWidget(
                                        text:
                                            "${publicProfileController.publicData.events![index].description}",
                                        textSize: 15,
                                        color: AppColors.black,
                                        maxLine: 2,
                                      ),
                                      const SizedBox(height: 3),
                                      TextWidget(
                                        text:
                                            "RS ${publicProfileController.publicData.events![index].discount}",
                                        textSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            decoration: BoxDecoration(
                                                color: AppColors.primary,
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.copy,
                                                  color: AppColors.white,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 6),
                                                const TextWidget(
                                                    text: "Copy Link",
                                                    textSize: 14),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Center(
                                              child: TextWidget(
                                                text:
                                                    "${publicProfileController.publicData.events![index].bookings}",
                                                textSize: 14,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          sizedTextfield,
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                                text: "Company",
                                textSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 6),
                          if (publicProfileController
                                  .publicData.companyData!.companyName !=
                              null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.white12,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // const SizedBox(width: 8),
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              publicProfileController.publicData
                                                  .companyData!.logo!,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: publicProfileController
                                                    .publicData
                                                    .companyData
                                                    ?.companyName ??
                                                "N/A", // Default text
                                            textSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          const SizedBox(height: 3),
                                          TextWidget(
                                            text:
                                                "${publicProfileController.publicData.companyData?.location ?? "Unknown"} Founded in ${publicProfileController.publicData.companyData?.startedAtDate ?? "N/A"}",
                                            textSize: 12,
                                          ),
                                          TextWidget(
                                            text:
                                                "Last funding ${publicProfileController.publicData.companyData?.lastFunding ?? "N/A"} Sector ${publicProfileController.publicData.companyData?.sector ?? "N/A"}",
                                            textSize: 12,
                                          ),
                                          TextWidget(
                                            text:
                                                "Stage ${publicProfileController.publicData.companyData?.stage ?? "N/A"}",
                                            textSize: 12,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  if ((publicProfileController.publicData
                                              .companyData?.description ??
                                          "")
                                      .isNotEmpty)
                                    Card(
                                      color: AppColors.white12,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: TextWidget(
                                          text: publicProfileController
                                                  .publicData
                                                  .companyData
                                                  ?.description ??
                                              "No description available",
                                          maxLine: 12,
                                          textSize: 13,
                                        ),
                                      ),
                                    ),
                                  const SizedBox(height: 8),
                                  if ((publicProfileController.publicData
                                              .companyData?.socialLinks ??
                                          [])
                                      .isNotEmpty)
                                    SizedBox(
                                      height: 42,
                                      child: ListView.separated(
                                        itemCount: publicProfileController
                                                .publicData
                                                .companyData
                                                ?.socialLinks
                                                ?.length ??
                                            0,
                                        shrinkWrap: true,
                                        separatorBuilder: (context, ind) =>
                                            const SizedBox(width: 3),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int ind) {
                                          final socialLink =
                                              publicProfileController
                                                  .publicData
                                                  .companyData
                                                  ?.socialLinks?[ind];
                                          return InkWell(
                                            onTap: () {
                                              if (socialLink.link != null) {
                                                Helper.launchUrl(
                                                    socialLink.link!);
                                              }
                                            },
                                            child: Card(
                                              color: AppColors.white12,
                                              surfaceTintColor:
                                                  AppColors.white12,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Row(
                                                  children: [
                                                    Image.network(
                                                      socialLink!.logo!,
                                                      height: 25,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    TextWidget(
                                                      text: socialLink.name!,
                                                      textSize: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          sizedTextfield,
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                                text: "Experience",
                                textSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 6),
                          ListView.builder(
                            itemCount: publicProfileController
                                .publicData.userProfile!.experience!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.white12,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        // const SizedBox(width: 8),
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                publicProfileController
                                                    .publicData
                                                    .userProfile!
                                                    .experience![index]
                                                    .companyLogo!,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              text:
                                                  "${publicProfileController.publicData.userProfile!.experience![index].companyRole!}", // Default text
                                              textSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            const SizedBox(height: 3),
                                            TextWidget(
                                              text: publicProfileController
                                                  .publicData
                                                  .userProfile!
                                                  .experience![index]
                                                  .companyLocation!,
                                              textSize: 12,
                                            ),
                                            TextWidget(
                                              text:
                                                  "${publicProfileController.publicData.userProfile!.experience![index].companyStartDate} - ${publicProfileController.publicData.userProfile!.experience![index].companyEndDate}",
                                              textSize: 12,
                                            ),
                                            TextWidget(
                                              text:
                                                  "${publicProfileController.publicData.userProfile!.experience![index].companyLocation}",
                                              textSize: 12,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    // if ((publicProfileController.publicData
                                    //             .companyData?.description ??
                                    //         "")
                                    //     .isNotEmpty)
                                    Card(
                                      color: AppColors.white12,
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: TextWidget(
                                          text:
                                              "${publicProfileController.publicData.userProfile!.experience![index].companyDescription}",
                                          maxLine: 12,
                                          textSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          sizedTextfield,
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                                text: "Education",
                                textSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 6),
                          ListView.builder(
                              itemCount: publicProfileController
                                  .publicData.userProfile!.education!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.white12,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    publicProfileController
                                                        .publicData
                                                        .userProfile!
                                                        .education![index]
                                                        .educationLogo!),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                text:
                                                    "${publicProfileController.publicData.userProfile!.education![index].educationCourse}", // Default text
                                                textSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              const SizedBox(height: 3),
                                              TextWidget(
                                                text:
                                                    "${publicProfileController.publicData.userProfile!.education![index].educationSchool}",
                                                textSize: 12,
                                              ),
                                              TextWidget(
                                                text:
                                                    "${publicProfileController.publicData.userProfile!.education![index].educationPassoutDate}",
                                                textSize: 12,
                                              ),
                                              TextWidget(
                                                text:
                                                    "${publicProfileController.publicData.userProfile!.education![index].educationLocation}",
                                                textSize: 12,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Card(
                                        color: AppColors.white12,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: TextWidget(
                                            text:
                                                "${publicProfileController.publicData.userProfile!.education![index].educationDescription}",
                                            maxLine: 12,
                                            textSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                          sizedTextfield,
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                                text: "Activity",
                                textSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 6),
                          if(publicProfileController.publicData.post!.isNotEmpty)
                              Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 250,
                                        child: ListView.separated(
                                          itemCount: publicProfileController
                                              .publicData.post!.length,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(width: 8);
                                          },
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return SizedBox(
                                              width: Get.width / 1.4,
                                              child: Card(
                                                elevation: 3,
                                                shadowColor: AppColors.white12,
                                                color: AppColors.blackCard,
                                                surfaceTintColor:
                                                    AppColors.blackCard,
                                                child: SingleChildScrollView(
                                                  child: Column(children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                AppColors
                                                                    .transparent,
                                                            radius: 18,
                                                            child: CircleAvatar(
                                                              radius: 20,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      '${publicProfileController.publicData.post![index].userProfilePicture}'),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 8),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                TextWidget(
                                                                    text:
                                                                        "${publicProfileController.publicData.post![index].userFirstName} ${publicProfileController.publicData.post![index].userLastName}",
                                                                    textSize:
                                                                        12),
                                                                // const SizedBox(height: 1),
                                                                TextWidget(
                                                                  text:
                                                                      "${publicProfileController.publicData.post![index].userDesignation}  ${publicProfileController.publicData.post![index].userLocation}",
                                                                  textSize: 10,
                                                                  color: AppColors
                                                                      .whiteCard,
                                                                ),
                                                                // const SizedBox(height: 1),
                                                                TextWidget(
                                                                  text:
                                                                      "${publicProfileController.publicData.post![index].age}",
                                                                  textSize: 10,
                                                                  color: AppColors
                                                                      .white54,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                        height: 0,
                                                        color:
                                                            AppColors.white38,
                                                        thickness: 0.5),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          HtmlWidget(
                                                            "${publicProfileController.publicData.post![index].description}",
                                                        
                                                            textStyle: TextStyle(
                                                                fontSize: 10,
                                                                color: AppColors
                                                                    .white),
                                                          ),
                                                          
                                                          publicProfileController
                                                                  .publicData
                                                                  .post![index]
                                                                  .images!
                                                                  .isEmpty
                                                              ? const SizedBox(
                                                                  height: 145)
                                                              : Column(
                                                                  children: [
                                                                      SizedBox(
                                                                        height:
                                                                            133,
                                                                        child: PageView
                                                                            .builder(
                                                                          controller:
                                                                              _pageController,
                                                                          itemCount: publicProfileController
                                                                              .publicData
                                                                              .post![index]
                                                                              .images!
                                                                              .length,
                                                                          onPageChanged:
                                                                              (ind) {
                                                                            setState(() {
                                                                              _currentIndex = ind;
                                                                            });
                                                                          },
                                                                          itemBuilder:
                                                                              (context, ind) {
                                                                            return Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(12),
                                                                                image: DecorationImage(
                                                                                  fit: BoxFit.cover,
                                                                                  image: NetworkImage(publicProfileController.publicData.post![index].images![ind]),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                      if (publicProfileController.publicData.post![
                                                                                  index]
                                                                              .images!
                                                                              .isNotEmpty &&
                                                                          publicProfileController.publicData.post![index].images!.length >
                                                                              1)
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children:
                                                                              List.generate(
                                                                            publicProfileController.publicData.post![index].images!.length,
                                                                            (index) =>
                                                                                Container(
                                                                              margin: const EdgeInsets.only(left: 4, right: 4, top: 8),
                                                                              width: _currentIndex == index ? 5 : 3,
                                                                              height: _currentIndex == index ? 5 : 3,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                color: _currentIndex == index ? AppColors.primary : AppColors.grey,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ])
                                                        ],
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                         
                        ],
                      ),
                    ),
                  ),
          )),
    );
  }
}
