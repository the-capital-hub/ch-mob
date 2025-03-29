import 'dart:convert';
import 'dart:developer' as log;
import 'package:capitalhub_crm/screen/01-Investor-Section/landingScreen/landing_screen_inv.dart';
import 'package:capitalhub_crm/screen/Auth-Process/authScreen/signup_otp_page.dart';
import 'package:capitalhub_crm/screen/Auth-Process/userDetailsScreen/username_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../screen/Auth-Process/authScreen/otp_page.dart';
import '../../screen/landingScreen/landing_screen.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/constant/app_var.dart';
import '../../utils/getStore/get_store.dart';
import '../../utils/helper/helper.dart';
import '../../utils/helper/helper_sncksbar.dart';
import '../../utils/notificationService/notification_service.dart';

class LoginController extends GetxController {
  final FirebaseNotificationService _firebaseNotificationService = Get.find();

  TextEditingController loginPhoneController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPassController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();
  final TextEditingController otpcontroller = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  String selectedIndustry = "";
  bool isLogin = true;
  String orderId = "";
  String? base64 = "";

  int selectedRoleIndex = -1;

  Future loginApiEmailPass(
    context,
  ) async {
    Helper.loader(context);
    String? fcmToken = await _firebaseNotificationService.getFcmToken();
    print("FCM Token in LoginController: $fcmToken");
    var body = {
      "phoneNumber": loginEmailController.text,
      "password": loginPassController.text,
      "fcmToken": fcmToken,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.loginUrlEmail, withToken: false);
    log.log(response.body);

    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      GetStoreData.storeUserData(
          id: data['data']['user']['_id'],
          name: data['data']['user']['firstName'] +
              " " +
              data['data']['user']['lastName'],
          email: data['data']['user']['email'],
          profileImage: data['data']['user']['profilePicture'],
          phone: data['data']['user']['phoneNumber'],
          isSubscribe: data['data']['user']['isSubscribed'],
          authToken: data['data']['token'],
          isInvestor: bool.parse(data['data']['user']['isInvestor']));
      await GetStoreDataList.storeUserList(
        UserModel(
          id: data['data']['user']['_id'],
          name: data['data']['user']['firstName'] +
              " " +
              data['data']['user']['lastName'],
          email: data['data']['user']['email'],
          profileImage: data['data']['user']['profilePicture'],
          phone: data['data']['user']['phoneNumber'],
          isSubscribe: data['data']['user']['isSubscribed'],
          authToken: data['data']['token'],
          isInvestor: bool.parse(data['data']['user']['isInvestor']),
        ),
      );

      if (GetStoreData.getStore.read('isInvestor') == false &&
          selectedRoleIndex == 0) {
        Get.offAll(const LandingScreen());
      } else if (GetStoreData.getStore.read('isInvestor') == true &&
          selectedRoleIndex == 1) {
        Get.offAll(const LandingScreenInvestor(),
            transition: Transition.fadeIn, duration: transDuration);
      } else {
        HelperSnackBar.snackBar("Error", "Choose a correct role");
      }
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  Future loginApiPhoneOTP(
    context,
  ) async {
    Helper.loader(context);
    var body = {
      "phoneNumber": "91${loginPhoneController.text}",
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.loginUrlPhone, withToken: false);
    log.log(response.body);

    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      orderId = data['data']['orderId'];
      Get.to(OtpPage());
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  // Future signupApi(context) async {
  //   Helper.loader(context);
  //   var body = {
  //     "phoneNumber": "+91${loginPhoneController.text}",
  //     "firstName": firstNameController.text,
  //     "lastName": lastNameController.text,
  //     "email": emailController.text,
  //     "company": companyNameController.text,
  //     "userName": userNameController.text,
  //     "isInvestor": selectedRoleIndex == 0 ? false : true,
  //     "industry": selectedIndustry,
  //     "designation": designationController.text,
  //     "gender": "",
  //     "linkedin": ""
  //   };
  //   var response = await ApiBase.postRequest(
  //       body: body, extendedURL: ApiUrl.signupUrl, withToken: false);
  //   log.log(response.body);
  //   var data = json.decode(response.body);
  //   if (data["status"] == true) {
  //     Get.back();
  //     loginApiPhoneOTP(context);
  //   } else {
  //     Get.back();
  //     HelperSnackBar.snackBar("Error", data["error"]);
  //     return "";
  //   }
  // }

  Future signupApi(context) async {
    Helper.loader(context);
    var body = {
      "phoneNumber": "+91${loginPhoneController.text}",
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.signupUrl, withToken: false);
    log.log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      orderId = data['data']['orderId'];
      Get.to(SignupOtpPage());
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  Future verifyOtpApi(context) async {
    Helper.loader(context);
    String? fcmToken = await _firebaseNotificationService.getFcmToken();
    print("FCM Token in LoginController: $fcmToken");
    var body = {
      "phoneNumber": "91${loginPhoneController.text}",
      "orderId": orderId,
      "otp": otpcontroller.text,
      "fcmToken": fcmToken,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.verifyOTPUrl, withToken: false);
    log.log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      GetStoreData.storeUserData(
          id: data['data']['user']['_id'],
          name: data['data']['user']['firstName'] +
              " " +
              data['data']['user']['lastName'],
          email: data['data']['user']['email'],
          profileImage: data['data']['user']['profilePicture'],
          isSubscribe: data['data']['user']['isSubscribed'],
          phone: data['data']['user']['phoneNumber'],
          authToken: data['data']['token'],
          isInvestor: bool.parse(data['data']['user']['isInvestor']));
      await GetStoreDataList.storeUserList(
        UserModel(
          id: data['data']['user']['_id'],
          name: data['data']['user']['firstName'] +
              " " +
              data['data']['user']['lastName'],
          email: data['data']['user']['email'],
          profileImage: data['data']['user']['profilePicture'],
          phone: data['data']['user']['phoneNumber'],
          authToken: data['data']['token'],
          isSubscribe: data['data']['user']['isSubscribed'],
          isInvestor: bool.parse(data['data']['user']['isInvestor']),
        ),
      );

      log.log(GetStoreData.getStore.read('access_token'));
      if (isLogin) {
        if (GetStoreData.getStore.read('isInvestor') == false &&
            selectedRoleIndex == 0) {
          Get.offAll(const LandingScreen());
        } else if (GetStoreData.getStore.read('isInvestor') == true &&
            selectedRoleIndex == 1) {
          Get.offAll(const LandingScreenInvestor(),
              transition: Transition.fadeIn, duration: transDuration);
        } else {
          HelperSnackBar.snackBar("Error", "Choose a correct role");
        }
      } else {
        //signup onboarding process
        log.log("message ok");
        HelperSnackBar.snackBar("Success", "Signup success");
        Get.offAll(() => const UserNameScreen());
      }
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"].toString());
      return "";
    }
  }

  Future verifySignupOtpApi(context) async {
    Helper.loader(context);
    String? fcmToken = await _firebaseNotificationService.getFcmToken();
    print("FCM Token in LoginController: $fcmToken");
    var body = {
      "phoneNumber": "91${loginPhoneController.text}",
      "orderId": orderId,
      "otp": otpcontroller.text,
      "isInvestor": selectedRoleIndex == 0 ? false : true,
      "profilePicture": base64,
      "fcmToken": fcmToken,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.verifyOtpForSignup, withToken: false);
    log.log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      GetStoreData.storeUserData(
          id: "",
          name: "",
          email: "",
          profileImage: data['data']['user']['profilePicture'],
          phone: data['data']['user']['phoneNumber'],
          authToken: data['data']['token'],
          isSubscribe: data['data']['user']['isSubscribed'],
          isInvestor: bool.parse(data['data']['user']['isInvestor']));
      await GetStoreDataList.storeUserList(
        UserModel(
          id: "",
          name: "",
          email: "",
          profileImage: data['data']['user']['profilePicture'],
          phone: data['data']['user']['phoneNumber'],
          authToken: data['data']['token'],
          isSubscribe: data['data']['user']['isSubscribed'],
          isInvestor: bool.parse(data['data']['user']['isInvestor']),
        ),
      );

      if (GetStoreData.getStore.read('isInvestor') == false &&
          selectedRoleIndex == 0) {
        Get.offAll(const LandingScreen());
      } else if (GetStoreData.getStore.read('isInvestor') == true &&
          selectedRoleIndex == 1) {
        Get.offAll(const LandingScreenInvestor(),
            transition: Transition.fadeIn, duration: transDuration);
      } else {
        HelperSnackBar.snackBar("Error", "Choose a correct role");
      }
      // } else {
      //   //signup onboarding process
      //   log.log("message ok");
      //   HelperSnackBar.snackBar("Success", "Signup success");
      //   Get.offAll(() => const UserNameScreen());
      // }
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"].toString());
      return "";
    }
  }

  Future<String> resendOTP(context) async {
    Helper.loader(context);
    var body = {
      "orderId": orderId,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.resendOTPUrl, withToken: false);
    log.log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);

      return data['data']['otp'].toString();
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  TextEditingController usernameController = TextEditingController();

  Future getUserByUsername(context) async {
    // Helper.loader(context);
    var body = {
      "username": usernameController.text,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.getUserByNameUrl, withToken: true);
    log.log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      // Get.back();
      HelperSnackBar.snackBar("Error", "User name alredy exist");
      return false;
    } else {
      // Get.back();
      return true;
    }
  }

