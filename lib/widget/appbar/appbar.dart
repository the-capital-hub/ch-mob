import 'package:capitalhub_crm/controller/notificationController/notification_controller.dart';
import 'package:capitalhub_crm/screen/chatScreen/chat_member_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screen/notificationScreen/notification_screen.dart';
import '../../utils/appcolors/app_colors.dart';
import '../textwidget/text_widget.dart';

class HelperAppBar {
  static NotificaitonController notificaitonController = Get.find();

  static appbarHelper({
    required String title,
    List<Widget>? action,
    Color? bgColor,
    bool? hideBack,
    bool autoAction = false,
  }) {
    return PreferredSize(
        preferredSize: const Size(0, 56),
        child: AppBar(
          backgroundColor: bgColor ?? AppColors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.white),
          title: TextWidget(
              text: title,
              fontWeight: FontWeight.w500,
              maxLine: 2,
              textSize: 17),
          centerTitle: true,
          // automaticallyImplyLeading: hideBack == true ? false : true,
          actions: autoAction
              ? [
                  InkWell(
                      onTap: () {
                        Get.to(const NotificationScreen())!.whenComplete(() {
                          notificaitonController.getNotificationCount();
                        });
                      },
                      child: Obx(() => Stack(
                            children: [
                              const Icon(Icons.notifications_none_sharp),
                              if (notificaitonController
                                      .notificationCount.value !=
                                  "0")
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: AppColors.redColor,
                                  child: TextWidget(
                                      text: notificaitonController
                                          .notificationCount.value,
                                      textSize: 8),
                                )
                            ],
                          ))),
                  const SizedBox(width: 10),
                ]
              : action,
          leading: hideBack == true
              ? null
              : IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    size: 20,
                    color: AppColors.white,
                  ),
                ),
        ));
  }
}
