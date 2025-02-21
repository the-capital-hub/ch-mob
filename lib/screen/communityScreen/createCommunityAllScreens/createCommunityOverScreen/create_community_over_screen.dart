import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityLandingScreen/community_landing_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CreateCommunityOverScreen extends StatefulWidget {
  
  const CreateCommunityOverScreen({super.key});
  

  @override
  State<CreateCommunityOverScreen> createState() =>
      _CreateCommunityOverScreenState();
      
}

class _CreateCommunityOverScreenState extends State<CreateCommunityOverScreen> {
  CommunityController createdCommunity = Get.put(CommunityController());
  TextEditingController urlController = TextEditingController();
   @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      createdCommunity.getCommunityById().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
        urlController.text = createdCommunity.createdCommunityDetails[0].shareLink;
        });
      });
    });
    super.initState();
  }
  List<String> imgURL = [
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
    "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        drawer: const DrawerWidget(),
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Create Community",
          hideBack: true,
          autoAction: true,
        ),
        body:Obx(() => createdCommunity.isLoading.value
                ? Helper.pageLoading()
                : createdCommunity.createdCommunityDetails.isEmpty
                      ? Center(child: TextWidget(text: "No Community Available", textSize: 16))
                      :Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(
                  text: "Congrats! ${createdCommunity.createdCommunityDetails[0].name} is live!", textSize: 20),
                  sizedTextfield,
                  sizedTextfield,
               CircleAvatar(
                radius: 60,
                foregroundImage: NetworkImage(
                  createdCommunity.createdCommunityDetails[0].image,
                ),
              ),
              sizedTextfield,
              TextWidget(text: createdCommunity.createdCommunityDetails[0].name, textSize: 20,),
             sizedTextfield,
              createdCommunity.createdCommunityDetails[0].subscription == "free"?
              TextWidget(text: "Any one can join for free", textSize: 13):  TextWidget(text: "Subscription Amount : \u{20B9} ${createdCommunity.createdCommunityDetails[0].amount.toString()}", textSize: 13),
              sizedTextfield,
              Divider(
                thickness: 1,
                color: AppColors.white54,
              ),
              SizedBox(height: 12,),
          
              
              
             
              
              
              
              Expanded(
                child: MyCustomTextField.textField(
                    lableText: "Community Page URL",
                    hintText: "Capitalhub/Community",
                    controller: urlController,
                    suffixIcon: IconButton(icon: Icon(
                        Icons.mobile_screen_share_rounded,
                        color: AppColors.whiteCard,
                        size: 22,
                      ),onPressed: (){
                        sharePostPopup(context,"",urlController.text);
                      },)
                    ),
              ),
              
              
            ],
          ),
        ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 12,
          ),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                Get.to(() =>  CommunityLandingScreen());
              },
              title: "Continue"),
        ),
      ),
    );
  }
}
