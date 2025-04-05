import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityAboutController/community_about_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class CommunityRegisterNowScreen extends StatefulWidget {
  int index;
  CommunityRegisterNowScreen({required this.index, super.key});

  @override
  State<CommunityRegisterNowScreen> createState() =>
      _CommunityRegisterNowScreenState();
}

class _CommunityRegisterNowScreenState
    extends State<CommunityRegisterNowScreen> {
  CommunityEventsController communityEvents = Get.find();
  TextEditingController urlController = TextEditingController();
  CommunityAboutController aboutCommunity = Get.put(CommunityAboutController());
  String communityAdminName = "";
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Future.wait([aboutCommunity.getAboutCommunity()]).then((values) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            communityAdminName =
                "${aboutCommunity.aboutCommunityList[0].admin!.firstName} ${aboutCommunity.aboutCommunityList[0].admin!.lastName}";
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
            backgroundColor: AppColors.transparent,
            appBar: HelperAppBar.appbarHelper(
              title: "Register for Webinar",
              hideBack: true,
              autoAction: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(children: [
                    // Card(
                    //   margin: EdgeInsets.zero,
                    //   color: AppColors.blackCard,
                    //   child: Padding(
                    //     padding: EdgeInsets.all(12.0),
                    //     child: Row(
                    //       children: [
                    //         TextWidget(
                    //           text: communityAdminName,
                    //           textSize: 16,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //         TextWidget(
                    //           text: " invites you to join!",
                    //           textSize: 16,
                    //           color: AppColors.primary,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // sizedTextfield,
                    // Container(
                    //   height: 200,
                    //   decoration: BoxDecoration(
                    //       image: const DecorationImage(
                    //           image: NetworkImage(
                    //             "https://bettermeetings.expert/wp-content/uploads/engaging-interactive-webinar-best-practices-and-formats.jpg",
                    //           ),
                    //           fit: BoxFit.fill),
                    //       borderRadius: BorderRadius.circular(10)),
                    // ),
                    // const SizedBox(height: 12),
                    Card(
                        margin: EdgeInsets.zero,
                        color: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: communityEvents.communityEventsData
                                    .webinars![widget.index].title!,
                                textSize: 20,
                                fontWeight: FontWeight.w500,
                              ),

                              sizedTextfield,
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: AppColors.white,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextWidget(
                                      text: communityEvents.communityEventsData
                                          .webinars![widget.index].date!,
                                      textSize: 16)
                                ],
                              ),
                              sizedTextfield,
                              // Row(
                              //   children: [
                              //     Icon(
                              //       Icons.schedule,
                              //       color: AppColors.white,
                              //       size: 22,
                              //     ),
                              //     const SizedBox(
                              //       width: 5,
                              //     ),
                              //      TextWidget(
                              //         text: "${communityEvents.communityEventsData[widget.index].duration} - ${communityEvents.communityEventsData[widget.index].duration}", textSize: 16)
                              //   ],
                              // ),
                              // sizedTextfield,
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: AppColors.white,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextWidget(
                                      text: communityEvents.communityEventsData
                                          .webinars![widget.index].duration!,
                                      textSize: 16)
                                ],
                              ),
                              sizedTextfield,
                              Row(
                                children: [
                                  Icon(
                                    Icons.payment,
                                    color: AppColors.white,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextWidget(
                                      text: communityEvents
                                                  .communityEventsData
                                                  .webinars![widget.index]
                                                  .price ==
                                              "0"
                                          ? "Free"
                                          : "\u{20B9}${communityEvents.communityEventsData.webinars![widget.index].price}",
                                      textSize: 16)
                                ],
                              ),
                              sizedTextfield,
                              Row(
                                children: [
                                  Icon(
                                    Icons.video_call,
                                    color: AppColors.white,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const TextWidget(
                                      text: "Google Meet", textSize: 16)
                                ],
                              ),
                              sizedTextfield,

                              HtmlWidget(
                                communityEvents.communityEventsData
                                    .webinars![widget.index].description!,
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.white,
                                ),
                              ),

                              sizedTextfield,
                            ],
                          ),
                        )),
                    sizedTextfield,
                    Card(
                      margin: EdgeInsets.zero,
                      color: AppColors.blackCard,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: AppColors.white38,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const TextWidget(
                              text: "Register for Webinar",
                              textSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const TextWidget(
                                text: "Please fill in your details to proceed",
                                textSize: 16),
                            sizedTextfield,
                            MyCustomTextField.textField(
                                hintText: "Enter Name",
                                controller: communityEvents.nameController,
                                lableText: "Name",
                                borderClr: AppColors.white12),
                            const SizedBox(height: 12),
                            MyCustomTextField.textField(
                                hintText: "Enter Email",
                                controller: communityEvents.emailController,
                                lableText: "Email",
                                borderClr: AppColors.white12),
                            const SizedBox(height: 12),
                            MyCustomTextField.textField(
                                textInputType: TextInputType.number,
                                hintText: "Enter Mobile Number",
                                controller: communityEvents.mobileController,
                                lableText: "Mobile Number",
                                borderClr: AppColors.white12),
                            const SizedBox(height: 12),
                            AppButton.primaryButton(
                                onButtonPressed: () {
                                  Helper.loader(context);
                                  communityEvents.registerCommunityWebinar(
                                      communityEvents.communityEventsData
                                          .webinars![widget.index].id
                                          .toString());
                                },
                                title: "Register Now"),
                            sizedTextfield,
                          ],
                        ),
                      ),
                    ),
                  ])),
            )));
  }
}
