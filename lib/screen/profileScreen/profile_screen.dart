import 'package:capitalhub_crm/controller/profileController/profile_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/profileModel/profile_model.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/Auth-Process/userDetailsScreen/bio_screen.dart';
import 'package:capitalhub_crm/screen/companyScreen/company_screen.dart';
import 'package:capitalhub_crm/screen/createPostScreen/create_post_screen.dart';
import 'package:capitalhub_crm/screen/documentationScreen/documentation_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/manageAccountScreen/manage_account_Screen.dart';
import 'package:capitalhub_crm/screen/oneLinkScreen/one_link_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/add_new_startup_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/personal_info_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/polls_widget_profile.dart';
import 'package:capitalhub_crm/screen/profileScreen/professional_info_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../utils/constant/app_var.dart';
import '../../utils/helper/placeholder.dart';
import '../chatScreen/chat_member_screen.dart';
import 'add_edit_philosophy.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  ProfileController profileController = Get.find();

  late TabController _tabController;
  final List<String> tabs = ["My Posts", "Featured Posts", "Company Update"];
  PageController _pageController = PageController();
  int _currentIndex = 0;
  double profilePercentageValue = 0;
  double profileValueInDecimal = 0;
  double companyPercentageValue = 0;
  double companyValueInDecimal = 0;

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await profileController.getProfile().then((val) {
        if (profileController.profileData.banner != null) {
          profilePercentageValue = double.parse(profileController
              .profileData.banner!.profileCompletionPercentage
              .replaceAll('%', ''));
          profileValueInDecimal = profilePercentageValue / 100;
          companyPercentageValue = double.parse(profileController
              .profileData.banner!.companyCompletionPercentage
              .replaceAll('%', ''));
          companyValueInDecimal = companyPercentageValue / 100;
        }
      });
      await profileController.getProfilePost(0);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String reportReason = "";
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: AppColors.transparent,
            drawer: GetStoreData.getStore.read('isInvestor')
                ? const DrawerWidgetInvestor()
                : const DrawerWidget(),
            appBar: HelperAppBar.appbarHelper(
                title: "Profile", hideBack: true, autoAction: true),
            body: Obx(() {
              if (profileController.isLoading.value) {
                return ShimmerLoader.shimmerProfile();
              }
              if (profileController.profileData.banner == null) {
                return const SizedBox();
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        if (!(profileController
                                .profileData.banner!.isProfileCompleted &&
                            profileController
                                .profileData.banner!.isCompanyAdded &&
                            profileController
                                .profileData.banner!.isPasswordSet))
                          boostProfile(),
                        const SizedBox(
                          height: 12,
                        ),
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: profileController
                                      .profileData.user!.isSubscribed ??
                                  false
                              ? AppColors.golden
                              : AppColors.transparent,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(profileController
                                .profileData.user!.profilePicture!),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                                text:
                                    "${profileController.profileData.user!.firstName} ${profileController.profileData.user!.lastName}",
                                textSize: 18,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWidget(
                                text: profileController
                                    .profileData.user!.userName!,
                                textSize: 15),
                            if (profileController
                                .profileData.user!.isSubscribed!)
                              const SizedBox(width: 6),
                            if (profileController
                                .profileData.user!.isSubscribed!)
                              Image.asset(PngAssetPath.verifyImg, height: 18)
                          ],
                        ),
                        const SizedBox(height: 4),
                        TextWidget(
                            text:
                                "${profileController.profileData.user!.designation} of ${profileController.profileData.user!.companyName}, ${profileController.profileData.user!.location}",
                            textSize: 14),
                        const SizedBox(height: 4),
                        TextWidget(
                            text:
                                "${profileController.profileData.user!.followersCount} Followers  |  ${profileController.profileData.user!.connectionsCount} Connections",
                            color: GetStoreData.getStore.read('isInvestor')
                                ? AppColors.primaryInvestor
                                : AppColors.primary,
                            textSize: 14),
                        const SizedBox(height: 8),
                        if (GetStoreData.getStore.read('isInvestor'))
                          Card(
                            color: AppColors.blackCard,
                            surfaceTintColor: AppColors.blackCard,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.white12,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TextWidget(
                                          text: "Professional Information",
                                          textSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(() =>
                                                const ProfessionalInfoScreen());
                                          },
                                          child: const Icon(
                                            Icons.edit_outlined,
                                            color: AppColors.primaryInvestor,
                                            size: 22,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                  thickness: 0.2,
                                  color: AppColors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, bottom: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      TextWidget(
                                          text: "Company",
                                          color: AppColors.grey,
                                          textSize: 15),
                                      const SizedBox(height: 1),
                                      TextWidget(
                                          text:
                                              "${profileController.profileData.user!.professionalInfo!.companyName}",
                                          textSize: 15),
                                      const SizedBox(height: 8),
                                      TextWidget(
                                          text: "Designation",
                                          color: AppColors.grey,
                                          textSize: 15),
                                      const SizedBox(height: 1),
                                      TextWidget(
                                          text:
                                              "${profileController.profileData.user!.professionalInfo!.designation}",
                                          textSize: 15),
                                      const SizedBox(height: 8),
                                      TextWidget(
                                          text: "Industry",
                                          color: AppColors.grey,
                                          textSize: 15),
                                      const SizedBox(height: 1),
                                      TextWidget(
                                          text:
                                              "${profileController.profileData.user!.professionalInfo!.industry}",
                                          textSize: 15),
                                      const SizedBox(height: 8),
                                      TextWidget(
                                          text: "Experience",
                                          color: AppColors.grey,
                                          textSize: 15),
                                      const SizedBox(height: 1),
                                      TextWidget(
                                          text:
                                              "${profileController.profileData.user!.professionalInfo!.experience}",
                                          textSize: 15)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (GetStoreData.getStore.read('isInvestor'))
                          sizedTextfield,
                        Card(
                          color: AppColors.blackCard,
                          surfaceTintColor: AppColors.blackCard,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white12,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12))),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
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
                                          Get.to(() => PersonalInfoScreen(
                                                isEdit: true,
                                              ));
                                        },
                                        child: Icon(
                                          Icons.edit_outlined,
                                          color: GetStoreData.getStore
                                                  .read('isInvestor')
                                              ? AppColors.primaryInvestor
                                              : AppColors.primary,
                                          size: 22,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 0,
                                thickness: 0.2,
                                color: AppColors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8),
                                    const TextWidget(
                                        text: "Experience",
                                        fontWeight: FontWeight.w500,
                                        textSize: 14),
                                    const SizedBox(height: 4),
                                    profileController.profileData.user!
                                            .experience!.isEmpty
                                        ? Center(
                                            child: TextWidget(
                                                text: "No Experience Found",
                                                color: AppColors.white54,
                                                textSize: 14),
                                          )
                                        : ListView.separated(
                                            shrinkWrap: true,
                                            itemCount: profileController
                                                .profileData
                                                .user!
                                                .experience!
                                                .length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return const SizedBox(
                                                height: 4,
                                              );
                                            },
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: AppColors.blackCard,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: AppColors.white38,
                                                      width: 0.5),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              profileController
                                                                  .profileData
                                                                  .user!
                                                                  .experience![
                                                                      index]
                                                                  .companyLogo),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          TextWidget(
                                                              text: profileController
                                                                  .profileData
                                                                  .user!
                                                                  .experience![
                                                                      index]
                                                                  .companyName,
                                                              textSize: 14),
                                                          TextWidget(
                                                              text: profileController
                                                                  .profileData
                                                                  .user!
                                                                  .experience![
                                                                      index]
                                                                  .location,
                                                              textSize: 14),
                                                          TextWidget(
                                                              text: profileController
                                                                  .profileData
                                                                  .user!
                                                                  .experience![
                                                                      index]
                                                                  .role,
                                                              textSize: 14),
                                                          TextWidget(
                                                            text: profileController
                                                                .profileData
                                                                .user!
                                                                .experience![
                                                                    index]
                                                                .description,
                                                            textSize: 14,
                                                            maxLine: 2,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        TextWidget(
                                                            text:
                                                                profileController
                                                                    .profileData
                                                                    .user!
                                                                    .experience![
                                                                        index]
                                                                    .startYear,
                                                            textSize: 12),
                                                        if (profileController
                                                            .profileData
                                                            .user!
                                                            .experience![index]
                                                            .endYear
                                                            .isNotEmpty)
                                                          const TextWidget(
                                                              text: "To",
                                                              textSize: 12),
                                                        TextWidget(
                                                            text:
                                                                profileController
                                                                    .profileData
                                                                    .user!
                                                                    .experience![
                                                                        index]
                                                                    .endYear,
                                                            textSize: 12),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                    const SizedBox(height: 8),
                                    const TextWidget(
                                        text: "Education",
                                        fontWeight: FontWeight.w500,
                                        textSize: 14),
                                    const SizedBox(height: 4),
                                    profileController.profileData.user!
                                            .education!.isEmpty
                                        ? Center(
                                            child: TextWidget(
                                                text: "No Education Found",
                                                color: AppColors.white54,
                                                textSize: 14),
                                          )
                                        : ListView.separated(
                                            shrinkWrap: true,
                                            itemCount: profileController
                                                .profileData
                                                .user!
                                                .education!
                                                .length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(height: 4),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: AppColors.blackCard,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: AppColors.white38,
                                                      width: 0.5),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              profileController
                                                                  .profileData
                                                                  .user!
                                                                  .education![
                                                                      index]
                                                                  .educationLogo),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          TextWidget(
                                                              text: profileController
                                                                  .profileData
                                                                  .user!
                                                                  .education![
                                                                      index]
                                                                  .educationSchoolName,
                                                              textSize: 14),
                                                          TextWidget(
                                                              text: profileController
                                                                  .profileData
                                                                  .user!
                                                                  .education![
                                                                      index]
                                                                  .educationLocation,
                                                              textSize: 14),
                                                          TextWidget(
                                                              text: profileController
                                                                  .profileData
                                                                  .user!
                                                                  .education![
                                                                      index]
                                                                  .educationCourse,
                                                              textSize: 14),
                                                          TextWidget(
                                                            text: profileController
                                                                .profileData
                                                                .user!
                                                                .education![
                                                                    index]
                                                                .educationDescription,
                                                            textSize: 14,
                                                            maxLine: 2,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    TextWidget(
                                                        text: profileController
                                                            .profileData
                                                            .user!
                                                            .education![index]
                                                            .educationPassYear,
                                                        textSize: 12),
                                                  ],
                                                ),
                                              );
                                            },
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white12,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12))),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TextWidget(
                                        text: "Bio",
                                        textSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(BioScreen(
                                            isEdit: true,
                                          ));
                                        },
                                        child: Icon(
                                          Icons.edit_outlined,
                                          color: GetStoreData.getStore
                                                  .read('isInvestor')
                                              ? AppColors.primaryInvestor
                                              : AppColors.primary,
                                          size: 22,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 0,
                                thickness: 0.2,
                                color: AppColors.white,
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, bottom: 12),
                                child: TextWidget(
                                    text: profileController
                                        .profileData.user!.bio!,
                                    maxLine: 10,
                                    textSize: 13),
                              ),
                            ],
                          ),
                        ),
                        sizedTextfield,
                        Card(
                          margin: const EdgeInsets.all(4),
                          color: AppColors.blackCard,
                          surfaceTintColor: AppColors.blackCard,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const TextWidget(
                                        text: "Top Voice ",
                                        textSize: 16,
                                        fontWeight: FontWeight.w500),
                                    Icon(
                                      Icons.shield,
                                      size: 20,
                                      color: AppColors.white,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextWidget(
                                  text: profileController
                                      .profileData.user!.topVoice!.description
                                      .toString(),
                                  textSize: 14,
                                  maxLine: 2,
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 8,
                                ),
                                LinearProgressIndicator(
                                  value: profileController
                                      .profileData.user!.topVoice!.postsCount,
                                  backgroundColor: AppColors.grey700,
                                  valueColor: AlwaysStoppedAnimation<
                                      Color>(GetStoreData.getStore
                                          .read('isInvestor')
                                      ? AppColors.primaryInvestor
                                      : AppColors
                                          .primary), // color of the progress bar
                                  borderRadius: BorderRadius.circular(20),
                                  minHeight: 5,
                                  semanticsLabel: "Post",
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                        if (profileController.profileData.user!.companyData!
                            .companyName!.isNotEmpty)
                          sizedTextfield,
                        if (profileController.profileData.user!.companyData!
                            .companyName!.isNotEmpty)
                          Card(
                            color: AppColors.blackCard,
                            surfaceTintColor: AppColors.blackCard,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
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
                                                    profileController
                                                            .profileData
                                                            .user!
                                                            .companyData!
                                                            .logo ??
                                                        ""))),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              text: profileController
                                                  .profileData
                                                  .user!
                                                  .companyData!
                                                  .companyName,
                                              textSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            const SizedBox(height: 4),
                                            TextWidget(
                                              text:
                                                  "${profileController.profileData.user!.companyData!.location} - Founded in ${profileController.profileData.user!.companyData!.startedAtDate}",
                                              textSize: 11,
                                            ),
                                            TextWidget(
                                              text:
                                                  "Last funding ${profileController.profileData.user!.companyData!.lastFunding} - Sector ${profileController.profileData.user!.companyData!.sector}",
                                              textSize: 11,
                                              maxLine: 2,
                                            ),
                                            TextWidget(
                                              text:
                                                  "Stage ${profileController.profileData.user!.companyData!.stage}",
                                              textSize: 11,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  if (profileController.profileData.user!
                                      .companyData!.description!.isNotEmpty)
                                    Card(
                                      color: AppColors.white12,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextWidget(
                                                  text: profileController
                                                      .profileData
                                                      .user!
                                                      .companyData!
                                                      .description,
                                                  maxLine: 12,
                                                  textSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        if (GetStoreData.getStore.read('isInvestor'))
                          sizedTextfield,
                        if (GetStoreData.getStore.read('isInvestor'))
                          Card(
                            color: AppColors.blackCard,
                            surfaceTintColor: AppColors.blackCard,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.white12,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TextWidget(
                                          text: "Investment Philosophy",
                                          textSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(PhilosophyScreen(
                                              isEdit: true,
                                            ));
                                          },
                                          child: Icon(
                                            Icons.edit_outlined,
                                            color: GetStoreData.getStore
                                                    .read('isInvestor')
                                                ? AppColors.primaryInvestor
                                                : AppColors.primary,
                                            size: 22,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                  thickness: 0.2,
                                  color: AppColors.white,
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, bottom: 12),
                                  child: TextWidget(
                                      text: profileController.profileData.user!
                                          .investmentPhilosophy!,
                                      maxLine: 10,
                                      textSize: 13),
                                ),
                              ],
                            ),
                          ),
                        postsSection(),
                        if (profileController
                            .profileData.user!.recentConnections!.isNotEmpty)
                          sizedTextfield,
                        if (profileController
                            .profileData.user!.recentConnections!.isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                    text: "Connections",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500),
                                // TextWidget(
                                //     text: "See more",
                                //     textSize: 13,
                                //     color: AppColors.primary)
                              ],
                            ),
                          ),
                        if (profileController
                            .profileData.user!.recentConnections!.isNotEmpty)
                          SizedBox(
                            height: 179,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: profileController
                                  .profileData.user!.recentConnections!.length,
                              padding: const EdgeInsets.only(top: 8),
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  width: Get.width / 2,
                                  child: Card(
                                    color: AppColors.blackCard,
                                    surfaceTintColor: AppColors.blackCard,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 28,
                                            backgroundImage: NetworkImage(
                                                '${profileController.profileData.user!.recentConnections![index].profilePicture}'),
                                          ),
                                          const SizedBox(height: 6),
                                          TextWidget(
                                              text:
                                                  "${profileController.profileData.user!.recentConnections![index].firstName} ${profileController.profileData.user!.recentConnections![index].lastName}",
                                              fontWeight: FontWeight.w500,
                                              textSize: 14),
                                          TextWidget(
                                              text:
                                                  "${profileController.profileData.user!.recentConnections![index].designation}",
                                              textSize: 12),
                                          const SizedBox(height: 8),
                                          AppButton.primaryButton(
                                              onButtonPressed: () {
                                                Get.to(
                                                    const ChatMemberScreen());
                                              },
                                              title: "Message",
                                              // width: 100,
                                              fontSize: 12,
                                              height: 32)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        const SizedBox(height: 8),
                        if (GetStoreData.getStore.read('isInvestor'))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextWidget(
                                  text: "My Investments", textSize: 15),
                              InkWell(
                                onTap: () {
                                  Get.to(() => AddNewStartupScreen(
                                        isEdit: false,
                                      ));
                                },
                                child: TextWidget(
                                  text: "+ Add",
                                  textSize: 15,
                                  color:
                                      GetStoreData.getStore.read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        sizedTextfield,
                        if (GetStoreData.getStore.read('isInvestor'))
                          SizedBox(
                            height: 210,
                            width: Get.width,
                            child: profileController
                                    .profileData.user!.startupsInvested!.isEmpty
                                ? const Center(
                                    child: TextWidget(
                                        text: "No Data Found", textSize: 14))
                                : ListView.separated(
                                    itemCount: profileController.profileData
                                        .user!.startupsInvested!.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(width: 12);
                                    },
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Stack(
                                        children: [
                                          Container(
                                            width: Get.width / 1.3,
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: AppColors.blackCard,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: AppColors.white38,
                                                  width: 0.4),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 22,
                                                      backgroundImage: NetworkImage(
                                                          "${profileController.profileData.user!.startupsInvested![index].logo}"),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Expanded(
                                                      child: TextWidget(
                                                        text:
                                                            "${profileController.profileData.user!.startupsInvested![index].name}",
                                                        textSize: 15,
                                                        maxLine: 2,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12)
                                                  ],
                                                ),
                                                const SizedBox(height: 6),
                                                TextWidget(
                                                  text:
                                                      "${profileController.profileData.user!.startupsInvested![index].description}",
                                                  textSize: 13,
                                                  maxLine: 5,
                                                ),
                                                const Spacer(),
                                                Divider(
                                                  color: AppColors.white54,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.local_atm,
                                                        color: AppColors.white),
                                                    const SizedBox(width: 6),
                                                    TextWidget(
                                                        text:
                                                            "Invested: ${profileController.profileData.user!.startupsInvested![index].investedEquity}",
                                                        textSize: 13),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                              right: 6,
                                              top: 6,
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      () => AddNewStartupScreen(
                                                            isEdit: true,
                                                            index: index,
                                                          ));
                                                },
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.whiteShade,
                                                    radius: 12,
                                                    child: Icon(Icons.edit,
                                                        size: 16,
                                                        color:
                                                            AppColors.black)),
                                              )),
                                        ],
                                      );
                                    },
                                  ),
                          ),
                        if (GetStoreData.getStore.read('isInvestor'))
                          sizedTextfield,
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                  text: "Milestones",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500),
                              // TextWidget(
                              //     text: "See more",
                              //     textSize: 13,
                              //     color: AppColors.primary)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                mileStoneWidget(
                                    profileController
                                        .profileData.user!.milestoneProfile!,
                                    "User profile", () {
                                  Get.to(() => const ProfileScreen());
                                }),
                                mileStoneWidget(
                                    profileController
                                        .profileData.user!.milestoneCompany!,
                                    "Company profile", () {
                                  Get.to(() => const CompanyScreen());
                                }),
                                mileStoneWidget(
                                    profileController
                                        .profileData.user!.milestoneOnelink!,
                                    "One link", () {
                                  Get.to(() => const OneLinkScreeen());
                                }),
                                mileStoneWidget(
                                    profileController
                                        .profileData.user!.milestoneDocuments!,
                                    "Document upload", () {
                                  Get.to(() => const DocumentationScreen());
                                }),
                                mileStoneWidget(
                                    profileController
                                        .profileData.user!.milestonePosts!,
                                    "Create first post", () {
                                  Get.to(() => CreatePostScreen());
                                }),
                              ]),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ));
  }

  boostProfile() {
    return ExpansionTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      backgroundColor: GetStoreData.getStore.read('isInvestor')
          ? AppColors.primaryInvestor
          : AppColors.primary,
      collapsedBackgroundColor: GetStoreData.getStore.read('isInvestor')
          ? AppColors.primaryInvestor
          : AppColors.primary,
      collapsedIconColor: GetStoreData.getStore.read('isInvestor')
          ? AppColors.black
          : AppColors.white,
      iconColor: GetStoreData.getStore.read('isInvestor')
          ? AppColors.black
          : AppColors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.rocket_launch,
              color: GetStoreData.getStore.read('isInvestor')
                  ? AppColors.black
                  : AppColors.white),
          const SizedBox(width: 5),
          TextWidget(
              text: "Boost Your Presence!",
              textSize: 16,
              color: GetStoreData.getStore.read('isInvestor')
                  ? AppColors.black
                  : AppColors.white,
              fontWeight: FontWeight.bold),
        ],
      ),
      onExpansionChanged: (bool expanded) {
        setState(() {
          isExpanded = expanded; // Track expansion state
        });
      },
      children: [
        Container(
          color: AppColors.blackCard,
          child: Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              if (!profileController.profileData.banner!.isProfileCompleted)
                InkWell(
                  onTap: () {
                    Get.to(() => PersonalInfoScreen());
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Rounded corners
                    ),
                    color: GetStoreData.getStore.read('isInvestor')
                        ? AppColors.primaryInvestor.withOpacity(0.1)
                        : AppColors.primary.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: "Stand Out with Your Profile",
                                textSize: 16,
                                color: GetStoreData.getStore.read('isInvestor')
                                    ? AppColors.primaryInvestor
                                    : AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Rounded corners
                                ),
                                color: GetStoreData.getStore.read('isInvestor')
                                    ? AppColors.primaryInvestor.withOpacity(0.2)
                                    : AppColors.primary.withOpacity(0.2),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextWidget(
                                      text:
                                          "${profileController.profileData.banner!.profileCompletionPercentage} Complete",
                                      textSize: 13,
                                      color: GetStoreData.getStore
                                              .read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          // Title section

                          // Progress Bar Section
                          const SizedBox(
                              height: 4), // Add spacing for better readability
                          LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(5),
                            backgroundColor: AppColors.black,
                            color: GetStoreData.getStore.read('isInvestor')
                                ? AppColors.primaryInvestor
                                : AppColors.primary,
                            value:
                                profileValueInDecimal, // Progress value between 0.0 and 1.0
                            minHeight: 6.0, // Height of the progress bar
                          ),

                          // Progress description text
                          const SizedBox(height: 8), // Add spacing
                          TextWidget(
                            text:
                                "Showcase your expertise and make a lasting impression",
                            textSize: 12,
                            color: AppColors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 4,
              ),
              if (!profileController.profileData.banner!.isCompanyAdded)
                InkWell(
                  onTap: () {
                    Get.to(() => const CompanyScreen());
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Rounded corners
                    ),
                    color: GetStoreData.getStore.read('isInvestor')
                        ? AppColors.primaryInvestor.withOpacity(0.1)
                        : AppColors.primary.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: "Add Your Company to Shine",
                                textSize: 16,
                                color: GetStoreData.getStore.read('isInvestor')
                                    ? AppColors.primaryInvestor
                                    : AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Rounded corners
                                ),
                                color: GetStoreData.getStore.read('isInvestor')
                                    ? AppColors.primaryInvestor.withOpacity(0.2)
                                    : AppColors.primary.withOpacity(0.2),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextWidget(
                                      text:
                                          "${profileController.profileData.banner!.companyCompletionPercentage} Complete",
                                      textSize: 13,
                                      color: GetStoreData.getStore
                                              .read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(5),
                            backgroundColor: AppColors.black,
                            color: GetStoreData.getStore.read('isInvestor')
                                ? AppColors.primaryInvestor
                                : AppColors.primary,
                            value: companyValueInDecimal,
                            minHeight: 6.0,
                          ),
                          const SizedBox(height: 8),
                          TextWidget(
                            text:
                                "Put your company in the spotlight and attract opportunities",
                            textSize: 12,
                            color: AppColors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 4,
              ),
              if (!profileController.profileData.banner!.isPasswordSet)
                InkWell(
                  onTap: () {
                    Get.to(() => const ManageAccountScreen());
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Rounded corners
                    ),
                    color: GetStoreData.getStore.read('isInvestor')
                        ? AppColors.primaryInvestor.withOpacity(0.1)
                        : AppColors.primary.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: "Secure Your Journey",
                                textSize: 16,
                                color: GetStoreData.getStore.read('isInvestor')
                                    ? AppColors.primaryInvestor
                                    : AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Rounded corners
                                ),
                                color: GetStoreData.getStore.read('isInvestor')
                                    ? AppColors.primaryInvestor.withOpacity(0.2)
                                    : AppColors.primary.withOpacity(0.2),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextWidget(
                                      text: "Essential",
                                      textSize: 13,
                                      color: GetStoreData.getStore
                                              .read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8), // Add spacing
                          TextWidget(
                            text:
                                "Protect your growing network with a strong password",
                            textSize: 12,
                            color: AppColors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }

  mileStoneWidget(Milestone milestone, String title, Function() ontap) {
    return SizedBox(
      width: Get.width / 1.7,
      child: Card(
        color: AppColors.blackCard,
        surfaceTintColor: AppColors.blackCard,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(milestone.image))),
              ),
              const SizedBox(height: 8),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      value: milestone.completion! / 100,
                      strokeWidth: 4.0,
                      strokeCap: StrokeCap.round,
                      backgroundColor: AppColors.whiteCard,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          GetStoreData.getStore.read('isInvestor')
                              ? AppColors.primaryInvestor
                              : AppColors.primary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWidget(
                        text: "${milestone.completion}%", textSize: 10),
                  )
                ],
              ),
              const SizedBox(height: 8),
              TextWidget(
                  text: milestone.description,
                  maxLine: 3,
                  align: TextAlign.center,
                  textSize: 12),
              const Spacer(),
              AppButton.primaryButton(
                  onButtonPressed: ontap,
                  title: title,
                  fontSize: 12,
                  height: 32),
            ],
          ),
        ),
      ),
    );
  }

  postsSection() {
    return Obx(
      () => profileController.isLoading.value
          ? const SizedBox()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                TabBar(
                  indicator: const BoxDecoration(), // Removes the indicator
                  labelColor: GetStoreData.getStore.read('isInvestor')
                      ? AppColors.primaryInvestor
                      : AppColors.primary,
                  dividerColor: AppColors.white54,
                  unselectedLabelColor: AppColors.whiteCard,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  onTap: (value) {
                    profileController.getProfilePost(value);
                  },
                  controller: _tabController,
                  tabs: tabs.map((tab) => Tab(text: tab)).toList(),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 250,
                  child: profileController.isTabLoading.value
                      ? Helper.tabLoading()
                      : profileController.profilePosts.isEmpty
                          ? const Center(
                              child: TextWidget(
                                  text: "No Post Found", textSize: 14),
                            )
                          : TabBarView(
                              controller: _tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: tabs.map((_) {
                                return ListView.separated(
                                  itemCount:
                                      profileController.profilePosts.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 8);
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: Get.width / 1.5,
                                      child: Card(
                                        elevation: 3,
                                        shadowColor: AppColors.white12,
                                        color: AppColors.blackCard,
                                        surfaceTintColor: AppColors.blackCard,
                                        child: SingleChildScrollView(
                                          child: Column(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.transparent,
                                                    radius: 18,
                                                    child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundImage: NetworkImage(
                                                          '${profileController.profilePosts[index].userProfilePicture}'),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            TextWidget(
                                                                text:
                                                                    "${profileController.profilePosts[index].userFirstName} ${profileController.profilePosts[index].userLastName}",
                                                                textSize: 12),
                                                            const Expanded(
                                                                child:
                                                                    SizedBox()),
                                                            InkWell(
                                                              onTap: () {
                                                                profileController
                                                                    .deletePost(
                                                                        context,
                                                                        _tabController
                                                                            .index,
                                                                        profileController
                                                                            .profilePosts[index]
                                                                            .postId!)
                                                                    .then((v) {
                                                                  profileController
                                                                      .profilePosts
                                                                      .removeAt(
                                                                          index);
                                                                  setState(
                                                                      () {});
                                                                });
                                                              },
                                                              child: const Icon(
                                                                Icons.delete,
                                                                color: AppColors
                                                                    .redColor,
                                                                size: 18,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        // const SizedBox(height: 1),
                                                        TextWidget(
                                                          text:
                                                              "${profileController.profilePosts[index].userDesignation}  ${profileController.profilePosts[index].userLocation}",
                                                          textSize: 10,
                                                          color: AppColors
                                                              .whiteCard,
                                                        ),
                                                        // const SizedBox(height: 1),
                                                        TextWidget(
                                                          text:
                                                              "${profileController.profilePosts[index].age}",
                                                          textSize: 10,
                                                          color:
                                                              AppColors.white54,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                                height: 0,
                                                color: AppColors.white38,
                                                thickness: 0.5),
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  HtmlWidget(
                                                    "${profileController.profilePosts[index].description}",
                                                    // onTapUrl: (url) async {
                                                    //   return await launch(
                                                    //       url);
                                                    // },
                                                    textStyle: TextStyle(
                                                        fontSize: 10,
                                                        color: AppColors.white),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  if (profileController
                                                      .profilePosts[index]
                                                      .pollOptions!
                                                      .isNotEmpty)
                                                    PollWidgetProfile(
                                                        pollOptions:
                                                            profileController
                                                                .profilePosts[
                                                                    index]
                                                                .pollOptions!,
                                                        totalVotes:
                                                            profileController
                                                                .profilePosts[
                                                                    index]
                                                                .totalVotes!,
                                                        myVotes:
                                                            profileController
                                                                .profilePosts[
                                                                    index]
                                                                .myVotes!),
                                                  profileController
                                                          .profilePosts[index]
                                                          .images!
                                                          .isEmpty
                                                      ? const SizedBox()
                                                      : Column(children: [
                                                          SizedBox(
                                                            height: 133,
                                                            child: PageView
                                                                .builder(
                                                              controller:
                                                                  _pageController,
                                                              itemCount:
                                                                  profileController
                                                                      .profilePosts[
                                                                          index]
                                                                      .images!
                                                                      .length,
                                                              onPageChanged:
                                                                  (ind) {
                                                                setState(() {
                                                                  _currentIndex =
                                                                      ind;
                                                                });
                                                              },
                                                              itemBuilder:
                                                                  (context,
                                                                      ind) {
                                                                return Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: NetworkImage(profileController
                                                                          .profilePosts[
                                                                              index]
                                                                          .images![ind]),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          if (profileController
                                                                  .profilePosts[
                                                                      index]
                                                                  .images!
                                                                  .isNotEmpty &&
                                                              profileController
                                                                      .profilePosts[
                                                                          index]
                                                                      .images!
                                                                      .length >
                                                                  1)
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children:
                                                                  List.generate(
                                                                profileController
                                                                    .profilePosts[
                                                                        index]
                                                                    .images!
                                                                    .length,
                                                                (index) =>
                                                                    Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              4,
                                                                          right:
                                                                              4,
                                                                          top:
                                                                              8),
                                                                  width: _currentIndex ==
                                                                          index
                                                                      ? 5
                                                                      : 3,
                                                                  height:
                                                                      _currentIndex ==
                                                                              index
                                                                          ? 5
                                                                          : 3,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: _currentIndex ==
                                                                            index
                                                                        ? GetStoreData.getStore.read(
                                                                                'isInvestor')
                                                                            ? AppColors
                                                                                .primaryInvestor
                                                                            : AppColors
                                                                                .primary
                                                                        : AppColors
                                                                            .grey,
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
                                );
                              }).toList(),
                            ),
                ),
                const SizedBox(height: 8),
                Divider(
                  color: AppColors.whiteCard,
                  thickness: 0.5,
                )
              ],
            ),
    );
  }
}
