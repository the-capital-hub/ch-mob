import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyStartupsController extends GetxController {
  var isLoading = false.obs;
  String base64 = "";
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyDescriptionController = TextEditingController();
  TextEditingController equityController = TextEditingController();
}