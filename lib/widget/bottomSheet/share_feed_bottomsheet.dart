import 'package:animate_do/animate_do.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../textwidget/text_widget.dart';
void showConnectionsBottomSheet(List<UserModel> connections) {
  final TextEditingController controller = TextEditingController();

  Get.bottomSheet(
    ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 500, minHeight: 200),
      child: SafeArea(
        child: StatefulBuilder(
          builder: (context, setState) {
            final Set<int> selectedIndexes = <int>{};
            List<UserModel> filteredConnections = [...connections];

            return StatefulBuilder(
              builder: (context, innerSetState) {
                return Container(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.blackCard,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TextWidget(
                          text: 'Select Connections',
                          textSize: 18,
                          fontWeight: FontWeight.bold),
                      Divider(height: 30, color: AppColors.white38),
                      MyCustomTextField.textField(
                        hintText: "Search Connection",
                        fillColor: AppColors.white12,
                        suffixIcon: Icon(Icons.search, color: AppColors.white38),
                        controller: controller,
                        onChange: (value) {
                          final query = value.toLowerCase();
                          innerSetState(() {
                            filteredConnections = connections
                                .where((user) =>
                                    user.name.toLowerCase().contains(query))
                                .toList();
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      Flexible(
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: filteredConnections.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            final user = filteredConnections[index];
                            final originalIndex = connections.indexOf(user);
                            final isSelected =
                                selectedIndexes.contains(originalIndex);

                            return GestureDetector(
                              onTap: () {
                                innerSetState(() {
                                  if (isSelected) {
                                    selectedIndexes.remove(originalIndex);
                                  } else {
                                    selectedIndexes.add(originalIndex);
                                  }
                                });
                              },
                              child: FadeIn(
                                delay: Duration(milliseconds: 30 * index),
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.all(isSelected ? 3 : 0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: isSelected
                                            ? Border.all(
                                                color: AppColors.blue, width: 2)
                                            : null,
                                      ),
                                      child: CircleAvatar(
                                        radius: 28,
                                        backgroundImage:
                                            NetworkImage(user.imageUrl),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    TextWidget(text: user.name, textSize: 12),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      AppButton.primaryButton(
                        onButtonPressed: selectedIndexes.isEmpty
                            ? null
                            : () {
                                final selectedUsers = selectedIndexes
                                    .map((i) => connections[i])
                                    .toList();
                                Get.back();
                                print("Selected: ${selectedUsers.map((e) => e.name).toList()}");
                              },
                        bgColor: AppColors.blue,
                        title: "Send ${selectedIndexes.isNotEmpty ? "(${selectedIndexes.length})" : ""}",
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    ),
    isScrollControlled: true,
    backgroundColor: AppColors.blackCard,
  );
}


class UserModel {
  final String name;
  final String imageUrl;

  UserModel({required this.name, required this.imageUrl});
}
