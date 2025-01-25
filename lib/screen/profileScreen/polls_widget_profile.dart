import 'package:capitalhub_crm/controller/homeController/home_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/profileModel/profile_post_model.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PollWidgetProfile extends StatefulWidget {
  final List<PollOptionData> pollOptions;
  final int totalVotes;
  final List<String> myVotes;

  PollWidgetProfile({
    required this.pollOptions,
    required this.myVotes,
    required this.totalVotes,
  });

  @override
  _PollWidgetProfileState createState() => _PollWidgetProfileState();
}

class _PollWidgetProfileState extends State<PollWidgetProfile> {
  HomeController homeController = Get.find();
  late List<PollOptionData> pollOptions;
  late List<String> myVotes;
  late int totalVotes;

  @override
  void initState() {
    super.initState();
    pollOptions = widget.pollOptions;
    myVotes = widget.myVotes;
    totalVotes = widget.totalVotes;
  }

  // Calculate percentage for each poll option
  double getPercentage(int numberOfVotes) {
    if (totalVotes == 0) return 0.0;
    return (numberOfVotes / totalVotes) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            for (int i = 0; i < pollOptions.length; i++) ...[
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                  height: 26,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white12,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      // Orange progress fill based on percentage
                      AnimatedContainer(
                        duration: const Duration(
                            milliseconds:
                                300), // Smooth animation when progress bar updates
                        width: getPercentage(pollOptions[i].numberOfVotes) *
                            (MediaQuery.of(context).size.width - 150) /
                            100, // Flexible width
                        decoration: BoxDecoration(
                          color: AppColors.primary
                              .withOpacity(0.7), // Fill color is orange
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      // Text overlay in the center of the bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextWidget(
                                  text: '${pollOptions[i].option}',
                                  textSize: 12,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  if (pollOptions[i].hasVoted!)
                                    const Icon(Icons.check_circle_outline,
                                        size: 14),
                                  const SizedBox(width: 4),
                                  TextWidget(
                                    text:
                                        '${pollOptions[i].numberOfVotes} votes',
                                    textSize: 12,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
        if (widget.totalVotes > 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextWidget(text: "$totalVotes users voted", textSize: 10),
          ),
        SizedBox(height: 6),
      ],
    );
  }
}
