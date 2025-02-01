// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:http/http.dart' as http;
import '../../utils/getStore/get_store.dart';

class ApiBase {
  static Map<String, String> withOutTokenHeaders = {
    'Content-Type': 'application/json',
  };

  static Map<String, String> getRequestHeaders() {
    var requestHeaders = {
      'Content-Type': 'application/json',
      "authorization": "Bearer ${GetStoreData.getStore.read('access_token')}",
      
    };
    return requestHeaders;
  }

  static Uri url({
    required String extendedURL,
  }) {
    log('full url ${ApiUrl.baseUrl}$extendedURL');
    return Uri.parse(ApiUrl.baseUrl + extendedURL);
  }

  static Future getRequest({
    required String extendedURL,
  }) async {
    final client = http.Client();
    var response = await client.get(
      url(extendedURL: extendedURL),
      headers: GetStoreData.getStore.read('access_token') != null
          ? getRequestHeaders()
          : withOutTokenHeaders,
    );

    if (response.statusCode == 403) {
      // logout();
    }
    return response;
  }

  static Future postRequest({
    required String extendedURL,
    required Object body,
    required bool withToken,
  }) async {
    // log("body " + jsonEncode(body));
    final client = http.Client();

    var response = await client.post(url(extendedURL: extendedURL),
        headers: withToken ? getRequestHeaders() : withOutTokenHeaders,
        body: jsonEncode(body));
    if (response.statusCode == 403) {
      // logout();
    }
    return response;
  }

  static Future pachRequest({
    required String extendedURL,
    required Object body,
    required bool withToken,
  }) async {
    log("body " + jsonEncode(body));
    final client = http.Client();

    var response = await client.patch(url(extendedURL: extendedURL),
        headers: withToken ? getRequestHeaders() : withOutTokenHeaders,
        body: jsonEncode(body));
    if (response.statusCode == 403) {
      // logout();
    }
    return response;
  }

  static Future putRequest({
    required String extendedURL,
    required Object body,
  }) async {
    log("putRequest ${jsonEncode(body)}");
    final client = http.Client();

    return client.put(url(extendedURL: extendedURL),
        headers: getRequestHeaders(), body: jsonEncode(body));
  }

  static Future deleteRequest({
    required String extendedURL,
  }) async {
    final client = http.Client();
    return client.delete(
      url(extendedURL: extendedURL),
      headers: getRequestHeaders(),
    );
  }
}
