import 'dart:async';
import 'package:capitalhub_crm/controller/homeController/home_controller.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/textWidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/helper/helper.dart';

class AutoScrollListView extends StatefulWidget {
  @override
  _AutoScrollListViewState createState() => _AutoScrollListViewState();
}

class _AutoScrollListViewState extends State<AutoScrollListView> {
  HomeController homeController = Get.find();
  ScrollController _scrollController = ScrollController();
  Timer? _timer;
  bool _isUserScrolling = false;
  int offSet = 10;
  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection !=
          ScrollDirection.idle) {
        // When user manually scrolls, stop auto-scrolling
        if (!_isUserScrolling) {
          setState(() {
            _isUserScrolling = true;
          });
          _stopAutoScroll();
        }
      } else {
        // User is idle, start auto-scrolling again if needed
        if (_isUserScrolling) {
          setState(() {
            _isUserScrolling = false;
          });
          _startAutoScroll();
        }
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _stopAutoScroll();
      }
    });
  }

  // Start auto-scrolling the ListView horizontally
  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.offset +
              1, // Increase this value for faster scrolling
          duration: const Duration(milliseconds: 50),
          curve: Curves.linear,
        );
      }
    });
  }

  // Stop auto-scrolling when user interacts
  void _stopAutoScroll() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.blackCard,
      ),
      padding: const EdgeInsets.all(8),
      child: homeController.isLoading.value
          ? Helper.loader(context)
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(
                        text: "Startup Corner",
                        textSize: 16,
                        fontWeight: FontWeight.w500),
                    InkWell(
                      onTap: () {
                        offSet += 10;
                        homeController.getStartupNews(offSet: offSet).then((v) {
                          setState(() {});
                        });
                      },
                      child: const TextWidget(
                        text: "Load More",
                        color: AppColors.primary,
                        textSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: homeController.startUpNewsList.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: Get.width / 1.3,
                        child: Card(
                          elevation: 3,
                          shadowColor: AppColors.white38,
                          color: AppColors.blackCard,
                          surfaceTintColor: AppColors.white12,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text:
                                        '${homeController.startUpNewsList[index].author}',
                                    textSize: 10),
                                const SizedBox(height: 2),
                                TextWidget(
                                  text:
                                      '${homeController.startUpNewsList[index].title}',
                                  textSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 2),
                                TextWidget(
                                    text:
                                        "${homeController.startUpNewsList[index].content}",
                                    textSize: 11,
                                    maxLine: 6,
                                    color: AppColors.grey3Color),
                                const SizedBox(height: 6),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Helper.launchUrl(homeController
                                        .startUpNewsList[index].sourceUrl!);
                                  },
                                  child: Container(
                                    height: 159,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${homeController.startUpNewsList[index].image}"))),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
