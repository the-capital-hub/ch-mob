import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controller/communityController/communityLandingAllControllers/communityPriorityDMsController/community_priority_dms_controller.dart';
import '../../../../../model/communityModel/communityLandingAllModels/communityPriorityDMsModel/community_priority_dms_model.dart';
import '../../../../../utils/appcolors/app_colors.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../../../widget/buttons/button.dart';
import '../../../../../widget/dropdownWidget/drop_down_widget.dart';
import '../../../../../widget/text_field/text_field.dart';

class CommunityAddPriorityDmsScreen extends StatefulWidget {
  final bool isEdit;
  CommunityPriorityDMs? communityPriorityDMs;
  CommunityAddPriorityDmsScreen(
      {super.key, required this.isEdit, this.communityPriorityDMs});

  @override
  State<CommunityAddPriorityDmsScreen> createState() =>
      _CommunityAddPriorityDmsScreenState();
}

class _CommunityAddPriorityDmsScreenState
    extends State<CommunityAddPriorityDmsScreen> {
  CommunityPriorityDMsController communityPriorityDMs =
      Get.put(CommunityPriorityDMsController());
  GlobalKey<FormState> priorityDMFormkey = GlobalKey();
  addDescription() async {
    await communityPriorityDMs.descriptionController
        .setText(widget.communityPriorityDMs!.description!);
  }

  @override
  void initState() {
    if (widget.isEdit) {
      communityPriorityDMs.selectedTimeLine =
          widget.communityPriorityDMs!.timelineUnit!;
      communityPriorityDMs.titleController.text =
          widget.communityPriorityDMs!.title!;
      communityPriorityDMs.amountController.text =
          widget.communityPriorityDMs!.amount!.toString();
      communityPriorityDMs.responseTimelineController.text =
          widget.communityPriorityDMs!.timelineValue.toString();
      communityPriorityDMs.topicsController.text =
          widget.communityPriorityDMs!.topics!.join(", ");
    } else {
      communityPriorityDMs.selectedTimeLine = "Hours";
      communityPriorityDMs.titleController.clear();
      communityPriorityDMs.amountController.clear();
      communityPriorityDMs.responseTimelineController.clear();
      communityPriorityDMs.topicsController.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Priority DMS"),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
              child: Form(
            key: priorityDMFormkey,
            child: Column(children: [
              MyCustomTextField.textField(
                  valText: "Please enter title",
                  hintText: "Enter service title",
                  controller: communityPriorityDMs.titleController,
                  lableText: "Title"),
              sizedTextfield,
              MyCustomTextField.htmlTextField(
                hintText: "Enter service description",
                controller: communityPriorityDMs.descriptionController,
                lableText: "Description",
                onEditorCreated: () async {
                  if (widget.isEdit) {
                    addDescription();
                  }
                },
              ),
              sizedTextfield,
              MyCustomTextField.textField(
                  valText: "Please enter amount",
                  textInputType: TextInputType.number,
                  hintText: "Enter amount",
                  controller: communityPriorityDMs.amountController,
                  lableText: "Amount (\u{20B9})"),
              sizedTextfield,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: MyCustomTextField.textField(
                          valText: "Please enter Response Timeline",
                          textInputType: TextInputType.number,
                          hintText: "Enter Response Timeline",
                          controller:
                              communityPriorityDMs.responseTimelineController,
                          lableText: "Response Timeline")),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: DropDownWidget(
                          status: communityPriorityDMs.selectedTimeLine,
                          statusList: const [
                            'Hours',
                            'Days',
                          ],
                          onChanged: (val) {
                            setState(() {
                              communityPriorityDMs.selectedTimeLine =
                                  val.toString();
                            });
                          }),
                    ),
                  ),
                ],
              ),
              sizedTextfield,
              MyCustomTextField.textField(
                  valText: "Please anter topics",
                  hintText: "Enter topics, seperated by commas",
                  controller: communityPriorityDMs.topicsController,
                  lableText: "Topics (comma-seperated)"),
              sizedTextfield,
              sizedTextfield,
              AppButton.primaryButton(
                  onButtonPressed: () {
                    if (priorityDMFormkey.currentState!.validate()) {
                      splitTopics();
                      if (widget.isEdit) {
                        Helper.loader(context);
                        communityPriorityDMs.updateCommunityPriorityDM(
                            topics, widget.communityPriorityDMs!.id.toString());
                      } else {
                        Helper.loader(context);
                        communityPriorityDMs.createCommunityPriorityDM(topics);
                      }
                    }
                  },
                  title: widget.isEdit ? "Update Priority Dms" : "Create Priority Dms"),
            ]),
          )),
        ),
      ),
    );
  }

  List<String> topics = [];

  void splitTopics() {
    setState(() {
      String text = communityPriorityDMs.topicsController.text.trim();
      topics = _processTopics(text);
    });
  }

  List<String> _processTopics(String text) {
    List<String> processedTopics = text
        .split(',')
        .map((topic) => topic.trim())
        .where((topic) => topic.isNotEmpty)
        .toList();

    return processedTopics;
  }
}
