import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../model/paymentTransactionModel/payment_transaction_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';

class PaymentTransactionsController extends GetxController {
  RxBool isLoading = false.obs;

  PaymentData paymentData = PaymentData();

  Future getPaymentList() async {
    try {   
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.paymentListing);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        PaymentTransactionModel paymentTransactionModel =
            PaymentTransactionModel.fromJson(data);
        paymentData = paymentTransactionModel.data!;
      }
    } catch (e) {
      log("get payment transaction list $e");
    } finally {
      isLoading.value = false;
    }
  }
}
