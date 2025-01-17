import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget {

  
  final picker = ImagePicker();
  File? _image;
  String? cropImage;
  String? base64Image;
  Future getImage(bool isCamera) async {
    try {
      final pickedFile = await picker.pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);

      // setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        cropImage = await imgCropper(_image!.path);
        // if (File(cropImage!).lengthSync() > 1 * 1024 * 1024) {
        //   final compressedImage = await _compressImage(File(cropImage!));
        //   cropImage = compressedImage;
        // } else {
        //   cropImage = cropImage;
        // }
        // int compressedImageSize = File(cropImage!).lengthSync();
        // log((compressedImageSize / (1024 * 1024)).toStringAsFixed(2));
        return base64Image = base64Encode(File(cropImage!).readAsBytesSync());
      } else {
        print('No image selected.');
        return null;
      }
    } catch (e) {
      log("message $e");
    }
    // });
  }

  CroppedFile? croppedFile;

  imgCropper(img) async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: img,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop your image',
            toolbarColor: AppColors.primary,
            toolbarWidgetColor: AppColors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );
    return croppedFile!.path;
  }
}
