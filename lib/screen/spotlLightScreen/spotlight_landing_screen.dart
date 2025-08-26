import 'package:capitalhub_crm/controller/spotlightController/spotlight_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/spotlLightScreen/spotlightHome/spotlight_all_product_Screen.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/appcolors/app_colors.dart';
import '../../utils/constant/app_var.dart';
import '../../widget/textwidget/text_widget.dart';
import 'spotlightHome/spotlight_startup_showcase_screen.dart';

class SpotLightLandingScreen extends StatefulWidget {
  const SpotLightLandingScreen({super.key});

  @override
  State<SpotLightLandingScreen> createState() => _SpotLightLandingScreenState();
}

class _SpotLightLandingScreenState extends State<SpotLightLandingScreen>
    with SingleTickerProviderStateMixin {
  SpotlightController spotlightController = Get.put(SpotlightController());
  List<String> animatedSubFilters = [];
  String selectedFilter = 'All';
  String selectedSubFilter = 'All';

  final List<String> filters = ['All', 'Idea', 'Pre-Seed', 'Seed', 'Growth'];
  final Map<String, List<String>> subFilterMap = {
    'All': ['All', 'Technology', 'Investments', 'Finance'],
    'Idea': ['All', 'Innovation', 'Startups'],
    'Pre-Seed': ['All', 'Tech', 'Healthcare'],
    'Seed': ['All', 'E-commerce', 'Education'],
    'Growth': ['All', 'B2B', 'Consumer'],
  };

  @override
  void initState() {
    super.initState();
    _triggerSubFilterAnimation();
  }

  bool showSubFilters = false;

  void _triggerSubFilterAnimation() async {
    final subfilters = subFilterMap[selectedFilter] ?? [];
    setState(() {
      animatedSubFilters.clear();
      showSubFilters = false;
    });

    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      animatedSubFilters.addAll(subfilters);
      showSubFilters = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        drawer: const DrawerWidget(),
        appBar: HelperAppBar.appbarHelper(
          title: "Spotlight",
          hideBack: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MAIN FILTERS
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filters.map((filter) {
                      final isSelected = selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              selectedFilter = filter;
                              selectedSubFilter =
                                  subFilterMap[filter]?.first ?? 'All';
                            });
                            _triggerSubFilterAnimation();
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: isSelected
                                ? AppColors.primary
                                : AppColors.transparent,
                            side: BorderSide(
                                color: isSelected
                                    ? AppColors.transparent
                                    : AppColors.white54),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 14),
                          ),
                          child: TextWidget(
                            text: filter,
                            textSize: 14,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Divider(
                  color: AppColors.white54,
                  thickness: 0.5,
                  height: 30,
                ),
                TextWidget(
                    text: "  Category",
                    textSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white54),
                const SizedBox(height: 2),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: animatedSubFilters.map((subFilter) {
                        final index = animatedSubFilters.indexOf(subFilter);
                        final isSelected = selectedSubFilter == subFilter;

                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: Duration(milliseconds: 500 + (index * 100)),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(10 * (1 - value), 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedSubFilter = subFilter;
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      // backgroundColor: isSelected
                                      //     ? AppColors.primary
                                      //     : AppColors.transparent,
                                      side: BorderSide(
                                        color: isSelected
                                            ? AppColors.primary
                                            : AppColors.white38,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 14),
                                    ),
                                    child: TextWidget(
                                      text: subFilter,
                                      textSize: 13,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
                sizedTextfield,
              ],
            )),
      ),
    );
  }
}
