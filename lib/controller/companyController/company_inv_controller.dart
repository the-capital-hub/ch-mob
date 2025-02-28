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
import '../../utils/helper/helper_sncksbar.dart';

// all model are commanly used in investor and startup
//in case of changes in response make it carefully
class CompanyInvController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingList = false.obs;
  List<CompanyList> companyList = [];

  Future<List<CompanyList>> getCompanyList(String query) async {
    try {
      companyList.clear();
      isLoadingList.value = true;
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.searchCompanyInv + query);
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
      "investorId": id
    };
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.addCompanyUserInv, withToken: true);
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
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getCompanyDetailInv +
              GetStoreData.getStore.read('id').toString());
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

  Future deleteCompany(context) async {
    var response = await ApiBase.deleteRequest(
      extendedURL: ApiUrl.deleteCompanyInv,
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

  String? selectedInvestmentStage;
  String? selectedProductStage;
  String? image;

  TextEditingController linkedInLinkController = TextEditingController();
  TextEditingController twitterLinkController = TextEditingController();
  TextEditingController instagramLinkController = TextEditingController();
  TextEditingController companyDescriptionController = TextEditingController();
  List<CoreTeamModel> coreTeamList = [];

  Future createCompany() async {
    var body = {
      if (base64 != "") "logo": base64,
      "companyName": companyNameController.text,
      "tagline": companyTaglineController.text,
      "location": companyLocationController.text,
      "startedAtDate": establishedDateController.text,
      "sector": selectedSector,
      "noOfEmployees": numOfEmpController.text,
      "vision": visionController.text,
      "mission": missionController.text,
      "keyFocus": keyFocusController.text,
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
    };
    var response = await ApiBase.postRequest(
      body: body,
      withToken: true,
      extendedURL: ApiUrl.createCompanyInv,
    );
    log(json.encode(body).toString());
    log(response.body.toString());
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
        .firstWhere((val) => val.name == "website")
        .link!;
    visionController.text = companyData.vision!;
    missionController.text = companyData.mission!;
    keyFocusController.text =
        companyData.keyFocus.toString().replaceAll("[", "").replaceAll("]", "");
    selectedInvestmentStage = companyData.stage!;
    selectedProductStage = null;
    linkedInLinkController.text = companyData.socialLinks
            ?.firstWhereOrNull((val) => val.name == "linkedin")
            ?.link ??
        "";
    twitterLinkController.text = companyData.socialLinks
            ?.firstWhereOrNull((val) => val.name == "twitter")
            ?.link ??
        "";
    instagramLinkController.text = companyData.socialLinks
            ?.firstWhereOrNull((val) => val.name == "instagram")
            ?.link ??
        "";
    companyDescriptionController.text = companyData.description!;
    coreTeamList = (companyData.team ?? [])
        .map((team) => CoreTeamModel.fromTeam(team))
        .toList();
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

  factory CoreTeamModel.fromTeam(Team team) {
    return CoreTeamModel(
      image: TextEditingController(text: team.image),
      name: TextEditingController(text: team.name),
      designaiton: TextEditingController(text: team.designation),
    );
  }
}
