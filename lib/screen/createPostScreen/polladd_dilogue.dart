import 'package:capitalhub_crm/controller/createPostController/create_post_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PollOptionsDialog extends StatefulWidget {
  @override
  _PollOptionsDialogState createState() => _PollOptionsDialogState();
}

class _PollOptionsDialogState extends State<PollOptionsDialog> {
  List<TextEditingController> controllers = [];
  CreatePostController createPostController = Get.put(CreatePostController());
  // Initialize with 2 default options
  @override
  void initState() {
    super.initState();
    controllers.add(TextEditingController());
    controllers.add(TextEditingController());
  }

  // Add a new poll option field
  void _addOption() {
    if (controllers.length < 6) {
      setState(() {
        controllers.add(TextEditingController());
      });
    }
  }

  // Remove a poll option field
  void _removeOption(int index) {
    if (controllers.length > 2) {
      setState(() {
        controllers.removeAt(index);
      });
    }
  }

  // Submit the poll options (For example, sending to an API)
  void _submitPollOptions() {
    createPostController.pollOptions = controllers
        .map((controller) => controller.text.trim())
        .where((option) => option.isNotEmpty)
        .toList();
    Get.back();
    if (createPostController.pollOptions.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('You must provide at least 2 non-empty options.')),
      );
      return;
    }

    print('Poll Options: ${createPostController.pollOptions}');
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const TextWidget(text: 'Add Poll Options', textSize: 14),
      backgroundColor: AppColors.blackCard,
      content: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < controllers.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MyCustomTextField.textField(
                          suffixIcon: (controllers.length > 2)
                              ? IconButton(
                                  visualDensity: VisualDensity.compact,
                                  icon: const Icon(Icons.remove_circle,
                                      color: Colors.red),
                                  onPressed: () => _removeOption(i),
                                )
                              : null,
                          hintText: "Option ${i + 1}",
                          fillColor: AppColors.white12,
                          borderClr: AppColors.white38,
                          controller: controllers[i]),
                    ),
                  ],
                ),
              ),
            if (controllers.length < 6)
              AppButton.outlineButton(
                  onButtonPressed: () {
                    _addOption();
                  },
                  borderColor: AppColors.white38,
                  height: 35,
                  fontSize: 12,
                  width: 116,
                  title: "+ Add Option"),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: AppButton.primaryButton(
                      height: 35,
                      onButtonPressed: () {
                        Get.back();
                      },
                      title: "Cancel"),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: AppButton.primaryButton(
                      onButtonPressed: () {
                        _submitPollOptions();
                      },
                      height: 35,
                      title: "Submit"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
