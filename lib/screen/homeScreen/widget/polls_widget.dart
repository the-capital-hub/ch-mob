import 'package:capitalhub_crm/controller/homeController/home_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/publicPostModel/public_post_model.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PollWidget extends StatefulWidget {
  final List<PollOptionData> pollOptions;
  final int totalVotes;
  final String postId;
  final List<String> myVotes;

  PollWidget({
    required this.pollOptions,
    required this.myVotes,
    required this.postId,
    required this.totalVotes,
  });

  @override
  _PollWidgetState createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
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

  // Handle tap event to vote/unvote
  void toggleVote(String pollId, int index) {
    setState(() {
      if (myVotes.contains(pollId)) {
        // Unvote
        myVotes.remove(pollId);
        pollOptions[index].hasVoted = false;
        pollOptions[index].numberOfVotes--;
        totalVotes--;
      } else {
        // Vote
        myVotes.add(pollId);
        pollOptions[index].hasVoted = true;
        pollOptions[index].numberOfVotes++;
        totalVotes++; // Increase total votes on vote
      }
    });
    homeController.votePoll(context, postID: widget.postId, optionID: pollId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              for (int i = 0; i < pollOptions.length; i++) ...[
                GestureDetector(
                  onTap: () => toggleVote(pollOptions[i].id!, i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                    ),
                    height: 38,
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
                              (MediaQuery.of(context).size.width - 48) /
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
                                TextWidget(
                                  text: '${pollOptions[i].option}',
                                  textSize: 14,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
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
                                      textSize: 14,
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
        ),
        if (widget.totalVotes > 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextWidget(text: "$totalVotes users voted", textSize: 12),
          )
      ],
    );
  }
}
