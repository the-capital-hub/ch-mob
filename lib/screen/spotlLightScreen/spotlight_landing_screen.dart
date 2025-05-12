import 'package:capitalhub_crm/controller/spotlightController/spotlight_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/spotlLightScreen/spotlightHome/spotlight_all_product_Screen.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/appcolors/app_colors.dart';
import '../../utils/constant/app_var.dart';
import 'spotlightHome/spotlight_request_screen.dart';
import 'spotlightHome/spotlight_startup_showcase_screen.dart';

class SpotLightLandingScreen extends StatefulWidget {
  const SpotLightLandingScreen({super.key});

  @override
  State<SpotLightLandingScreen> createState() => _SpotLightLandingScreenState();
}

class _SpotLightLandingScreenState extends State<SpotLightLandingScreen>
    with SingleTickerProviderStateMixin {
  SpotlightController spotlightController = Get.put(SpotlightController());
  // List<String> animatedSubFilters = [];
  // String selectedFilter = 'All';
  // String selectedSubFilter = 'All';
  // final List<String> filters = ['All', 'Idea', 'Pre-Seed', 'Seed', 'Growth'];
  // @override
  // void initState() {
  //   super.initState();
  //   _spotlightController = AnimationController(
  //     duration: const Duration(seconds: 3),
  //     vsync: this,
  //   );

  //   SchedulerBinding.instance.addPostFrameCallback((_) {
  //     spotlightController
  //         .getSpotlightProductList(industry: "All", stage: "All")
  //         .then((_) {
  //       _triggerSubFilterAnimation();
  //       _spotlightController.forward().whenComplete(() {
  //         setState(() {});
  //       });
  //     });
  //   });
  // }

  // late AnimationController _spotlightController;

  // bool showSubFilters = false;
  // @override
  // void dispose() {
  //   _spotlightController.dispose();
  //   super.dispose();
  // }

  // void _triggerSubFilterAnimation() async {
  //   final subfilters = spotlightController.spotlightData.industries!;

  //   if (!mounted) return;
  //   setState(() {
  //     animatedSubFilters.clear();
  //     showSubFilters = false;
  //   });

  //   await Future.delayed(const Duration(milliseconds: 100));

  //   if (!mounted) return;
  //   setState(() {
  //     animatedSubFilters.addAll(subfilters);
  //     showSubFilters = true;
  //   });
  // }

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StartupShowcaseScreen(),
                  sizedTextfield,
                  // SpotlightTopProduct(),
                  // sizedTextfield,
                  AppButton.primaryButton(
                      onButtonPressed: () {
                        Get.to(() => const SpotLightAllProductScreen());
                      },
                      title: "View All Product"),
                  sizedTextfield,
                  AppButton.outlineButton(
                      onButtonPressed: () {
                        Get.to(() => const SpotlightRequestScreen());
                      },
                      borderColor: AppColors.primary,
                      title: "View Request")
                ],
              ),
            )),
      ),
    );
  }
}
