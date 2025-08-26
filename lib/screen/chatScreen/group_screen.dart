import 'package:capitalhub_crm/controller/chatController/chat_controller.dart';
import 'package:capitalhub_crm/screen/chatScreen/chat_screen.dart';
import 'package:capitalhub_crm/screen/chatScreen/create_group_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'group_chat_screen.dart';

class GroupListScreen extends StatefulWidget {
  const GroupListScreen({super.key});

  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  TextEditingController searchController = TextEditingController();
  ChatController chatController = Get.put(ChatController());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      chatController.getGroupChatMemberList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(title: "Community", hideBack: true),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MyCustomTextField.textField(
                //     prefixIcon: Icon(
                //       Icons.search,
                //       color: AppColors.white54,
                //     ),
                //     hintText: "Search",
                //     controller: searchController),
                // sizedTextfield,
                InkWell(
                  onTap: () {
                    Get.to(const CreateCommunityScreen())!.then((val) {
                      chatController.getGroupChatMemberList();
                    });
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.whiteCard,
                        child: const Icon(
                          Icons.groups_2,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const TextWidget(
                          text: "Create new community", textSize: 15)
                    ],
                  ),
                ),
                sizedTextfield,
                Obx(
                  () => chatController.isLoading.value
                      ? Expanded(child: Helper.pageLoading())
                      : Expanded(
                          child: ListView.separated(
                            itemCount: chatController.groupChatList.length,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 10);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(GroupChatScreen(
                                      member:
                                          chatController.groupChatList[index]));
                                },
                                child: Card(
                                  color: AppColors.blackCard,
                                  surfaceTintColor: AppColors.blackCard,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              chatController
                                                  .groupChatList[index]
                                                  .communityImage!),
                                          radius: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                text:
                                                    "${chatController.groupChatList[index].communityName}",
                                                textSize: 14,
                                                maxLine: 2,
                                              ),
                                              // if (chatController
                                              //     .groupChatList[index]
                                              //     .memberProfileImages!
                                              //     .isNotEmpty) ...[
                                              //   sizedTextfield,
                                              //   SizedBox(
                                              //       height: 40,
                                              //       width: Get.width,
                                              //       child: ListView.separated(
                                              //           itemCount: chatController
                                              //               .groupChatList[
                                              //                   index]
                                              //               .memberProfileImages!
                                              //               .length,
                                              //           scrollDirection:
                                              //               Axis.horizontal,
                                              //           separatorBuilder:
                                              //               (context, index) {
                                              //             return const SizedBox(
                                              //                 width: 12);
                                              //           },
                                              //           itemBuilder:
                                              //               (BuildContext
                                              //                       context,
                                              //                   int ind) {
                                              //             return CircleAvatar(
                                              //               radius: 20,
                                              //               backgroundImage:
                                              //                   NetworkImage(
                                              //                       '${chatController.groupChatList[index].memberProfileImages![ind]}'),
                                              //             );
                                              //           }))
                                              // ],
                                              // sizedTextfield,
                                              // TextWidget(
                                              //     text: chatController
                                              //         .groupChatList[index]
                                              //         .memberNames
                                              //         .toString()
                                              //         .replaceAll('[', '')
                                              //         .replaceAll(']', ''),
                                              //     textSize: 12),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12),

                                        Card(
                                          color: AppColors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                    CupertinoIcons.person,
                                                    size: 14),
                                                const SizedBox(width: 3),
                                                TextWidget(
                                                    text:
                                                        "${chatController.groupChatList[index].memberCount}",
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    textSize: 12),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                )
              ],
            ),
          ),
        ));
  }
}
