import 'dart:convert';
import 'dart:io';

import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/loginController/login_controller.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/constant/app_var.dart';
import '../../../utils/constant/asset_constant.dart';
import '../../../widget/text_field/text_field.dart';
import '../../../widget/textwidget/text_widget.dart';
import 'signup_otp_page.dart';

class SignupByNumberScreen extends StatefulWidget {
  const SignupByNumberScreen({super.key});

  @override
  State<SignupByNumberScreen> createState() => _SignupByNumberScreenState();
}

class _SignupByNumberScreenState extends State<SignupByNumberScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  LoginController loginMobileController = Get.put(LoginController());
  String? _base64Image;
  String _selectedAvatar = PngAssetPath.avtar1Img; // Default avatar

  final List<String> _avatarList = [
    PngAssetPath.avtar1Img,
    PngAssetPath.avtar2Img,
    PngAssetPath.avtar3Img,
    PngAssetPath.avtar4Img,
    PngAssetPath.avtar5Img,
  ];

  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    _convertAssetToBase64(PngAssetPath.avtar1Img);
    loginMobileController.isLogin = false;
    super.initState();
  }

  @override
  void dispose() {
    loginMobileController.isLogin = true;
    super.dispose();
  }

  Future<void> _convertToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64String = base64Encode(imageBytes);
    setState(() {
      _base64Image = base64String;
    });
  }

  Future<void> _convertAssetToBase64(String assetPath) async {
    ByteData assetByteData = await rootBundle.load(assetPath);
    List<int> assetBytes = assetByteData.buffer.asUint8List();
    String base64String = base64Encode(assetBytes);
    setState(() {
      _base64Image = base64String;
    });
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      _convertToBase64(imageFile);
      setState(() {
        _selectedAvatar = imageFile.path;
      });
    }
  }

  void _selectAvatar(String avatarPath) async {
    setState(() {
      _selectedAvatar = avatarPath;
    });
    await _convertAssetToBase64(avatarPath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        appBar: HelperAppBar.appbarHelper(title: "", hideBack: false),
        backgroundColor: AppColors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    PngAssetPath.appLogo,
                    height: 40,
                    width: 60,
                  ),
                  const TextWidget(
                    text: "Join Capital Hub",
                    textSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  const TextWidget(
                      text:
                          "India’s biggest community of startups and investors",
                      textSize: 10),
                  sizedTextfield,
                  sizedTextfield,
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.orange,
                          backgroundImage: _selectedAvatar.startsWith('assets/')
                              ? AssetImage(_selectedAvatar)
                              : FileImage(File(_selectedAvatar))
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: InkWell(
                            onTap: _pickImageFromGallery,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.primary,
                              child: Icon(Icons.edit,
                                  size: 18, color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizedTextfield,
                  sizedTextfield,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _avatarList.map((avatar) {
                      return GestureDetector(
                        onTap: () => _selectAvatar(avatar),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(avatar),
                            // border: _selectedAvatar == avatar
                            //     ? Border.all(color: Colors.blue, width: 3)
                            //     : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  sizedTextfield,
                  sizedTextfield,
                  MyCustomTextField.textField(
                      controller: loginMobileController.loginPhoneController,
                      valText: "Please enter mobile number",
                      textInputType: TextInputType.phone,
                      lableText: 'Mobile Number',
                      hintText: "Enter Mobile Number"),
                  sizedTextfield,
                  sizedTextfield,
                  AppButton.primaryButton(
                      onButtonPressed: () {
                        // Get.to(SignupOtpPage());
                        loginMobileController.signupApi(context);
                        loginMobileController.base64 = _base64Image;
                        
                      },
                      title: "Create Account")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
