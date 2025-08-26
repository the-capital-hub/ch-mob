import 'dart:developer';

import 'package:capitalhub_crm/screen/Auth-Process/authScreen/signup_by_number_screen.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pinput/pinput.dart';

import '../../../controller/loginController/login_controller.dart';
import '../../../utils/apiService/google_service.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/text_field/text_field.dart';
import '../../../widget/textwidget/text_widget.dart';
import '../../../utils/constant/app_var.dart';
import '../../../utils/constant/asset_constant.dart';
import 'signupInfoScreens/signup_info_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  LoginController loginMobileController = Get.put(LoginController());
  GlobalKey<FormState> formkey = GlobalKey();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        PngAssetPath.appLogo,
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(width: 4),
                      const TextWidget(text: "Capital Hub", textSize: 16)
                    ],
                  ),
                  sizedTextfield,
                  const TextWidget(
                    text: "Sign in",
                    textSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  sizedTextfield,
                  SizedBox(
                    height: 30,
                    child: TabBar(
                      controller: _tabController,
                      tabAlignment: TabAlignment.fill,
                      indicatorColor:
                          loginMobileController.selectedRoleIndex == 0
                              ? AppColors.primary
                              : AppColors.primaryInvestor,
                      // indicator: const BoxDecoration(),
                      dividerHeight: 0, // No indicator
                      tabs: [
                        Tab(
                          child: TextWidget(
                            text: 'Email/Password',
                            color: _tabController.index == 0
                                ? AppColors.white
                                : AppColors.grey,
                            textSize: 14,
                          ),
                        ),
                        Tab(
                          child: TextWidget(
                            text: 'Mobile/OTP',
                            color: _tabController.index == 1
                                ? AppColors.white
                                : AppColors.grey,
                            textSize: 14,
                          ),
                        ),
                      ],
                      onTap: (index) {
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  _tabController.index == 0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: 'Username/Email',
                              color: AppColors.white,
                              textSize: 12,
                            ),
                            const SizedBox(height: 8),
                            MyCustomTextField.textField(
                                controller:
                                    loginMobileController.loginEmailController,
                                valText: "Please enter username/email",
                                hintText: "Enter Username/Email"),
                            const SizedBox(height: 12),
                            TextWidget(
                              text: 'Password',
                              color: AppColors.white,
                              textSize: 12,
                            ),
                            const SizedBox(height: 8),
                            MyCustomTextField.textField(
                                controller:
                                    loginMobileController.loginPassController,
                                valText: "Please enter password",
                                hintText: "Enter Password"),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: 'Mobile Number',
                              color: AppColors.white,
                              textSize: 12,
                            ),
                            const SizedBox(height: 8),
                            MyCustomTextField.textField(
                                controller:
                                    loginMobileController.loginPhoneController,
                                valText: "Please enter mobile number",
                                textInputType: TextInputType.phone,
                                hintText: "Enter Mobile Number"),
                          ],
                        ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                          text: "I don’t have an account ",
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          textSize: 14),
                      InkWell(
                        onTap: () {
                          Get.to(() => const SignupByNumberScreen());
                          // Get.to(() => const SignupScreen());
                        },
                        child:  TextWidget(
                            text: "Sign Up",
                            textSize: 14,
                            fontWeight: FontWeight.w500,
                            color: loginMobileController.selectedRoleIndex == 0
                                ? AppColors.primary
                                : AppColors.primaryInvestor),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppButton.primaryButton(
                    title: 'Continue',
                    bgColor: loginMobileController.selectedRoleIndex == 0
                        ? AppColors.primary
                        : AppColors.primaryInvestor,
                    textColor: loginMobileController.selectedRoleIndex == 0
                        ? AppColors.white
                        : AppColors.black,
                    onButtonPressed: () {
                      if (_tabController.index == 0) {
                        if (loginMobileController
                                .loginEmailController.text.isNotEmpty &&
                            loginMobileController
                                .loginPassController.text.isNotEmpty) {
                          loginMobileController.loginApiEmailPass(
                            context,
                          );
                        } else {
                          HelperSnackBar.snackBar("Error",
                              "Please enter Username/Email & Password");
                        }
                      } else {
                        if (loginMobileController
                            .loginPhoneController.text.isNotEmpty) {
                          loginMobileController.loginApiPhoneOTP(
                            context,
                          );
                        } else {
                          HelperSnackBar.snackBar(
                              "Error", "Please enter Mobile Number");
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  AppButton.outlineButton(
                      borderColor: loginMobileController.selectedRoleIndex == 0
                          ? AppColors.primary
                          : AppColors.primaryInvestor,
                      title: "Login With Google",
                      onButtonPressed: () async {
                        final user = await GoogleSignInService.signIn();
                        if (user != null) {
                          final GoogleSignInAuthentication auth =
                              await user.authentication;

                          loginMobileController.googleLogin(
                              context, user, auth);
                          var body = {
                            "credential": {
                              "displayName": user.displayName,
                              "email": user.email,
                              "id": user.id,
                              "photoURL": user.photoUrl
                            },
                          };
                          log(body.toString());
                        } else {
                          log("Login failed");
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
