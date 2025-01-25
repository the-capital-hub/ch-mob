import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';

import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  List<String> iconPath = [
    PngAssetPath.facebookIcon,
    PngAssetPath.twitterIconSmall,
    PngAssetPath.instagramIcon,
    PngAssetPath.youtubeIcon
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        drawer: const DrawerWidget(),
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Plans",
          hideBack: true,
          autoAction: true,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TabBar(
            padding: EdgeInsets.zero,
            controller: _tabController,
            isScrollable: true,
            dividerHeight: 0,
            tabAlignment: TabAlignment.start,
            indicator: BoxDecoration(
              color: AppColors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(text: "Upcoming"),
              Tab(text: "Past"),
            ],
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.white,
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            labelStyle:
                const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TabBarView(controller: _tabController, children: [
              ListView.separated(
                  itemCount: 2,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      height: 200,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                              ),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(15)),
                      child: Card(
                        color: AppColors.black.withOpacity(0.4),
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 3, bottom: 12, top: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const TextWidget(
                                  text: "Product Launch Event", textSize: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.blackCard,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.all(8),
                                    child: const TextWidget(
                                        text: "Thu.19.2020", textSize: 16),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 175,
                                    padding: const EdgeInsets.all(8),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 4,
                                      itemBuilder: (context, index) {
                                        return 
                                          CircleAvatar(
                                            backgroundColor:
                                                AppColors.whiteShade,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(9.0),
                                              child:
                                                  Image.asset(iconPath[index]),
                                            ),
                                         
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              ListView.separated(
                  itemCount: 2,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      height: 200,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                              ),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(15)),
                      child: Card(
                        color: AppColors.black.withOpacity(0.4),
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const TextWidget(
                                  text: "Product Launch Event", textSize: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.blackCard,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.all(8),
                                    child: const TextWidget(
                                        text: "Thu.19.2020", textSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 175,
                                    padding: const EdgeInsets.all(8),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 4,
                                      itemBuilder: (context, index) {
                                        return CircleAvatar(
                                          backgroundColor: AppColors.whiteShade,
                                          child: Padding(
                                            padding: const EdgeInsets.all(9.0),
                                            child: Image.asset(iconPath[index]),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ]),
          )),
        ]),
      ),
    );
  }
}
