// lib/screens/chat_page.dart
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:capitalhub_crm/controller/chatController/chat_controller.dart';
import 'package:capitalhub_crm/screen/chatScreen/doc_preview.dart';
import 'package:capitalhub_crm/screen/homeScreen/widget/fullscreen_image_view.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:video_player/video_player.dart';
import '../../model/01-StartupModel/chatModel/chat_memberlist_model.dart';
import '../../model/01-StartupModel/chatModel/group_memberlist_model.dart';
import '../../model/01-StartupModel/chatModel/member_chats.dart';
import 'video_preview.dart';

class GroupChatScreen extends StatefulWidget {
  final Groups member;

  GroupChatScreen({required this.member});

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  ChatController chatController = Get.find();
  final TextEditingController _controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedAttachment;
  MessageType? _selectedAttachmentType;
  VideoPlayerController? _videoPlayerController;
  void _sendMessage() async {
    if (_controller.text.isNotEmpty || _selectedAttachment != null) {
      String base64String = "";
      if (_selectedAttachment != null) {
        base64String = await convertToBase64(_selectedAttachment!);
      }
      //  api call to send message
      chatController
          .addMessage(
              chatmessage: ChatMessage(
        chatId: widget.member.communityId,
        senderId: 'asset',
        text: _controller.text,
        attachmentUrl: base64String,
        attachmentType: _selectedAttachmentType ?? MessageType.text,
        timestamp: Helper.formatDateTime(DateTime.now()),
      ))
          .then((v) {
        setState(() {
          _controller.clear();
          _selectedAttachment = null;
          _selectedAttachmentType = null;
        });
      });
      // chatController.messages.add(ChatMessage(
      //   senderId: 'asset',
      //   text: _controller.text,
      //   messageId: DateTime.now().toString(),
      //   attachmentUrl: _selectedAttachment?.path,
      //   attachmentType: _selectedAttachmentType ?? MessageType.text,
      //   timestamp: Helper.formatDateTime(DateTime.now()),
      // ));
      _scrollToEnd();
    }
  }

  Future<String> convertToBase64(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final base64String = base64Encode(bytes);
      return base64String;
    } catch (e) {
      throw Exception("Error converting file to Base64: $e");
    }
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      chatController.getChats(widget.member.communityId).then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToEnd();
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  String? selectedMessageId;
  void toggleOverlay(String messageId) {
    setState(() {
      selectedMessageId = selectedMessageId == messageId ? null : messageId;
    });
  }

