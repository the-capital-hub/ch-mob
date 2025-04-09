import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'productDetailsScreen/product_detail_screen.dart';

class ProductCardList extends StatelessWidget {
  final List<Map<String, dynamic>> data = List.generate(
      10,
      (index) => {
            'title': 'Chat GPT',
            'description':
                'GPT-4.5 is our most advanced model yet, scaling up unsupervised learning for better pattern recognition.',
            'tags': [
              'Artificial Intelligence',
              'User Experience',
              'Design Tools'
            ],
            'likes': 0,
            'comments': 0,
            'flames': 0,
            'topProduct': true,
          });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: data.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = data[index];
          return InkWell(
            onTap: () {
              Get.to(() => const ProductDetailScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.blackCard,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(PngAssetPath.appIcon),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextWidget(
                            text: item['title'],
                            textSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white),
                      ),
                      if (item['topProduct'])
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextWidget(
                            text: 'Top Product',
                            textSize: 10,
                            color: AppColors.white,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextWidget(
                    text: item['description'],
                    textSize: 13,
                    color: AppColors.whiteShade,
                    maxLine: 10,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 34,
                    child: Row(
                      children: [
                        Icon(Icons.tag, color: Colors.grey.shade600, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: item['tags'].length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, tagIndex) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade800,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: TextWidget(
                                      text: item['tags'][tagIndex],
                                      textSize: 12,
                                      color: AppColors.white),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildIconStat(Icons.thumb_up, item['likes']),
                      _buildIconStat(
                          Icons.mode_comment_outlined, item['comments']),
                      _buildIconStat(
                          Icons.local_fire_department, item['flames'],
                          iconColor: Colors.redAccent),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconStat(IconData icon, int count, {Color? iconColor}) {
    return Row(
      children: [
        Icon(icon, color: iconColor ?? Colors.white60, size: 20),
        const SizedBox(width: 4),
        Text('$count', style: const TextStyle(color: Colors.white60)),
      ],
    );
  }
}
