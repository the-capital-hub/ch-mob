import 'package:capitalhub_crm/controller/spotlightController/spotlight_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/helper/placeholder.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/spotlightModel/spotlight_productDetail_model.dart';
import '../../../utils/helper/helper.dart';
import '../../../widget/textwidget/text_widget.dart';

class CommentSectionPage extends StatefulWidget {
  @override
  State<CommentSectionPage> createState() => _CommentSectionPageState();
}

class _CommentSectionPageState extends State<CommentSectionPage> {
  final TextEditingController _commentController = TextEditingController();
  SpotlightController spotlightController = Get.find();
  final Set<String> _expandedComments = {};
  CommentType _selectedType = CommentType.support;
  String _filter = "All";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
              text: "Comments", textSize: 16, fontWeight: FontWeight.w500),
          const SizedBox(height: 8),
          _buildCommentInput(),
          const SizedBox(height: 12),
          if (spotlightController.productDetail.comments!.isNotEmpty)
            DropdownButton<String>(
              dropdownColor: Colors.grey[900],
              value: _filter,
              items: ["All", "Support", "Roast"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: TextWidget(
                    text: "Filter by: $value",
                    color: AppColors.white,
                    textSize: 14,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _filter = value!;
                });
              },
            ),
          const SizedBox(height: 8),
          Obx(
            () => spotlightController.isCommentLoad.value
                ? SizedBox(height: 400, child: ShimmerLoader.shimmerTile())
                : Column(
                    children: spotlightController.productDetail.comments!
                        .where((comment) {
                          switch (_filter) {
                            case "Support":
                              return comment.type == CommentType.support;
                            case "Roast":
                              return comment.type == CommentType.roast;
                            default:
                              return true; // "All" or any other fallback
                          }
                        })
                        .map(_buildCommentCard)
                        .toList(),
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: MyCustomTextField.textField(
                    hintText: "What do you think...",
                    fillColor: AppColors.black,
                    controller: _commentController),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  if (_commentController.text.isNotEmpty) {
                    // setState(() {
                    //   spotlightController.productDetail.comments!.insert(
                    //     0,
                    //     ProductComment(
                    //       id: spotlightController.productDetail.id,
                    //       content: _commentController.text,
                    //       type: _selectedType,
                    //     ),
                    //   );
                    // });
                    FocusScope.of(context).unfocus();
                    spotlightController
                        .addComment(
                            comment: _commentController.text,
                            isSupporting: _selectedType == CommentType.support
                                ? true
                                : false)
                        .then((v) {
                      _commentController.clear();
                      spotlightController.isCommentLoad.value = false;
                    });
                  }
                },
                child: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 20,
                    child: Icon(Icons.send, size: 20, color: AppColors.white)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildToggleButton(
                      "Support", CommentType.support, AppColors.primary),
                  const SizedBox(width: 8),
                  _buildToggleButton(
                      "Roast", CommentType.roast, AppColors.primary),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, CommentType type, Color color) {
    bool isSelected = _selectedType == type;
    return ElevatedButton.icon(
      icon: Icon(type == CommentType.support ? Icons.thumb_up : Icons.whatshot,
          color: Colors.white, size: 16),
      label: TextWidget(
        text: text,
        textSize: 12,
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(110, 30),
        backgroundColor: isSelected ? color : Colors.grey[800],
        shape: const StadiumBorder(),
      ),
      onPressed: () => setState(() => _selectedType = type),
    );
  }

  Widget _buildCommentCard(ProductComment comment) {
    final bool isExpanded = _expandedComments.contains(comment.id);
    final replyController = TextEditingController();
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: comment.type == CommentType.support
            ? AppColors.green700.withOpacity(0.5)
            : AppColors.redColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: comment.type == CommentType.support
                ? AppColors.green700
                : AppColors.redColor,
            width: 2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage("${comment.userImage}"),
                    backgroundColor: Colors.white),
                const SizedBox(width: 8),
                TextWidget(
                    text: comment.userName!,
                    textSize: 15,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500),
                const SizedBox(width: 12),
                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                //   decoration: BoxDecoration(
                //     color: comment.type == CommentType.support
                //         ? AppColors.green700
                //         : AppColors.redColor.withOpacity(0.7),
                //     borderRadius: BorderRadius.circular(22),
                //   ),
                //   child: TextWidget(
                //       text: comment.type == CommentType.support
                //           ? "Support"
                //           : "Roast",
                //       color: AppColors.white,
                //       textSize: 12),
                // )
                const Spacer(),
                TextWidget(
                    text: comment.date!, textSize: 12, color: AppColors.grey)
              ],
            ),
            const SizedBox(height: 4),
            TextWidget(
                text: comment.content!,
                maxLine: 3,
                color: AppColors.white,
                textSize: 14),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (comment.isDownvotedByMe == true) {
                        comment.isDownvotedByMe = false;
                        comment.downvotesCount =
                            (comment.downvotesCount ?? 0) - 1;
                      }
                      if (comment.isUpvotedByMe == true) {
                        comment.isUpvotedByMe = false;
                        comment.upvotesCount = (comment.upvotesCount ?? 0) - 1;
                      } else {
                        comment.isUpvotedByMe = true;
                        comment.upvotesCount = (comment.upvotesCount ?? 0) + 1;
                      }
                    });
                    spotlightController.addUpvoteDownvoteComment(
                      commentId: comment.id!,
                      isUpvote: true,
                    );
                  },
                  child: Icon(
                    comment.isUpvotedByMe!
                        ? Icons.thumb_up_alt
                        : Icons.thumb_up_alt_outlined,
                    size: 20,
                    color: comment.isUpvotedByMe!
                        ? AppColors.blue
                        : AppColors.whiteShade,
                  ),
                ),
                const SizedBox(width: 4),
                TextWidget(
                  text: "${comment.upvotesCount}",
                  textSize: 14,
                  color: AppColors.white,
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (comment.isUpvotedByMe == true) {
                        comment.isUpvotedByMe = false;
                        comment.upvotesCount = (comment.upvotesCount ?? 0) - 1;
                      }
                      if (comment.isDownvotedByMe == true) {
                        comment.isDownvotedByMe = false;
                        comment.downvotesCount =
                            (comment.downvotesCount ?? 0) - 1;
                      } else {
                        comment.isDownvotedByMe = true;
                        comment.downvotesCount =
                            (comment.downvotesCount ?? 0) + 1;
                      }
                    });
                    spotlightController.addUpvoteDownvoteComment(
                      commentId: comment.id!,
                      isUpvote: false,
                    );
                  },
                  child: Icon(
                    comment.isDownvotedByMe!
                        ? Icons.thumb_down_alt
                        : Icons.thumb_down_alt_outlined,
                    size: 20,
                    color: comment.isDownvotedByMe!
                        ? AppColors.redColor
                        : AppColors.whiteShade,
                  ),
                ),
                const SizedBox(width: 4),
                TextWidget(
                    text: "${comment.downvotesCount}",
                    textSize: 14,
                    color: AppColors.white),
                const Spacer(),
                TextButton(
                  onPressed: () => setState(() => isExpanded
                      ? _expandedComments.remove(comment.id)
                      : _expandedComments.add(comment.id!)),
                  child: TextWidget(
                      text:
                          "Reply ${comment.replies!.isNotEmpty ? '(${comment.replies!.length})' : ''}",
                      color: AppColors.white,
                      textSize: 14),
                ),
              ],
            ),
            if (isExpanded) ...[
              Row(
                children: [
                  Expanded(
                    child: MyCustomTextField.textField(
                      hintText: "Write a reply...",
                      fillColor: AppColors.black,
                      controller: replyController,
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      if (replyController.text.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                        spotlightController
                            .addReplyInComment(
                                comment: replyController.text, id: comment.id!)
                            .then((v) {
                          replyController.clear();
                          spotlightController.isCommentLoad.value = false;
                        });
                      }
                    },
                    child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        radius: 20,
                        child:
                            Icon(Icons.send, size: 20, color: AppColors.white)),
                  )
                ],
              ),
              ...comment.replies!.map((r) => Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(r.userImage!),
                              backgroundColor: Colors.white),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text: r.userName!,
                                    textSize: 13,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500),
                                TextWidget(
                                    text: r.content!,
                                    textSize: 12,
                                    maxLine: 2,
                                    color: AppColors.white),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (r.isDownvotedByMe == true) {
                                            r.isDownvotedByMe = false;
                                            r.downvotesCount =
                                                (r.downvotesCount ?? 0) - 1;
                                          }
                                          if (r.isUpvotedByMe == true) {
                                            r.isUpvotedByMe = false;
                                            r.upvotesCount =
                                                (r.upvotesCount ?? 0) - 1;
                                          } else {
                                            r.isUpvotedByMe = true;
                                            r.upvotesCount =
                                                (r.upvotesCount ?? 0) + 1;
                                          }
                                        });
                                        spotlightController
                                            .addUpvoteDownvoteCommentReply(
                                                commentId: comment.id!,
                                                replycommentId: r.id!,
                                                isUpvote: true);
                                      },
                                      child: Icon(
                                        r.isUpvotedByMe!
                                            ? Icons.thumb_up_alt
                                            : Icons.thumb_up_alt_outlined,
                                        size: 20,
                                        color: r.isUpvotedByMe!
                                            ? AppColors.blue
                                            : AppColors.whiteShade,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    TextWidget(
                                      text: "${r.upvotesCount}",
                                      textSize: 14,
                                      color: AppColors.white,
                                    ),
                                    const SizedBox(width: 16),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (r.isUpvotedByMe == true) {
                                            r.isUpvotedByMe = false;
                                            r.upvotesCount =
                                                (r.upvotesCount ?? 0) - 1;
                                          }
                                          if (r.isDownvotedByMe == true) {
                                            r.isDownvotedByMe = false;
                                            r.downvotesCount =
                                                (r.downvotesCount ?? 0) - 1;
                                          } else {
                                            r.isDownvotedByMe = true;
                                            r.downvotesCount =
                                                (r.downvotesCount ?? 0) + 1;
                                          }
                                        });

                                        spotlightController
                                            .addUpvoteDownvoteCommentReply(
                                                commentId: comment.id!,
                                                replycommentId: r.id!,
                                                isUpvote: false);
                                      },
                                      child: Icon(
                                        r.isDownvotedByMe!
                                            ? Icons.thumb_down_alt
                                            : Icons.thumb_down_alt_outlined,
                                        size: 20,
                                        color: r.isDownvotedByMe!
                                            ? AppColors.redColor
                                            : AppColors.whiteShade,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    TextWidget(
                                        text: "${r.downvotesCount}",
                                        textSize: 14,
                                        color: AppColors.white),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ]
          ],
        ),
      ),
    );
  }
}