  void hideOverlay() {
    setState(() {
      selectedMessageId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: AppBar(
              backgroundColor: AppColors.black,
              elevation: 3,
              shadowColor: AppColors.white,
              leading: Row(
                children: [
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios,
                        size: 20, color: AppColors.whiteCard),
                  ),
                  const SizedBox(width: 4),
                  CircleAvatar(
                    radius: 21,
                    backgroundImage:
                        NetworkImage(widget.member.communityImage!),
                  ),
                ],
              ),
              titleSpacing: 0,
              leadingWidth: 90,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(text: widget.member.communityName!, textSize: 16),
                  TextWidget(
                      text: widget.member.description!,
                      color: AppColors.white54,
                      textSize: 12),
                ],
              ),
              actions: [
                PopupMenuButton<String>(
                    iconColor: AppColors.white,
                    color: AppColors.blackCard,
                    onSelected: (value) {
                      if (value == 'clear_chat') {
                        chatController
                            .clearChat(context, widget.member.communityId)
                            .then((v) {
                          setState(() {});
                        });
                      }
                    },
                    itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'clear_chat',
                            child: TextWidget(text: "Clear Chat", textSize: 14),
                          ),
                        ])
              ]),
          body: Obx(() => chatController.isLoading.value
              ? Helper.pageLoading()
              : Column(
                  children: [
                    sizedTextfield,
                    Expanded(
                      child: InkWell(
                        onTap: hideOverlay,
                        splashColor: AppColors.transparent,
                        highlightColor: AppColors.transparent,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          controller: scrollController,
                          itemCount: chatController.messages.length,
                          itemBuilder: (context, index) {
                            final message = chatController.messages[index];
                            bool isSelected = false;
                            if (message.messageId != null) {
                              isSelected =
                                  selectedMessageId == message.messageId;
                            }
                            return Align(
                              alignment: message.senderId == 'me' ||
                                      message.senderId == 'asset'
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: InkWell(
                                splashColor: AppColors.transparent,
                                highlightColor: AppColors.transparent,
                                onLongPress: () {
                                  if (message.senderId == 'me' ||
                                      message.senderId == 'asset') {
                                    toggleOverlay(message.messageId!);
                                  }
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                          minWidth: 40,
                                          maxWidth: Get.width * 0.70),
                                      margin: const EdgeInsets.only(
                                        bottom: 8,
                                        // right: message.senderId == 'me'?0:100,
                                        // left: message.senderId == 'me'?100:0,
                                      ),
                                      decoration: BoxDecoration(
                                          color: AppColors.blackCard,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft:
                                                  const Radius.circular(10),
                                              bottomRight:
                                                  const Radius.circular(10),
                                              topLeft: message.senderId ==
                                                          'me' ||
                                                      message.senderId ==
                                                          'asset'
                                                  ? const Radius.circular(10)
                                                  : const Radius.circular(0),
                                              topRight: message.senderId ==
                                                          'me' ||
                                                      message.senderId ==
                                                          'asset'
                                                  ? const Radius.circular(0)
                                                  : const Radius.circular(10))),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          _buildMessage(message),
                                          const SizedBox(height: 3),
                                          TextWidget(
                                            text: message.timestamp,
                                            align: TextAlign.right,
                                            textSize: 8,
                                            color: AppColors.white54,
                                          )
                                        ],
                                      ),
                                    ),
                                    if (isSelected)
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: InkWell(
                                              onTap: () {
                                                if (message.senderId ==
                                                    "asset") {
                                                  chatController.messages
                                                      .removeWhere((item) =>
                                                          item.messageId ==
                                                          message.messageId);
                                                  setState(() {});
                                                } else {
                                                  chatController
                                                      .deleteMessage(
                                                          message.messageId)
                                                      .then((v) {
                                                    setState(() {});
                                                  });
                                                }
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    AppColors.redColor,
                                                radius: 20,
                                                child: Icon(
                                                  Icons.delete,
                                                  color: AppColors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (_selectedAttachment != null) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            _selectedAttachmentType == MessageType.image
                                ? Image.file(_selectedAttachment!,
                                    width: 100, height: 100)
                                : _selectedAttachmentType == MessageType.video
                                    ? _videoPlayerController != null &&
                                            _videoPlayerController!
                                                .value.isInitialized
                                        ? Container(
                                            width: 100,
                                            height: 100,
                                            child: VideoPlayer(
                                                _videoPlayerController!))
                                        : Container(
                                            width: 100,
                                            height: 100,
                                            color: Colors.black,
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                    : _selectedAttachmentType ==
                                            MessageType.document
                                        ? SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: SfPdfViewer.file(
                                              File(
                                                _selectedAttachment!.path,
                                              ),
                                            ))
                                        : Container(),
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _selectedAttachment = null;
                                  _selectedAttachmentType = null;
                                  _videoPlayerController?.dispose();
                                  _videoPlayerController = null;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyCustomTextField.textField(
                          hintText: "Type here...",
                          controller: _controller,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _showAttachmentOptions();
                                    },
                                    icon: Icon(
                                      Icons.attachment_outlined,
                                      color: AppColors.white54,
                                    )),
                                const SizedBox(width: 2),
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: AppColors.primary,
                                  child: Transform.rotate(
                                    angle: 5.6,
                                    child: (chatController
                                                .isMessageSending.value &&
                                            (_selectedAttachmentType ==
                                                    MessageType.image ||
                                                _selectedAttachmentType ==
                                                    MessageType.video ||
                                                _selectedAttachmentType ==
                                                    MessageType.document))
                                        ? CircularProgressIndicator(
                                            backgroundColor: AppColors.primary,
                                            color: AppColors.white,
                                            strokeWidth: 2,
                                            strokeCap: StrokeCap.round,
                                            strokeAlign: 1,
                                          )
                                        : IconButton(
                                            icon: Icon(
                                              Icons.send_outlined,
                                              color: AppColors.whiteCard,
                                              size: 18,
                                            ),
                                            onPressed: _sendMessage,
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          )),
                    ),
                  ],
                )),
        ));
  }

  Widget _buildMessage(ChatMessage message) {
    switch (message.attachmentType) {
      case MessageType.text:
        return TextWidget(text: message.text, textSize: 14);
      case MessageType.image:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.to(FullscreenImageView(
                    imageURl: message.attachmentUrl!,
                    fileImage: message.senderId == "asset" ? true : false,
                    name: ""));
              },
              child: message.senderId == "asset"
                  ? Image.file(
                      File(message.attachmentUrl!),
                      height: 150,
                    )
                  : Image.network(
                      message.attachmentUrl!,
                      height: 150,
                    ),
            ),
            if (message.text.isNotEmpty) const SizedBox(height: 8),
            if (message.text.isNotEmpty)
              TextWidget(text: message.text, textSize: 14),
          ],
        );
      case MessageType.video:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 14,
                  child: VideoPlayerPreview(videoUrl: message.attachmentUrl!),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.play_circle_filled,
                          size: 50, color: Colors.white),
                      onPressed: () {
                        Get.to(() => FullscreenVideoPlayer(
                            videoUrl: message.attachmentUrl!,
                            isNetworkUrl: message.senderId == "asset"
                                ? false
                                : message.senderId == "me"
                                    ? true
                                    : true));
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (message.text.isNotEmpty) const SizedBox(height: 8),
            if (message.text.isNotEmpty)
              TextWidget(
                text: message.text,
                textSize: 14,
              ),
          ],
        );
      case MessageType.document:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview PDF if needed
            message.senderId == "asset"
                ? SizedBox(
                    height: 100,
                    child: SfPdfViewer.file(
                      File(message.attachmentUrl!),
                      onTap: (details) {
                        Get.to(() => DocPreviewScreen(
                            url: message.attachmentUrl!, isNetworkUrl: false));
                      },
                    ),
                  )
                : InkWell(
                    onTap: () {
                      Get.to(() => DocPreviewScreen(
                          url: message.attachmentUrl!, isNetworkUrl: true));
                    },
                    child: SizedBox(
                      height: 100,
                      child: SfPdfViewer.network(
                        message.attachmentUrl!,
                      ),
                    ),
                  ),
            if (message.text.isNotEmpty)
              TextWidget(text: message.text, textSize: 14),
          ],
        );
      default:
        return Container();
    }
  }

  void _initializeVideoPlayer(File file) {
    // Dispose of the previous controller if one exists
    _videoPlayerController?.dispose();
    _videoPlayerController = VideoPlayerController.file(file)
      ..initialize().then((_) {
        // Ensure the first frame is shown after initialization
        setState(() {});
        _videoPlayerController?.setLooping(true); // Optional: Loop the video
      }).catchError((error) {
        // Handle errors during initialization
        setState(() {
          _selectedAttachment = null;
          _selectedAttachmentType = null;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading video: $error')),
          );
        });
      });
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      backgroundColor: AppColors.blackCard,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: AppColors.whiteCard,
                ),
                title: const TextWidget(
                  text: 'Camera',
                  textSize: 15,
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _selectedAttachment = File(pickedFile.path);
                      _selectedAttachmentType = MessageType.image;
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo,
                  color: AppColors.whiteCard,
                ),
                title: const TextWidget(
                  text: 'Gallery',
                  textSize: 15,
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final result =
                      await FilePicker.platform.pickFiles(type: FileType.media);
                  if (result != null && result.files.single.path != null) {
                    setState(() {
                      _selectedAttachment = File(result.files.single.path!);
                      final extension =
                          result.files.single.extension?.toLowerCase();
                      if (['mp4', 'mov', 'avi'].contains(extension)) {
                        _selectedAttachmentType = MessageType.video;
                        _initializeVideoPlayer(_selectedAttachment!);
                      } else {
                        _selectedAttachmentType = MessageType.image;
                      }
                    });
                  }

                  // Navigator.pop(context);
                  // final result = await FilePicker.platform.pickFiles(
                  //   type: FileType.media,
                  // );
                  // if (result != null && result.files.single.path != null) {
                  //   setState(() {
                  //     _selectedAttachment = File(result.files.single.path!);
                  //     final extension = result.files.single.extension;
                  //     if (extension == 'mp4' ||
                  //         extension == 'mov' ||
                  //         extension == 'avi') {
                  //       _selectedAttachmentType = MessageType.video;
                  //       _initializeVideoPlayer(_selectedAttachment!);
                  //     } else {
                  //       _selectedAttachmentType = MessageType.image;
                  //     }
                  // });
                  // }
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.insert_drive_file,
                  color: AppColors.whiteCard,
                ),
                title: const TextWidget(
                  text: 'Document',
                  textSize: 15,
                ),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf'],
                  );
                  if (result != null && result.files.single.path != null) {
                    if (result.files.single.path!.endsWith('pdf')) {
                      setState(() {
                        _selectedAttachment = File(result.files.single.path!);
                        _selectedAttachmentType = MessageType.document;
                      });
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
