import "package:capitalhub_crm/controller/resourceController/resource_controller.dart";
import "package:capitalhub_crm/utils/appcolors/app_colors.dart";
import "package:capitalhub_crm/utils/constant/app_var.dart";
import "package:capitalhub_crm/utils/helper/helper.dart";
import "package:capitalhub_crm/widget/appbar/appbar.dart";
import "package:capitalhub_crm/widget/textwidget/text_widget.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:get/get.dart";

class ResourceDetailsScreen extends StatefulWidget {
  
  const ResourceDetailsScreen({ super.key});

  @override
  State<ResourceDetailsScreen> createState() => _ResourceDetailsScreenState();
}

class _ResourceDetailsScreenState extends State<ResourceDetailsScreen> {
  ResourceController allResourcesById = Get.put(ResourceController());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      allResourcesById.getAllResourcesById().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
         
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
            title: "", hideBack: false, autoAction: false),
        body: 
        Obx(() => allResourcesById.isLoading.value
                ? Helper.pageLoading()
                : allResourcesById.resourceByIdDetails.isEmpty
                      ? Center(child: TextWidget(text: "No Resource Detail Available", textSize: 16))
                      :
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                  text: allResourcesById.resourceByIdDetails[0].title,
                  textSize: 25,
                  fontWeight: FontWeight.bold,),
              Divider(
                color: AppColors.grey700,
              ),
              SizedBox(height: 12,),
              Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image:  DecorationImage(
                                image: NetworkImage(
                                  allResourcesById.resourceByIdDetails[0].logoUrl,
                                ),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(height: 16,),
              TextWidget(
                text: allResourcesById.resourceByIdDetails[0].description,
                textSize: 16,
                fontWeight: FontWeight.w500,
                maxLine: 11,
              ),
              
              
              // ListTile(
              //   dense: true,
              //   visualDensity: VisualDensity.compact,
              //   contentPadding:
              //       const EdgeInsets.only(left: 55, top: 0, bottom: 0),
              //   title: TextWidget(
              //     text: allResourcesById.resourceByIdDetails[0].files[0].name,
              //     textSize: 16,
              //     fontWeight: FontWeight.w500,
              //     maxLine: 1,
              //     color: AppColors.white,
              //   ),
              //   onTap: () {
              //     // Get.to(communitySubPages[communitySubItemsIndex]);
              //   },
              // ),
              SizedBox(height: 16,),
              if(!allResourcesById.resourceByIdDetails[0].files.isEmpty)
              TextWidget(text: "Resource Files", textSize: 20,fontWeight: FontWeight.w500,),
              SizedBox(height: 16,),
              Expanded(
                child: ListView.builder(
                            itemCount: allResourcesById.resourceByIdDetails[0].files.length,
                            itemBuilder: (context, index) {
                // Get the file name from the list
                var fileName = allResourcesById.resourceByIdDetails[0].files[index].name;
                
                return ListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  tileColor: AppColors.white12,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  // contentPadding: const EdgeInsets.only(left: 55, top: 0, bottom: 0),
                  title: Text(
                    fileName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary, // Replace with your AppColors.white if needed
                    ),
                  ),
                  trailing: TextWidget(text: "(${allResourcesById.resourceByIdDetails[0].files[index].extension.split('/').last.toUpperCase()})", textSize: 16,fontWeight: FontWeight.w500,),
                  onTap: () {
                    Helper.launchUrl(
                                                                        allResourcesById.resourceByIdDetails[0].files[index].url            );
                  },
                );
                            },
                          ),
              ),
        
            ],
          ),
        ),
      ),
      )
    );
  }
}
