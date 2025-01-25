import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/screen/chatScreen/chat_screen.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:get/get.dart';

import '../../model/01-StartupModel/chatModel/chat_memberlist_model.dart';
import '../../model/01-StartupModel/chatModel/create_chat_model.dart';
import '../../model/01-StartupModel/chatModel/group_memberlist_model.dart';
import '../../model/01-StartupModel/chatModel/member_chats.dart';
import '../../model/01-StartupModel/chatModel/search_member_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper_sncksbar.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;
  var isSearchLoading = false.obs;
  List<ChatMember> pinnedChatsList = [];
  List<ChatMember> normalChatsList = [];
  Future getChatMemberList() async {
    try {
      isLoading.value = true;
      pinnedChatsList.clear();
      normalChatsList.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.chatMemberList);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        ChatMemberList chatMemberListModel = ChatMemberList.fromJson(data);
        pinnedChatsList.addAll(chatMemberListModel.data!.pinnedChats!);
        normalChatsList.addAll(chatMemberListModel.data!.normalChats!);
      }
    } catch (e) {
      log("getChat list $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future pinUserChat(id) async {
    isLoading.value = true;
    var response = await ApiBase.pachRequest(
      body: {},
      withToken: true,
      extendedURL: ApiUrl.chatTogglePin + id,
    );
    log(response.body);

    var data = json.decode(response.body);
    if (data["status"]) {
      getChatMemberList();
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  List<ChatMessage> messages = [];

  Future getChats(chatID) async {
    try {
      messages.clear();
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getchats + chatID);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        MemberChat memberChat = MemberChat.fromJson(data);
        messages.addAll(memberChat.data);
      }
    } catch (e) {
      log("getChat $e");
    } finally {
      isLoading.value = false;
    }
  }

  var isMessageSending = false.obs;
  Future addMessage({required ChatMessage chatmessage}) async {
    isMessageSending.value = true;
    var response = await ApiBase.postRequest(
      body: chatmessage.toJson(),
      withToken: true,
      extendedURL: ApiUrl.addMessage,
    );
    log(response.body);

    var data = json.decode(response.body);
    if (data["status"]) {
      ChatMessage chatMessage = ChatMessage.fromJson(data['data']);
      messages.add(chatMessage);
      isMessageSending.value = false;
      return true;
    } else {
      isMessageSending.value = false;
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  RxList<SearchMember> searchMemberList = <SearchMember>[].obs;

  Future searchMember(query) async {
    try {
      isSearchLoading.value = true;
      searchMemberList.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.searchMember + query);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        SearchMemberModel searchMemberModel = SearchMemberModel.fromJson(data);
        searchMemberList.addAll(searchMemberModel.data);
      }
    } catch (e) {
      log("getChat $e");
    } finally {
      isSearchLoading.value = false;
    }
  }

  Future createChat(context, id) async {
    Helper.loader(context);
    var response = await ApiBase.postRequest(
      body: {"recieverId": id},
      withToken: true,
      extendedURL: ApiUrl.createChat,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      CreateChatModel createChatModel = CreateChatModel.fromJson(data);
      Get.back(closeOverlays: true);
      Get.to(ChatScreen(member: createChatModel.data))!.whenComplete(() {
        getChatMemberList();
      });

      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future deleteMessage(id) async {
    var response = await ApiBase.deleteRequest(
      extendedURL: ApiUrl.deleteMessage + id,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      messages.removeWhere((item) => item.messageId == id);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future clearChat(context, id) async {
    Helper.loader(context);
    var response = await ApiBase.deleteRequest(
      extendedURL: ApiUrl.clearChat + id,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      messages.clear();
      Get.back(closeOverlays: true);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future blockUnblock(context, id) async {
    Helper.loader(context);
    var response = await ApiBase.postRequest(
      body: {"targetUserId": id},
      withToken: true,
      extendedURL: ApiUrl.blockUser,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  List<Groups> groupChatList = [];
  Future getGroupChatMemberList() async {
    try {
      isLoading.value = true;
      groupChatList.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.groupChatMemberList);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        GroupMemberListModel groupMemberListModel =
            GroupMemberListModel.fromJson(data);
        groupChatList.addAll(groupMemberListModel.data);
      }
    } catch (e) {
      log("getChat list $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future createGroup(image, name, description) async {
    var response = await ApiBase.postRequest(
      body: {
        "profileImage": image,
        "communityName": name,
        "about": description
      },
      withToken: true,
      extendedURL: ApiUrl.createGroup,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
