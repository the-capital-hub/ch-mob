import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';

import '../../../widget/textwidget/text_widget.dart';

enum CommentType { support, roast }

class Comment {
  final String id;
  final String userName;
  final String content;
  final CommentType type;
  final List<Reply> replies;
  int likes;

  Comment({
    required this.id,
    required this.userName,
    required this.content,
    required this.type,
    this.replies = const [],
    this.likes = 0,
  });
}

class Reply {
  final String id;
  final String userName;
  final String content;

  Reply({
    required this.id,
    required this.userName,
    required this.content,
  });
}

class CommentSectionPage extends StatefulWidget {
  @override
  State<CommentSectionPage> createState() => _CommentSectionPageState();
}

class _CommentSectionPageState extends State<CommentSectionPage> {
  final TextEditingController _commentController = TextEditingController();
  final List<Comment> _comments = [];
  final Set<String> _expandedComments = {};
  CommentType _selectedType = CommentType.support;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
                text: "Comments", textSize: 16, fontWeight: FontWeight.w500),
            const SizedBox(height: 8),
            _buildCommentInput(),
            const SizedBox(height: 12),
            DropdownButton<String>(
              dropdownColor: Colors.grey[900],
              value: "All",
              items: ["All", "Support", "Roast"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: TextWidget(
                      text: "Filter by: $value",
                      color: AppColors.white,
                      textSize: 14),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            const SizedBox(height: 8),
            ..._comments.map(_buildCommentCard).toList(),
          ],
        ),
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
                    setState(() {
                      _comments.insert(
                        0,
                        Comment(
                          id: DateTime.now().toString(),
                          userName: "You",
                          content: _commentController.text,
                          type: _selectedType,
                          replies: [],
                        ),
                      );
                      _commentController.clear();
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

  Widget _buildCommentCard(Comment comment) {
    final bool isExpanded = _expandedComments.contains(comment.id);
    final replyController = TextEditingController();
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 16, backgroundColor: Colors.white),
                const SizedBox(width: 8),
                TextWidget(
                    text: comment.userName,
                    textSize: 15,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: comment.type == CommentType.support
                        ? AppColors.green700
                        : AppColors.redColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: TextWidget(
                      text: comment.type == CommentType.support
                          ? "Support"
                          : "Roast",
                      color: AppColors.white,
                      textSize: 12),
                )
              ],
            ),
            const SizedBox(height: 8),
            TextWidget(
                text: comment.content, color: AppColors.white, textSize: 14),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() => comment.likes++);
                  },
                  child: Icon(Icons.thumb_up_alt_outlined,
                      size: 20, color: AppColors.whiteShade),
                ),
                const SizedBox(width: 8),
                TextWidget(
                    text: "Like ${comment.likes}",
                    textSize: 14,
                    color: AppColors.white),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => setState(() => isExpanded
                      ? _expandedComments.remove(comment.id)
                      : _expandedComments.add(comment.id)),
                  child: TextWidget(
                      text:
                          "Reply ${comment.replies.length > 0 ? '(${comment.replies.length})' : ''}",
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
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      if (replyController.text.isNotEmpty) {
                        setState(() {
                          comment.replies.add(Reply(
                            id: DateTime.now().toString(),
                            userName: "You",
                            content: replyController.text,
                          ));
                          replyController.clear();
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
              ...comment.replies.map((r) => Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const CircleAvatar(
                              radius: 12, backgroundColor: Colors.white),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  text: r.userName,
                                  textSize: 13,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500),
                              TextWidget(
                                  text: r.content,
                                  textSize: 12,
                                  color: AppColors.white),
                            ],
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
