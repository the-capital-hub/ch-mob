import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/constant/app_var.dart';
import '../../../widget/text_field/text_field.dart';

class MyStartupScreenInvestor extends StatefulWidget {
  const MyStartupScreenInvestor({super.key});

  @override
  State<MyStartupScreenInvestor> createState() =>
      _MyStartupScreenInvestorState();
}

class _MyStartupScreenInvestorState extends State<MyStartupScreenInvestor> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        drawer: const DrawerWidgetInvestor(),
        appBar: HelperAppBar.appbarHelper(
            title: "My Startups", hideBack: true, autoAction: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyCustomTextField.textField(
                    hintText: "Search",
                    controller: searchController,
                    borderRadius: 12,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.white54,
                    )),
                const SizedBox(height: 4),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: TextWidget(text: "My Investments", textSize: 16),
                ),
                const SizedBox(height: 4),
                Card(
                  color: AppColors.blackCard,
                  surfaceTintColor: AppColors.blackCard,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            FlutterLogo(),
                            SizedBox(width: 8),
                            TextWidget(text: "Bondlink", textSize: 17),
                          ],
                        ),
                        SizedBox(height: 8),
                        TextWidget(
                            maxLine: 3,
                            text:
                                "One classical breakdown of economic activity distinguishes three sectors.",
                            textSize: 14),
                        SizedBox(height: 2),
                        Divider(),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Image(
                              image: AssetImage(PngAssetPath.investedImg),
                              height: 22,
                            ),
                            SizedBox(width: 8),
                            TextWidget(text: "Invested: ", textSize: 14),
                            SizedBox(width: 4),
                            TextWidget(text: "3% Equity", textSize: 14)
                          ],
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: TextWidget(text: "My Interset", textSize: 16),
                ),
                const SizedBox(height: 4),
                Card(
                  color: AppColors.blackCard,
                  surfaceTintColor: AppColors.blackCard,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            FlutterLogo(),
                            SizedBox(width: 8),
                            TextWidget(text: "Bondlink", textSize: 17),
                          ],
                        ),
                        SizedBox(height: 8),
                        TextWidget(
                            maxLine: 3,
                            text:
                                "One classical breakdown of economic activity distinguishes three sectors.",
                            textSize: 14),
                        SizedBox(height: 2),
                        Divider(),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Image(
                              image: AssetImage(PngAssetPath.investedImg),
                              height: 22,
                            ),
                            SizedBox(width: 8),
                            TextWidget(text: "Invested: ", textSize: 14),
                            SizedBox(width: 4),
                            TextWidget(text: "3% Equity", textSize: 14)
                          ],
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  color: AppColors.blackCard,
                  surfaceTintColor: AppColors.blackCard,
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          // SfCircularChart(
                          //   margin: const EdgeInsets.all(0),
                          //   series: <DoughnutSeries<_ChartData, String>>[
                          //     DoughnutSeries<_ChartData, String>(
                          //       dataSource: getChartData(),
                          //       radius: "115",
                          //       innerRadius: "70",
                          //       xValueMapper: (_ChartData data, _) =>
                          //           data.category,
                          //       yValueMapper: (_ChartData data, _) =>
                          //           data.value,
                          //       dataLabelMapper: (_ChartData data, _) =>
                          //           '${data.value}%',
                          //       strokeColor: AppColors.blackCard,
                          //       pointColorMapper: (_ChartData data, _) =>
                          //           data.color,
                          //       dataLabelSettings: const DataLabelSettings(
                          //         isVisible: true,
                          //         // labelPosition: ChartDataLabelPosition
                          //         //     .outside, // Position the labels outside
                          //         // connectorLineSettings: ConnectorLineSettings(
                          //         //   type: ConnectorType
                          //         //       .curve, // Curve the connector lines
                          //         // ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const TextWidget(
                              text: "Total Investment\n50 Lakhs",
                              align: TextAlign.center,
                              textSize: 15)
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 8,
                                        backgroundColor: Color(0xffD3F36B)),
                                    TextWidget(
                                        text: "  Agritech 25 Lakhs",
                                        textSize: 14),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 8,
                                        backgroundColor: Color(0xff543C52)),
                                    TextWidget(
                                        text: "  Fintech 25 Lakhs",
                                        textSize: 14),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 8,
                                        backgroundColor: Color(0xffF55951)),
                                    TextWidget(
                                        text: "  Maintech 12 Lakhs",
                                        textSize: 14),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 8,
                                        backgroundColor: Color(0xff723939)),
                                    TextWidget(
                                        text: "  Bondlink 8 Lakhs",
                                        textSize: 14),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      sizedTextfield
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: TextWidget(text: "Past Investment", textSize: 16),
                ),
                const SizedBox(height: 4),
                Card(
                  color: AppColors.blackCard,
                  surfaceTintColor: AppColors.blackCard,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        
                        ListView.separated(
                          itemCount: 2,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 4);
                          },shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return 
                        Card(
                          color: AppColors.white12,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    FlutterLogo(size: 30),
                                    SizedBox(width: 10),
                                    TextWidget(
                                      text: "Mini Cubex",
                                      textSize: 16,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const TextWidget(
                                    text: "Mini cubex Finance comapny",
                                    textSize: 14),
                                const SizedBox(height: 8),
                                AppButton.primaryButton(
                                    onButtonPressed: () {},
                                    bgColor: AppColors.primaryInvestor,
                                    textColor: Colors.black,
                                    borderRadius: 12,
                                    title: "10 Lakhs"),
                              ],
                            ),
                          ),
                        );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<_ChartData> getChartData() {
    return [
      _ChartData('Bondlink', 15, const Color(0xff723939)),
      _ChartData('Maintech', 25, const Color.fromARGB(255, 222, 80, 72)),
      _ChartData('Fintech', 25, const Color(0xff543C52)),
      _ChartData('Agritech', 35, const Color(0xffD3F36B)),
    ];
  }
}

class _ChartData {
  _ChartData(this.category, this.value, this.color);
  final String category;
  final double value;
  final Color color;
}
