import 'dart:async';

import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/companyScreen/add_company_screen.dart';
import 'package:capitalhub_crm/screen/companyScreen/companyScreenInv/add_company_inv_screen.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/companyController/company_inv_controller.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/constant/app_var.dart';
import '../../../utils/constant/asset_constant.dart';
import '../../../utils/helper/helper.dart';
import '../../../widget/appbar/appbar.dart';
import '../../../widget/textwidget/text_widget.dart';
import '../../drawerScreen/drawer_screen.dart';

class CompanyInvScreen extends StatefulWidget {
  const CompanyInvScreen({super.key});

  @override
  State<CompanyInvScreen> createState() => _CompanyInvScreenState();
}

class _CompanyInvScreenState extends State<CompanyInvScreen> {
  CompanyInvController companyInvController = Get.put(CompanyInvController());
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  @override
  void initState() {
    companyInvController.getCompanyDetail();
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
        await companyInvController.getCompanyList(query);
        setState(() {});
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
              child: companyInvController.isLoadingList.value
                  ? Helper.loader(context)
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: companyInvController.companyList.length,
                      separatorBuilder: (context, index) {
                        return const Divider(height: 0);
                      },
                      itemBuilder: (context, index) {
                        return ListTile(
                          visualDensity: VisualDensity.compact,
                          title: TextWidget(
                              text: companyInvController
                                  .companyList[index].company!,
                              textSize: 14),
                          onTap: () {
                            searchController.clear();
                            companyInvController.addCompanyToUser(context,
                                companyInvController.companyList[index].id);

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
          drawer: const DrawerWidgetInvestor(),
          appBar: HelperAppBar.appbarHelper(
              title: "Company", hideBack: true, autoAction: true),
          body: Obx(
            () => companyInvController.isLoading.value
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
                                  Get.to(AddCompanyInvScreen(
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
                                      color: AppColors.primaryInvestor,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.black,
                                    size: 25,
                                  ),
                                ),
                              ),
                              if (companyInvController
                                  .companyData.isOwnCompany??false)
                                InkWell(
                                  onTap: () {
                                    Get.to(AddCompanyInvScreen(
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
                                        color: AppColors.primaryInvestor,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Icon(
                                      Icons.edit,
                                      color: AppColors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        companyInvController.isCompanyFound.value == false
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
                                                              companyInvController
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
                                                                "${companyInvController.companyData.name!}",
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
                                                            "${companyInvController.companyData.tagline}",
                                                        textSize: 12,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      TextWidget(
                                                        text:
                                                            "${companyInvController.companyData.location} , Founded in ${companyInvController.companyData.foundingDate} , Last Funding in ${companyInvController.companyData.lastFunding}",
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
                                                              "About the company : ${companyInvController.companyData.description}",
                                                          textSize: 14,
                                                          maxLine: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      const SizedBox(height: 4),
                                                      TextWidget(
                                                          text:
                                                              "No of Employees : ${companyInvController.companyData.numberOfEmployees}",
                                                          textSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      const SizedBox(height: 4),
                                                      TextWidget(
                                                          text:
                                                              "Vision :${companyInvController.companyData.vision} ",
                                                          textSize: 14,
                                                          maxLine: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      const SizedBox(height: 4),
                                                      TextWidget(
                                                          text:
                                                              "Mission : ${companyInvController.companyData.mission}",
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
                                              itemCount: companyInvController
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
                                                        companyInvController
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
                                                            "${companyInvController.companyData.socialLinks![ind].logo}",
                                                            height: 25,
                                                          ),
                                                          const SizedBox(
                                                              width: 8),
                                                          TextWidget(
                                                              text:
                                                                  "${companyInvController.companyData.socialLinks![ind].name}",
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
                                              itemCount: companyInvController
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
                                                                        '${companyInvController.companyData.team![index].image}'),
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
                                                                          "${companyInvController.companyData.team![index].name}",
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
                                                                      "${companyInvController.companyData.team![index].designation}",
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
                                                  companyInvController
                                                      .companyData
                                                      .keyFocus!
                                                      .length, (ind) {
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
                                                            "${companyInvController.companyData.keyFocus![ind]}",
                                                        textSize: 14),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                          sizedTextfield,
                                          if (companyInvController
                                              .companyData.isOwnCompany!)
                                            AppButton.primaryButton(
                                                onButtonPressed: () {
                                                  companyInvController
                                                      .deleteCompany(
                                                          context,
                                                          companyInvController
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
