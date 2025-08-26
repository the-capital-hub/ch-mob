import 'package:capitalhub_crm/controller/spotlightController/spotlight_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/spotlightModel/spotlight_productlist_model.dart';
import 'productDetailsScreen/product_detail_screen.dart';

class SpotlightProductCard extends StatefulWidget {
  SpotlightProduct item;
  SpotlightProductCard({super.key, required this.item});
  @override
  State<SpotlightProductCard> createState() => _SpotlightProductCardState();
}

class _SpotlightProductCardState extends State<SpotlightProductCard> {
  SpotlightController spotlightController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailScreen(
              productId: widget.item.id!,
            ));
      },
      child: Container(
        width: Get.width - 50,
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
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(widget.item.logo!),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextWidget(
                      text: widget.item.title!,
                      textSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
                if (widget.item.topProduct!)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              text: widget.item.tagline!,
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
                      itemCount: widget.item.tags!.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, tagIndex) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: TextWidget(
                                text: widget.item.tags![tagIndex],
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
                _buildIconStat(Icons.thumb_up, widget.item.upvotesCount!),
                _buildIconStat(Icons.thumb_down, widget.item.downvoteCount!),
                _buildIconStat(
                    Icons.mode_comment_outlined, widget.item.comments!),
                _buildIconStat(
                    Icons.mobile_screen_share_outlined, widget.item.shares!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconStat(IconData icon, int count,
      {Color? iconColor, Function()? ontap}) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          Icon(icon, color: iconColor ?? Colors.white60, size: 20),
          const SizedBox(width: 4),
          Text('$count', style: const TextStyle(color: Colors.white60)),
        ],
      ),
    );
  }
}
