import 'dart:developer';

import 'package:capitalhub_crm/controller/createPostController/create_post_controller.dart';
import 'package:capitalhub_crm/controller/oneLinkController/one_link_controller.dart';
import 'package:capitalhub_crm/screen/createPostScreen/create_post_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../profileScreen/polls_widget_profile.dart';

class OneLinkScreeen extends StatefulWidget {
  const OneLinkScreeen({super.key});

  @override
  State<OneLinkScreeen> createState() => _OneLinkScreeenState();
}

class _OneLinkScreeenState extends State<OneLinkScreeen> {
  // TextEditingController fullNameController = TextEditingController();
  // TextEditingController companyNameController = TextEditingController();
  CreatePostController createPostController = Get.put(CreatePostController());
  OneLinkController oneLinkController = Get.put(OneLinkController());
  PageController _pageController = PageController();
  int _currentIndex = 0;
  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  fetchApi() async {
    await Future.wait([
      oneLinkController.getOneLinkDetails(),
      oneLinkController.getCompanyProfilePost()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          drawer: const DrawerWidget(),
          appBar: HelperAppBar.appbarHelper(
              title: "One Link", hideBack: true, autoAction: true),
          body:
              oneLinkController.isLoading.value &&
                      oneLinkController.isLoadingPost.value
                  ? Helper.pageLoading()
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWidget(
                                text: "Create one link", textSize: 16),
                            sizedTextfield,
                            MyCustomTextField.textField(
                                hintText: "Type link here",
                                readonly: true,
                                controller: oneLinkController.linkController,
                                prefixIcon: Icon(
                                  Icons.link,
                                  color: AppColors.white54,
                                ),
                                lableText:
                                    "Now share all your startup details in OneLink"),
                            sizedTextfield,
                            Stack(
                              children: [
                                MyCustomTextField.textField(
                                    hintText: "Type your text here",
                                    controller:
                                        oneLinkController.introMsgController,
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        oneLinkController.postIntroMsg(context);
                                      },
                                      child: Container(
                                          height: 92,
                                          width: 10,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(6),
                                                  bottomRight:
                                                      Radius.circular(6)),
                                              color: AppColors.primary),
                                          child: Icon(
                                            Icons.send,
                                            color: AppColors.white,
                                          )),
                                    ),
                                    maxLine: 3,
                                    lableText: "Introductory message"),
                                Positioned(
                                  right: 8,
                                  child: InkWell(
                                    onTap: () {
                                      prevMsgDilogue();
                                    },
                                    child: const TextWidget(
                                      text: "Previous Messages",
                                      textSize: 13,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            sizedTextfield,
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              color: AppColors.blackCard,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                            text: "Company Update",
                                            textSize: 16,
                                            color: AppColors.white),
                                        InkWell(
                                          onTap: () {
                                            createPostController.isPublicPost=false;
                                            Get.to(CreatePostScreen(isPublicPost: false,))!
                                                .whenComplete(() {
                                              oneLinkController
                                                  .getCompanyProfilePost();
                                                  createPostController.isPublicPost = true;
                                            });
                                          },
                                          child: const TextWidget(
                                            text: "Create Post +",
                                            color: AppColors.primary,
                                            textSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    sizedTextfield,
                                    oneLinkController.companyPosts.isEmpty
                                        ? TextWidget(
                                            text: "No Company Update Posts",
                                            textSize: 12,
                                            color: AppColors.white54)
                                        : Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: 250,
                                                  child: ListView.separated(
                                                    itemCount: oneLinkController
                                                        .companyPosts.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return const SizedBox(
                                                          width: 8);
                                                    },
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return SizedBox(
                                                        width: Get.width / 1.7,
                                                        child: Card(
                                                          elevation: 3,
                                                          shadowColor:
                                                              AppColors.white12,
                                                          color: AppColors
                                                              .blackCard,
                                                          surfaceTintColor:
                                                              AppColors
                                                                  .blackCard,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        CircleAvatar(
                                                                          backgroundColor:
                                                                              AppColors.transparent,
                                                                          radius:
                                                                              18,
                                                                          child:
                                                                              CircleAvatar(
                                                                            radius:
                                                                                20,
                                                                            backgroundImage:
                                                                                NetworkImage('${oneLinkController.companyPosts[index].userProfilePicture}'),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                8),
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  TextWidget(text: "${oneLinkController.companyPosts[index].userFirstName} ${oneLinkController.companyPosts[index].userLastName}", textSize: 12),
                                                                                  const Expanded(child: SizedBox()),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      oneLinkController.deletePost(context, oneLinkController.companyPosts[index].postId!).then((v) {
                                                                                        oneLinkController.companyPosts.removeAt(index);
                                                                                        setState(() {});
                                                                                      });
                                                                                    },
                                                                                    child: const Icon(
                                                                                      Icons.delete,
                                                                                      color: AppColors.redColor,
                                                                                      size: 18,
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              // const SizedBox(height: 1),
                                                                              TextWidget(
                                                                                text: "${oneLinkController.companyPosts[index].userDesignation}  ${oneLinkController.companyPosts[index].userLocation}",
                                                                                textSize: 10,
                                                                                color: AppColors.whiteCard,
                                                                              ),
                                                                              // const SizedBox(height: 1),
                                                                              TextWidget(
                                                                                text: "${oneLinkController.companyPosts[index].age}",
                                                                                textSize: 10,
                                                                                color: AppColors.white54,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Divider(
                                                                      height: 0,
                                                                      color: AppColors
                                                                          .white38,
                                                                      thickness:
                                                                          0.5),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        HtmlWidget(
                                                                          "${oneLinkController.companyPosts[index].description}",
                                                                          // onTapUrl: (url) async {
                                                                          //   return await launch(
                                                                          //       url);
                                                                          // },
                                                                          textStyle: TextStyle(
                                                                              fontSize: 10,
                                                                              color: AppColors.white),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                6),
                                                                        if (oneLinkController
                                                                            .companyPosts[
                                                                                index]
                                                                            .pollOptions!
                                                                            .isNotEmpty)
                                                                          PollWidgetProfile(
                                                                              pollOptions: oneLinkController.companyPosts[index].pollOptions!,
                                                                              totalVotes: oneLinkController.companyPosts[index].totalVotes!,
                                                                              myVotes: oneLinkController.companyPosts[index].myVotes!),
                                                                        oneLinkController.companyPosts[index].images!.isEmpty
                                                                            ? const SizedBox(height: 145)
                                                                            : Column(children: [
                                                                                SizedBox(
                                                                                  height: 133,
                                                                                  child: PageView.builder(
                                                                                    controller: _pageController,
                                                                                    itemCount: oneLinkController.companyPosts[index].images!.length,
                                                                                    onPageChanged: (ind) {
                                                                                      setState(() {
                                                                                        _currentIndex = ind;
                                                                                      });
                                                                                    },
                                                                                    itemBuilder: (context, ind) {
                                                                                      return Container(
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(12),
                                                                                          image: DecorationImage(
                                                                                            fit: BoxFit.cover,
                                                                                            image: NetworkImage(oneLinkController.companyPosts[index].images![ind]),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                if (oneLinkController.companyPosts[index].images!.isNotEmpty && oneLinkController.companyPosts[index].images!.length > 1)
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: List.generate(
                                                                                      oneLinkController.companyPosts[index].images!.length,
                                                                                      (index) => Container(
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
                                    sizedTextfield,
                                  ],
                                ),
                              ),
                            ),
                            sizedTextfield,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppButton.primaryButton(
                                  onButtonPressed: () {
                                    oneLinkPostDilogue();
                                  },
                                  title: "Create one link"),
                            )
                          ],
                        ),
                      ),
                    ),
        )));
  }

  prevMsgDilogue() {
    return Get.defaultDialog(
      title: "Previous Messages",
      titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteCard),
      backgroundColor: AppColors.blackCard,
      titlePadding: const EdgeInsets.only(top: 8),
      contentPadding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      content: SizedBox(
        height: Get.height / 2,
        child: ListView.separated(
          itemCount:
              oneLinkController.oneLinkData.previousIntroductoryMessage!.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              color: AppColors.white12,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                oneLinkController.introMsgController.text = oneLinkController
                    .oneLinkData.previousIntroductoryMessage![index];
                setState(() {});
                Get.back(closeOverlays: true);
              },
              child: SizedBox(
                height: 40,
                child: Center(
                  child: TextWidget(
                      text: oneLinkController
                          .oneLinkData.previousIntroductoryMessage![index],
                      textSize: 14),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  oneLinkPostDilogue() {
    return Get.defaultDialog(
        title: "Create one link",
        titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteCard),
        backgroundColor: AppColors.blackCard,
        titlePadding: const EdgeInsets.only(top: 8),
        contentPadding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              if (oneLinkController.genratedIntroMessage.isNotEmpty)
                TextWidget(
                  text: oneLinkController.genratedIntroMessage,
                  textSize: 14,
                  maxLine: 2,
                ),
              if (oneLinkController.genratedIntroMessage.isNotEmpty)
                const SizedBox(height: 12),
              MyCustomTextField.textField(
                  hintText: "Enter Secret Key",
                  lableText: "Assign Secret Key",
                  borderClr: AppColors.white38,
                  maxLength: 4,
                  textInputType: TextInputType.number,
                  controller: oneLinkController.secrateKeyController),
              const SizedBox(height: 12),
              AppButton.primaryButton(
                  onButtonPressed: () {
                    if (oneLinkController.secrateKeyController.text.length ==
                        4) {
                      oneLinkController.createSecrateKey(context).then((val) {
                        setState(() {});
                      });
                    }
                  },
                  width: 100,
                  borderRadius: 6,
                  fontSize: 13,
                  height: 30,
                  title: "Assign"),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Helper.launchUrl(oneLinkController.oneLinkData.oneLink!);
                },
                child: const TextWidget(
                    text: "Click for OneLink",
                    color: AppColors.primary,
                    textSize: 14),
              )
            ],
          ),
        ));
  }
}
