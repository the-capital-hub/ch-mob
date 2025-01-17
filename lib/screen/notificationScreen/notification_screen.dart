import 'package:capitalhub_crm/controller/notificationController/notification_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../utils/constant/app_var.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificaitonController notificaitonController =
      Get.put(NotificaitonController());
  @override
  void initState() {
    notificaitonController.getNotificationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(title: "Notifications", action: [
            TextButton(
                onPressed: () {
                  notificaitonController.markAllAsRead(context);
                },
                child: const TextWidget(
                  text: "Mark all read",
                  textSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ))
          ]),
          body: Obx(
            () => notificaitonController.isLoading.value
                ? Helper.pageLoading()
                : ListView.separated(
                    itemCount: notificaitonController.notificationList.length,
                    padding: const EdgeInsets.all(10),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: notificaitonController
                                        .notificationList[index].isRead!
                                    ? AppColors.transparent
                                    : AppColors.primary,
                                width: 0.5),
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          onTap: () {
                            notificaitonController
                                .markAsRead(context, index)
                                .then((val) {
                              setState(() {});
                            });
                          },
                          visualDensity: VisualDensity.compact,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          minTileHeight: 60,minLeadingWidth: 20,
                          leading: CircleAvatar(radius: 18,
                            backgroundImage: NetworkImage(
                                "${notificaitonController.notificationList[index].image}"),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: TextWidget(
                                    text:
                                        "${notificaitonController.notificationList[index].title} ",
                                    textSize: 14),
                              ),
                              TextWidget(
                                  text:
                                      "${notificaitonController.notificationList[index].date}",
                                  textSize: 10,
                                  color: AppColors.white54),
                            ],
                          ),
                          subtitle: HtmlWidget(
                            "${notificaitonController.notificationList[index].subTitle}",
                            textStyle:
                                TextStyle(fontSize: 12, color: AppColors.grey),
                          ),
                          //  TextWidget(
                          //   text:
                          //       "${notificaitonController.notificationList[index].subTitle}",
                          //   maxLine: 5,
                          //   textSize: 12,
                          //   color: AppColors.grey,
                          // ),
                          // trailing: TextWidget(
                          //     text:
                          //         "${notificaitonController.notificationList[index].date}",
                          //     textSize: 10,
                          //     color: AppColors.white54),
                        ),
                      );
                    },
                  ),
          )),
    );
  }
}
