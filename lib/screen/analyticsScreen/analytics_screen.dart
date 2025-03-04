import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/appcolors/app_colors.dart';
import '../../utils/constant/app_var.dart';
import '../../widget/appbar/appbar.dart';
import '../drawerScreen/drawer_screen.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String selectedFilter = 'Last 7 days';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        drawer: const DrawerWidget(),
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
            title: "Analytics", autoAction: true, hideBack: true),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 334,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.blackCard,
              borderRadius: BorderRadius.circular(12),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFilterButton('Last 7 days'),
                      const SizedBox(width: 8),
                      _buildFilterButton('Last 17 days'),
                      const SizedBox(width: 8),
                      _buildFilterButton('1 month'),
                      const SizedBox(width: 8),
                      _buildFilterButton('1 year'),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildAnalyticsCard('0', 'Comments', Icons.comment),
                    const SizedBox(width: 12),
                    _buildAnalyticsCard('0', 'Posts', Icons.visibility),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildAnalyticsCard('1', 'Profile Views', Icons.visibility),
                    const SizedBox(width: 12),
                    _buildAnalyticsCard('2', 'Followers', Icons.people),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    bool isSelected = selectedFilter == label;
    return TextButton(
      onPressed: () {
        setState(() {
          selectedFilter = label;
        });
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        backgroundColor: isSelected ? AppColors.primary : AppColors.grey700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: TextWidget(
        text: label,
        textSize: 12,
      ),
    );
  }

  Widget _buildAnalyticsCard(String count, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white12,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.white, size: 28),
            const SizedBox(height: 5),
            TextWidget(
              text: count,
              textSize: 22,
            ),
            const SizedBox(height: 5),
            TextWidget(text: label, textSize: 14),
          ],
        ),
      ),
    );
  }
}
