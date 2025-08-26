import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import '../helper/helper_sncksbar.dart';

class ImageHelper {
  static Future<void> shareImage(String imageUrl) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/shared_image.jpg';

      await Dio().download(imageUrl, filePath);

      await Share.shareXFiles(
        [XFile(filePath)],
      );
    } catch (e) {
      print("Error sharing image: $e");
    }
  }

  static Future<void> downloadImage(String imageUrl) async {
    try {
      if (await _requestPermission()) {
        var response =
            await Dio().get(imageUrl, onReceiveProgress: (received, total) {
          if (total != -1) {
            // Calculate the progress percentage
            int progress = ((received / total) * 100).toInt();
            // Show the progress notification
          }
        }, options: Options(responseType: ResponseType.bytes));
        Uint8List imageData = Uint8List.fromList(response.data);

        final result = await ImageGallerySaver.saveImage(imageData,
            name: "capitalhub_${DateTime.now().millisecondsSinceEpoch}");

        if (result['isSuccess']) {
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

  static Future<void> downloadVideo(String videoUrl) async {
    try {
      if (await _requestPermission()) {
        final tempDir = await getTemporaryDirectory();
        final filePath =
            '${tempDir.path}/capitalhub_video_${DateTime.now().millisecondsSinceEpoch}.mp4';

        final response = await Dio().download(videoUrl, filePath,
            onReceiveProgress: (received, total) {
          if (total != -1) {
            // Calculate the progress percentage
            int progress = ((received / total) * 100).toInt();
            // Show the progress notification
          }
        });

        if (response.statusCode == 200) {
          final saved = await ImageGallerySaver.saveFile(filePath);
          log(saved.toString());
          if (saved['isSuccess'] == true) {
          } else {
            HelperSnackBar.snackBar("Error", "Failed to save video");
          }
        } else {
          HelperSnackBar.snackBar("Error", "Download failed");
        }
      } else {
        print("❌ Permission denied!");
      }
    } catch (e) {
      print("❌ Error downloading video: $e");
    }
  }

  static Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        var status = await Permission.photos.status;
        if (!status.isGranted) {
          status = await Permission.photos.request();
        }
        if (status.isDenied) {
          status = await Permission.storage.request();
        }
        var manageStatus = await Permission.manageExternalStorage.status;
        if (!manageStatus.isGranted) {
          manageStatus = await Permission.manageExternalStorage.request();
        }
        return status.isGranted || manageStatus.isGranted;
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
}

class FileHelper {
  static Future<void> sharePdf(pdfUrl) async {
    try {
      // Get the temporary directory to store the file
      final Directory tempDir = await getTemporaryDirectory();
      final String fileName =
          "sample_${DateTime.now().millisecondsSinceEpoch}.pdf";
      final String filePath = "${tempDir.path}/$fileName";

      // Download the PDF
      Response response = await Dio().get(
        pdfUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      // Save the PDF to the temporary directory
      File file = File(filePath);
      await file.writeAsBytes(response.data as Uint8List);

      // Share the PDF file using shareXFiles
      await Share.shareXFiles([XFile(filePath)], text: 'Check out this PDF!');
    } catch (e) {
      print("Error downloading or sharing PDF: $e");
    }
  }

  static Future downloadPDF(String pdfUrl) async {
    try {
      await FileDownloader.downloadFile(
          url: pdfUrl,
          name: "capitalhub_${DateTime.now()}",
          onDownloadCompleted: (String path) {},
          onProgress: (String? fileName, double progress) {
            int percentage = (progress * 100).toInt();
          },
          onDownloadError: (String error) {
            print('DOWNLOAD ERROR: $error');
            HelperSnackBar.snackBar("Error", "Download error $error");
          });
    } catch (e) {
      print("❌ Error downloading PDF: $e");
    }
  }

  static Future<bool> _requestPermission() async {
    var status = await Permission.storage.status;
    var managestatus = await Permission.manageExternalStorage.status;
    if (status.isGranted) {
      return true;
    }
    if (managestatus.isGranted) {
      return true;
    }
    status = await Permission.storage.request();
    managestatus = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      return true;
    }
    if (managestatus.isGranted) {
      return true;
    }
    openAppSettings();
    return false;
  }
}
