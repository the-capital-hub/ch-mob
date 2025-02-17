import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../utils/appcolors/app_colors.dart';
import '../textWidget/text_widget.dart';

Future<bool> sharePostPopup(BuildContext context, String postID, String shareLink) async {
  TextEditingController whatsappMsgController = TextEditingController();
  // TextEditingController urlController = TextEditingController(
  //     text: "https://www.thecapitalhub.in/post_details/$postID");
  TextEditingController urlController = TextEditingController();
  if(postID != ""){
    urlController.text = "https://www.thecapitalhub.in/post_details/$postID";
  }
  else{
    urlController.text = shareLink;
  }
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: AppColors.blackCard,
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextWidget(
                  text: "Share on socials",
                  textSize: 20,
                  color: AppColors.white,
                  maxLine: 2,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {
                            Helper.launchUrl(
                                "https://twitter.com/intent/tweet?url=${Uri.encodeFull(urlController.text)}&text=${whatsappMsgController.text}");
                          },
                          child: Image.asset(PngAssetPath.twitterIcon,
                              height: 50)),
                      InkWell(
                        onTap: () {
                          Helper.launchUrl(
                              "https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeFull(urlController.text)}");
                        },
                        child: Image.asset(PngAssetPath.fbIcon, height: 50),
                      ),
                      InkWell(
                        onTap: () {
                          Helper.launchUrl(
                              "https://www.linkedin.com/sharing/share-offsite/?url=${Uri.encodeFull(urlController.text)}");
                        },
                        child:
                            Image.asset(PngAssetPath.linkedinIcon, height: 50),
                      ),
                      InkWell(
                        onTap: () {
                          Helper.launchUrl(
                              "https://wa.me/?text=${whatsappMsgController.text}%20${Uri.encodeFull(urlController.text)}");
                        },
                        child:
                            Image.asset(PngAssetPath.whatsappIcon, height: 50),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: MyCustomTextField.textField(
                      borderClr: AppColors.white38,
                      lableText: "Message",
                      hintText: "Enter Message For Whatsapp",
                      controller: whatsappMsgController),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: MyCustomTextField.textField(
                      borderClr: AppColors.white38,
                      hintText: "",
                      readonly: true,
                      suffixIcon: InkWell(
                          onTap: () {
                            if (urlController.text.isNotEmpty) {
                              Clipboard.setData(
                                  ClipboardData(text: urlController.text));
                              HelperSnackBar.snackBar(
                                  "Success", "Text Copied Successfully");
                            } else {
                              HelperSnackBar.snackBar("Error", "");
                            }
                          },
                          child: Icon(
                            Icons.copy,
                            color: AppColors.white,
                          )),
                      controller: urlController),
                ),
                SizedBox(height: 8),
                Divider(
                  color: AppColors.grey3Color,
                  height: 0,
                  thickness: 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                          height: 45,
                          child: Center(
                            child: TextWidget(
                              text: "Cancel".toUpperCase(),
                              color: Colors.white54,
                              textSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
}
