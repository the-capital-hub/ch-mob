import 'package:capitalhub_crm/controller/campaignsController/campaigns_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/placeholder.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/campaignModel/outreach_view_model.dart';
import '../../../widget/dilogue/campaignDilogue/schedule_campaign_dilogue.dart';

class ViewOutreachScreen extends StatefulWidget {
  String id;

  ViewOutreachScreen({super.key, required this.id});

  @override
  State<ViewOutreachScreen> createState() => _ViewOutreachScreenState();
}

class _ViewOutreachScreenState extends State<ViewOutreachScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  CampaignsController campaignsController = Get.find();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    campaignsController.getOutrechView(widget.id).then((v) {
      items = [
        {
          "title": "Sent",
          "icon": Icons.mail,
          "color": Colors.blue,
          "value": campaignsController.outreachView.overview?.sent ?? 0,
        },
        {
          "title": "Opened",
          "icon": Icons.remove_red_eye,
          "color": Colors.green,
          "value": campaignsController.outreachView.overview?.opened ?? 0,
        },
        {
          "title": "Clicked",
          "icon": Icons.mouse,
          "color": Colors.amber,
          "value": campaignsController.outreachView.overview?.clicked ?? 0,
        },
        {
          "title": "Replied",
          "icon": Icons.reply,
          "color": Colors.purple,
          "value": campaignsController.outreachView.overview?.replied ?? 0,
        },
        {
          "title": "Bounced",
          "icon": Icons.error,
          "color": Colors.red,
          "value": campaignsController.outreachView.overview?.bounced ?? 0,
        },
      ];
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Obx(() => campaignsController.isOutreachViewLoading.value
          ? SafeArea(child:  ShimmerLoader.shimmerOutreachView())
          : Scaffold(
              backgroundColor: AppColors.transparent,
              appBar: HelperAppBar.appbarHelper(
                  title: "${campaignsController.outreachView.campaignName}"),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                        text:
                            "Created: ${campaignsController.outreachView.campaignCreatedAt}",
                        color: AppColors.whiteShade,
                        align: TextAlign.right,
                        textSize: 14),
                    if (campaignsController.outreachView.status == "scheduled")
                      TextWidget(
                          text:
                              "Schedule: ${campaignsController.outreachView.campaignScheduledAt}",
                          color: AppColors.whiteShade,
                          align: TextAlign.right,
                          textSize: 14),
                    if (campaignsController.outreachView.status == "completed")
                      TextWidget(
                          text:
                              "Sent: ${campaignsController.outreachView.campaignSentAt}",
                          color: AppColors.whiteShade,
                          align: TextAlign.right,
                          textSize: 14),
                    sizedTextfield,
                    if (campaignsController.outreachView.status == "draft" ||
                        campaignsController.outreachView.status == "scheduled")
                      Row(
                        children: [
                          Expanded(
                              child: AppButton.primaryButton(
                                  borderRadius: 8,
                                  bgColor:
                                      campaignsController.outreachView.status ==
                                              "scheduled"
                                          ? AppColors.redColor
                                          : AppColors.blue,
                                  onButtonPressed: () {
                                    if (campaignsController
                                            .outreachView.status ==
                                        "scheduled") {
                                      Helper.loader(context);
                                      campaignsController
                                          .scheduleOutreachCampaign(
                                              id: campaignsController
                                                  .outreachView.campaignId!,
                                              fromViewScreen: true,
                                              isCancel: true)
                                          .then((v) {
                                        setState(() {});
                                      });
                                    } else {
                                      scheduleCampaignPopup(context, () {
                                        Helper.loader(context);
                                        campaignsController
                                            .scheduleOutreachCampaign(
                                                isCancel: false,
                                                fromViewScreen: true,
                                                id: campaignsController
                                                    .outreachView.campaignId!)
                                            .then((v) {
                                          setState(() {});
                                        });
                                      });
                                    }
                                  },
                                  title:
                                      campaignsController.outreachView.status ==
                                              "scheduled"
                                          ? "Cancel"
                                          : "Schedule")),
                          const SizedBox(width: 12),
                          Expanded(
                              child: AppButton.primaryButton(
                                  borderRadius: 8,
                                  bgColor: AppColors.green700,
                                  onButtonPressed: () {
                                    Helper.loader(context);
                                    campaignsController
                                        .runOutreachCampaign(widget.id, true)
                                        .then((v) {
                                      setState(() {});
                                    });
                                  },
                                  title: "Send Now")),
                        ],
                      ),
                    sizedTextfield,
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.white12),
                      child: TabBar(
                        controller: tabController,
                        indicator: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        indicatorPadding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 6),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: AppColors.white,
                        dividerColor: AppColors.transparent,
                        dividerHeight: 0,
                        unselectedLabelColor: AppColors.whiteShade,
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        tabs: const [
                          Tab(text: "Overview"),
                          Tab(text: "Recipients"),
                          Tab(text: "Content"),
                        ],
                      ),
                    ),
                    sizedTextfield,
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: [overview(), recipients(), content()],
                      ),
                    ),
                  ],
                ),
              ),
            )),
    );
  }

  List<Map<String, dynamic>> items = [];
  Widget _buildGridItem(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blackCard,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: CircleAvatar(
              backgroundColor: item["color"],
              radius: 23,
              child: Icon(item["icon"], color: Colors.white, size: 26),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(textSize: 14, text: item["title"]),
                const SizedBox(height: 6),
                TextWidget(textSize: 14, text: item['value']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  overview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: 1.6,
          children: items.map((item) => _buildGridItem(item)).toList(),
        ),
        sizedTextfield,
        const TextWidget(
            text: "Investor Lists", textSize: 16, fontWeight: FontWeight.w500),
        sizedTextfield,
        SizedBox(
          height: 55,
          child: ListView.separated(
            itemCount: campaignsController
                .outreachView.overview!.investorLists!.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 150,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: AppColors.blackCard,
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: TextWidget(
                    text: campaignsController
                        .outreachView.overview!.investorLists![index],
                    maxLine: 2,
                    align: TextAlign.left,
                    textSize: 14),
              );
            },
          ),
        ),
      ],
    );
  }

  recipients() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: AppColors.white,
            unselectedLabelColor: AppColors.grey,
            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3.0,
            tabs: [
              Tab(
                  text:
                      "Investors (${campaignsController.outreachView.recipients!.investors!.length})"),
              Tab(
                  text:
                      "VCs (${campaignsController.outreachView.recipients!.vcs!.length})"),
            ],
          ),
          sizedTextfield,
          Expanded(
            child: TabBarView(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: campaignsController
                        .outreachView.recipients!.investors!.isEmpty
                    ? const Center(child: TextWidget(text: "No Data Found", textSize: 14))
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 25,
                          headingRowHeight: 50,
                          dataRowHeight: 45,
                          dividerThickness: 0.4,
                          horizontalMargin: 20,
                          border: TableBorder.all(
                              color: AppColors.white38,
                              width: 1,
                              borderRadius: BorderRadius.circular(12)),
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return AppColors.white12;
                            },
                          ),
                          columns: const [
                            DataColumn(
                                label: SizedBox(
                                    width: 140,
                                    child: TextWidget(
                                        text: "Investor",
                                        align: TextAlign.center,
                                        textSize: 15))),
                            DataColumn(
                                label: SizedBox(
                                    width: 165,
                                    child: TextWidget(
                                        text: "Email",
                                        align: TextAlign.center,
                                        textSize: 15))),
                            DataColumn(
                                label: SizedBox(
                                    width: 80,
                                    child: TextWidget(
                                        text: "Status",
                                        align: TextAlign.center,
                                        textSize: 15))),
                            DataColumn(
                                label:
                                    TextWidget(text: "Opened", textSize: 15)),
                            DataColumn(
                                label:
                                    TextWidget(text: "Clicked", textSize: 15)),
                            DataColumn(
                                label:
                                    TextWidget(text: "Replied", textSize: 15)),
                          ],
                          rows: List.generate(
                              campaignsController.outreachView.recipients!
                                  .investors!.length, (ind) {
                            Investor investor = campaignsController
                                .outreachView.recipients!.investors![ind];
                            return _buildDataRow(
                              context,
                              investor,
                              ind,
                            );
                          }),
                        ),
                      ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: campaignsController
                        .outreachView.recipients!.vcs!.isEmpty
                    ? const Center(child: TextWidget(text: "No Data Found", textSize: 14))
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 25,
                    headingRowHeight: 50,
                    dataRowHeight: 45,
                    dividerThickness: 0.4,
                    horizontalMargin: 20,
                    border: TableBorder.all(
                        color: AppColors.white38,
                        width: 1,
                        borderRadius: BorderRadius.circular(12)),
                    headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        return AppColors.white12;
                      },
                    ),
                    columns: const [
                      DataColumn(
                          label: SizedBox(
                              width: 140,
                              child: TextWidget(
                                  text: "VCs",
                                  align: TextAlign.center,
                                  textSize: 15))),
                      DataColumn(
                          label: SizedBox(
                              width: 165,
                              child: TextWidget(
                                  text: "Email",
                                  align: TextAlign.center,
                                  textSize: 15))),
                      DataColumn(
                          label: SizedBox(
                              width: 80,
                              child: TextWidget(
                                  text: "Status",
                                  align: TextAlign.center,
                                  textSize: 15))),
                      DataColumn(
                          label: TextWidget(text: "Opened", textSize: 15)),
                      DataColumn(
                          label: TextWidget(text: "Clicked", textSize: 15)),
                      DataColumn(
                          label: TextWidget(text: "Replied", textSize: 15)),
                    ],
                    rows: List.generate(
                        campaignsController
                            .outreachView.recipients!.vcs!.length, (ind) {
                      VCs vcs = campaignsController
                          .outreachView.recipients!.vcs![ind];
                      return _buildDataRowVcs(
                        context,
                        vcs,
                        ind,
                      );
                    }),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(BuildContext context, Investor investor, int index) {
    return DataRow(
      color: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return index.isEven ? AppColors.transparent : AppColors.white12;
        },
      ),
      cells: [
        DataCell(SizedBox(
            width: 140,
            child: TextWidget(
                text: "${investor.firstName!} ${investor.lastName!}",
                align: TextAlign.center,
                maxLine: 2,
                textSize: 14))),
        DataCell(SizedBox(
            width: 165,
            child: TextWidget(
                text: investor.email!,
                align: TextAlign.center,
                maxLine: 2,
                textSize: 14))),
        DataCell(_buildStatusBadge(investor.status!)),
        DataCell(Center(
            child: TextWidget(text: investor.emailOpened!, textSize: 14))),
        DataCell(Center(
            child: TextWidget(text: investor.emailClicked!, textSize: 14))),
        DataCell(Center(
            child: TextWidget(text: investor.emailReplied!, textSize: 14))),
      ],
    );
  }

  DataRow _buildDataRowVcs(BuildContext context, VCs vcs, int index) {
    return DataRow(
      color: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return index.isEven ? AppColors.transparent : AppColors.white12;
        },
      ),
      cells: [
        DataCell(SizedBox(
            width: 140,
            child: TextWidget(
                text: "${vcs.name}",
                align: TextAlign.center,
                maxLine: 2,
                textSize: 14))),
        DataCell(SizedBox(
            width: 165,
            child: TextWidget(
                text: vcs.email!,
                align: TextAlign.center,
                maxLine: 2,
                textSize: 14))),
        DataCell(_buildStatusBadge(vcs.status!)),
        DataCell(
            Center(child: TextWidget(text: vcs.emailOpened!, textSize: 14))),
        DataCell(
            Center(child: TextWidget(text: vcs.emailClicked!, textSize: 14))),
        DataCell(
            Center(child: TextWidget(text: vcs.emailReplied!, textSize: 14))),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color badgeColor;
    Color textColor;

    switch (status) {
      case "pending":
        badgeColor = Colors.brown;
        textColor = AppColors.white;
        break;
      case "sent":
        badgeColor = AppColors.green700;
        textColor = AppColors.white;
        break;
      default:
        badgeColor = AppColors.redColor;
        textColor = AppColors.white;
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        decoration: BoxDecoration(
          color: badgeColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: TextWidget(
          text: status.capitalizeFirst!,
          color: textColor,
          textSize: 14,
        ),
      ),
    );
  }

  content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedTextfield,
        Card(
          color: AppColors.blackCard,
          surfaceTintColor: AppColors.blackCard,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(text: "Subject", textSize: 14),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        text: campaignsController
                            .outreachView.emailContent!.subject!,
                        textSize: 16,
                        maxLine: 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        sizedTextfield,
        Card(
          color: AppColors.blackCard,
          surfaceTintColor: AppColors.blackCard,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(text: "Body", textSize: 14),
                const SizedBox(height: 4),
                HtmlWidget(
                  campaignsController.outreachView.emailContent!.body!,
                  onTapUrl: (url) async {
                    return await launch(url);
                  },
                  textStyle: TextStyle(fontSize: 12, color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
