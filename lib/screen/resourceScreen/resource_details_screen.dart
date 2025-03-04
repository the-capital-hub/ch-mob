import "package:capitalhub_crm/controller/resourceController/resource_controller.dart";
import "package:capitalhub_crm/utils/appcolors/app_colors.dart";
import "package:capitalhub_crm/utils/constant/app_var.dart";
import "package:capitalhub_crm/utils/helper/helper.dart";
import "package:capitalhub_crm/widget/appbar/appbar.dart";
import "package:capitalhub_crm/widget/textwidget/text_widget.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:get/get.dart";

class ResourceDetailsScreen extends StatefulWidget {
  const ResourceDetailsScreen({super.key});

  @override
  State<ResourceDetailsScreen> createState() => _ResourceDetailsScreenState();
}

class _ResourceDetailsScreenState extends State<ResourceDetailsScreen> {
  ResourceController resourceController = Get.put(ResourceController());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      resourceController.getAllResourcesById().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
              title: "", hideBack: false, autoAction: false),
          body: Obx(
            () => resourceController.isLoading.value
                ? Helper.pageLoading()
                : Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: "${resourceController.resourceById.title}",
                          textSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        Divider(
                          color: AppColors.grey700,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "${resourceController.resourceById.logoUrl}",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextWidget(
                          text:
                              "${resourceController.resourceById.description}",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          maxLine: 11,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (resourceController.resourceById.files?.isNotEmpty ??
                            true)
                          const TextWidget(
                            text: "Resource Files",
                            textSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                resourceController.resourceById.files?.length ??
                                    0,
                            itemBuilder: (context, index) {
                              var fileName =
                                  "${resourceController.resourceById.files![index].name}";

                              return ListTile(
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                tileColor: AppColors.white12,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                title: Text(
                                  fileName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary,
                                  ),
                                ),
                                trailing: TextWidget(
                                  text:
                                      "(${resourceController.resourceById.files![index].extension.toString().split('/').last.toUpperCase()})",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                onTap: () {
                                  Helper.launchUrl(
                                      "${resourceController.resourceById.files![index].url}");
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ));
  }
}
