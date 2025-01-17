import 'package:capitalhub_crm/controller/exploreController/explore_controller.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/textWidget/text_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../controller/exploreController/explore_filter_data.dart';
import '../../utils/appcolors/app_colors.dart';
import '../../utils/constant/app_var.dart';

class FilterExploreScreen extends StatefulWidget {
  const FilterExploreScreen({super.key});

  @override
  State<FilterExploreScreen> createState() => _FilterExploreScreenState();
}

class _FilterExploreScreenState extends State<FilterExploreScreen> {
  ExploreController exploreController = Get.find();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      exploreController.getExploreFilterCollection();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Filter", action: [
          TextButton(
              onPressed: () {
                exploreController.cleaarFilter();
                exploreController.getExploreCollection().then((v) {
                  Get.back();
                });
              },
              child: TextWidget(
                text: "Clear all",
                textSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.redColor,
              ))
        ]),
        body: Obx(() => exploreController.isLoading.value
            ? Helper.pageLoading()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      if (exploreController.tabController.index == 0)
                        Column(
                          children: [
                            DropDownWidget(
                                status: exploreController.selectedSectore ??
                                    "Sector",
                                lable: "Sector",
                                statusList: ExploreFliterData.sectorList,
                                onChanged: (val) {
                                  exploreController.selectedSectore = val!;
                                  setState(() {});
                                }),
                            const SizedBox(height: 12),
                            DropDownWidget(
                                status:
                                    exploreController.selectedCity ?? "City",
                                lable: "City",
                                statusList: exploreController.cityList,
                                onChanged: (val) {
                                  exploreController.selectedCity = val!;
                                  setState(() {});
                                }),
                            const SizedBox(height: 12),
                            DropDownWidget(
                                status:
                                    exploreController.selectedEmployeeSize ??
                                        "Employee Size",
                                lable: "Employee Size",
                                statusList: ExploreFliterData.empSizeOptions,
                                onChanged: (val) {
                                  exploreController.selectedEmployeeSize = val!;
                                  setState(() {});
                                }),
                            const SizedBox(height: 12),
                            DropDownWidget(
                                status:
                                    exploreController.selectedFundingRaise ??
                                        "Funding Raised",
                                lable: "Funding Raised",
                                statusList:
                                    ExploreFliterData.fundingRaisedOptions,
                                onChanged: (val) {
                                  exploreController.selectedFundingRaise = val!;
                                  setState(() {});
                                }),
                            const SizedBox(height: 12),
                            DropDownWidget(
                                status:
                                    exploreController.selectedStartupStage ??
                                        "Startup Stage",
                                lable: "Startup Stage",
                                statusList:
                                    ExploreFliterData.startupStageOptions,
                                onChanged: (val) {
                                  exploreController.selectedStartupStage = val!;
                                  setState(() {});
                                }),
                            const SizedBox(height: 12),
                            DropDownWidget(
                                status:
                                    exploreController.selectedInvestmentStage ??
                                        "Investment Stage",
                                lable: "Investment Stage",
                                statusList:
                                    ExploreFliterData.investmentStageOptions,
                                onChanged: (val) {
                                  exploreController.selectedInvestmentStage =
                                      val!;
                                  setState(() {});
                                }),
                            const SizedBox(height: 12),
                            DropDownWidget(
                                status:
                                    exploreController.selectedAgeOfStartup ??
                                        "Age of startup",
                                lable: "Age of startup",
                                statusList: ExploreFliterData.ageOptions,
                                onChanged: (val) {
                                  exploreController.selectedAgeOfStartup = val!;
                                  setState(() {});
                                }),
                          ],
                        ),
                      if (exploreController.tabController.index == 1)
                        Column(
                          children: [
                            DropDownWidget(
                                status: exploreController.selectedSectore ??
                                    "Sector",
                                lable: "Sector",
                                statusList: ExploreFliterData.sectorList,
                                onChanged: (val) {
                                  exploreController.selectedSectore = val!;
                                  setState(() {});
                                }),
                            const SizedBox(height: 12),
                            DropDownWidget(
                                status:
                                    exploreController.selectedCity ?? "City",
                                lable: "City",
                                statusList: exploreController.cityList,
                                onChanged: (val) {
                                  exploreController.selectedCity = val!;
                                  setState(() {});
                                }),
                            const SizedBox(height: 12),
                            DropDownWidget(
                                status: exploreController.selectedGender ??
                                    "Gender",
                                lable: "Gender",
                                statusList: ExploreFliterData.genderOptions,
                                onChanged: (val) {
                                  exploreController.selectedGender = val!;
                                  setState(() {});
                                }),
                            const SizedBox(height: 12),
                            DropDownWidget(
                                status: exploreController.selectedYearOfExp ??
                                    "Year Of Experience",
                                lable: "Year Of Experience",
                                statusList:
                                    ExploreFliterData.yearsOfExperienceOptions,
                                onChanged: (val) {
                                  exploreController.selectedYearOfExp = val!;
                                  setState(() {});
                                }),
                          ],
                        ),
                      if (exploreController.tabController.index == 2)
                        Column(children: [
                          DropDownWidget(
                              status:
                                  exploreController.selectedSectore ?? "Sector",
                              lable: "Sector",
                              statusList: ExploreFliterData.sectorList,
                              onChanged: (val) {
                                exploreController.selectedSectore = val!;
                                setState(() {});
                              }),
                          const SizedBox(height: 12),
                          DropDownWidget(
                              status:
                                  exploreController.selectedCity ?? "Location",
                              lable: "Location",
                              statusList: exploreController.cityList,
                              onChanged: (val) {
                                exploreController.selectedCity = val!;
                                setState(() {});
                              }),
                          const SizedBox(height: 12),
                          DropDownWidget(
                              status:
                                  exploreController.selectedGender ?? "Gender",
                              lable: "Gender",
                              statusList: ExploreFliterData.genderOptions,
                              onChanged: (val) {
                                exploreController.selectedGender = val!;
                                setState(() {});
                              }),
                          const SizedBox(height: 12),
                          DropDownWidget(
                              status:
                                  exploreController.selectedInvestmentSize ??
                                      "Investment Size",
                              lable: "Investment Size",
                              statusList:
                                  ExploreFliterData.investmentSizeOptions,
                              onChanged: (val) {
                                exploreController.selectedInvestmentSize = val!;
                                setState(() {});
                              }),
                          const SizedBox(height: 12),
                          DropDownWidget(
                              status:
                                  exploreController.selectedInvestmentStage ??
                                      "Investment Stage",
                              lable: "Investment Stage",
                              statusList:
                                  ExploreFliterData.investmentStageOptions,
                              onChanged: (val) {
                                exploreController.selectedInvestmentStage =
                                    val!;
                                setState(() {});
                              }),
                        ]),
                      if (exploreController.tabController.index == 3)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropDownWidget(
                                status: exploreController.selectedSectore ??
                                    "Sector Focus",
                                lable: "Stage Focus",
                                statusList: ExploreFliterData.sectorList,
                                onChanged: (val) {
                                  exploreController.selectedSectore = val!;
                                  setState(() {});
                                }),
                            const SizedBox(height: 12),
                            DropDownWidget(
                                status:
                                    exploreController.selectedInvestmentStage ??
                                        "Stage Focus",
                                lable: "Stage Focus",
                                statusList:
                                    ExploreFliterData.investmentStageOptions,
                                onChanged: (val) {
                                  exploreController.selectedInvestmentStage =
                                      val!;
                                  setState(() {});
                                }),
                            const SizedBox(height: 12),
                            DropDownWidget(
                                status:
                                    exploreController.selectedInvestmentSize ??
                                        "Ticket Size",
                                lable: "Ticket Size",
                                statusList:
                                    ExploreFliterData.investmentSizeOptions,
                                onChanged: (val) {
                                  exploreController.selectedInvestmentSize =
                                      val!;
                                  setState(() {});
                                }),
                          ],
                        ),
                      SizedBox(height: 12),
                      MyCustomTextField.textField(
                          hintText: "Search",
                          lableText: "Search",
                          controller: exploreController.searchFilterController)
                    ],
                  ),
                ),
              )),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: AppButton.primaryButton(
            onButtonPressed: () {
              exploreController.getExploreCollection().then((val) {
                Get.back();
              });
            },
            title: exploreController.tabController.index ==0?"Find Startup":exploreController.tabController.index ==1?"Find Founder":exploreController.tabController.index ==2?"Find Investor":"Find VCs",
          ),
        ),
      ),
    );
  }
}
