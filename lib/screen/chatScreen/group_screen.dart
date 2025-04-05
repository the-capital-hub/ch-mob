import 'package:capitalhub_crm/controller/chatController/chat_controller.dart';
import 'package:capitalhub_crm/screen/chatScreen/chat_screen.dart';
import 'package:capitalhub_crm/screen/chatScreen/create_community_screen.dart';
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
                              return sizedTextfield;
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                            text:
                                                "${chatController.groupChatList[index].communityName}",
                                            textSize: 14),
                                        sizedTextfield,
                                        SizedBox(
                                          height: 40,
                                          width: Get.width,
                                          child: ListView.separated(
                                            itemCount: chatController
                                                .groupChatList[index]
                                                .memberProfileImages!
                                                .length,
                                            scrollDirection: Axis.horizontal,
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(width: 12);
                                            },
                                            itemBuilder: (BuildContext context,
                                                int ind) {
                                              // if (index == 5) {
                                              //   return Stack(
                                              //     children: [
                                              //       const CircleAvatar(
                                              //         radius: 18,
                                              //         backgroundImage: NetworkImage(
                                              //             'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'),
                                              //       ),
                                              //       CircleAvatar(
                                              //         radius: 18,
                                              //         backgroundColor: AppColors.black54,
                                              //         child: const TextWidget(
                                              //             text: "+10", textSize: 12),
                                              //       )
                                              //     ],
                                              //   );
                                              // }
                                              return CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                    '${chatController.groupChatList[index].memberProfileImages![ind]}'),
                                              );
                                            },
                                          ),
                                        ),
                                        sizedTextfield,
                                        TextWidget(
                                            text: chatController
                                                .groupChatList[index]
                                                .memberNames
                                                .toString()
                                                .replaceAll('[', '')
                                                .replaceAll(']', ''),
                                            textSize: 12),
                                        sizedTextfield,
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
