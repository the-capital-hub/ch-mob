import 'package:capitalhub_crm/controller/paymentTransactionController/payment_transactions_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/text_field/text_field.dart';

class PaymentTransactionScreen extends StatefulWidget {
  const PaymentTransactionScreen({super.key});

  @override
  State<PaymentTransactionScreen> createState() =>
      _PaymentTransactionScreenState();
}

class _PaymentTransactionScreenState extends State<PaymentTransactionScreen> {
  TextEditingController searchController = TextEditingController();
  PaymentTransactionsController paymentController =
      Get.put(PaymentTransactionsController());
  String selectedFilter = 'All';

  final List<String> filters = ['All', 'Success', 'Pending', 'Failed'];

  final Map<String, Color> borderColors = {
    'All': AppColors.blue,
    'Success': AppColors.green700,
    'Pending': Colors.orange,
    'Failed': AppColors.redColor,
  };
  List filteredTransactions = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_applyFilters);
    paymentController.getPaymentList().then((v) {
      filteredTransactions = paymentController.paymentData.paymentDetails!;
    });
  }

  void _applyFilters() {
    final query = searchController.text.toLowerCase();
    final filter = selectedFilter;

    setState(() {
      filteredTransactions =
          paymentController.paymentData.paymentDetails!.where((transaction) {
        final matchesSearch = transaction.name!.toLowerCase().contains(query) ||
            transaction.email!.toLowerCase().contains(query) ||
            transaction.phone!.toLowerCase().contains(query);

        final matchesFilter = filter == 'All' || transaction.status == filter;

        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_applyFilters);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        drawer: const DrawerWidget(),
        appBar: HelperAppBar.appbarHelper(
          title: "Payment Transactions",
          hideBack: true,
          action: [
            InkWell(
              onTap: () {
                paymentController.getPaymentList();
              },
              child: const Icon(
                Icons.cached,
                color: AppColors.blue,
              ),
            ),
            const SizedBox(width: 10)
          ],
        ),
        body: Obx(
          () => paymentController.isLoading.value
              ? Helper.pageLoading()
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          color: AppColors.blackCard,
                          surfaceTintColor: AppColors.blackCard,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                MyCustomTextField.textField(
                                    hintText: "Search",
                                    fillColor: AppColors.white12,
                                    suffixIcon: searchController.text.isNotEmpty
                                        ? InkWell(
                                            onTap: () {
                                              searchController.clear();
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: AppColors.white54,
                                            ),
                                          )
                                        : null,
                                    controller: searchController),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: filters.map((filter) {
                                    final isSelected = selectedFilter == filter;
                                    final color = borderColors[filter]!;
                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: OutlinedButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedFilter = filter;
                                            });
                                            _applyFilters();
                                          },
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: isSelected
                                                ? color
                                                : Colors.transparent,
                                            side: BorderSide(color: color),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                          ),
                                          child: TextWidget(
                                            text: filter,
                                            color: isSelected
                                                ? Colors.white
                                                : color,
                                            textSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (paymentController.paymentData.summary!.show!)
                          sizedTextfield,
                        if (paymentController.paymentData.summary!.show!)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Card(
                                    color: AppColors.blackCard,
                                    surfaceTintColor: AppColors.blackCard,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            TextWidget(
                                                text: "Total Transactions",
                                                color: AppColors.whiteShade,
                                                textSize: 14),
                                            const SizedBox(height: 4),
                                            TextWidget(
                                              text:
                                                  "${paymentController.paymentData.summary!.totalTransactions}",
                                              textSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )
                                          ],
                                        ))),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Card(
                                    color: AppColors.blackCard,
                                    surfaceTintColor: AppColors.blackCard,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            TextWidget(
                                                text: "Successful Payments",
                                                color: AppColors.whiteShade,
                                                textSize: 14),
                                            const SizedBox(height: 4),
                                            TextWidget(
                                              text:
                                                  "${paymentController.paymentData.summary!.successfulPayments}",
                                              textSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )
                                          ],
                                        ))),
                              )
                            ],
                          ),
                        if (paymentController.paymentData.summary!.show!)
                          const SizedBox(height: 6),
                        if (paymentController.paymentData.summary!.show!)
                          SizedBox(
                            width: Get.width,
                            child: Card(
                                color: AppColors.blackCard,
                                surfaceTintColor: AppColors.blackCard,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        TextWidget(
                                            text: "Total Revenue",
                                            color: AppColors.whiteShade,
                                            textSize: 14),
                                        const SizedBox(height: 4),
                                        TextWidget(
                                          text:
                                              "${paymentController.paymentData.summary!.totalRevenue}",
                                          textSize: 18,
                                          fontWeight: FontWeight.w500,
                                        )
                                      ],
                                    ))),
                          ),
                        sizedTextfield,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: filteredTransactions.isEmpty
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 40),
                                  child: Center(
                                    child: TextWidget(
                                      text: "No data found",
                                      textSize: 16,
                                      color: AppColors.whiteShade,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: DataTable(
                                      columnSpacing: 25,
                                      headingRowHeight: 50,
                                      dataRowHeight: 70,
                                      dividerThickness: 0.4,
                                      horizontalMargin: 20,
                                      border: TableBorder.all(
                                        color: AppColors.white38,
                                        width: 1,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      headingRowColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                        (_) => AppColors.white12,
                                      ),
                                      columns: const [
                                        DataColumn(
                                          label: Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextWidget(
                                                    text: "User",
                                                    textSize: 15,
                                                    align: TextAlign.center),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextWidget(
                                                    text: "Service",
                                                    textSize: 15,
                                                    align: TextAlign.center),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextWidget(
                                                    text: "Amount",
                                                    textSize: 15,
                                                    align: TextAlign.center),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextWidget(
                                                    text: "Date",
                                                    textSize: 15,
                                                    align: TextAlign.center),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextWidget(
                                                    text: "Payment Method",
                                                    textSize: 15,
                                                    align: TextAlign.center),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextWidget(
                                                    text: "Status",
                                                    textSize: 15,
                                                    align: TextAlign.center),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextWidget(
                                                    text: "Order ID",
                                                    textSize: 15,
                                                    align: TextAlign.center),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: List.generate(
                                          filteredTransactions.length, (index) {
                                        return _buildTransactionRow(context,
                                            index, filteredTransactions[index]);
                                      }),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  DataRow _buildTransactionRow(
      BuildContext context, int index, var data) {
    return DataRow(
      color: MaterialStateProperty.resolveWith<Color?>(
        (_) => index.isEven ? AppColors.transparent : AppColors.white12,
      ),
      cells: [
        DataCell(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(text: data.name!, textSize: 14),
            TextWidget(
                text: data.email!, textSize: 12, color: AppColors.white54),
            TextWidget(
                text: data.phone!, textSize: 12, color: AppColors.white54),
          ],
        )),
        DataCell(SizedBox(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(text: data.service!, maxLine: 2, textSize: 14),
              TextWidget(
                  text: data.subService!,
                  textSize: 12,
                  color: AppColors.white54),
            ],
          ),
        )),
        DataCell(TextWidget(text: data.amount!, textSize: 14)),
        DataCell(TextWidget(text: data.date!, textSize: 14)),
        DataCell(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Icon(Icons.payments, size: 16, color: Colors.white),
                const SizedBox(width: 5),
                TextWidget(text: data.paymentType!, textSize: 14),
              ],
            ),
            TextWidget(
                text: data.paymentInfo!,
                textSize: 12,
                color: AppColors.white54),
            TextWidget(
                text: data.bankName!, textSize: 12, color: AppColors.white54),
          ],
        )),
        DataCell(Container(
          height: 30,
          width: 80,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: data.status == 'Success'
                ? AppColors.green700
                : data.status == 'Pending'
                    ? Colors.orange
                    : AppColors.redColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextWidget(
            text: data.status!,
            textSize: 13,
            color: Colors.white,
          ),
        )),
        DataCell(TextWidget(text: data.orderId!, textSize: 14)),
      ],
    );
  }
}

class TransactionData {
  final String name;
  final String email;
  final String phone;
  final String service;
  final String subService;
  final String amount;
  final String date;
  final String paymentType;
  final String paymentInfo;
  final String bankName;
  final String orderId;
  final String status;

  TransactionData({
    required this.name,
    required this.email,
    required this.phone,
    required this.service,
    required this.subService,
    required this.amount,
    required this.date,
    required this.paymentType,
    required this.paymentInfo,
    required this.bankName,
    required this.orderId,
    required this.status,
  });
}
