import 'package:capitalhub_crm/controller/newsController/news_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../utils/appcolors/app_colors.dart';
import '../../utils/constant/app_var.dart';
import '../../utils/getStore/get_store.dart';
import '../../utils/helper/placeholder.dart';
import '../../widget/appbar/appbar.dart';
import '../../widget/textwidget/text_widget.dart';
import '../drawerScreen/drawer_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsController newsController = Get.put(NewsController());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      newsController.getNewsList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
          backgroundColor: AppColors.transparent,
          drawer: GetStoreData.getStore.read('isInvestor')
              ? const DrawerWidgetInvestor()
              : const DrawerWidget(),
          appBar: HelperAppBar.appbarHelper(
              title: "News", hideBack: true, autoAction: true),
          body: Obx(() => newsController.isLoading.value
              ? ShimmerLoader.shimmerTile()
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: newsController.newsList.length,
                  padding: const EdgeInsets.all(10),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: AppColors.blackCard,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: CachedNetworkImage(
                                height: 200, width: double.infinity,
                                imageUrl: newsController.newsList[index].image!,
                                placeholder: (context, url) => const SizedBox(
                                  height: 200,
                                  child: Center(
                                      child: SpinKitThreeBounce(
                                          size: 30, color: Colors.white)),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover, // Image fit style
                              )
                              // Image.network(
                              //   newsController.newsList[index].image!,
                              //   width: double.infinity,
                              //   height: 200,
                              //   fit: BoxFit.cover,
                              // ),
                              ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                TextWidget(
                                  text:
                                      '${newsController.newsList[index].title}',
                                  textSize: 15,
                                  maxLine: 2,
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(height: 8),
                                TextWidget(
                                    text:
                                        '${newsController.newsList[index].subtitle}',
                                    textSize: 14,
                                    maxLine: 10,
                                    color: AppColors.whiteCard),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      Helper.launchUrl(
                                          "${newsController.newsList[index].readmoreUrl}");
                                    },
                                    child: const TextWidget(
                                      text: 'Read More',
                                      color: AppColors.blue,
                                      textSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ))),
    );
  }
}
