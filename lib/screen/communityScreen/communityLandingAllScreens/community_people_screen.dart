import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/community_drawer_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunityPeopleScreen extends StatefulWidget {
  const CommunityPeopleScreen({super.key});

  @override
  State<CommunityPeopleScreen> createState() => _CommunityPeopleScreenState();
}

class _CommunityPeopleScreenState extends State<CommunityPeopleScreen> {
  TextEditingController searchController = TextEditingController();
List<String> communityNames = [
    "Capital Hub Community",
    "Hub Community",
    "Hustler's Community",
    "Pixel Community",
    "Monday Community",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
        child: Scaffold(
          drawer: const CommunityDrawerWidget(),
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "People",
            hideBack: true,
            autoAction: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12), // Padding around the card
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Row(children: [TextWidget(text: "At a ", textSize: 25,fontWeight: FontWeight.bold,),TextWidget(text: "Glance", textSize: 25,color: AppColors.primary,fontWeight: FontWeight.bold,)],),
                Card(
                  
                   color: AppColors.blackCard,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12), // Rounded corners for the card
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text: "20", textSize: 25),
                        TextWidget(text: "Total Member", textSize: 13),
                        Divider(thickness: 1,color: AppColors.white38,),
                        TextWidget(text: "3", textSize: 25),
                        TextWidget(text: "Country", textSize: 13),
                        Divider(thickness: 1,color: AppColors.white38,),
                        TextWidget(text: "Chat On", textSize: 13),
                        Divider(thickness: 1,color: AppColors.white38,),
                        Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 8),
                                Flexible(child: MyCustomTextField.textField(
                                  prefixIcon: Icon(Icons.search),
                                  fillColor: AppColors.white,
                      
                      hintText: "Search for member",
                      controller: searchController),),
                      SizedBox(width: 8),
                    
                     
                                SizedBox(width: 8),
                                //                   InkWell(
                                //                     child: CircleAvatar(
                                //                       radius: 25,
                                //                       backgroundColor: AppColors.primary,
                                //                       child: Icon(Icons.filter_list,color: AppColors.white,)
                                //                     ),
                                //                     onTap: (){
                                //         //               DropDownWidget(
                                //         // status: postType,
                                //         // lable: "Filter",
                                //         // statusList: const ["Public", "Private", "Pitch Day"],
                                //         // onChanged: (val) {
                                //         //   setState(() {
                                //         //     privacyStatus = val.toString();
                                //         //   });
                                //         // });
                                //           DropdownButton<String>(
                                //   value: selectedItem,
                                //   onChanged: (String? newValue) {
                                //     setState(() {
                                //       selectedItem = newValue!;
                                //     });
                                //   },
                                //   items: postType.map<DropdownMenuItem<String>>((String value) {
                                //     return DropdownMenuItem<String>(
                                //       value: value,
                                //       child: Text(value),
                                //     );
                                //   }).toList(),
                                // ),
                                //         }
                                //                   ),
                      CircleAvatar(
                        radius: 20,
                                  backgroundColor: AppColors.primary,
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.filter_list),
                        iconColor: AppColors.white,
                        color: AppColors.blackCard,
                        offset: Offset(0, 55),
                        onSelected: (value) {
                         
                          },
                        
                        itemBuilder: (context) => [
                              const PopupMenuItem(
                                
                                child: TextWidget(text: "All Posts", textSize: 14),
                              ),
                              PopupMenuItem(
                                
                                child: TextWidget(text:
                                     "Admin Posts",
                                      
                                    textSize: 14),
                              ),
                              const PopupMenuItem(
                                
                                child: TextWidget(text: "Member Posts", textSize: 14),
                              ),
                            ]),
                      )
                      
                      ],),
                        Container(
                          height: 200,
                          width: 200,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                              thickness: 1,
                                              color: AppColors.white54,
                                            ),
                            shrinkWrap:
                                true, // Makes ListView take only as much space as it needs
                            padding:
                                EdgeInsets.zero, // Remove extra padding from ListView
                            itemCount: communityNames.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                  "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                                  ),
                                //  backgroundColor: AppColors.blue,
                                ),
                                title: TextWidget(text: communityNames[index], textSize: 16),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
        )
        );
  }

}
