import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/controller/homeController/home_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CommunitiesCornerWidget extends StatefulWidget {
  const CommunitiesCornerWidget({super.key});

  @override
  State<CommunitiesCornerWidget> createState() =>
      _CommunitiesCornerWidgetState();
}

class _CommunitiesCornerWidgetState extends State<CommunitiesCornerWidget> {
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: homeController.isLoading.value
          ? Helper.loader(context)
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(text: "Communities Corner", textSize: 16),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        scrollDirection: Axis.horizontal,
                        itemCount: homeController.communityCornerList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: Get.width / 1.3,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.blackCard,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "${homeController.communityCornerList[index].image}",
                                      ),
                                      fit: BoxFit.fitHeight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Spacer(),
                                TextWidget(
                                  text: homeController
                                      .communityCornerList[index].name!,
                                  textSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 12),
                                const TextWidget(
                                    text: "Join our vibrant community!",
                                    textSize: 14),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: 250,
                                  child: Row(
                                    children: [
                                      TextWidget(
                                          text:
                                              "${homeController.communityCornerList[index].memberSize} Members",
                                          textSize: 14),
                                      Spacer(),
                                      TextWidget(
                                        text:
                                            "${homeController.communityCornerList[index].amount}",
                                        textSize: 12,
                                        color: AppColors.primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
