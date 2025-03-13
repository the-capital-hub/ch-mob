import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class ViewListScreen extends StatefulWidget {
  const ViewListScreen({super.key});

  @override
  _ViewListScreenState createState() => _ViewListScreenState();
}

class _ViewListScreenState extends State<ViewListScreen> {
  final List<Map<String, String>> investors = [
    {
      'name': 'Chinmay Agarwal (CoinSwitch)',
      'role': 'Investor',
      'location': 'Bengaluru'
    },
    {'name': 'Harsh Shah (Fynd)', 'role': 'Investor', 'location': 'Mumbai'},
    {
      'name': 'Vidit Aatrey (Meesho)',
      'role': 'Investor',
      'location': 'Bengaluru'
    },
  ];

  List<int> selectedIndices = [];

  void toggleSelection(int index) {
    setState(() {
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index);
      } else {
        selectedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Test"),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                      text: "3 Investor", textSize: 14),
                  TextWidget(text: "Created by Meet dev", textSize: 14),
                ],
              ),
              sizedTextfield,
              Expanded(
                child: ListView.separated(
                  itemCount: investors.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final investor = investors[index];
                    final isSelected = selectedIndices.contains(index);
      
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(PngAssetPath.accountImg),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                    text: investor['name']!,
                                    textSize: 14,
                                    maxLine: 2),
                                TextWidget(text: investor['role']!, textSize: 13),
                                TextWidget(
                                    text: investor['location']!, textSize: 12),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => toggleSelection(index),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.grey700,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextWidget(
                                text: isSelected ? 'Selected' : 'Select',
                                textSize: 12,
                              ),
                            ),
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
        bottomNavigationBar: selectedIndices.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      setState(() {
                        selectedIndices.clear();
                      });
                    },
                    title: "Remove Selected (${selectedIndices.length})"),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
