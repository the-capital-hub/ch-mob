import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../controller/chatController/chat_controller.dart';
import '../../model/chatModel/group_admin_connection_model.dart';
import '../../widget/buttons/button.dart';

class AddMemberGroupchat extends StatefulWidget {
  final String groupId;
  const AddMemberGroupchat({super.key, required this.groupId});

  @override
  State<AddMemberGroupchat> createState() => _AddMemberGroupchatState();
}

class _AddMemberGroupchatState extends State<AddMemberGroupchat> {
  ChatController chatController = Get.find();

  RxList<AdminConnections> searchResults = <AdminConnections>[].obs;
  RxList<AdminConnections> selectedUsers = <AdminConnections>[].obs;

  void searchUser(String query) {
    if (query.isEmpty) {
      return;
    }
  }

  void toggleSelection(AdminConnections user) {
    if (selectedUsers.any((u) => u.id == user.id)) {
      selectedUsers.removeWhere((u) => u.id == user.id);
    } else {
      selectedUsers.add(user);
    }
    setState(() {});
  }

  void submitSelectedUsers() {
    List<String> ids = selectedUsers.map((u) => u.id!).toList();
    debugPrint("Submitted User IDs: $ids");
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  final TextEditingController searchCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Add Member"),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              MyCustomTextField.textField(
                hintText: "Search Members from Connection",
                lableText: "Member",
                controller: searchCtrl,
                prefixIcon: Icon(Icons.search, color: AppColors.white54),
                onChange: searchUser,
              ),
              sizedTextfield,
              Obx(() {
                if (chatController.isLoading.value) {
                  return Expanded(child: Helper.pageLoading());
                }
                return searchResults.isEmpty && searchCtrl.text.isNotEmpty
                    ? const TextWidget(text: "No results", textSize: 14)
                    : Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider(
                                thickness: 1, color: AppColors.white12);
                          },
                          itemCount: searchResults.length,
                          itemBuilder: (_, index) {
                            final user = searchResults[index];
                            final isSelected =
                                selectedUsers.any((u) => u.id == user.id);

                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.white12),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(user.imageUrl!),
                                ),
                                title:
                                    TextWidget(text: user.name!, textSize: 14),
                                trailing: user.isMember!
                                    ? InkWell(
                                        onTap: () {
                                          user.isMember = false;
                                          setState(() {});
                                        },
                                        child: const Icon(
                                          Icons.remove_circle_outline,
                                          color: AppColors.redColor,
                                        ),
                                      )
                                    : Icon(
                                        isSelected
                                            ? Icons.check_circle
                                            : Icons.add_circle_outline,
                                        color: isSelected
                                            ? Colors.green
                                            : AppColors.white54,
                                      ),
                                onTap: () => user.isMember!
                                    ? null
                                    : toggleSelection(user),
                              ),
                            );
                          },
                        ),
                      );
              }),
              const SizedBox(height: 10),
              Obx(() {
                final isKeyboardOpen =
                    MediaQuery.of(context).viewInsets.bottom > 0;
                if (isKeyboardOpen || selectedUsers.isEmpty) {
                  return const SizedBox.shrink();
                }
                return selectedUsers.isEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Wrap(
                          spacing: 6,
                          children: selectedUsers
                              .map((user) => Chip(
                                    label: TextWidget(
                                        text: user.name!, textSize: 12),
                                    avatar: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(user.imageUrl!),
                                    ),
                                    backgroundColor: AppColors.blackCard,
                                    deleteIconColor: AppColors.white54,
                                    side: const BorderSide(),
                                    onDeleted: () => toggleSelection(user),
                                  ))
                              .toList(),
                        ),
                      );
              }),
              Obx(() {
                return selectedUsers.isEmpty
                    ? const SizedBox.shrink()
                    : AppButton.primaryButton(
                        onButtonPressed: submitSelectedUsers, title: "Submit");
              }),
            ],
          ),
        ),
      ),
    );
  }
}
