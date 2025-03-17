import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunityRegisterNowScreen extends StatefulWidget {
  const CommunityRegisterNowScreen({super.key});

  @override
  State<CommunityRegisterNowScreen> createState() =>
      _CommunityRegisterNowScreenState();
}

class _CommunityRegisterNowScreenState
    extends State<CommunityRegisterNowScreen> {
  TextEditingController urlController = TextEditingController();
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
                    Card(
                      margin: EdgeInsets.zero,
                      color: AppColors.blackCard,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            TextWidget(
                              text: "Nitin Kumar",
                              textSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            TextWidget(
                              text: " invites you to join!",
                              textSize: 16,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    sizedTextfield,
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                "https://bettermeetings.expert/wp-content/uploads/engaging-interactive-webinar-best-practices-and-formats.jpg",
                              ),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(height: 12),
                    Card(
                        margin: EdgeInsets.zero,
                        color: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidget(
                                text: "Title",
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
                                  const TextWidget(
                                      text: "7 March 2024", textSize: 16)
                                ],
                              ),
                              sizedTextfield,
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: AppColors.white,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const TextWidget(
                                      text: "10:15AM - 10:45AM", textSize: 16)
                                ],
                              ),
                              sizedTextfield,
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
                                  const TextWidget(
                                      text: "30 minutes", textSize: 16)
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
                                  const TextWidget(text: "Free", textSize: 16)
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
                              const TextWidget(
                                  text: "Description",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500),
                              // SizedBox(height: 8),
                              // // HtmlWidget(communityProducts.communityProductsList[widget.index].description, textStyle: TextStyle(fontSize: 13,color: AppColors.white),),
                              // SizedBox(height: 8),
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
                                controller: urlController,
                                lableText: "Name",
                                borderClr: AppColors.white12),
                            const SizedBox(height: 12),
                            MyCustomTextField.textField(
                                hintText: "Enter Email",
                                controller: urlController,
                                lableText: "Email",
                                borderClr: AppColors.white12),
                            const SizedBox(height: 12),
                            MyCustomTextField.textField(
                                hintText: "Enter Mobile Number",
                                controller: urlController,
                                lableText: "Mobile Number",
                                borderClr: AppColors.white12),
                            const SizedBox(height: 12),
                            AppButton.primaryButton(
                                onButtonPressed: () {}, title: "Register Now"),
                            sizedTextfield,
                          ],
                        ),
                      ),
                    ),
                  ])),
            )));
  }
}
