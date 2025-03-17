import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../model/01-StartupModel/exploreModel/explore_filter_model.dart';
import '../../model/01-StartupModel/exploreModel/explore_founder_model.dart';
import '../../model/01-StartupModel/exploreModel/explore_investor_model.dart';
import '../../model/01-StartupModel/exploreModel/explore_startup_model.dart';
import '../../model/01-StartupModel/exploreModel/explore_vc_details_model.dart';
import '../../model/01-StartupModel/exploreModel/explore_vc_model.dart';
import '../../model/01-StartupModel/exploreModel/get_campaignList_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper.dart';
import '../../utils/helper/helper_sncksbar.dart';

class ExploreController extends GetxController {
  late TabController tabController;
  var isLoading = true.obs;
  String selectedType = "";

  TextEditingController searchFilterController = TextEditingController();
  String? selectedSectore;
  String? selectedCity;
  String? selectedEmployeeSize;
  String? selectedFundingRaise;
  String? selectedStartupStage;
  String? selectedInvestmentStage;
  String? selectedAgeOfStartup;
  String? selectedGender;
  String? selectedYearOfExp;
  String? selectedInvestmentSize;
  cleaarFilter() {
    selectedSectore = null;
    selectedCity = null;
    selectedEmployeeSize = null;
    selectedFundingRaise = null;
    selectedStartupStage = null;
    selectedInvestmentStage = null;
    selectedAgeOfStartup = null;
    selectedGender = null;
    selectedYearOfExp = null;
    selectedInvestmentSize = null;
    searchFilterController.clear();
  }

  List<StartupExplore> startupExploreList = [];
  List<FounderExplore> founderExploreList = [];
  List<InvestorExplore> investorExploreList = [];
  List<VcDetail> vcExploreList = [];
  Future getExploreCollection() async {
    try {
      isLoading.value = true;
      var response = await ApiBase.getRequest(
          extendedURL:
              "${ApiUrl.exploreUrl}type=$selectedType&sector=${selectedSectore ?? ""}&gender=${selectedGender ?? ""}&city=${selectedCity ?? ""}&size=${selectedEmployeeSize ?? ""}&fundingRaised=${selectedFundingRaise ?? ""}&age=${selectedAgeOfStartup ?? ""}&stage=${selectedStartupStage ?? ""}&yearsOfExperience=${selectedYearOfExp ?? ""}&investmentSize=${selectedInvestmentSize ?? ""}&investmentStage=${selectedInvestmentStage ?? ""}&searchQuery=${searchFilterController.text}");
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        if (tabController.index == 0) {
          startupExploreList.clear();
          ExploreStartupModel exploreStartupModel =
              ExploreStartupModel.fromJson(data);
          startupExploreList.addAll(exploreStartupModel.data!);
        } else if (tabController.index == 1) {
          founderExploreList.clear();
          ExploreFounderModel exploreFounderModel =
              ExploreFounderModel.fromJson(data);
          founderExploreList.addAll(exploreFounderModel.data!);
        } else if (tabController.index == 2) {
          investorExploreList.clear();
          ExploreInvestorModel exploreInvestorModel =
              ExploreInvestorModel.fromJson(data);
          investorExploreList.addAll(exploreInvestorModel.data!);
        } else {
          vcExploreList.clear();
          ExploreVcModel exploreVcDetailsModel = ExploreVcModel.fromJson(data);
          vcExploreList.addAll(exploreVcDetailsModel.data!);
        }
      }
    } catch (e) {
      log("getcollection $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<String> cityList = [];
  Future getExploreFilterCollection() async {
    try {
      cityList.clear();
      isLoading.value = true;
      var response = await ApiBase.getRequest(
          extendedURL: "${ApiUrl.exploreFilterUrl}$selectedType");
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        ExploreFilterModel exploreFilterModel =
            ExploreFilterModel.fromJson(data);
        cityList.addAll(exploreFilterModel.data!.cities!);
        log(cityList.toString());
      }
    } catch (e) {
      log("getcollection $e");
    } finally {
      isLoading.value = false;
    }
  }

  VCData vcDetails = VCData();
  Future vcDeatilPost(context, {required String vcId}) async {
    isLoading.value = true;
    try {
      var body = {"vcId": vcId};
      var response = await ApiBase.postRequest(
          body: body, extendedURL: ApiUrl.vcsUrl, withToken: true);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        ExploreVcDetailsModel exploreVcDetailsModel =
            ExploreVcDetailsModel.fromJson(data);
        vcDetails = exploreVcDetailsModel.data!;
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {
      isLoading.value = false;
    }
  }

  var isButtonLoading = false.obs;
  Future intrestedUnintrestedPost({required String id}) async {
    try {
      isButtonLoading.value = true;
      var body = {
        "companyId": id,
      };
      var response = await ApiBase.pachRequest(
          body: body, extendedURL: ApiUrl.toggleIntrestInvUrl, withToken: true);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {
      isButtonLoading.value = false;
    }
  }

  Future onelinkSent({required String id}) async {
    try {
      isButtonLoading.value = true;
      var body = {
        "startUpId": id,
      };
      var response = await ApiBase.postRequest(
          body: body, extendedURL: ApiUrl.onelinkSentUrl, withToken: true);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {
      isButtonLoading.value = false;
    }
  }

  var isListLoading = false.obs;
  List<CampaignList> campaignLists = [];
  Future getCampaignLists() async {
    try {
      isListLoading.value = true;
      campaignLists.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getCampaignUrl);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        GetCampaignListModel getCampaignListModel =
            GetCampaignListModel.fromJson(data);

        campaignLists.addAll(getCampaignListModel.data!);
      }
    } catch (e) {
      log("getCamp List $e");
    } finally {
      isListLoading.value = false;
    }
  }

  Future createCampaignList({
    String? listId,
    String? listName,
    required List<String> selectedInvId,
  }) async {
    try {
      var body = {
        if (listName != null) "list_name": listName,
        if (listId != null) "list_id": listId,
        "investors": selectedInvId
      };
      var response = await ApiBase.postRequest(
          body: body, extendedURL: ApiUrl.createCampaignUrl, withToken: true);
      log(response.body);
      var data = json.decode(response.body);

      if (data["status"] == true) {
        // HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        // HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {}
  }
}
