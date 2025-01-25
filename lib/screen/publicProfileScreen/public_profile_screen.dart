import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
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
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: AppColors.white12,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.white38)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          publicProfileController.publicData
                                              .userProfile!.profilePicture),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                            text:
                                                "${publicProfileController.publicData.userProfile!.firstName} ${publicProfileController.publicData.userProfile!.lastName}",
                                            textSize: 18,
                                            fontWeight: FontWeight.w500),
                                        TextWidget(
                                            text: publicProfileController
                                                .publicData
                                                .userProfile!
                                                .designation,
                                            textSize: 14),
                                      ],
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Helper.launchUrl(publicProfileController
                                            .publicData
                                            .userProfile!
                                            .linkedinUrl);
                                      },
                                      child: Image.asset(
                                          PngAssetPath.linkedinIcon,
                                          height: 35),
                                    )
                                  ],
                                ),
                                Divider(
                                  height: 24,
                                  color: AppColors.white38,
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                        child: TextWidget(
                                            text: "Current Company",
                                            textSize: 15)),
                                    Expanded(
                                        child: TextWidget(
                                            text: publicProfileController
                                                .publicData
                                                .userProfile!
                                                .companyName,
                                            textSize: 15)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Expanded(
                                        child: TextWidget(
                                            text: "Designation", textSize: 15)),
                                    Expanded(
                                        child: TextWidget(
                                            text: publicProfileController
                                                .publicData
                                                .userProfile!
                                                .designation,
                                            textSize: 15)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                        child: TextWidget(
                                            text: "Experience", textSize: 15)),
                                    Expanded(
                                      child: SizedBox(
                                        height: 100,
                                        child: ListView.separated(
                                          itemCount: publicProfileController
                                              .publicData
                                              .userProfile!
                                              .experience
                                              .length,
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(width: 8),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return SizedBox(
                                              width: 150,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 15,
                                                        backgroundImage: NetworkImage(
                                                            publicProfileController
                                                                .publicData
                                                                .userProfile!
                                                                .experience[
                                                                    index]
                                                                .companyLogo),
                                                      ),
                                                      const SizedBox(width: 6),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          TextWidget(
                                                              text: publicProfileController
                                                                  .publicData
                                                                  .userProfile!
                                                                  .experience[
                                                                      index]
                                                                  .companyName,
                                                              textSize: 14),
                                                          TextWidget(
                                                              text: publicProfileController
                                                                  .publicData
                                                                  .userProfile!
                                                                  .experience[
                                                                      index]
                                                                  .location,
                                                              textSize: 12),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 2),
                                                  TextWidget(
                                                      text:
                                                          "${publicProfileController.publicData.userProfile!.experience[index].startYear} - ${publicProfileController.publicData.userProfile!.experience[index].endYear}",
                                                      textSize: 14),
                                                  const SizedBox(height: 2),
                                                  TextWidget(
                                                      text:
                                                          publicProfileController
                                                              .publicData
                                                              .userProfile!
                                                              .experience[index]
                                                              .role,
                                                      textSize: 14),
                                                  const SizedBox(height: 2),
                                                  TextWidget(
                                                      text:
                                                          publicProfileController
                                                              .publicData
                                                              .userProfile!
                                                              .experience[index]
                                                              .description,
                                                      textSize: 14),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          sizedTextfield,
                          Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: AppColors.white12,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.white38)),
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
                                                      .isAccessible
                                                  ? publicProfileController
                                                      .publicData
                                                      .userEmail!
                                                      .email
                                                  : "xxxxx@xxx.com",
                                              maxLine: 3,
                                              textSize: 14)),
                                      const SizedBox(width: 8),
                                      if (!publicProfileController
                                          .publicData.userEmail!.isAccessible)
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
                              )),
                          sizedTextfield,
                          Container(
                              width: Get.width,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: AppColors.white12,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.white38)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextWidget(
                                        text: "Bio",
                                        textSize: 16,
                                        fontWeight: FontWeight.w500),
                                    const SizedBox(height: 8),
                                    TextWidget(
                                        text: publicProfileController
                                            .publicData.userProfile!.bio,
                                        maxLine: 100,
                                        textSize: 12)
                                  ])),
                          sizedTextfield,
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: AppColors.white12,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.white38)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 8),
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
                                                      .companyData!
                                                      .logo))),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: publicProfileController
                                              .publicData
                                              .companyData!
                                              .companyName,
                                          textSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        const SizedBox(height: 4),
                                        TextWidget(
                                          text:
                                              "${publicProfileController.publicData.companyData!.location} Founded in ${publicProfileController.publicData.companyData!.startedAtDate}",
                                          textSize: 11,
                                        ),
                                        TextWidget(
                                          text:
                                              "Last funding ${publicProfileController.publicData.companyData!.lastFunding} Sector ${publicProfileController.publicData.companyData!.sector}",
                                          textSize: 11,
                                        ),
                                        TextWidget(
                                          text:
                                              "Stage ${publicProfileController.publicData.companyData!.stage}",
                                          textSize: 11,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // if (profileController
                                //     .profileData.companyData!.description!.isNotEmpty)
                                Card(
                                  color: AppColors.white12,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: TextWidget(
                                        text: publicProfileController.publicData
                                            .companyData!.description,
                                        maxLine: 12,
                                        textSize: 13),
                                  ),
                                ),
                                sizedTextfield,
                                SizedBox(
                                  height: 42,
                                  child: ListView.separated(
                                    itemCount: publicProfileController
                                        .publicData
                                        .companyData!
                                        .socialLinks
                                        .length,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, ind) {
                                      return const SizedBox(width: 3);
                                    },
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int ind) {
                                      return InkWell(
                                        onTap: () {
                                          Helper.launchUrl(
                                              publicProfileController
                                                  .publicData
                                                  .companyData!
                                                  .socialLinks[ind]
                                                  .link);
                                        },
                                        child: Card(
                                          color: AppColors.white12,
                                          surfaceTintColor: AppColors.white12,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  publicProfileController
                                                      .publicData
                                                      .companyData!
                                                      .socialLinks[ind]
                                                      .logo,
                                                  height: 25,
                                                ),
                                                const SizedBox(width: 8),
                                                TextWidget(
                                                    text:
                                                        publicProfileController
                                                            .publicData
                                                            .companyData!
                                                            .socialLinks[ind]
                                                            .name,
                                                    textSize: 12)
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
                        ],
                      ),
                    ),
                  ),
          )),
    );
  }
}