  String profilePicBase64 = '';
  TextEditingController bioController = TextEditingController();

  Future<bool> updateFounder(context) async {
    Helper.loader(context);
    var body = {
      "userName": usernameController.text,
      "profilePicture": profilePicBase64,
      "bio": bioController.text
    };
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.updateFounderUrl, withToken: true);
    log.log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future googleLogin(context, GoogleSignInAccount user,
      GoogleSignInAuthentication auth) async {
    String? fcmToken = await _firebaseNotificationService.getFcmToken();
    print("FCM Token in LoginController: $fcmToken");
    var body = {
      "credential": {
        "email": user.email,
        "serverAuthCode": user.serverAuthCode
      },
      "fcmToken": fcmToken,
    };
    log.log(body.toString());

    log.log(auth.toString());

    var response = await ApiBase.postRequest(
      body: body,
      extendedURL: ApiUrl.googleLogin,
      withToken: false,
    );

    log.log("Response: ${response.body}");

    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      GetStoreData.storeUserData(
          id: data['data']['user']['_id'],
          name: data['data']['user']['firstName'] +
              " " +
              data['data']['user']['lastName'],
          email: data['data']['user']['email'],
          profileImage: data['data']['user']['profilePicture'],
          phone: data['data']['user']['phoneNumber'],
          authToken: data['data']['token'],
          isSubscribe: data['data']['user']['isSubscribed'],
          isInvestor: bool.parse(data['data']['user']['isInvestor']));
      await GetStoreDataList.storeUserList(
        UserModel(
          id: data['data']['user']['_id'],
          name: data['data']['user']['firstName'] +
              " " +
              data['data']['user']['lastName'],
          email: data['data']['user']['email'],
          profileImage: data['data']['user']['profilePicture'],
          phone: data['data']['user']['phoneNumber'],
          authToken: data['data']['token'],
          isSubscribe: data['data']['user']['isSubscribed'],
          isInvestor: bool.parse(data['data']['user']['isInvestor']),
        ),
      );
      log.log(GetStoreData.getStore.read('access_token'));
      if (GetStoreData.getStore.read('isInvestor') == false &&
          selectedRoleIndex == 0) {
        Get.offAll(const LandingScreen());
      } else if (GetStoreData.getStore.read('isInvestor') == true &&
          selectedRoleIndex == 1) {
        Get.offAll(const LandingScreenInvestor(),
            transition: Transition.fadeIn, duration: transDuration);
      } else {
        HelperSnackBar.snackBar("Error", "Choose a correct role");
      }
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
    }
  }

  List suggestions = [].obs;
  Future checkUsernameAvailability(userName) async {
    var body = {"userName": userName};
    log.log(body.toString());
    var response = await ApiBase.postRequest(
        body: body,
        extendedURL: ApiUrl.checkUsernameAvailability,
        withToken: true);
    log.log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      suggestions = List.from(data["suggestions"]);
      return true;
    } else {
      suggestions = List.from(data["suggestions"]);

      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future saveRequiredData(
    context,
  ) async {
    var body = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "userName": userNameController.text
    };
    log.log(body.toString());
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.saveRequiredData, withToken: true);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      GetStoreData.storeUserData(
          id: data['data']['_id'],
          name: data['data']['firstName'] + " " + data['data']['lastName'],
          email: data['data']['email'],
          isSubscribe: GetStoreData.getStore.read('isSubscribed'),
          profileImage: GetStoreData.getStore.read('profile_image'),
          phone: GetStoreData.getStore.read('phone'),
          authToken: GetStoreData.getStore.read('access_token'),
          isInvestor: GetStoreData.getStore.read('isInvestor'));
      await GetStoreDataList.storeUserList(
        UserModel(
            id: data['data']['_id'],
            name: data['data']['firstName'] + " " + data['data']['lastName'],
            email: data['data']['email'],
            isSubscribe: GetStoreData.getStore.read('isSubscribed'),
            profileImage: GetStoreData.getStore.read('profile_image'),
            phone: GetStoreData.getStore.read('phone'),
            authToken: GetStoreData.getStore.read('access_token'),
            isInvestor: GetStoreData.getStore.read('isInvestor')),
      );

      if (GetStoreData.getStore.read('isInvestor') == false) {
        Get.offAll(const LandingScreen());
      } else if (GetStoreData.getStore.read('isInvestor') == true) {
        Get.offAll(const LandingScreenInvestor(),
            transition: Transition.fadeIn, duration: transDuration);
      } else {
        HelperSnackBar.snackBar("Error", "Choose a correct role");
      }
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);

      return false;
    }
  }

  // var imageBase64 = "".obs;
  // final ImagePicker _picker = ImagePicker();
  // XFile? image;

  // Future<void> openCameraGallery({required bool isCamera}) async {

  //   var tempimage = await _picker.pickImage(
  //       source: isCamera ? ImageSource.camera : ImageSource.gallery);
  //   if (tempimage != null) {
  //     // File f = new File(tempimage.path);
  //     // var s = f.lengthSync();
  //     // var fileSizeInKB = s / 2048;
  //     // if (fileSizeInKB > fileSizeLimit) {
  //     //   HelperSnackBar.snackBar("Error", "Please select under 2 mb");
  //     // } else {
  //     image = tempimage;
  //     File file = File(image!.path);
  //     List<int> fileInByte = file.readAsBytesSync();
  //     String fileInBase64 = base64Encode(fileInByte);
  //     imageBase64.value = "data:image/jpeg;base64,$fileInBase64";
  //     // }
  //   }
  //   // Get.back();
  //   update();
  // }
}
