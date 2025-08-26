import 'package:capitalhub_crm/controller/companyController/company_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAffilationRequestScreen extends StatefulWidget {
  const ViewAffilationRequestScreen({super.key});

  @override
  State<ViewAffilationRequestScreen> createState() =>
      _ViewAffilationRequestScreenState();
}

class _ViewAffilationRequestScreenState
    extends State<ViewAffilationRequestScreen> {
  CompanyController companyController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Affiliation Requests"),
        body: Obx(
          () => companyController.isLoading.value
              ? Helper.pageLoading()
              : ListView.separated(
                  itemCount:
                      companyController.affilationReqData.requests!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 8);
                  },
                  // padding: const EdgeInsets.all(12),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.blackCard),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    "${companyController.affilationReqData.requests![index].userDetails!.profilePicture}"),
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                      text:
                                          "${companyController.affilationReqData.requests![index].userDetails!.firstName} ${companyController.affilationReqData.requests![index].userDetails!.lastName} ",
                                      textSize: 14),
                                  TextWidget(
                                      text:
                                          "${companyController.affilationReqData.requests![index].userDetails!.email}",
                                      textSize: 14),
                                ],
                              )
                            ],
                          ),
                          sizedTextfield,
                          TextWidget(
                              text:
                                  "Role: ${companyController.affilationReqData.requests![index].role}",
                              textSize: 15,
                              fontWeight: FontWeight.w500),
                          const SizedBox(height: 4),
                          TextWidget(
                              text:
                                  "${companyController.affilationReqData.requests![index].description}",
                              textSize: 12),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              TextWidget(
                                  text:
                                      "Start: ${companyController.affilationReqData.requests![index].startDate}",
                                  textSize: 14),
                              SizedBox(width: 12),
                              TextWidget(
                                  text:
                                      "End: ${companyController.affilationReqData.requests![index].endDate}",
                                  textSize: 14),
                            ],
                          ),
                          sizedTextfield,
                          companyController.affilationReqData.requests![index]
                                      .status ==
                                  "pending"
                              ? Row(
                                  children: [
                                    AppButton.primaryButton(
                                        height: 30,
                                        width: 100,
                                        bgColor: AppColors.green700,
                                        onButtonPressed: () {
                                          Helper.loader(context);
                                          companyController
                                              .updateAffilatedRequest(
                                                  requestId: companyController
                                                      .affilationReqData
                                                      .requests![index]
                                                      .requestId!,
                                                  startupId: companyController
                                                      .affilationReqData
                                                      .requests![index]
                                                      .startUpId!,
                                                  status: "approved");
                                        },
                                        title: "Accept"),
                                    const SizedBox(width: 12),
                                    AppButton.primaryButton(
                                        height: 30,
                                        width: 100,
                                        bgColor: AppColors.redColor,
                                        onButtonPressed: () {
                                          Helper.loader(context);
                                          companyController
                                              .updateAffilatedRequest(
                                                  requestId: companyController
                                                      .affilationReqData
                                                      .requests![index]
                                                      .requestId!,
                                                  startupId: companyController
                                                      .affilationReqData
                                                      .requests![index]
                                                      .startUpId!,
                                                  status: "rejected");
                                        },
                                        title: "Reject"),
                                  ],
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      companyController.affilationReqData
                                                  .requests![index].status ==
                                              "approved"
                                          ? Icons.check_circle_outline_outlined
                                          : Icons.close,
                                      size: 18,
                                      color: companyController.affilationReqData
                                                  .requests![index].status ==
                                              "approved"
                                          ? AppColors.green700
                                          : AppColors.redColor,
                                    ),
                                    const SizedBox(width: 4),
                                    TextWidget(
                                      text:
                                          "${companyController.affilationReqData.requests![index].status!.capitalizeFirst}",
                                      textSize: 14,
                                      color: companyController.affilationReqData
                                                  .requests![index].status ==
                                              "approved"
                                          ? AppColors.darkGreen
                                          : AppColors.redColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                )
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
