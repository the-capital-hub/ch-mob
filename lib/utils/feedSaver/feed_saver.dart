import 'dart:typed_data';
import 'dart:ui';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';
import '../helper/helper_sncksbar.dart';

class FeedSaver {
  static Future<Uint8List?> captureWidget(
      GlobalKey key, BuildContext context) async {
    try {
      flashAndVibrate(context);

      RenderRepaintBoundary boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(
        pixelRatio: 3.0,
      );
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error capturing widget: $e');
      return null;
    }
  }

  static Future<void> flashAndVibrate(BuildContext context) async {
    Vibration.vibrate(duration: 200, preset: VibrationPreset.rapidTapFeedback);

    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final overlayEntry = OverlayEntry(
      builder: (_) => Positioned.fill(
        child: ColoredBox(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
    );

    for (int i = 0; i < 2; i++) {
      overlay.insert(overlayEntry);
      await Future.delayed(const Duration(milliseconds: 80));
      overlayEntry.remove();
      await Future.delayed(const Duration(milliseconds: 80));
    }
  }

  static Future<void> saveToGallery(Uint8List bytes) async {
    // final status = await Permission.storage.request();
    // if (status.isGranted) {
    //   await ImageGallerySaver.saveImage(
    //     bytes,
    //     quality: 100,
    //     name: 'post_${DateTime.now().millisecondsSinceEpoch}',
    //   );
    // } else {
    //   debugPrint('Storage permission denied');
    // }

    try {
      if (await _requestPermission()) {
        final result = await ImageGallerySaver.saveImage(bytes,
            name: "capitalhub_${DateTime.now().millisecondsSinceEpoch}");

        if (result['isSuccess']) {
          Get.back();
          HelperSnackBar.snackBar("Success", "Image saved successfully");
        } else {
          HelperSnackBar.snackBar("Error", "Failed to save image");
        }
      } else {
        print("❌ Permission denied!");
      }
    } catch (e) {
      print("❌ Error downloading image: $e");
    }
  }

  static Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        var status = await Permission.photos.status;
        if (!status.isGranted) {
          status = await Permission.photos.request();
          if(status.isDenied){
            status = await Permission.storage.request();
          }
        }
        return status.isGranted;
      } else {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
        }
        return status.isGranted;
      }
    }
    return true;
  }

  static Future<void> shareImage(Uint8List bytes) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/shared_post.png');
    await file.writeAsBytes(bytes);
    await Share.shareXFiles(
      [XFile(file.path)],
    );
  }

  static Future<void> showShareBottomSheet({
    required BuildContext context,
    required Uint8List imageBytes,
  }) async {
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.blackCard,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (_) => SizedBox(
              height: 470,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                        height: 400,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity - 20,
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.memory(imageBytes, fit: BoxFit.contain)),
                    sizedTextfield,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton.outlineGradient(
                            onButtonPressed: () async {
                              await saveToGallery(imageBytes);
                            },
                            icon: Icon(CupertinoIcons.arrow_down_circle,
                                color: AppColors.white, size: 20),
                            height: 35,
                            width: 100,
                            title: "Download"),
                        const SizedBox(width: 22),
                        AppButton.outlineGradient(
                            onButtonPressed: () async {
                              await shareImage(imageBytes);
                              Get.back();
                            },
                            icon: Image(
                                image: const AssetImage(PngAssetPath.share),
                                color: AppColors.white,
                                height: 20),
                            width: 100,
                            height: 35,
                            title: "Share"),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
