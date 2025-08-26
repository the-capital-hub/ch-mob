import 'dart:async';

import 'package:capitalhub_crm/controller/chatController/chat_controller.dart';
import 'package:capitalhub_crm/controller/homeController/home_controller.dart';
import 'package:capitalhub_crm/controller/oneLinkController/one_link_controller.dart';
import 'package:capitalhub_crm/screen/chatScreen/chat_screen.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'group_screen.dart';

class ChatMemberScreen extends StatefulWidget {
  const ChatMemberScreen({super.key});

  @override
  State<ChatMemberScreen> createState() => _ChatMemberScreenState();
}

class _ChatMemberScreenState extends State<ChatMemberScreen> {
  ChatController chatController = Get.put(ChatController());
  OneLinkController oneLinkController = Get.put(OneLinkController());
  @override
  void initState() {
    oneLinkController.getOneLinkDetails();
    chatController.getChatMemberList();
    searchController.addListener(_onSearchChanged);
    super.initState();
  }

  Timer? _debounce;
  @override
  void dispose() {
    _debounce?.cancel();
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = searchController.text.trim();
      if (query.isNotEmpty) {
        chatController.searchMember(query);
        setState(() {});
      } else {
        setState(() {
          chatController.searchMemberList.value = [];
        });
      }
    });
  }

  // final List<Member> members = [
  //   Member(id: '1', name: 'Alice'),
  //   Member(id: '2', name: 'Bob'),
  //   Member(id: '3', name: 'Charlie'),
  //   Member(id: '3', name: 'Charlie'),
  //   Member(id: '3', name: 'Charlie'),
  //   Member(id: '3', name: 'Charlie'),
  //   Member(id: '3', name: 'Charlie'),
  //   Member(id: '3', name: 'Charlie'),
  //   Member(id: '3', name: 'Charlie'),
  //   Member(id: '3', name: 'Charlie'),
  // ];
  TextEditingController searchController = TextEditingController();
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.transparent,
            appBar: HelperAppBar.appbarHelper(
              title: "Chat",
            ),
            body: Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: chatController.isLoading.value
                    ? Helper.pageLoading()
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: MyCustomTextField.textField(
                                hintText: "Search",
                                borderRadius: 8,
                                prefixIcon: const Icon(Icons.search),
                                controller: searchController),
                          ),
                          if (searchController.text.isNotEmpty)
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 200,
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 6, left: 4, right: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.blackCard,
                                  border: Border.all(color: AppColors.white12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: chatController.searchMemberList.isEmpty
                                    ? SizedBox(
                                        width: Get.width,
                                        height: 50,
                                        child: Center(
                                          child: chatController
                                                  .isSearchLoading.value
                                              ? Helper.pageLoading(
                                                  color: AppColors.blackCard)
                                              : TextWidget(
                                                  color: AppColors.white54,
                                                  text: "No Member Found",
                                                  textSize: 14),
                                        ),
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        itemCount: chatController
                                            .searchMemberList.length,
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            height: 0,
                                            color: AppColors.white12,
                                          );
                                        },
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            visualDensity:
                                                VisualDensity.compact,
                                            title: TextWidget(
                                                text: chatController
                                                    .searchMemberList[index]
                                                    .name,
                                                textSize: 14),
                                            subtitle: TextWidget(
                                                text: chatController
                                                    .searchMemberList[index]
                                                    .designation,
                                                textSize: 10),
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  chatController
                                                      .searchMemberList[index]
                                                      .profile),
                                            ),
                                            onTap: () {
                                              chatController.createChat(
                                                  context,
                                                  chatController
                                                      .searchMemberList[index]
                                                      .userId);
                                            },
                                          );
                                        },
                                      ),
                              ),
                            ),
                          const SizedBox(height: 6),
                          InkWell(
                            onTap: () {
                              Get.to(() => const GroupListScreen());
                            },
                            child: Card(
                              color: AppColors.blackCard,
                              surfaceTintColor: AppColors.blackCard,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                        text: "Groups",
                                        color: AppColors.whiteCard,
                                        textSize: 15),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.white54,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          if (chatController.pinnedChatsList.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(
                                    text: "  Pinned Message",
                                    textSize: 14,
                                    fontWeight: FontWeight.w500),
                                const SizedBox(height: 3),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxHeight: 250,
                                  ),
                                  child: ListView.separated(
                                    itemCount:
                                        chatController.pinnedChatsList.length,
                                    padding: const EdgeInsets.all(8),
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                              position: index,
                                              delay: const Duration(
                                                  milliseconds: 100),
                                              duration: const Duration(
                                                  milliseconds: 375),
                                              child: FadeInAnimation(
                                                  delay: const Duration(
                                                      milliseconds: 200),
                                                  child: Divider(
                                                      thickness: 0.5,
                                                      color: AppColors.white38,
                                                      height: 6)));
                                    },
                                    itemBuilder: (context, index) {
                                      final member =
                                          chatController.pinnedChatsList[index];
                                      return AnimationConfiguration
                                          .staggeredList(
                                              position: index,
                                              delay: const Duration(
                                                  milliseconds: 100),
                                              duration: const Duration(
                                                  milliseconds: 375),
                                              child: SlideAnimation(
                                                  // horizontalOffset: 1000,
                                                  verticalOffset: 50.0,
                                                  child: ListTile(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    minVerticalPadding: 14,
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 8,
                                                            vertical: 0),
                                                    leading: CircleAvatar(
                                                      radius: 21,
                                                      backgroundImage:
                                                          NetworkImage(member
                                                              .senderImage),
                                                    ),
                                                    title: TextWidget(
                                                      text: member.senderName,
                                                      textSize: 15,
                                                    ),
                                                    subtitle: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3),
                                                      child: TextWidget(
                                                          text:
                                                              member.senderName,
                                                          color:
                                                              AppColors.white54,
                                                          textSize: 12),
                                                    ),
                                                    onTap: () {
                                                      Get.to(
                                                        () => ChatScreen(
                                                            member: member),
                                                      )!
                                                          .whenComplete(() {
                                                        chatController
                                                            .getChatMemberList();
                                                      });
                                                    },
                                                    trailing: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        TextWidget(
                                                            text: member
                                                                .lastMessageTime,
                                                            textSize: 12,
                                                            color: AppColors
                                                                .white54),
                                                        const SizedBox(
                                                            height: 8),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            if (member
                                                                    .unreadCount >
                                                                0)
                                                              CircleAvatar(
                                                                radius: 8,
                                                                backgroundColor:
                                                                    AppColors
                                                                        .primary,
                                                                child: TextWidget(
                                                                    text: member
                                                                        .unreadCount
                                                                        .toString(),
                                                                    textSize:
                                                                        10),
                                                              ),
                                                            InkWell(
                                                              splashColor:
                                                                  AppColors
                                                                      .transparent,
                                                              onTap: () {
                                                                chatController
                                                                    .pinUserChat(
                                                                        member
                                                                            .chatId);
                                                              },
                                                              child:
                                                                  const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            4.0,
                                                                        left:
                                                                            8),
                                                                child: Icon(
                                                                    CupertinoIcons
                                                                        .pin_fill,
                                                                    color: AppColors
                                                                        .redColor,
                                                                    size: 16),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          sizedTextfield,
                          chatController.normalChatsList.isEmpty
                              ? const SizedBox()
                              : Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TextWidget(
                                          text: "  All Message",
                                          textSize: 14,
                                          fontWeight: FontWeight.w500),
                                      const SizedBox(height: 3),
                                      Expanded(
                                        child: ListView.separated(
                                          itemCount: chatController
                                              .normalChatsList.length,
                                          padding: const EdgeInsets.all(8),
                                          separatorBuilder: (context, index) {
                                            return AnimationConfiguration
                                                .staggeredList(
                                                    position: index,
                                                    delay: const Duration(
                                                        milliseconds: 100),
                                                    duration: const Duration(
                                                        milliseconds: 375),
                                                    child: FadeInAnimation(
                                                        delay: const Duration(
                                                            milliseconds: 200),
                                                        child: Divider(
                                                            thickness: 0.5,
                                                            color: AppColors
                                                                .white38,
                                                            height: 6)));
                                          },
                                          itemBuilder: (context, index) {
                                            final member = chatController
                                                .normalChatsList[index];
                                            return AnimationConfiguration
                                                .staggeredList(
                                                    position: index,
                                                    delay: const Duration(
                                                        milliseconds: 100),
                                                    duration: const Duration(
                                                        milliseconds: 375),
                                                    child: SlideAnimation(
                                                        // horizontalOffset: 1000,
                                                        verticalOffset: 50.0,
                                                        child: ListTile(
                                                          visualDensity:
                                                              VisualDensity
                                                                  .compact,
                                                          minVerticalPadding:
                                                              14,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 0),
                                                          leading: CircleAvatar(
                                                            radius: 21,
                                                            backgroundImage:
                                                                NetworkImage(member
                                                                    .senderImage),
                                                          ),
                                                          title: TextWidget(
                                                            text: member
                                                                .senderName,
                                                            textSize: 15,
                                                          ),
                                                          subtitle: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 3),
                                                            child: TextWidget(
                                                                text: member
                                                                    .lastMessage,
                                                                color: AppColors
                                                                    .white54,
                                                                textSize: 12),
                                                          ),
                                                          onTap: () {
                                                            Get.to(
                                                              () => ChatScreen(
                                                                  member:
                                                                      member),
                                                            )!
                                                                .whenComplete(
                                                                    () {
                                                              chatController
                                                                  .getChatMemberList();
                                                            });
                                                          },
                                                          trailing: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              TextWidget(
                                                                  text: member
                                                                      .lastMessageTime,
                                                                  textSize: 12,
                                                                  color: AppColors
                                                                      .white54),
                                                              const SizedBox(
                                                                  height: 8),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  if (member
                                                                          .unreadCount >
                                                                      0)
                                                                    CircleAvatar(
                                                                      radius: 8,
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .primary,
                                                                      child: TextWidget(
                                                                          text: member
                                                                              .unreadCount
                                                                              .toString(),
                                                                          textSize:
                                                                              10),
                                                                    ),
                                                                  InkWell(
                                                                    splashColor:
                                                                        AppColors
                                                                            .transparent,
                                                                    onTap: () {
                                                                      chatController
                                                                          .pinUserChat(
                                                                              member.chatId);
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              4.0,
                                                                          left:
                                                                              8),
                                                                      child: Icon(
                                                                          CupertinoIcons
                                                                              .pin,
                                                                          color: AppColors
                                                                              .white54,
                                                                          size:
                                                                              16),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
              ),
            )));
  }
}
