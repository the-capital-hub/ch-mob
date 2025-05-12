import 'package:capitalhub_crm/controller/spotlightController/spotlight_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/utils/helper/placeholder.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../utils/constant/asset_constant.dart';
import '../spotlight_animation.dart';
import 'product_detail_comments_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  SpotlightController spotlightController = Get.find();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _commentSectionKey = GlobalKey();

  @override
  void initState() {
    spotlightController.getSpotlightProductDetail(productId: widget.productId);
    super.initState();
  }

  void scrollToCommentSection() {
    final RenderBox renderBox =
        _commentSectionKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox
            .localToGlobal(Offset.zero, ancestor: context.findRenderObject())
            ?.dy ??
        0;
    _scrollController.animateTo(
      _scrollController.offset + offset - 100,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Obx(
        () => spotlightController.isDetailLoading.value
            ? Stack(
                children: [
                  ShimmerLoader.shimmerProductDetailSpotlight(),
                  const AnimatedSwingingSpotlight()
                ],
              )
            : Scaffold(
                backgroundColor: AppColors.transparent,
                appBar: HelperAppBar.appbarHelper(
                    title: "${spotlightController.productDetail.title}"),
                body: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        if (spotlightController
                            .productDetail.banner!.isNotEmpty)
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(
                                    spotlightController.productDetail.banner!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        sizedTextfield,
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.blackCard,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  spotlightController
                                          .productDetail.logo!.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            spotlightController
                                                .productDetail.logo!,
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text:
                                              '${spotlightController.productDetail.title}',
                                          textSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(height: 2),
                                        TextWidget(
                                          text: 'tagline',
                                          textSize: 13,
                                          color: AppColors.white54,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          sharePostPopup(
                                              context,
                                              "",
                                              spotlightController
                                                  .productDetail.shareUrl!);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppColors.white12,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                              Icons
                                                  .mobile_screen_share_outlined,
                                              size: 16,
                                              color: AppColors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      InkWell(
                                        onTap: () {
                                          HelperSnackBar.snackBar("Info",
                                              "Save Product Will Comming Soon");
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppColors.white12,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                              Icons.bookmark_add_outlined,
                                              size: 16,
                                              color: AppColors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (spotlightController
                                  .productDetail.aboutCompany!.isNotEmpty) ...[
                                const SizedBox(height: 6),
                                const TextWidget(
                                    text: "About the Company", textSize: 15),
                                const SizedBox(height: 3),
                                TextWidget(
                                    text:
                                        "${spotlightController.productDetail.aboutCompany}",
                                    textSize: 13,
                                    color: AppColors.whiteShade,
                                    maxLine: 5)
                              ],
                              if (spotlightController
                                  .productDetail.industry!.isNotEmpty) ...[
                                const SizedBox(height: 6),
                                const TextWidget(
                                    text: "Industry", textSize: 15),
                                const SizedBox(height: 3),
                                TextWidget(
                                    text: spotlightController
                                        .productDetail.industry!,
                                    textSize: 13,
                                    color: AppColors.whiteShade,
                                    maxLine: 5)
                              ],
                              if (spotlightController
                                  .productDetail.socialLinks!.isNotEmpty) ...[
                                const SizedBox(height: 6),
                                const TextWidget(
                                    text: "Connect With Us", textSize: 15),
                                const SizedBox(height: 3),
                                SizedBox(
                                  height: 35,
                                  child: ListView.separated(
                                    itemCount: spotlightController
                                        .productDetail.socialLinks!.length,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, ind) {
                                      return const SizedBox(width: 6);
                                    },
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int ind) {
                                      return InkWell(
                                        onTap: () {
                                          Helper.launchUrl(
                                              "${spotlightController.productDetail.socialLinks![ind].link}");
                                        },
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          color: AppColors.white12,
                                          surfaceTintColor: AppColors.white12,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 2),
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  spotlightController
                                                      .productDetail
                                                      .socialLinks![ind]
                                                      .logo!,
                                                  height: 22,
                                                ),
                                                const SizedBox(width: 8),
                                                TextWidget(
                                                    text: spotlightController
                                                        .productDetail
                                                        .socialLinks![ind]
                                                        .name!,
                                                    textSize: 12)
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                              sizedTextfield,
                              if (spotlightController
                                  .productDetail.tags!.isNotEmpty) ...[
                                Row(
                                  children: [
                                    const Icon(Icons.local_offer,
                                        size: 18, color: Colors.orange),
                                    const SizedBox(width: 6),
                                    const TextWidget(
                                        text: 'Tags',
                                        textSize: 12,
                                        color: Colors.white),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                      height: 30,
                                      child: ListView.separated(
                                        itemCount: spotlightController
                                            .productDetail.tags!.length,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(width: 8);
                                        },
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade800,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: TextWidget(
                                                text:
                                                    '${spotlightController.productDetail.tags?[index]}',
                                                color: Colors.white,
                                                textSize: 12),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                sizedTextfield
                              ],
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: AppButton.outlineButton(
                                      onButtonPressed: () {
                                        final product =
                                            spotlightController.productDetail;
                                        if (product.isDownvotedByMe == true) {
                                          product.isDownvotedByMe = false;
                                          product.downvotesCount =
                                              (product.downvotesCount ?? 0) - 1;
                                        }
                                        if (product.isUpvotedByMe == true) {
                                          product.isUpvotedByMe = false;
                                          product.upvotesCount =
                                              (product.upvotesCount ?? 0) - 1;
                                        } else {
                                          product.isUpvotedByMe = true;
                                          product.upvotesCount =
                                              (product.upvotesCount ?? 0) + 1;
                                        }

                                        setState(() {});
                                        spotlightController
                                            .addUpvoteDownvoteProduct(
                                          productID: product.id!,
                                          isUpvote: true,
                                        );
                                      },
                                      borderColor: AppColors.green700,
                                      height: 40,
                                      bgColor: spotlightController.productDetail
                                                  .isUpvotedByMe ==
                                              true
                                          ? AppColors.green700
                                          : Colors.transparent,
                                      title: "👍 Upvote",
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: AppButton.outlineButton(
                                      onButtonPressed: () {
                                        final product =
                                            spotlightController.productDetail;
                                        if (product.isUpvotedByMe == true) {
                                          product.isUpvotedByMe = false;
                                          product.upvotesCount =
                                              (product.upvotesCount ?? 0) - 1;
                                        }
                                        if (product.isDownvotedByMe == true) {
                                          product.isDownvotedByMe = false;
                                          product.downvotesCount =
                                              (product.downvotesCount ?? 0) - 1;
                                        } else {
                                          product.isDownvotedByMe = true;
                                          product.downvotesCount =
                                              (product.downvotesCount ?? 0) + 1;
                                        }

                                        setState(() {});
                                        spotlightController
                                            .addUpvoteDownvoteProduct(
                                          productID: product.id!,
                                          isUpvote: false,
                                        );
                                      },
                                      borderColor: AppColors.redColor,
                                      height: 40,
                                      bgColor: spotlightController.productDetail
                                                  .isDownvotedByMe ==
                                              true
                                          ? AppColors.redColor
                                          : Colors.transparent,
                                      title: "👎 Downvote",
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                      onTap: () {
                                        scrollToCommentSection();
                                      },
                                      child: CircleAvatar(
                                        radius: 19,
                                        backgroundColor: AppColors.white12,
                                        child: Icon(
                                          CupertinoIcons.chat_bubble_2_fill,
                                          size: 22,
                                          color: AppColors.white,
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        sizedTextfield,
                        statusBar(),
                        sizedTextfield,
                        if (spotlightController
                            .productDetail
                            .coreValueProposition!
                            .isNotEmpty) ...[coreValue(), sizedTextfield],
                        founderTab(),
                        if (spotlightController
                            .productDetail.foundingTeam!.isNotEmpty)
                          sizedTextfield,
                        if (spotlightController
                            .productDetail.foundingTeam!.isNotEmpty)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.blackCard,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(
                                    text: "Founding Team",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 205,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 12),
                                    itemCount: spotlightController
                                        .productDetail.foundingTeam!.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          width: Get.width / 1.5,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: AppColors.white12,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 18,
                                                    backgroundImage: NetworkImage(
                                                        spotlightController
                                                            .productDetail
                                                            .foundingTeam![
                                                                index]
                                                            .profilePicture!),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextWidget(
                                                          text:
                                                              "${spotlightController.productDetail.foundingTeam![index].firstName!} ${spotlightController.productDetail.foundingTeam![index].lastName!}",
                                                          textSize: 14),
                                                      TextWidget(
                                                          text:
                                                              spotlightController
                                                                  .productDetail
                                                                  .foundingTeam![
                                                                      index]
                                                                  .designation!,
                                                          color:
                                                              AppColors.white54,
                                                          textSize: 12),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              TextWidget(
                                                  text: spotlightController
                                                      .productDetail
                                                      .foundingTeam![index]
                                                      .companyName!,
                                                  fontWeight: FontWeight.w500,
                                                  textSize: 12),
                                              const SizedBox(height: 2),
                                              TextWidget(
                                                  text: spotlightController
                                                      .productDetail
                                                      .foundingTeam![index]
                                                      .bio!,
                                                  maxLine: 4,
                                                  textSize: 11),
                                              const Spacer(),
                                              AppButton.primaryButton(
                                                  onButtonPressed: () {
                                                    Helper.launchUrl(
                                                        spotlightController
                                                            .productDetail
                                                            .foundingTeam![
                                                                index]
                                                            .linkedin!);
                                                  },
                                                  title: "LinkedIn",
                                                  height: 40,
                                                  bgColor: AppColors.blue)
                                            ],
                                          ));
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        if (spotlightController
                            .productDetail.productImages!.isNotEmpty)
                          sizedTextfield,
                        if (spotlightController
                            .productDetail.productImages!.isNotEmpty)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.blackCard,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(
                                    text: "Product Images",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 205,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 12),
                                    itemCount: spotlightController
                                        .productDetail.productImages!.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: Get.width / 1.4,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: AppColors.white12,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                spotlightController
                                                    .productDetail
                                                    .productImages![index]),
                                            fit: BoxFit.cover,
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
                        Container(
                            key: _commentSectionKey,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.blackCard,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: CommentSectionPage())
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  statusBar() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.blackCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: '${spotlightController.productDetail.launchedAt}',
                      textSize: 14,
                      align: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_today,
                            color: AppColors.redColor, size: 16),
                        const SizedBox(width: 6),
                        TextWidget(
                            text: 'Launched On',
                            textSize: 12,
                            color: AppColors.grey),
                      ],
                    ),
                  ],
                ),
              ),

              // Votes
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text:
                              '${spotlightController.productDetail.upvotesCount}',
                          color: AppColors.green700,
                          textSize: 14,
                        ),
                        const SizedBox(width: 4),
                        const TextWidget(text: '|', textSize: 14),
                        const SizedBox(width: 4),
                        TextWidget(
                          text:
                              '${spotlightController.productDetail.downvotesCount}',
                          color: AppColors.redColor,
                          textSize: 14,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_upward,
                            color: AppColors.green700, size: 16),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_downward,
                            color: AppColors.redColor, size: 16),
                        const SizedBox(width: 6),
                        TextWidget(
                            text: 'Votes', textSize: 12, color: AppColors.grey),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextWidget(
                        text:
                            '${spotlightController.productDetail.commentsCount}',
                        fontWeight: FontWeight.bold,
                        textSize: 14),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(CupertinoIcons.chat_bubble_2_fill,
                            color: AppColors.redColor, size: 16),
                        const SizedBox(width: 4),
                        TextWidget(
                          text: 'Comments',
                          color: AppColors.grey,
                          textSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Shares
              Expanded(
                child: Column(
                  children: [
                    TextWidget(
                        text: '${spotlightController.productDetail.shareCount}',
                        fontWeight: FontWeight.bold,
                        textSize: 14),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.share,
                            color: AppColors.redColor, size: 16),
                        const SizedBox(width: 4),
                        TextWidget(
                          text: 'Shares',
                          color: AppColors.grey,
                          textSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  founderTab() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.blackCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
              text: "Founder", textSize: 16, fontWeight: FontWeight.w500),
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                  backgroundImage: NetworkImage(spotlightController
                      .productDetail.founder!.profilePicture!),
                  radius: 30),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text:
                          "${spotlightController.productDetail.founder!.firstName} ${spotlightController.productDetail.founder!.lastName!}",
                      textSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    TextWidget(
                      text: spotlightController.productDetail.founder!.bio!,
                      textSize: 12,
                      maxLine: 3,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  coreValue() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.blackCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
              text: "Core Value Propositions",
              textSize: 16,
              fontWeight: FontWeight.w500),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                spotlightController.productDetail.coreValueProposition!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 15,
                      child: TextWidget(
                        text: '${index + 1}',
                        textSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.white12,
                          borderRadius: BorderRadius.circular(10),
                          border: const Border(
                            left: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        child: TextWidget(
                            text: spotlightController
                                .productDetail.coreValueProposition![index],
                            textSize: 12,
                            maxLine: 3),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
