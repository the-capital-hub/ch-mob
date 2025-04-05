import 'package:capitalhub_crm/controller/oneLinkController/one_link_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/helper/helper.dart';

class OneLinkRequestScreen extends StatefulWidget {
  const OneLinkRequestScreen({super.key});

  @override
  State<OneLinkRequestScreen> createState() => _OneLinkRequestScreenState();
}

class _OneLinkRequestScreenState extends State<OneLinkRequestScreen> {
  OneLinkController oneLinkController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "One Link Requests",
        ),
        body: Obx(
          () => oneLinkController.isLoading.value
              ? Helper.pageLoading()
              : ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: oneLinkController.oneLinkReqData.requests!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      thickness: 0.5,
                      color: AppColors.white12,
                      height: 0,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        contentPadding: const EdgeInsets.all(2),
                        leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(oneLinkController
                                .oneLinkReqData
                                .requests![index]
                                .user!
                                .profilePicture!)),
                        title: TextWidget(
                            text: oneLinkController.oneLinkReqData
                                    .requests![index].user!.firstName! +
                                oneLinkController.oneLinkReqData
                                    .requests![index].user!.lastName!,
                            textSize: 14),
                        subtitle: TextWidget(
                            text: oneLinkController.oneLinkReqData
                                .requests![index].user!.designation!,
                            textSize: 14,
                            color: AppColors.whiteCard),
                        trailing: oneLinkController
                                    .oneLinkReqData.requests![index].status ==
                                "pending"
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Helper.loader(context);
                                      oneLinkController.acceptOnelink(
                                          oneLinkController.oneLinkReqData
                                              .requests![index].startUpId!,
                                          oneLinkController.oneLinkReqData
                                              .requests![index].requestId!,
                                          true);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.darkGreen,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      child: const TextWidget(
                                          text: "Accept", textSize: 12),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  InkWell(
                                    onTap: () {
                                      Helper.loader(context);

                                      oneLinkController.acceptOnelink(
                                          oneLinkController.oneLinkReqData
                                              .requests![index].startUpId!,
                                          oneLinkController.oneLinkReqData
                                              .requests![index].requestId!,
                                          false);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.redColor,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      child: const TextWidget(
                                          text: "Reject", textSize: 12),
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    oneLinkController.oneLinkReqData
                                                .requests![index].status ==
                                            "approved"
                                        ? Icons.check_circle_outline_outlined
                                        : Icons.close,
                                    size: 18,
                                    color:oneLinkController.oneLinkReqData
                                                .requests![index].status ==
                                            "approved"? AppColors.green700:AppColors.redColor,
                                  ),
                                  const SizedBox(width: 4),
                                  TextWidget(
                                    text:
                                        "${oneLinkController.oneLinkReqData.requests![index].status!.capitalizeFirst}",
                                    textSize: 14,
                                    color: oneLinkController.oneLinkReqData
                                                .requests![index].status ==
                                            "approved"
                                        ? AppColors.darkGreen
                                        : AppColors.redColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ));
                  },
                ),
        ),
      ),
    );
  }
}
