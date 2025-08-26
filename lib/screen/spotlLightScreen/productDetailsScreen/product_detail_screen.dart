import 'package:animate_do/animate_do.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Chat GPT"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage(PngAssetPath.appIcon),
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              PngAssetPath.appIcon,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(
                                  text: 'test name',
                                  textSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 2),
                                TextWidget(
                                  text: 'test description',
                                  textSize: 13,
                                  color: AppColors.white54,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.white12,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.mobile_screen_share_outlined,
                                    size: 16, color: AppColors.white),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.white12,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.bookmark_add_outlined,
                                    size: 16, color: AppColors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      sizedTextfield,
                      Row(
                        children: [
                          const Icon(Icons.local_offer,
                              size: 18, color: Colors.orange),
                          const SizedBox(width: 6),
                          const TextWidget(
                              text: 'Tags', textSize: 12, color: Colors.white),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const TextWidget(
                                text: 'aa', color: Colors.white, textSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("👍", style: TextStyle(fontSize: 13)),
                                  SizedBox(width: 4),
                                  TextWidget(
                                      text: "For Support",
                                      textSize: 11,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.white12,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("😧", style: TextStyle(fontSize: 13)),
                                  SizedBox(width: 4),
                                  TextWidget(
                                      text: "For Roast",
                                      textSize: 11,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                sizedTextfield,
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
                          itemCount: 5,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                                width: Get.width / 1.5,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.white12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 18,
                                          backgroundImage:
                                              AssetImage(PngAssetPath.appIcon),
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const TextWidget(
                                                text: "Dhairya Jain",
                                                textSize: 14),
                                            TextWidget(
                                                text: "Full Stack Developer",
                                                color: AppColors.white54,
                                                textSize: 12),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    const TextWidget(
                                        text: "Capital Hub",
                                        fontWeight: FontWeight.w500,
                                        textSize: 12),
                                    const SizedBox(height: 2),
                                    const TextWidget(
                                        text:
                                            "I have been associated with The Capital Hub as a Full-Stack Developer for more than 6 months The Capital Hub as a Full-Stack Developer for more than 6 months",
                                        maxLine: 4,
                                        textSize: 11),
                                    const SizedBox(height: 8),
                                    AppButton.primaryButton(
                                        onButtonPressed: () {},
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
                sizedTextfield,
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
                          itemCount: 5,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              width: Get.width / 1.4,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.white12,
                                image: const DecorationImage(
                                  image: AssetImage(PngAssetPath.appIcon),
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
    );
  }
}
