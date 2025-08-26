import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../model/newsModel/news_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';

class NewsController extends GetxController {
  RxBool isLoading = false.obs;

  List<NewsData> newsList = [];

  Future getNewsList() async {
    try {
      newsList.clear();
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getNewsByDateUrl);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        NewsModel newsModel = NewsModel.fromJson(data);
        newsList.addAll(newsModel.data!);
        log("lenght   "+newsList.length.toString());
      }
    } catch (e) {
      log("getnews list $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future getTodaysNews() async {
    try {
      newsList.clear();
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getTodaysNewsUrl);
      // log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        NewsModel newsModel = NewsModel.fromJson(data);
        newsList.addAll(newsModel.data!);
        log("lenght   "+newsList.length.toString());
      }
    } catch (e) {
      log("getnews list $e");
    } finally {
      isLoading.value = false;
    }
  }
}
