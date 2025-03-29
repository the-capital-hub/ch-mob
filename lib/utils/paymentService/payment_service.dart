import 'dart:developer';

import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:get/get.dart';

class CashFreePaymentService {
  final CFPaymentGatewayService _cfPaymentGatewayService =
      CFPaymentGatewayService();

  CashFreePaymentService() {
    _cfPaymentGatewayService.setCallback(_verifyPayment, _onError);
  }

  void _verifyPayment(String orderId) {
    log("Verify Payment: $orderId");
    GetStoreData.storeUserData(
        id: GetStoreData.getStore.read('id'),
        name: GetStoreData.getStore.read('name'),
        email: GetStoreData.getStore.read('email'),
        isSubscribe: true,
        profileImage: GetStoreData.getStore.read('profile_image'),
        phone: GetStoreData.getStore.read('phone'),
        authToken: GetStoreData.getStore.read('access_token'),
        isInvestor: GetStoreData.getStore.read('isInvestor'));
    Get.back();
  }

  void _onError(CFErrorResponse errorResponse, String orderId) {
    log("Payment Error: ${errorResponse.getMessage()}");
  }

  Future<CFSession?> _createSession(
      String orderId, String paymentSessionId) async {
    try {
      return CFSessionBuilder()
          .setEnvironment(CFEnvironment.SANDBOX)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();
    } on CFException catch (e) {
      print("Session Error: ${e.message}");
      return null;
    }
  }

  Future<void> pay(String orderId, String paymentSessionId) async {
    try {
      var session = await _createSession(orderId, paymentSessionId);
      if (session == null) return;

      var paymentComponent =
          CFPaymentComponentBuilder().setComponents(<CFPaymentModes>[]).build();

      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#FF620E")
          .setPrimaryFont("Sans-Serif")
          .setSecondaryFont("Sans-Serif")
          .build();

      var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
          .setSession(session)
          .setPaymentComponent(paymentComponent)
          .setTheme(theme)
          .build();

      _cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
    } on CFException catch (e) {
      print("Payment Exception: ${e.message}");
    }
  }
}
