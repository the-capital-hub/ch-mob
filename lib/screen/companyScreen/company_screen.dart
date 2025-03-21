import 'dart:async';

import 'package:capitalhub_crm/controller/companyController/company_controller.dart';
import 'package:capitalhub_crm/screen/companyScreen/add_company_screen.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/01-StartupModel/companyModel/company_search_moel.dart';
import '../../utils/appcolors/app_colors.dart';
import '../../utils/constant/app_var.dart';
import '../../utils/constant/asset_constant.dart';
import '../../utils/helper/helper.dart';
import '../../widget/appbar/appbar.dart';
import '../../widget/textwidget/text_widget.dart';
import '../drawerScreen/drawer_screen.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  CompanyController companyController = Get.put(CompanyController());
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  @override
  void initState() {
    companyController.getCompanyDetail();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    _overlayEntry?.remove();
    super.dispose();
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      if (query.isNotEmpty) {
        await companyController.getCompanyList(query);
        // setState(() {});
        _showOverlay();
      } else {
        _removeOverlay();
      }
    });
  }

  void _showOverlay() {
    _removeOverlay();
    _overlayEntry = _createOverlayEntry();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Overlay.of(context).insert(_overlayEntry!);
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: Get.width - 30,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 85),
          child: Material(
            elevation: 4.0,
            color: AppColors.blackCard,
            borderRadius: BorderRadius.circular(10),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: companyController.isLoadingList.value
                  ? Helper.loader(context)
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: companyController.companyList.length,
                      separatorBuilder: (context, index) {
                        return const Divider(height: 0);
                      },
                      itemBuilder: (context, index) {
                        return ListTile(
                          visualDensity: VisualDensity.compact,
                          title: TextWidget(
                              text:
                                  companyController.companyList[index].company!,
                              textSize: 14),
                          onTap: () {
                            searchController.clear();
                            companyController.addCompanyToUser(context,
                                companyController.companyList[index].id);

                            _removeOverlay();
                          },
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
          backgroundColor: AppColors.transparent,
          drawer: const DrawerWidget(),
          appBar: HelperAppBar.appbarHelper(
              title: "Company", hideBack: true, autoAction: true),
          body: Obx(
            () => companyController.isLoading.value
                ? Helper.pageLoading()
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CompositedTransformTarget(
                                  link: _layerLink,
                                  child: MyCustomTextField.textField(
                                      lableText:
                                          "Choose from an existing company",
                                      hintText: "Search",
                                      onChange: onSearchChanged,
                                      controller: searchController),
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  Get.to(AddCompanyScreen(
                                    isEdit: false,
                                  ))!
                                      .whenComplete(() {
                                    setState(() {});
                                  });
                                },
                                child: Container(
                                  height: 48,
                                  margin: const EdgeInsets.only(top: 24),
                                  width: 48,
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.whiteCard,
                                    size: 25,
                                  ),
                                ),
                              ),
                              if (companyController.companyData.isOwnCompany??false)
                                InkWell(
                                  onTap: () {
                                    Get.to(AddCompanyScreen(
                                      isEdit: true,
                                    ))!
                                        .whenComplete(() {
                                      setState(() {});
                                    });
                                  },
                                  child: Container(
                                    height: 48,
                                    margin:
                                        const EdgeInsets.only(top: 24, left: 6),
                                    width: 48,
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Icon(
                                      Icons.edit,
                                      color: AppColors.whiteCard,
                                      size: 20,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        companyController.isCompanyFound.value == false
                            ? const Expanded(
                                child: Center(
                                  child: TextWidget(
                                      text: "No Company Found",
                                      textSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            : Expanded(
                                child: SingleChildScrollView(
                                  child: Card(
                                      color: AppColors.blackCard,
                                      surfaceTintColor: AppColors.blackCard,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 55,
                                                  width: 55,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              companyController
                                                                  .companyData
                                                                  .logo!))),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextWidget(
                                                            text:
                                                                "${companyController.companyData.name!}",
                                                            textSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          // Icon(Icons.bookmark_border_outlined,
                                                          //     color: AppColors.white, size: 20)
                                                        ],
                                                      ),
                                                      const SizedBox(height: 4),
                                                      TextWidget(
                                                        text:
                                                            "${companyController.companyData.tagline}",
                                                        textSize: 12,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      TextWidget(
                                                        text:
                                                            "${companyController.companyData.location} , Founded in ${companyController.companyData.foundingDate} , Last Funding in ${companyController.companyData.lastFunding}",
                                                        textSize: 10,
                                                        maxLine: 2,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            color: AppColors.white38,
                                            height: 0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(6),
                                            child: SizedBox(
                                              width: Get.width,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                color: AppColors.white12,
                                                surfaceTintColor:
                                                    AppColors.white12,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextWidget(
                                                          text:
                                                              "About the company : ${companyController.companyData.description}",
                                                          textSize: 14,
                                                          maxLine: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      const SizedBox(height: 4),
                                                      TextWidget(
                                                          text:
                                                              "No of Employees : ${companyController.companyData.numberOfEmployees}",
                                                          textSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      const SizedBox(height: 4),
                                                      TextWidget(
                                                          text:
                                                              "Vision :${companyController.companyData.vision} ",
                                                          textSize: 14,
                                                          maxLine: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      const SizedBox(height: 4),
                                                      TextWidget(
                                                          text:
                                                              "Mission : ${companyController.companyData.mission}",
                                                          textSize: 14,
                                                          maxLine: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, bottom: 6),
                                            child: TextWidget(
                                                text: "Market Size",
                                                textSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                sqaureCard(
                                                    img: PngAssetPath.tamIcon,
                                                    subTitle:
                                                        "${companyController.companyData.tam}",
                                                    title: "TAM"),
                                                sqaureCard(
                                                    img: PngAssetPath.samIcon,
                                                    subTitle:
                                                        "${companyController.companyData.sam}",
                                                    title: "SAM"),
                                                sqaureCard(
                                                    img: PngAssetPath.somIcon,
                                                    subTitle:
                                                        "${companyController.companyData.som}",
                                                    title: "SOM"),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            child: TextWidget(
                                                text: "Current Funding",
                                                textSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              sqaureCard(
                                                  img: PngAssetPath
                                                      .fundingAskIcon,
                                                  subTitle:
                                                      "${companyController.companyData.fundAsk}",
                                                  title: "Fund Ask"),
                                              sqaureCard(
                                                  img: PngAssetPath
                                                      .valuationIcon,
                                                  subTitle:
                                                      "${companyController.companyData.valuation}",
                                                  title: "Valuation"),
                                              sqaureCard(
                                                  img: PngAssetPath
                                                      .fundingRaisedIcon,
                                                  subTitle:
                                                      "${companyController.companyData.raisedFunds}",
                                                  title: "Funds raised"),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            child: TextWidget(
                                                text: "Previous funding",
                                                textSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              sqaureCard(
                                                  img: PngAssetPath
                                                      .fundingAskIcon,
                                                  subTitle:
                                                      "${companyController.companyData.valuation}",
                                                  title: "Valuation"),
                                              sqaureCard(
                                                  img: PngAssetPath
                                                      .valuationIcon,
                                                  subTitle:
                                                      "${companyController.companyData.totalInvestment}",
                                                  title: "Total Investment"),
                                              sqaureCard(
                                                  img: PngAssetPath
                                                      .fundingRaisedIcon,
                                                  subTitle:
                                                      "${companyController.companyData.noOfInvesters}",
                                                  title: "No. of Investors"),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            child: TextWidget(
                                                text: "Revenue Statistics",
                                                textSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              sqaureCard(
                                                  img: PngAssetPath
                                                      .fundingAskIcon,
                                                  subTitle:
                                                      "${companyController.companyData.lastYearRevenue}",
                                                  title:
                                                      "Last year revenue (FY 23)"),
                                              sqaureCard(
                                                  img: PngAssetPath
                                                      .valuationIcon,
                                                  subTitle:
                                                      "${companyController.companyData.target}",
                                                  title: "Target (FY 24)"),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            child: TextWidget(
                                                text: "Public Links",
                                                textSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 42,
                                            child: ListView.separated(
                                              itemCount: companyController
                                                  .companyData
                                                  .socialLinks!
                                                  .length,
                                              shrinkWrap: true,
                                              separatorBuilder: (context, ind) {
                                                return const SizedBox(width: 3);
                                              },
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int ind) {
                                                return InkWell(
                                                  onTap: () {
                                                    Helper.launchUrl(
                                                        companyController
                                                            .companyData
                                                            .socialLinks![ind]
                                                            .link!);
                                                  },
                                                  child: Card(
                                                    color: AppColors.white12,
                                                    surfaceTintColor:
                                                        AppColors.white12,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 12.0),
                                                      child: Row(
                                                        children: [
                                                          Image.network(
                                                            "${companyController.companyData.socialLinks![ind].logo}",
                                                            height: 25,
                                                          ),
                                                          const SizedBox(
                                                              width: 8),
                                                          TextWidget(
                                                              text:
                                                                  "${companyController.companyData.socialLinks![ind].name}",
                                                              textSize: 12)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            child: TextWidget(
                                                text: "Founding Team",
                                                textSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 118,
                                            child: ListView.separated(
                                              itemCount: companyController
                                                  .companyData.team!.length,
                                              shrinkWrap: true,
                                              separatorBuilder:
                                                  (context, index) {
                                                return const SizedBox(width: 3);
                                              },
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Card(
                                                  color: AppColors.white12,
                                                  surfaceTintColor:
                                                      AppColors.white12,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: SizedBox(
                                                      width: Get.width / 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 20,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        '${companyController.companyData.team![index].image}'),
                                                              ),
                                                              const SizedBox(
                                                                  width: 8),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  TextWidget(
                                                                      text:
                                                                          "${companyController.companyData.team![index].name}",
                                                                      textSize:
                                                                          14),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const TextWidget(
                                                                  text:
                                                                      "Designation",
                                                                  textSize: 13),
                                                              const SizedBox(
                                                                  height: 4),
                                                              TextWidget(
                                                                  text:
                                                                      "${companyController.companyData.team![index].designation}",
                                                                  textSize: 13),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            child: TextWidget(
                                                text: "Key Focusing Area",
                                                textSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Wrap(
                                              spacing: 4.0,
                                              runSpacing: 4.0,
                                              children: List.generate(
                                                  companyController.companyData
                                                      .keyFocus!.length, (ind) {
                                                return Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  color: AppColors.white12,
                                                  surfaceTintColor:
                                                      AppColors.white12,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                    child: TextWidget(
                                                        text:
                                                            "${companyController.companyData.keyFocus![ind]}",
                                                        textSize: 14),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                          sizedTextfield,
                                          if (companyController
                                              .companyData.isOwnCompany!)
                                            AppButton.primaryButton(
                                                onButtonPressed: () {
                                                  companyController
                                                      .deleteCompany(
                                                          context,
                                                          companyController
                                                              .companyData.id);
                                                },
                                                title: "Delete Company")
                                        ],
                                      )),
                                ),
                              )
                      ],
                    ),
                  ),
          )),
    );
  }

  sqaureCard(
      {required String img, required String title, required String subTitle}) {
    return Expanded(
      child: Card(
        color: AppColors.white12,
        surfaceTintColor: AppColors.white12,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                img,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: TextWidget(
                        text: title,
                        align: TextAlign.center,
                        maxLine: 2,
                        fontWeight: FontWeight.w500,
                        textSize: 12),
                  ),
                ],
              ),
              TextWidget(text: subTitle, textSize: 12)
            ],
          ),
        ),
      ),
    );
  }
}
