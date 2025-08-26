import 'package:capitalhub_crm/widget/bottomSheet/create_post_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../model/companyModel/all_affilated_member.dart';
import '../../model/companyModel/company_model.dart';
import '../../model/companyModel/company_search_moel.dart';
import '../../model/companyModel/get_affilation_request_model.dart';
import '../../model/companyModel/get_team_member.dart';
import '../../model/companyModel/search_user_model.dart';
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
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getCompanyDetailInv +
              GetStoreData.getStore.read('id').toString());
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        isCompanyFound.value = true;
      } else {
        isCompanyFound.value = false;
      }
    } catch (e) {
      log("getCompany $e");
    } finally {}
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
  String? image;

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

  // List<CoreTeamModel> coreTeamList = [];

  Future createCompany() async {
    var body = {
      if (base64 != "") "logo": base64,
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
      // "team": coreTeamList,
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

  Future fillData() async {
    image = companyData.logo!;
    companyNameController.text = companyData.name!;
    companyTaglineController.text = companyData.tagline!;
    companyLocationController.text = companyData.location!;
    establishedDateController.text = companyData.foundingDate!;
    selectedSector = companyData.sector;
    numOfEmpController.text = companyData.numberOfEmployees!;
    websiteUrlController.text = companyData.socialLinks!
        .firstWhere(
          (val) => val.name == "website",
        )
        .link!;
    visionController.text = companyData.vision!;
    missionController.text = companyData.mission!;
    keyFocusController.text =
        companyData.keyFocus.toString().replaceAll("[", "").replaceAll("]", "");
    tamController.text = companyData.tam!;
    samController.text = companyData.sam!;
    somController.text = companyData.som!;
    lastFundingDateController.text = companyData.lastFunding!;
    selectedInvestmentStage = companyData.stage!;
    selectedProductStage = null;
    linkedInLinkController.text = companyData.socialLinks!
        .firstWhere(
          (val) => val.name == "linkedin",
        )
        .link!;
    twitterLinkController.text = companyData.socialLinks!
        .firstWhere(
          (val) => val.name == "twitter",
        )
        .link!;
    instagramLinkController.text = companyData.socialLinks!
        .firstWhere(
          (val) => val.name == "instagram",
        )
        .link!;
    companyDescriptionController.text = companyData.description!;
    totalInvestmentController.text = companyData.totalInvestment!;
    noOfInvestorController.text = companyData.noOfInvesters!;
    valuationController.text = companyData.valuation!;
    fundAskController.text = companyData.fundAsk!;
    currentValuationController.text = companyData.valuation!;
    fundRaisedController.text = companyData.raisedFunds!;
    lastYearRevenueController.text = companyData.lastYearRevenue!;
    targetController.text = companyData.target!;
    // coreTeamList = (companyData.team ?? [])
    //     .map((team) => CoreTeamModel.fromTeam(team))
    //     .toList();
  }
  Future clearData() async {
    image = null;
    companyNameController.clear();
    companyTaglineController.clear();
    companyLocationController.clear();
    establishedDateController.clear();
    selectedSector = null;
    numOfEmpController.clear();

    websiteUrlController.clear();
    visionController.clear();
    missionController.clear();
    keyFocusController.clear();
    tamController.clear();
    samController.clear();
    somController.clear();
    lastFundingDateController.clear();
    selectedInvestmentStage = null;
    selectedProductStage = null;
    linkedInLinkController.clear();
    twitterLinkController.clear();
    instagramLinkController.clear();
    companyDescriptionController.clear();
    totalInvestmentController.clear();
    noOfInvestorController.clear();
    valuationController.clear();
    fundAskController.clear();
    currentValuationController.clear();
    fundRaisedController.clear();
    lastYearRevenueController.clear();
    targetController.clear();
  }

  TextEditingController roleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  bool currentWorking = false;
  Future addAffilatedRequest(startupId) async {
    var body = {
      "role": roleController.text,
      "description": descriptionController.text,
      "startDate": startDateController.text,
      "endDate": endDateController.text,
      "currentWorking": currentWorking,
      "startUpId": startupId,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.sendAffilationReq, withToken: true);
    log(response.body);

    var data = json.decode(response.body);
    Get.back(closeOverlays: true);
    Get.back();
    if (data["status"]) {
      roleController.clear();
      descriptionController.clear();
      startDateController.clear();
      endDateController.clear();
      currentWorking = false;
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future updateAffilatedRequest(
      {required String requestId,
      required String startupId,
      required String status}) async {
    var body = {
      "requestId": requestId,
      "startUpId": startupId,
      "status": status,
    };
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.updateAffilationReq, withToken: true);
    log(response.body);

    var data = json.decode(response.body);
    Get.back();
    if (data["status"]) {
      roleController.clear();
      descriptionController.clear();
      startDateController.clear();
      endDateController.clear();
      currentWorking = false;
      isLoading.value = true;
      await getAffilatedRequest().then((v) {
        isLoading.value = false;
      });
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  AffilationReqData affilationReqData = AffilationReqData();
  Future getAffilatedRequest() async {
    try {
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getMemberAffilationReq);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        GetAffilationRequestModel getAffilationRequestModel =
            GetAffilationRequestModel.fromJson(data);
        affilationReqData = getAffilationRequestModel.data!;
      } else {}
    } catch (e) {
      log("getAffilatedrequest: $e");
      return companyList;
    } finally {}
  }

  List<UserData> userData = [];
  var isUserLoading = false.obs;
  Future searchUsers(query) async {
    try {
      isUserLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.searchUser + query);
      log(response.body);
      userData.clear();
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        SearchUserModel searchUserModel = SearchUserModel.fromJson(data);
        userData.addAll(searchUserModel.data!);
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
      }
    } catch (e) {
      log("getsearch: $e");
      return false;
    } finally {
      isUserLoading.value = false;
    }
  }

  Future addTeamMember({required String role, required String userId}) async {
    var body = {
      "role": role,
      "userId": userId,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.addTeamMember, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    Get.back(closeOverlays: true);
    Get.back();
    if (data["status"]) {
      await getTeamMember();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  var isTeamLoading = false.obs;
  RxList<TeamMember> teamMember = <TeamMember>[].obs;
  Future getTeamMember() async {
    try {
      isTeamLoading.value = true;
      teamMember.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getTeamMember);
      log(response.body);

      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        GetTeamMemberModel getTeamMemberModel =
            GetTeamMemberModel.fromJson(data);
        teamMember.addAll(getTeamMemberModel.data!);
      }
    } catch (e) {
      log("getTeam member: $e");
      return false;
    } finally {
      isTeamLoading.value = false;
    }
  }

  Future removeTeamMember({required String userId}) async {
    var body = {
      "userId": userId,
    };
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.removeTeamMember, withToken: true);
    log(response.body);
    var data = json.decode(response.body);

    if (data["status"]) {
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}

// class CoreTeamModel {
//   CoreTeamModel(
//       {required this.image, required this.name, required this.designaiton});
//   TextEditingController? image;
//   TextEditingController? name;
//   TextEditingController? designaiton;

//   Map<String, dynamic> toJson() {
//     return {
//       'image': image?.text ?? '',
//       'name': name?.text ?? '',
//       'designation': designaiton?.text ?? '',
//     };
//   }

//   // ✅ Add this method to convert a Team model to CoreTeamModel
//   factory CoreTeamModel.fromTeam(Team team) {
//     return CoreTeamModel(
//       image: TextEditingController(text: team.image),
//       name: TextEditingController(text: team.name),
//       designaiton: TextEditingController(text: team.designation),
//     );
//   }
// }
