import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import '../../../../../model/communityModel/communityLandingAllModels/communityEventsModel/community_event_model.dart';
import '../../../../../utils/appcolors/app_colors.dart';
import '../../../../../utils/getStore/get_store.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../../../widget/buttons/button.dart';
import '../../../../../widget/text_field/text_field.dart';

class CommunityAddEventsScreen extends StatefulWidget {
  final bool isEdit;
  CommunityEvents? events;
  CommunityAddEventsScreen({super.key, required this.isEdit, this.events});

  @override
  State<CommunityAddEventsScreen> createState() =>
      _CommunityAddEventsScreenState();
}

class _CommunityAddEventsScreenState extends State<CommunityAddEventsScreen> {
  CommunityEventsController communityEvents =
      Get.put(CommunityEventsController());
  GlobalKey<FormState> eventsFormkey = GlobalKey();

  addDescription() async {
    await communityEvents.descriptionController
        .setText(widget.events!.description!);
  }

  @override
  void initState() {
    if (widget.isEdit) {
      communityEvents.titleController.text = widget.events!.title!;
      communityEvents.durationMinutesController.text =
          "${widget.events!.duration}";
      communityEvents.priceController.text = "${widget.events!.price}";
      communityEvents.priceDiscountController.text =
          "${widget.events!.discount}";
    } else {
      communityEvents.titleController.clear();
      communityEvents.durationMinutesController.clear();
      communityEvents.priceController.clear();
      communityEvents.priceDiscountController.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Events"),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
              child: Form(
            key: eventsFormkey,
            child: Column(children: [
              MyCustomTextField.textField(
                  valText: "Please enter service title",
                  hintText: "Enter service title",
                  controller: communityEvents.titleController,
                  lableText: "Title"),
              const SizedBox(
                height: 16,
              ),
              MyCustomTextField.htmlTextField(
                hintText: "Enter service description",
                controller: communityEvents.descriptionController,
                lableText: "Description",
                onEditorCreated: () async {
                  if (widget.isEdit) {
                    addDescription();
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: MyCustomTextField.textField(
                          valText: "Please enter amount",
                          textInputType: TextInputType.number,
                          hintText: "Enter amount",
                          controller: communityEvents.priceController,
                          lableText: "Amount (\u{20B9})")),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: MyCustomTextField.textField(
                          valText: "Please enter duration",
                          textInputType: TextInputType.number,
                          hintText: "Enter duration",
                          controller: communityEvents.durationMinutesController,
                          lableText: "Duration (minutes)")),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              MyCustomTextField.textField(
                  valText: "Please enter discount (%)",
                  textInputType: TextInputType.number,
                  hintText: "Enter discount (%)",
                  controller: communityEvents.priceDiscountController,
                  lableText: "Discount (%)"),
              const SizedBox(
                height: 20,
              ),
              AppButton.primaryButton(
                  onButtonPressed: () {
                    if (eventsFormkey.currentState!.validate()) {
                      if (widget.isEdit) {
                        Helper.loader(context);
                        communityEvents
                            .updateCommunityEvent(widget.events!.eventId);
                        communityEvents.addListener;
                      } else {
                        Helper.loader(context);
                        communityEvents.createCommunityEvent();
                        communityEvents.addListener;
                      }
                    }
                  },
                  title: widget.isEdit ? "Update Event" : "Create Event"),
            ]),
          )),
        ),
      ),
    );
  }
}
