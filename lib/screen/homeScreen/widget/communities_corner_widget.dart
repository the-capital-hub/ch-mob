import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/controller/homeController/home_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CommunitiesCornerWidget extends StatefulWidget {
  const CommunitiesCornerWidget({super.key});

  @override
  State<CommunitiesCornerWidget> createState() => _CommunitiesCornerWidgetState();
}

class _CommunitiesCornerWidgetState extends State<CommunitiesCornerWidget> {
  HomeController homeController = Get.find();
  CommunityController allCommunities = Get.put(CommunityController());
   @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      allCommunities.getAllCommunities().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
         
        });
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.blackCard,
      ),
      padding: const EdgeInsets.all(8),
      child: homeController.isLoading.value
          ? Helper.loader(context)
          :
          ListView.builder(
                    // controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: homeController.startUpNewsList.length,
                    itemBuilder: (context, index) {
                      return 
          
          Column(
            children: [
              Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(color: AppColors.primary)
              ),
              SizedBox(height: 16,),
              TextWidget(text: "Hustler's Club", textSize: 20),
              SizedBox(height: 16,),
              TextWidget(text: "Join our vibrant community!", textSize: 16),
              SizedBox(height: 16,),
              Row(
                
                children: [
                  TextWidget(text: "17 Members", textSize: 16),
                  SizedBox(width: 16,),
                  TextWidget(text: "Free to Join", textSize: 16,color: AppColors.primary,),
                ],
              )
            ],
          );
                    }
    ),
    );
  }
}