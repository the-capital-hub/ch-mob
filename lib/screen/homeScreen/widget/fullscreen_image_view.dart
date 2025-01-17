import 'dart:io';

import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullscreenImageView extends StatelessWidget {
  String imageURl;
  String name;
  bool? fileImage;
  FullscreenImageView({
    super.key,
    required this.imageURl,
    required this.name,
    this.fileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: HelperAppBar.appbarHelper(title: name),
      body: Center(
          child: InteractiveViewer(
              panEnabled: false,
              maxScale: 3,
              child: fileImage == true
                  ? Image.file(File(imageURl),
                      height: Get.height, width: Get.width)
                  : Image.network(
                      imageURl,
                      height: Get.height,
                      width: Get.width,
                    ))),
    );
  }
}
