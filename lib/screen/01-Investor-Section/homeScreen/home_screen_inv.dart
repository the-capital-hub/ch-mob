import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/constant/app_var.dart';
import '../../../widget/text_field/text_field.dart';
import '../../../widget/textwidget/text_widget.dart';
import '../../chatScreen/chat_member_screen.dart';
import '../drawerScreen/drawer_screen_inv.dart';

class HomeScreenInvestor extends StatefulWidget {
  const HomeScreenInvestor({super.key});

  @override
  State<HomeScreenInvestor> createState() => _HomeScreenInvestorState();
}

class _HomeScreenInvestorState extends State<HomeScreenInvestor>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds:
              300), // 0.3 seconds here is the length of the animation itself
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _scaleAnimation = Tween<double>(begin: 50, end: 100).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

// continued from code above
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animate() {
    _animationController.reset();

    _animationController.forward();
    isLiked = true;
    Future.delayed(const Duration(milliseconds: 1000), () {
      _animationController.reverse();
    });
    setState(() {});
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          drawer: const DrawerWidgetInvestor(),
          appBar: AppBar(
            backgroundColor: AppColors.black,
            iconTheme: IconThemeData(color: AppColors.white),
            titleSpacing: 0,
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: "Good Morning", textSize: 12),
                SizedBox(height: 3),
                TextWidget(text: "Pramod Badiger", textSize: 16),
              ],
            ),
            actions: [
              const Icon(Icons.notifications_none_sharp),
              const SizedBox(width: 8),
              InkWell(
                  onTap: () {
                    Get.to(const ChatMemberScreen());
                  },
                  child: const Icon(
                    CupertinoIcons.chat_bubble_text,
                    size: 22,
                  )),
              const SizedBox(width: 8),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                MyCustomTextField.textField(
                    hintText: "Search",
                    controller: searchController,
                    borderRadius: 12,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.white54,
                    )),
                Expanded(
                  child: ListView.separated(
                    itemCount: 10,
                    padding: const EdgeInsets.only(top: 8),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onDoubleTap: _animate,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Card(elevation: 4, shadowColor: AppColors.white54,
                              color: AppColors.blackCard,
                              surfaceTintColor: AppColors.blackCard,
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                            'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const TextWidget(
                                                    text: "Capital Hub",
                                                    textSize: 14),
                                                const SizedBox(width: 4),
                                                TextWidget(
                                                  text:
                                                      "@Pramodbadiger@21 . 11h",
                                                  textSize: 10,
                                                  color: AppColors.white54,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            TextWidget(
                                              text: "Fonder | Start up ideas",
                                              textSize: 12,
                                              color: AppColors.whiteCard,
                                            ),
                                            const SizedBox(height: 3),
                                            const TextWidget(
                                                text: "Bangaluru",
                                                textSize: 12),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      InkWell(
                                        onTap: () {
                                          feedBottomSheet();
                                        },
                                        child: Icon(
                                          Icons.more_vert_rounded,
                                          color: AppColors.whiteCard,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                    height: 0,
                                    color: AppColors.white38,
                                    thickness: 0.5),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      const TextWidget(
                                        text:
                                            "In startups , i always felt like i belonged. I began my design career with a small startup and have worked in a variety of companies since then. The majority of the places I’ve worked were small companies with a small number of passionate people willing to make mistake, build quickly, and break things.",
                                        textSize: 12,
                                        maxLine: 10,
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: const DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://cdn.prod.website-files.com/641d54fdcc011edcca41c54a/644246192862f4c4419415de_631ad283d03462d6356d411d_How-Digital-Gold-Investment-for-a-longer-period-can-make-you-Rich-1920X1080.jpeg"),
                                              ))),
                                    ],
                                  ),
                                ),
                                Divider(
                                    height: 0,
                                    color: AppColors.white38,
                                    thickness: 0.5),
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
                                      const SizedBox(width: 4),
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundColor: AppColors.white12,
                                        child: Icon(
                                          CupertinoIcons.chat_bubble_text_fill,
                                          color: AppColors.whiteCard,
                                          size: 15,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Expanded(
                                        child: TextWidget(
                                          text: "Harideep and 121 Others",
                                          textSize: 10,
                                          maxLine: 2,
                                        ),
                                      ),
                                      const TextWidget(
                                          text: "150 Comments ● 120 Likes",
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
                                          isLiked = !isLiked;
                                          setState(() {});
                                        },
                                        child: Icon(
                                          isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          color: isLiked
                                              ? AppColors.redColor
                                              : AppColors.whiteCard,
                                          size: 22,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const TextWidget(
                                          text: "Like", textSize: 13),
                                      const SizedBox(width: 10),
                                      Icon(
                                        CupertinoIcons.chat_bubble_text,
                                        color: AppColors.whiteCard,
                                        size: 21,
                                      ),
                                      const SizedBox(width: 4),
                                      const TextWidget(
                                          text: "Comments", textSize: 13),
                                      const Spacer(),
                                      Icon(
                                        Icons.bookmark_border_outlined,
                                        color: AppColors.whiteCard,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            ),
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return Opacity(
                                  opacity: _opacityAnimation.value,
                                  child: Icon(
                                    Icons.favorite,
                                    size: _scaleAnimation.value,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  bool isLiked = false;
  feedBottomSheet() {
    return Get.bottomSheet(
        backgroundColor: AppColors.blackCard,
        Container(
          height: 251,
          width: Get.width,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              Container(
                height: 3,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.whiteCard),
              ),
              ListTile(
                leading: Icon(Icons.update, color: AppColors.white),
                title: const TextWidget(
                  text: "Update the post",
                  textSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                leading: Icon(Icons.share, color: AppColors.white),
                title: const TextWidget(
                  text: "Share Via",
                  textSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                leading: Icon(Icons.cancel, color: AppColors.white),
                title: const TextWidget(
                  text: "Unfollow Capital Hub",
                  textSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                leading:
                    Icon(Icons.visibility_off_rounded, color: AppColors.white),
                title: const TextWidget(
                  text: "I don’t want to see this post",
                  textSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ));
  }
}
