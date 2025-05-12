import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/screen/spotlLightScreen/spotlight_landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/companyModel/search_user_model.dart';
import '../../model/spotlightModel/spotlight_productDetail_model.dart';
import '../../model/spotlightModel/spotlight_productlist_model.dart';
import '../../model/spotlightModel/spotlight_request_model.dart';
import '../../model/spotlightModel/spotlight_user_existing_product_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper_sncksbar.dart';

class SpotlightController extends GetxController {
  var isLoading = false.obs;
  var isDetailLoading = false.obs;
//add spotlight
  TextEditingController productNameController = TextEditingController();
  TextEditingController taglineController = TextEditingController();
  TextEditingController aboutCompanyController = TextEditingController();
  TextEditingController firstCommentController = TextEditingController();
  TextEditingController productUrlController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();
  List<TextEditingController> tagsControllers = [];
  List<TextEditingController> corevaluePropositionControllers = [];
  String? base64ImageLogo;
  String? base64ImageBanner;
  List<String> productBase64Images = [];
  List<UserData> selectedUsers = [];
  String selectedOption = 'Free';
  final List<String> pricingOptions = ['Free', 'Paid', 'Trial Available'];
  TextEditingController amountController = TextEditingController();
  TextEditingController promocodeController = TextEditingController();
  String? selectIndustry;
  String amountType = 'One-Time';
  String fundingStageType = 'Idea';
  String? selectedProductId;
  Future addProduct() async {
    var body = {
      "existingProductId": selectedProductId,
      "title": productNameController.text,
      "tagline": taglineController.text,
      "socialLinks": {
        "website": productUrlController.text,
        "twitter": twitterController.text,
        "instagram": instagramController.text,
        "linkedin": linkedInController.text
      },
      "aboutCompany": aboutCompanyController.text,
      "tags": tagsControllers.map((e) => e.text).toList(),
      "coreValueProposition":
          corevaluePropositionControllers.map((e) => e.text).toList(),
      if (firstCommentController.text.isNotEmpty)
        "firstComment": firstCommentController.text,
      if (base64ImageLogo != null) "logo": base64ImageLogo,
      if (base64ImageBanner != null) "banner": base64ImageBanner,
      "productImages": productBase64Images,
      "makers": selectedUsers.map((e) => e.userId).toList(),
      "pricing": selectedOption, // Free, Paid, Trial
      "priceAmount": selectedOption != "Free" ? amountController.text : "",
      "priceType": amountType
          .toString()
          .capitalizeFirst, // "One-time", "Monthly", "Yearly"
      "promoCode": promocodeController.text,
      "stage": fundingStageType, // "Idea", "Pre-Seed", "Seed", "Growth
      "industry": selectIndustry
    };
    log(body.toString());
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.addSpotLightProduct, withToken: true);
    Get.back();
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      Get.back();
      Get.back();
      await getSpotlightProductList(stage: "All", industry: "All", type: "all");
      clearData();
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  String logo = "";
  String banner = "";
  void populateProductData(ExistingProduct selectedProduct) {
    // Text controllers
    productNameController.text = selectedProduct.title ?? '';
    taglineController.text = selectedProduct.tagline ?? '';
    aboutCompanyController.text = selectedProduct.aboutCompany ?? '';
    firstCommentController.text = selectedProduct.firstComment ?? '';
    productUrlController.text = selectedProduct.productLink ?? '';
    twitterController.text = selectedProduct.twitterLink ?? '';
    instagramController.text = selectedProduct.instagramLink ?? '';
    linkedInController.text = selectedProduct.linkedinLink ?? '';

    // Tags
    tagsControllers.clear();
    if (selectedProduct.tags != null) {
      for (var tag in selectedProduct.tags!) {
        tagsControllers.add(TextEditingController(text: tag));
      }
    }

    // Core Value Propositions
    corevaluePropositionControllers.clear();
    if (selectedProduct.coreValueProposition != null) {
      for (var value in selectedProduct.coreValueProposition!) {
        corevaluePropositionControllers.add(TextEditingController(text: value));
      }
    }

    // Image URLs (Base64 if needed)
    logo = selectedProduct.logo!;
    banner = selectedProduct.banner!;
    productBase64Images = selectedProduct.productImages ?? [];

    // Team
    selectedUsers = selectedProduct.team
            ?.map((teamMember) => UserData(
                  userId: teamMember.id,
                  firstName: teamMember.firstName,
                  lastName: teamMember.lastName,
                  profilePicture: teamMember.profilePicture,
                ))
            .toList() ??
        [];

    // Pricing
    selectedOption = selectedProduct.pricing ?? 'Free';
    amountController.text = selectedProduct.priceAmount?.toString() ?? '';
    promocodeController.text = selectedProduct.promoCode ?? '';
    amountType = selectedProduct.priceType ?? 'One-time';

    // Others
    selectIndustry = selectedProduct.industry;
    fundingStageType = selectedProduct.stage ?? 'Idea';
    selectedProductId = selectedProduct.existingProductId;
  }

