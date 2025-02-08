// import 'package:animated_introduction/animated_introduction.dart';
// import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
// import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../utils/constant/app_var.dart';
// import '../authScreen/welcome_auth_screen.dart';

// class Onboarding1Screen extends StatefulWidget {
//   const Onboarding1Screen({super.key});

//   @override
//   State<Onboarding1Screen> createState() => _Onboarding1ScreenState();
// }

// class _Onboarding1ScreenState extends State<Onboarding1Screen> {
//   final List<SingleIntroScreen> pages = [
//     SingleIntroScreen(
//       title: 'Welcome to the Event Management App!',
//       textStyle: TextStyle(
//         color: AppColors.white,
//         fontSize: 15,
//         fontWeight: FontWeight.w400,
//       ),
//       description:
//           'You plans your Events, We\'ll do the rest and will be the best! Guaranteed!  ',
//       imageAsset: PngAssetPath.ob1Img,
//       centerBallRadius: 0,
//       imageWithBubble: false,
//     ),
//     SingleIntroScreen(
//       title: 'Book tickets to cricket matches and events',
//       centerBallRadius: 0,
//       imageWithBubble: false,
//       textStyle: TextStyle(
//         color: AppColors.white,
//         fontSize: 15,
//         fontWeight: FontWeight.w400,
//       ),
//       description:
//           'Tickets to the latest movies, crickets matches, concerts, comedy shows, plus lots more!',
//       imageAsset: PngAssetPath.ob2Img,
//     ),
//     SingleIntroScreen(
//       title: 'Grabs all events now only in your hands',
//       centerBallRadius: 0,
//       imageWithBubble: false,
//       textStyle: TextStyle(
//         color: AppColors.white,
//         fontSize: 15,
//         fontWeight: FontWeight.w400,
//       ),
//       description: 'All events are now in your hands, just a click away! ',
//       imageAsset: PngAssetPath.ob3Img,
//     ),
//     SingleIntroScreen(
//       title: 'Grabs all events now only in your hands',
//       centerBallRadius: 0,
//       sideDotsBgColor: AppColors.primary,
//       textStyle: TextStyle(
//         color: AppColors.white,
//         fontSize: 15,
//         fontWeight: FontWeight.w400,
//       ),
//       description: 'All events are now in your hands, just a click away! ',
//       imageAsset: PngAssetPath.ob4Img,
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: bgDec,
//         child: Scaffold(
//             backgroundColor: AppColors.transparent,
//             body: AnimatedIntroduction(
//               slides: pages,
//               containerBg: AppColors.black,
//               indicatorType: IndicatorType.circle,
//               footerBgColor: AppColors.blackCard,
//               doneText: "Done",
//               onDone: () {
//                 Get.to(() => const WelcomeScreen(),
//                     duration: const Duration(seconds: 1),
//                     transition: Transition.circularReveal);
//               },
//             )));
//   }
// }
