import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommunityHomeScreen extends StatefulWidget {
  const CommunityHomeScreen({super.key});

  @override
  State<CommunityHomeScreen> createState() => _CommunityHomeScreenState();
}

class _CommunityHomeScreenState extends State<CommunityHomeScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        drawer: const DrawerWidget(),
        appBar: HelperAppBar.appbarHelper(
          title: "Home",
          hideBack: true,
          autoAction: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage(PngAssetPath.accountImg),
                              ),
                              SizedBox(width: 8),
                              Flexible(child: MyCustomTextField.textField(
                    fillColor: AppColors.blackCard,
                    hintText: "Share an idea",
                    controller: searchController),),
                    SizedBox(width: 8),

                    CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.primary,
                                child: TextWidget(text: "Post", textSize: 16),
                              ),
                              SizedBox(width: 8),
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.primary,
                                child: Icon(Icons.filter_list,color: AppColors.white,)
                              ),
                    
                    
                    ],),
                
                       

              
              sizedTextfield,
              Flexible(
                child: ListView.separated(
                    itemCount: 2,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                    itemBuilder: (context, index) {
                      return feeds(index);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
  feeds(index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Card(
          elevation: 3,
          shadowColor: AppColors.white38,
          color: AppColors.blackCard,
          surfaceTintColor: AppColors.blackCard,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor:
                        AppColors.golden,
                            
                    radius: 22,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          '"https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1"'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                // Get.to(PublicProfileScreen(
                                //     id: homeController
                                //         .postList[index].userId!));
                              },
                              child: TextWidget(
                                  text:
                                      "Suresh Kumar",
                                  textSize: 14),
                            ),
                            const SizedBox(width: 4),
                            
                              Image.asset(PngAssetPath.verifyImg,
                                  height: 14),
                            const SizedBox(width: 4),
                            TextWidget(
                              text:
                                  "${21-12-2024}",
                              textSize: 10,
                              color: AppColors.white54,
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                
                              },
                              child: TextWidget(
                                // text: "",
                                text: 
                                     "Follow",
                                    
                                textSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                            )
                          ],
                        ),
                        // const SizedBox(height: 1),
                        TextWidget(
                          text:
                              "Developer at CapitalHub",
                          textSize: 12,
                          color: AppColors.whiteCard,
                        ),
                        // const SizedBox(height: 1),
                        const TextWidget(text: "Bangalore", textSize: 12),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                 
                    InkWell(
                      
                      child: Icon(
                        Icons.more_vert_rounded,
                        color: AppColors.whiteCard,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),
            Divider(height: 0, color: AppColors.white38, thickness: 0.5),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  
                    
                        
                  
                 
                  
                  
                    // Column(children: [
                    //   SizedBox(
                    //     height: 250,
                    //     child: PageView.builder(
                         
                    //       itemCount: homeController
                    //           .postList[index].image!.length,
                    //       onPageChanged: (index) {
                    //         setState(() {
                    //           _currentIndex = index;
                    //         });
                    //       },
                    //       itemBuilder: (context, ind) {
                    //         return Padding(
                    //           padding: const EdgeInsets.symmetric(
                    //               horizontal: 4),
                    //           child: InkWell(
                    //             onTap: () {
                                 
                    //             },
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                 borderRadius:
                    //                     BorderRadius.circular(12),
                    //                 image: DecorationImage(
                    //                   fit: BoxFit.cover,
                    //                   image: NetworkImage("https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1"),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
    
                    //   // Page Indicator
                      
                    // ]),
                 
                  TextWidget(text: "Guide to Raising Angel Investments for Indian Founders - A 10-Minute Read by Capital HUB", textSize: 16,maxLine: 2,),

                  SizedBox(height: 8,),

                  TextWidget(text: "Raising angel investments is a crucial step for early-stage startups, especially in the vibrant Indian startup ecosystem. This guide, designed specifically for young founders, will walk you through the essentials of securing angel investment to fuel your venture’s growth. Understanding the dynamics of angel funding can empower you to navigate the fundraising process with confidence.", textSize: 12,maxLine: 6,)
,SizedBox(height: 8,)
                 ,Container(
                      height: 200,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                              ),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(2)),
                    ),
                    // Container(
                    //     padding: const EdgeInsets.all(8),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(12),
                    //         color: AppColors.transparent),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         TextWidget(
                    //           text: "   Reshared Post",
                    //           textSize: 12,
                    //           color: AppColors.grey,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                            
                    //       ],
                    //     ))
                ],
              ),
            ),
            Divider(height: 0, color: AppColors.white38, thickness: 0.5),
            
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.white12,
                      child: const Icon(
                        Icons.favorite,
                        color: AppColors.redColor,
                        size: 15,
                      ),
                    ),
                    // const SizedBox(width: 4),
                    // CircleAvatar(
                    //   radius: 12,
                    //   backgroundColor:
                    //       AppColors.white12,
                    //   child: Icon(
                    //     CupertinoIcons
                    //         .chat_bubble_text_fill,
                    //     color: AppColors.whiteCard,
                    //     size: 15,
                    //   ),
                    // ),
                    const SizedBox(width: 8),
                    
                      Expanded(
                        child: TextWidget(
                          text:
                              "Suresh Kumar and Many Others",
                          textSize: 11,
                          maxLine: 2,
                        ),
                      ),
                    
                      TextWidget(
                          text:
                              "Comments",
                          textSize: 10)
                  ],
                ),
              ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  color: Color(0xff54545433)),
              child: Row(
                children: [
                  InkWell(
                    splashColor: AppColors.transparent,
                    onTap: () {
                      
                    },
                    child: Icon(
                       Icons.favorite,
                          
                      color: 
                          AppColors.redColor,
                           
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const TextWidget(text: "Like", textSize: 13),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                     
                    },
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.chat_bubble_text,
                          color: AppColors.whiteCard,
                          size: 21,
                        ),
                        const SizedBox(width: 4),
                        const TextWidget(text: "Comments", textSize: 13),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      
                    },
                    child: Icon(
                      Icons.mobile_screen_share_rounded,
                      color: AppColors.whiteCard,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                     
                    },
                    child: Transform.rotate(
                      angle: 0.77,
                      child: Icon(
                        Icons.screen_rotation_alt,
                        color: AppColors.whiteCard,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      
                    },
                    child: Icon(
                       Icons.bookmark,
                          
                      color: AppColors.whiteCard,
                      size: 22,
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
        
      ],
    );
  }
}