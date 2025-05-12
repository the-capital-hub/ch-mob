import 'package:capitalhub_crm/controller/exploreController/explore_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/getStore/get_store.dart';
import '../../widget/textwidget/text_widget.dart';

void showInvestorSearchSheet(BuildContext context) {
  Get.bottomSheet(
    const InvestorSearchSheet(),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    elevation: 10,
  );
}

class InvestorSearchSheet extends StatefulWidget {
  const InvestorSearchSheet({super.key});

  @override
  State<InvestorSearchSheet> createState() => _InvestorSearchSheetState();
}

class _InvestorSearchSheetState extends State<InvestorSearchSheet> {
  final String welcomeMessage =
      "Hello ${GetStoreData.getStore.read('name')},\nAs an AI investor, I can provide you with valuable insights, data analysis, for your investment decisions. How can I help you today?";

  TextEditingController searchController = TextEditingController();
  ExploreController exploreController = Get.find();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchController.text = exploreController.aiInvestorQuery;
      if (exploreController.aiInvestorQuery == "") {
        startTypingEffect(welcomeMessage);
      }
    });
  }

  final RxBool isTypingRx = false.obs;
  bool _isDisposed = false;
  Future startTypingEffect(String response) async {
    if (_isDisposed) return;
    if (mounted) {
      setState(() {
        exploreController.displayedResponse = "";
        isTypingRx.value = true;
      });
    } else {
      exploreController.displayedResponse = "";
      isTypingRx.value = true;
    }

    for (int i = 0; i < response.length; i++) {
      await Future.delayed(const Duration(milliseconds: 10));
      if (_isDisposed) break;
      exploreController.displayedResponse += response[i];
      if (mounted) setState(() {});
    }
    exploreController.displayedResponse = response;

    if (_isDisposed) return;
    if (mounted) {
      setState(() {
        isTypingRx.value = false;
      });
    } else {
      isTypingRx.value = false;
    }
  }

  void onSearchPressed() async {
    // await Future.delayed(const Duration(seconds: 1));
    exploreController.aiInvestorQuery = searchController.text.trim();

    if (exploreController.aiInvestorQuery.isEmpty) return;

    String fullResponse =
        "Sure, I can help you find the right investors for ${exploreController.aiInvestorQuery}. I use smart data and insights to suggest investors who might be a good fit for your needs. Let’s explore some options together!";

    startTypingEffect(fullResponse).then((v) {
      if (Get.isBottomSheetOpen == true) {
        Get.back();
      }
      exploreController.getExploreCollection();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.blackCard,
            border: Border(
                top: BorderSide(
                    color: GetStoreData.getStore.read('isInvestor')
                        ? AppColors.primaryInvestor
                        : AppColors.primary,
                    width: 2)),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextWidget(
                    text: "Ask AI to find Investors",
                    textSize: 20,
                    fontWeight: FontWeight.bold,
                    color: GetStoreData.getStore.read('isInvestor')
                        ? AppColors.primaryInvestor
                        : AppColors.primary,
                  ),
                  InkWell(
                    onTap: () {
                      exploreController.aiInvestorQuery = "";
                      Get.back();
                      exploreController.getExploreCollection().then((v) {});
                    },
                    child: const Icon(
                      Icons.refresh,
                      color: AppColors.primary,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              MyCustomTextField.textField(
                  hintText:
                      "Search with ai\n e.g, Show me seed Investor in india",
                  controller: searchController,
                  borderClr: AppColors.white12,
                  fillColor: AppColors.black,
                  maxLine: 3,
                  suffixIcon: IgnorePointer(
                    ignoring: isTypingRx.value,
                    child: InkWell(
                      onTap: () {
                        if (!isTypingRx.value) onSearchPressed();
                      },
                      child: Container(
                        height: 88,
                        width: 10,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                          color: isTypingRx.value
                              ? AppColors.grey
                              : GetStoreData.getStore.read('isInvestor')
                                  ? AppColors.primaryInvestor
                                  : AppColors.primary,
                        ),
                        child: Icon(
                          Icons.send,
                          color: isTypingRx.value
                              ? Colors.black38
                              : GetStoreData.getStore.read('isInvestor')
                                  ? AppColors.black
                                  : AppColors.white,
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 24),
              if (exploreController.displayedResponse.isNotEmpty ||
                  isTypingRx.value)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextWidget(
                    text: exploreController.displayedResponse,
                    color: Colors.white,
                    textSize: 14,
                    maxLine: 100,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
