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
  CommunityController allCommunities = Get.put(CommunityController());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      allCommunities.getAllCommunities().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.blackCard,
      ),
      padding: const EdgeInsets.all(8),
      child: homeController.isLoading.value
          ? Helper.loader(context)
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(text: "Communities Corner", textSize: 20),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: homeController.startUpNewsList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 180,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                        "https://res.cloudinary.com/drjt9guif/image/upload/v1739605439/TheCapitalHub/posts/images/k3eekniyiqkswisifupe.webp",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const TextWidget(
                                  text: "Hustler's Club",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 12),
                                const TextWidget(
                                    text: "Join our vibrant community!",
                                    textSize: 14),
                                const SizedBox(height: 12),
                                Container(
                                  width: 250,
                                  child: const Row(
                                    children: [
                                      TextWidget(
                                          text: "17 Members", textSize: 14),
                                      Spacer(),
                                      TextWidget(
                                        text: "Free to Join",
                                        textSize: 14,
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
