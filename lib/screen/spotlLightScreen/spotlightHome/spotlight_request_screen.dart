import 'package:capitalhub_crm/controller/spotlightController/spotlight_controller.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/helper/placeholder.dart';
import '../../../widget/textwidget/text_widget.dart';

class SpotlightRequestScreen extends StatefulWidget {
  const SpotlightRequestScreen({super.key});

  @override
  State<SpotlightRequestScreen> createState() => _SpotlightRequestScreenState();
}

class _SpotlightRequestScreenState extends State<SpotlightRequestScreen> {
  SpotlightController spotlightController = Get.find();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      spotlightController.viewRequestList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Requests"),
        body: Obx(() => spotlightController.isLoading.value
            ? ShimmerLoader.shimmerLoadingExplore()
            : ListView.separated(
                itemCount: spotlightController.requestData.length,
                padding: const EdgeInsets.all(10),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: AppColors.blackCard,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundImage: NetworkImage(
                                    spotlightController
                                        .requestData[index].logo!),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                            text:
                                                '${spotlightController.requestData[index].title}',
                                            textSize: 16,
                                            fontWeight: FontWeight.bold),
                                        TextWidget(
                                            text:
                                                '${spotlightController.requestData[index].createdAt}',
                                            textSize: 12,
                                            color: AppColors.white54),
                                      ],
                                    ),
                                    TextWidget(
                                        text:
                                            '${spotlightController.requestData[index].tagline}',
                                        textSize: 14),
                                    const SizedBox(height: 6),
                                    SizedBox(
                                      height: 30,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: spotlightController
                                            .requestData[index].tags!.length,
                                        shrinkWrap: true,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(width: 8),
                                        itemBuilder: (context, ind) =>
                                            _buildTag(spotlightController
                                                .requestData[index].tags![ind]),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          if (spotlightController
                              .requestData[index].remarkText!.isNotEmpty)
                            sizedTextfield,
                          if (spotlightController
                              .requestData[index].remarkText!.isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: AppColors.white12,
                                  borderRadius: BorderRadius.circular(12),
                                  border: const Border(
                                      left: BorderSide(
                                          color: AppColors.blue, width: 2))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.info,
                                          color: AppColors.blue, size: 20),
                                      SizedBox(width: 8),
                                      TextWidget(
                                        text: 'Remarks from Admin',
                                        textSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  TextWidget(
                                      text:
                                          '${spotlightController.requestData[index].remarkText}',
                                      textSize: 14,
                                      maxLine: 10)
                                ],
                              ),
                            ),
                          sizedTextfield,
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.white12,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(
                                  text: 'Submission History',
                                  textSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(height: 8),
                                ListView.builder(
                                  itemCount: spotlightController
                                      .requestData[index]
                                      .submissionHistory!
                                      .length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int ind) {
                                    return _buildStatusRow(
                                        '${spotlightController.requestData[index].submissionHistory![ind].date}',
                                        '${spotlightController.requestData[index].submissionHistory![ind].status}');
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextWidget(
          text: label,
          textSize: 12,
        ),
      ),
    );
  }

  Widget _buildStatusRow(String month, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.circle,
              size: 10,
              color: status == "Rejected"
                  ? AppColors.redColor
                  : AppColors.green700),
          const SizedBox(width: 8),
          TextWidget(text: month, textSize: 14),
          const Spacer(),
          TextWidget(
              text: status,
              textSize: 14,
              fontWeight: FontWeight.w500,
              color: status == "Rejected"
                  ? AppColors.redColor
                  : AppColors.green700),
        ],
      ),
    );
  }
}
