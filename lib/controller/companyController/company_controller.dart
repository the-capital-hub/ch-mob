import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../model/01-StartupModel/companyModel/company_model.dart';
import '../../model/01-StartupModel/companyModel/company_search_moel.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../utils/getStore/get_store.dart';
import '../../utils/helper/helper.dart';
import '../../utils/helper/helper_sncksbar.dart';

class CompanyController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingList = false.obs;
  List<CompanyList> companyList = [];

  Future<List<CompanyList>> getCompanyList(String query) async {
    try {
      companyList.clear();
      isLoadingList.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.searchCompany + query);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        CompanySearchModel companySearchModel =
            CompanySearchModel.fromJson(data);
        companyList.addAll(companySearchModel.data!);
        return companyList;
      } else {
        return companyList;
      }
    } catch (e) {
      log("getCompList $e");
      return companyList;
    } finally {
      isLoadingList.value = false;
    }
  }

  Future addCompanyToUser(context, id) async {
    var body = {
      "userId": "${GetStoreData.getStore.read('id')}",
      "startUpId": id
    };
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.addCompanyUser, withToken: true);
    log(response.body);

    var data = json.decode(response.body);
    if (data["status"]) {
      getCompanyDetail();
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  CompanyData companyData = CompanyData();
  var isCompanyFound = false.obs;
  Future getCompanyDetail() async {
    try {
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getCompanyDetail+GetStoreData.getStore.read('id').toString());
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        isCompanyFound.value = true;
        CompanyModel companyModel = CompanyModel.fromJson(data);
        companyData = companyModel.data!;
      } else {
        isCompanyFound.value = false;
      }
    } catch (e) {
      log("getCompany $e");
      return companyList;
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteCompany(context, id) async {
    var body = {"startUpId": id};
    var response = await ApiBase.putRequest(
      body: body,
      extendedURL: ApiUrl.deleteCompany,
    );
    log(response.body);

    var data = json.decode(response.body);
    if (data["status"]) {
      getCompanyDetail();
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

//add company
  String base64 = "";
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyTaglineController = TextEditingController();
  TextEditingController companyLocationController = TextEditingController();
  TextEditingController establishedDateController = TextEditingController();
  String? selectedSector;

  TextEditingController numOfEmpController = TextEditingController();
  TextEditingController websiteUrlController = TextEditingController();
  TextEditingController visionController = TextEditingController();
  TextEditingController missionController = TextEditingController();
  TextEditingController keyFocusController = TextEditingController();
  TextEditingController tamController = TextEditingController();
  TextEditingController samController = TextEditingController();
  TextEditingController somController = TextEditingController();
  TextEditingController lastFundingDateController = TextEditingController();

  String? selectedInvestmentStage;
  String? selectedProductStage;

  TextEditingController linkedInLinkController = TextEditingController();
  TextEditingController twitterLinkController = TextEditingController();
  TextEditingController instagramLinkController = TextEditingController();

  TextEditingController companyDescriptionController = TextEditingController();

  TextEditingController totalInvestmentController = TextEditingController();
  TextEditingController noOfInvestorController = TextEditingController();
  TextEditingController valuationController = TextEditingController();

  TextEditingController fundAskController = TextEditingController();
  TextEditingController currentValuationController = TextEditingController();
  TextEditingController fundRaisedController = TextEditingController();

  TextEditingController lastYearRevenueController = TextEditingController();
  TextEditingController targetController = TextEditingController();

  List<CoreTeamModel> coreTeamList = [];

  Future createCompany() async {
    var body = {
      "logo": base64,
      "company": companyNameController.text,
      "tagline": companyTaglineController.text,
      "location": companyLocationController.text,
      "startedAtDate": establishedDateController.text,
      "sector": selectedSector,
      "noOfEmployees": numOfEmpController.text,
      "vision": visionController.text,
      "mission": missionController.text,
      "keyFocus": keyFocusController.text,
      "TAM": tamController.text,
      "SAM": samController.text,
      "SOM": somController.text,
      "lastFunding": lastFundingDateController.text,
      "productStage": selectedProductStage,
      "stage": selectedInvestmentStage,
      "socialLinks": {
        "website": websiteUrlController.text,
        "linkedin": linkedInLinkController.text,
        "twitter": twitterLinkController.text,
        "instagram": instagramLinkController.text
      },
      "description": companyDescriptionController.text,
      "team": coreTeamList,
      "colorCard": {
        "last_round_investment": valuationController.text,
        "total_investment": totalInvestmentController.text,
        "no_of_investers": noOfInvestorController.text,
        "fund_ask": fundAskController.text,
        "valuation": currentValuationController.text,
        "raised_funds": fundRaisedController.text,
        "last_year_revenue": lastYearRevenueController.text,
        "target": targetController.text
      }
    };
    var response = await ApiBase.postRequest(
      body: body,
      withToken: true,
      extendedURL: ApiUrl.createCompany,
    );
    log(response.body);

    var data = json.decode(response.body);
    if (data["status"]) {
      isCompanyFound.value = true;
      CompanyModel companyModel = CompanyModel.fromJson(data);
      companyData = companyModel.data!;
      Get.back(closeOverlays: true);
      Get.back();
      return true;
    } else {
      Get.back(closeOverlays: true);
      HelperSnackBar.snackBar("Error", data["message"]);

      return false;
    }
  }
}

class CoreTeamModel {
  CoreTeamModel(
      {required this.image, required this.name, required this.designaiton});
  TextEditingController? image;
  TextEditingController? name;
  TextEditingController? designaiton;

  Map<String, dynamic> toJson() {
    return {
      'image': image?.text ?? '',
      'name': name?.text ?? '',
      'designation': designaiton?.text ?? '',
    };
  }
}
