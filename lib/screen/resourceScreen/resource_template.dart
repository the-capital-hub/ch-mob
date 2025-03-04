import 'package:capitalhub_crm/screen/resourceScreen/resource_screen.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../controller/resourceController/resource_controller.dart';
import '../../utils/appcolors/app_colors.dart';
import '../../utils/constant/app_var.dart';
import '../../utils/constant/asset_constant.dart';
import '../../widget/appbar/appbar.dart';
import '../../widget/textWidget/text_widget.dart';

class ResourceTemplate extends StatefulWidget {
  const ResourceTemplate({super.key});

  @override
  State<ResourceTemplate> createState() => _ResourceTemplateState();
}

class _ResourceTemplateState extends State<ResourceTemplate> {
  ResourceController allResources = Get.put(ResourceController());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      allResources.getAllResources().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
         
        });
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ResourceController resourceController = Get.put(ResourceController());

    return 
    
    Container(
      decoration: bgDec,
      child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
              title: "", hideBack: false, autoAction: false),
          body: 
          Obx(() => allResources.isLoading.value
                ? Helper.pageLoading()
                : allResources.allResourcesDetails.isEmpty
                      ? Center(child: TextWidget(text: "No Resources Available", textSize: 16))
                      :
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const TextWidget(
                        text: 'Ready - to - Use Templates',
                        textSize: 30,
                        align: TextAlign.center,
                        fontWeight: FontWeight.bold,
                        maxLine: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const TextWidget(
                        text:
                            'Access to events, unlock investors database and more at 1,999/-',
                        textSize: 18,
                        align: TextAlign.center,
                        maxLine: 2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.white12,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const TextWidget(
                        text: 'Join Hustlers Club ?',
                        textSize: 25,
                        align: TextAlign.center,
                        fontWeight: FontWeight.bold,
                        maxLine: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const TextWidget(
                        text: 'Get ready to use templates',
                        textSize: 18,
                        align: TextAlign.center,
                        maxLine: 2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        PngAssetPath.foxCurveImg,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: List<Widget>.generate(
                            allResources.allResourcesDetails[0].resources.length,
                            (index) {
                          return InkWell(
                            onTap: () => Get.to(() => const ResourceScreen()),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 120,
                              width: ((constraints.maxWidth / 2) - (15 / 2)),
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            image:  DecorationImage(
                                image: NetworkImage(
                                  allResources.allResourcesDetails[0].resources[index].logoUrl,
                                ),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                                  const SizedBox(height: 10,),
                                  TextWidget(text: allResources.allResourcesDetails[0].resources[index].title,

                                    textSize: 20,
                                    fontWeight: FontWeight.bold,
                                    maxLine: 2,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () => Get.to(() => const ResourceScreen()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)),
                      child: const TextWidget(
                        text: 'View All',
                        textSize: 15,
                        maxLine: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
      )
    );
  }
}
