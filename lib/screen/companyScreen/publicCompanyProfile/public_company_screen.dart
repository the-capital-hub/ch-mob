import 'package:animate_do/animate_do.dart';
import 'package:capitalhub_crm/controller/companyController/company_controller.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/constant/app_var.dart';
import '../../../utils/helper/helper.dart';
import '../../../utils/helper/placeholder.dart';
import '../../../widget/textwidget/text_widget.dart';

class PublicCompanyScreen extends StatefulWidget {
  final String userId;
  const PublicCompanyScreen({super.key, required this.userId});

  @override
  State<PublicCompanyScreen> createState() => _PublicCompanyScreenState();
}

class _PublicCompanyScreenState extends State<PublicCompanyScreen> {
  CompanyController companyController = Get.put(CompanyController());

  @override
  void initState() {
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  final fundingKey = GlobalKey();
  final publicLinksKey = GlobalKey();
  final keyFocusKey = GlobalKey();
  final teamKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(title: "Company"),
          body: Obx(
            () => companyController.isLoading.value
                ? ShimmerLoader.buildShimmerCompanyScreen()
                : !companyController.isCompanyFound.value
                    ? const Center(
                        child: TextWidget(
                          text: "No Company Found",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : SingleChildScrollView(
                        controller: _scrollController,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ZoomIn(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 22,
                                            backgroundImage: NetworkImage(
                                                companyController
                                                    .affilationReqData.hashCode
                                                    .toString()),
                                            backgroundColor: Colors.transparent,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  text:
                                                      companyController.base64,
                                                  textSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                const SizedBox(height: 4),
                                                TextWidget(
                                                  text:
                                                      "${companyController.descriptionController}",
                                                  textSize: 12,
                                                  color: Colors.grey[300],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width: Get.width,
                                        child: Row(
                                          children: [
                                            TextWidget(
                                              text:
                                                  "${companyController.selectedSector}",
                                              textSize: 10,
                                              color: AppColors.grey,
                                            ),
                                            const SizedBox(width: 4),
                                            _dotSeparator(),
                                            const SizedBox(width: 4),
                                            TextWidget(
                                              text:
                                                  "Founded ${companyController.base64}",
                                              textSize: 10,
                                              color: AppColors.grey,
                                            ),
                                            const SizedBox(width: 4),
                                            _dotSeparator(),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: TextWidget(
                                                text:
                                                    "Last Funding ${companyController.targetController.value}",
                                                textSize: 10,
                                                color: AppColors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      TextWidget(
                                        text: "${companyController.base64}",
                                        textSize: 12,
                                        maxLine: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              sizedTextfield,
                              // Public link,
                              const TextWidget(
                                text: "Public Links",
                                textSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                key: publicLinksKey,
                                child: SizedBox(
                                  height: 40,
                                  child: ListView.separated(
                                    itemCount:
                                        companyController.userData.length,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, ind) {
                                      return const SizedBox(width: 3);
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int ind) {
                                      return InkWell(
                                        onTap: () {
                                          Helper.launchUrl(
                                              companyController.base64);
                                        },
                                        child: Card(
                                          color: AppColors.white12,
                                          surfaceTintColor: AppColors.white12,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  companyController.base64,
                                                  height: 25,
                                                ),
                                                const SizedBox(width: 8),
                                                TextWidget(
                                                    text:
                                                        "${companyController.companyDescriptionController.value}",
                                                    textSize: 12)
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              sizedTextfield,
                              //key focus
                              const TextWidget(
                                text: "Key Focusing Area",
                                textSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                key: keyFocusKey,
                                child: Wrap(
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: List.generate(
                                      companyController
                                          .affilationReqData.hashCode, (ind) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: AppColors.white38,
                                              width: 0.8),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      color: AppColors.transparent,
                                      surfaceTintColor: AppColors.white12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 6),
                                        child: TextWidget(
                                            text: companyController
                                                .affilationReqData
                                                .isFounder
                                                .hashCode
                                                .toString(),
                                            textSize: 14),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const SizedBox(height: 6),
                              //Founding team
                              const TextWidget(
                                text: "Founding Team",
                                textSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
          )),
    );
  }

  Widget _dotSeparator() {
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        shape: BoxShape.circle,
      ),
    );
  }
}
