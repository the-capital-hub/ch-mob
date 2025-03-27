import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          drawer: const DrawerWidget(),
          backgroundColor: AppColors.black,
          appBar: HelperAppBar.appbarHelper(
              title: "Help", hideBack: true, autoAction: true),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.help_outline, color: AppColors.primary),
                      SizedBox(width: 12),
                      TextWidget(text: "Help Center", textSize: 16),
                    ],
                  ),
                  sizedTextfield,
                  const TextWidget(
                      text: "Hello, how can we help ?",
                      textSize: 22,
                      fontWeight: FontWeight.w500),
                  sizedTextfield,
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: AppColors.blackCard,
                        surfaceTintColor: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Image.asset(imageList[index], height: 85),
                              sizedTextfield,
                              TextWidget(
                                  text: titleList[index],
                                  maxLine: 2,
                                  align: TextAlign.center,
                                  textSize: 15)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  sizedTextfield,
                  const Row(
                    children: [
                      Icon(Icons.article_outlined, color: AppColors.primary),
                      SizedBox(width: 8),
                      TextWidget(
                          text: "Featured Articles",
                          textSize: 16,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                  sizedTextfield,
                  Card(
                    color: AppColors.blackCard,
                    surfaceTintColor: AppColors.blackCard,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Card(
                        color: AppColors.white12,
                        child: ListView.separated(
                          itemCount: questions.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return const Divider(height: 0);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                                position: index,
                                delay: const Duration(milliseconds: 100),
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  // horizontalOffset: 1000,
                                  verticalOffset: 50.0,
                                  child: ExpansionTile(
                                    title: TextWidget(
                                      text: questions[index]['q']!,
                                      maxLine: 5,
                                      textSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    iconColor: AppColors.white,
                                    collapsedIconColor: AppColors.white,
                                    childrenPadding: const EdgeInsets.all(12),
                                    children: [
                                      TextWidget(
                                          text: questions[index]['a']!,
                                          textSize: 13,
                                          color: AppColors.whiteShade,
                                          maxLine: 51)
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  var imageList = [
    PngAssetPath.contactusImg,
    PngAssetPath.mailImg,
    // PngAssetPath.accountImg,
    // PngAssetPath.helpImg
  ];
  var titleList = [
    "Contact us",
    "Mail us",
    // "Account, Profile and Network",
    // "Get Help"
  ];
  List<Map<String, String>> questions = [
    {
      "q": "What is the 'OneLink' feature on Capital Hub?",
      "a":
          "The 'OneLink' feature on Capital Hub allows users to express their interest in a startup's profile with a single click."
    },
    {
      "q": "Is the 'OneLink' feature visible to other users on Capital Hub?",
      "a":
          "No, the 'OneLink' feature is a private action. It does not display your interest to other users, maintaining your privacy."
    },
    {
      "q": "How does the 'Explore' feature on Capital Hub work?",
      "a":
          "The 'Explore' feature allows users to discover and filter startups, founders, and investors according to their preferences and criteria."
    },
    {
      "q":
          "Can I filter startups by industry or sector using the 'Explore' feature?",
      "a":
          "Yes, you can filter startups by industry, sector, or other relevant criteria to find opportunities that align with your interests."
    },
    {
      "q":
          "What criteria can I use to filter founders or investors in the 'Explore' section?",
      "a":
          "The criteria may include location, experience, investment preferences, and more, enabling you to find the right founders or investors for your needs."
    },
    {
      "q": "Are the search results in 'Explore' updated in real-time?",
      "a":
          "The search results are typically updated in real-time, ensuring you have access to the most current profiles that match your filters."
    },
    {
      "q":
          "Can I use the 'Explore' feature to network with other users on Capital Hub?",
      "a":
          "Yes, the 'Explore' feature not only helps you find opportunities but also facilitates networking and connections with like-minded users."
    },
    {
      "q":
          "Can I upload documents to Capital Hub for my startup or investment profile?",
      "a":
          "Yes, Capital Hub allows users to upload relevant documents, such as business plans, pitch decks, financial statements, and more, to enhance their profiles."
    },
    {
      "q": "How do I upload documents to my Capital Hub profile?",
      "a":
          "To upload documents, access your profile, and look for the 'Document Upload' section. Follow the instructions to upload and manage your files."
    },
    {
      "q":
          "Are the uploaded documents visible to all users, or can I control who accesses them?",
      "a":
          "You can typically control the visibility of your documents. You can choose to share them with specific users or make them public on your profile."
    },
    {
      "q": "How do I create a post on Capital Hub?",
      "a":
          "To create a post, log in to your Capital Hub account, navigate to the 'Create Post' section, and follow the provided prompts to compose and share your content."
    },
    {
      "q": "What can I post on Capital Hub using the 'Create Post' feature?",
      "a":
          "You can share a variety of content, including news, articles, updates about your startup, investment insights, industry trends, and more."
    },
    {
      "q": "What is the 'Create Community' feature, and how does it work?",
      "a":
          "'Create Community' allows users to establish their own dedicated community spaces within Capital Hub, tailored to specific interests or industries."
    },
    {
      "q": "How can I create a community on Capital Hub?",
      "a":
          "To create a community, go to the 'Create Community' section, provide the necessary details, and customize your community's settings and preferences."
    },
    {
      "q":
          "Can I invite specific users to join my community, or is it open to all Capital Hub members?",
      "a":
          "Depending on your preferences, you can make your community public and open to all members or send invitations to specific users to join."
    },
    {
      "q":
          "How do I access the 'My Community' dashboard as a community administrator?",
      "a":
          "As an administrator, you can access the 'My Community' dashboard by visiting your community and clicking on the administrative options."
    },
    {
      "q":
          "Can I customize the look and feel of my community using 'My Community'?",
      "a":
          "Yes, 'My Community' typically provides customization options for the community's appearance, rules, and settings."
    },
    {
      "q":
          "What tools are available in 'My Community' for member management and moderation?",
      "a":
          "'My Community' often offers tools for member invites, content moderation, member roles, and other features to help you maintain a positive community environment."
    },
    {
      "q": "How do I save a post on Capital Hub for future reference?",
      "a":
          "To save a post, you can typically click on a 'Save' or 'Bookmark' option associated with the post."
    },
    {
      "q": "Are saved posts visible to other users on Capital Hub?",
      "a":
          "Saved posts are generally private and visible only to you. They serve as a personal collection of content you wish to revisit."
    }
  ];
}