  clearData() {
    selectedProductId = null;
    productNameController.clear();
    taglineController.clear();
    aboutCompanyController.clear();
    firstCommentController.clear();
    productUrlController.clear();
    twitterController.clear();
    instagramController.clear();
    linkedInController.clear();
    tagsControllers.clear();
    selectIndustry = null;
    corevaluePropositionControllers.clear();
    base64ImageLogo = null;
    base64ImageBanner = null;
    productBase64Images.clear();
    selectedUsers.clear();
    selectedOption = 'Free';
    amountController.clear();
    promocodeController.clear();
    amountType = 'One-Time';
    fundingStageType = 'Idea';
  }

  SpotlightData spotlightData = SpotlightData(products: []);

  Future getSpotlightProductList({
    required String stage,
    required String industry,
    required String type,
  }) async {
    try {
      isLoading.value = true;
      var response = await ApiBase.getRequest(
          extendedURL:
              "${ApiUrl.spotLightlistUrl}stage=$stage&industry=$industry&type=$type");
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        SpotlightProductListModel spotlightProductListModel =
            SpotlightProductListModel.fromJson(data);
        spotlightData = spotlightProductListModel.data!;
      }
    } catch (e) {
      log("getproduct list $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<ExistingProduct> userProduct = [];
  Future getUserProductList() async {
    try {
      isLoading.value = true;
      userProduct.clear();
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.spotLightUserProductlistUrl);
      var data = jsonDecode(response.body);
      log(response.body);
      if (data['status'] == true) {
        UserExistingProductModel userExistingProductModel =
            UserExistingProductModel.fromJson(data);
        userProduct.addAll(userExistingProductModel.data!);
      }
    } catch (e) {
      log("getproduct list $e");
    } finally {
      isLoading.value = false;
    }
  }

  ProductDetail productDetail = ProductDetail();
  Future getSpotlightProductDetail(
      {required String productId, bool? isLoad = true}) async {
    try {
      if (isLoad == true) {
        isDetailLoading.value = true;
      }
      var response = await ApiBase.getRequest(
          extendedURL: "${ApiUrl.spotLightProductUrl}/$productId");
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        SpotlightProductDetailModel spotlightProductDetailModel =
            SpotlightProductDetailModel.fromJson(data);
        productDetail = spotlightProductDetailModel.data!;
      }
    } catch (e) {
      log("getproductdetail list $e");
    } finally {
      isDetailLoading.value = false;
    }
  }

  var isCommentLoad = false.obs;

  Future addComment(
      {required String comment, required bool isSupporting}) async {
    isCommentLoad.value = true;
    var body = {
      "comment": comment,
      "isSupporting": isSupporting,
      "id": productDetail.id
    };
    var response = await ApiBase.postRequest(
        body: body,
        extendedURL: ApiUrl.addSpotlightCommentProduct,
        withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      await getSpotlightProductDetail(
          productId: productDetail.id!, isLoad: false);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future addReplyInComment(
      {required String comment, required String id}) async {
    isCommentLoad.value = true;
    var body = {
      "comment": comment,
      "id": id,
    };
    var response = await ApiBase.postRequest(
        body: body,
        extendedURL: ApiUrl.replySpotlightCommentProduct,
        withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      await getSpotlightProductDetail(
          productId: productDetail.id!, isLoad: false);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future addUpvoteDownvoteProduct(
      {required String productID, required bool isUpvote}) async {
    var body = {};
    var response = await ApiBase.postRequest(
        body: body,
        extendedURL: isUpvote
            ? "${ApiUrl.upvoteProduct}$productID"
            : "${ApiUrl.downvoteProduct}$productID",
        withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future addUpvoteDownvoteComment(
      {required String commentId, required bool isUpvote}) async {
    var body = {};
    var response = await ApiBase.postRequest(
        body: body,
        extendedURL: isUpvote
            ? "${ApiUrl.upvoteComment}$commentId"
            : "${ApiUrl.downvoteComment}$commentId",
        withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future addUpvoteDownvoteCommentReply(
      {required String commentId,
      required String replycommentId,
      required bool isUpvote}) async {
    var body = {};
    var response = await ApiBase.postRequest(
        body: body,
        extendedURL: isUpvote
            ? "${ApiUrl.upvoteCommentReply}$commentId/$replycommentId"
            : "${ApiUrl.downvoteCommentReply}$commentId/$replycommentId",
        withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  List<RequestData> requestData = [];
  Future viewRequestList() async {
    try {
      isLoading.value = true;
      requestData.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.spotlightRequest);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        SpotlightRequestModel spotlightRequestModel =
            SpotlightRequestModel.fromJson(data);
        requestData.addAll(spotlightRequestModel.data!);
      }
    } catch (e) {
      log("getrequest list $e");
    } finally {
      isLoading.value = false;
    }
  }
}
