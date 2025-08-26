import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../appcolors/app_colors.dart';

class ShimmerLoader {
  static shimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: AppColors.blackCard,
      child: ListView.separated(
        itemCount: 5,
        padding: const EdgeInsets.all(10),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.black12,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 12,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 80,
                          height: 10,
                          color: Colors.grey[700],
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Follow Button Placeholder
                    Container(
                      width: 60,
                      height: 20,
                      color: Colors.grey[700],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Post Content Placeholder
                Container(
                  width: double.infinity,
                  height: 14,
                  color: Colors.grey[700],
                ),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 14,
                  color: Colors.grey[700],
                ),
                const SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 14,
                  color: Colors.grey[700],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static shimmerLoadingExplore() {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: AppColors.blackCard,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.black12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Section
                  Row(
                    children: [
                      // Profile Image Placeholder
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Name & Role Placeholder
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 140,
                            height: 12,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 100,
                            height: 10,
                            color: Colors.grey[700],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // About the company
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Investment Cards Placeholder
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(3, (index) {
                      return Container(
                        width: (MediaQuery.of(context).size.width - 48) / 3,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 15),
                  // Public Links
                  Container(
                    width: 100,
                    height: 14,
                    color: Colors.grey[700],
                  ),
                  const SizedBox(height: 10),
                  // LinkedIn Placeholder
                  Container(
                    width: 120,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Company Invested
                  Container(
                    width: 150,
                    height: 14,
                    color: Colors.grey[700],
                  ),
                  const SizedBox(height: 10),
                  // Company Invested Buttons Placeholder
                  Row(
                    children: List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 70,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 15),
                  // Connect Button Placeholder
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static shimmerProfile() {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: AppColors.blackCard,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                height: 20,
                width: 150,
                alignment: Alignment.center,
                color: Colors.grey,
              ),
              const SizedBox(height: 14),

              // Info Section
              Container(
                height: 15,
                width: 250,
                color: Colors.grey,
              ),
              const SizedBox(height: 14),
              Container(
                height: 15,
                width: 200,
                color: Colors.grey,
              ),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 120,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 40,
                    width: 120,
                    color: Colors.grey,
                  ),
                ],
              ),

              const SizedBox(height: 8),
              Column(
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: index % 2 == 0 ? 200 : 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static buildShimmerTable() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          sizedTextfield,
          Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.black12,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  _buildShimmerBox(width: 30, height: 25),
                  const SizedBox(width: 10),
                  _buildShimmerBox(width: 120, height: 25),
                  const Spacer(),
                  _buildShimmerBox(width: 50, height: 25),
                  const SizedBox(width: 20),
                  _buildShimmerBox(width: 50, height: 25),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[600]!,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.black12,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        _buildShimmerBox(width: 30, height: 20), // Checkbox
                        const SizedBox(width: 10),
                        _buildShimmerBox(width: 120, height: 20), // List Name
                        const Spacer(),
                        _buildShimmerBox(width: 50, height: 20), // Investors
                        const SizedBox(width: 20),
                        _buildShimmerBox(width: 50, height: 20), // VCs
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static buildShimmerTablePayment() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Shimmer.fromColors(
              baseColor: Colors.grey[800]!,
              highlightColor: Colors.grey[600]!,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildShimmerBox(width: Get.width / 2 - 28, height: 50),
                      _buildShimmerBox(width: Get.width / 2 - 28, height: 50)
                    ],
                  ),
                  sizedTextfield,
                  _buildShimmerBox(width: Get.width - 24, height: 50),
                ],
              )),
          sizedTextfield,
          Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.black12,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  _buildShimmerBox(width: 30, height: 25),
                  const SizedBox(width: 10),
                  _buildShimmerBox(width: 120, height: 25),
                  const Spacer(),
                  _buildShimmerBox(width: 50, height: 25),
                  const SizedBox(width: 20),
                  _buildShimmerBox(width: 50, height: 25),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[600]!,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.black12,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        _buildShimmerBox(width: 30, height: 20), // Checkbox
                        const SizedBox(width: 10),
                        _buildShimmerBox(width: 120, height: 20), // List Name
                        const Spacer(),
                        _buildShimmerBox(width: 50, height: 20), // Investors
                        const SizedBox(width: 20),
                        _buildShimmerBox(width: 50, height: 20), // VCs
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static buildShimmerTableAnnalytics() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: Colors.grey[600]!,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildShimmerBox(width: Get.width / 2 - 28, height: 110),
                _buildShimmerBox(width: Get.width / 2 - 28, height: 110)
              ],
            ),
            sizedTextfield,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildShimmerBox(width: Get.width / 2 - 28, height: 120),
                _buildShimmerBox(width: Get.width / 2 - 28, height: 120)
              ],
            ),
          ],
        ));
  }

  static Widget buildShimmerBlincProfile() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),

          // Circular Avatar
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[700],
          ),
          const SizedBox(height: 12),

          // Title
          _buildShimmerBoxVc(width: 120, height: 18),
          const SizedBox(height: 12),

          // Description lines
          _buildShimmerBoxVc(width: Get.width * 0.85, height: 14),
          const SizedBox(height: 6),
          _buildShimmerBoxVc(width: Get.width * 0.75, height: 14),
          const SizedBox(height: 6),
          _buildShimmerBoxVc(width: Get.width * 0.80, height: 14),
           const SizedBox(height: 6),
          _buildShimmerBoxVc(width: Get.width * 0.75, height: 14),
          const SizedBox(height: 6),
          _buildShimmerBoxVc(width: Get.width * 0.80, height: 14),
          const SizedBox(height: 12),

          // Buttons (Linkedin and Apply)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildShimmerBoxVc(width: 100, height: 36),
              const SizedBox(width: 16),
              _buildShimmerBoxVc(width: 120, height: 36),
            ],
          ),

          const SizedBox(height: 12),

          // Contact Email
          _buildShimmerBoxVc(width: Get.width * 0.6, height: 16),
          const SizedBox(height: 20),

          // Stage Focus Chips

          _buildShimmerBoxVc(width: 150, height: 32),
          const SizedBox(height: 12),
          _buildShimmerBoxVc(width: 150, height: 32),
          const SizedBox(height: 20),

          _buildShimmerBoxVc(width: Get.width-24, height: 200),
        ],
      ),
    );
  }

  static Widget _buildShimmerBoxVc(
      {required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static _buildShimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.black12,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  static shimmerTile() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: Colors.grey[600]!,
        child: ListView.separated(
            itemCount: 10,
            padding: const EdgeInsets.all(10),
            separatorBuilder: (context, index) => sizedTextfield,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.black12,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: _buildShimmerBox(width: Get.width, height: 100),
              );
            }));
  }

  static shimmerOutreachView() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: AppColors.blackCard,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmerContainer(height: 30, width: 200), // Title shimmer
            const SizedBox(height: 10),
            shimmerContainer(height: 20, width: 250), // Date shimmer
            const SizedBox(height: 20),
            Row(
              children: [
                shimmerContainer(height: 50, width: 140),
                const SizedBox(width: 10),
                shimmerContainer(height: 50, width: 140),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                shimmerContainer(height: 40, width: 100),
                const SizedBox(width: 10),
                shimmerContainer(height: 40, width: 100),
                const SizedBox(width: 10),
                shimmerContainer(height: 40, width: 100),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (_, index) =>
                    shimmerContainer(height: 100, width: 100),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static shimmerContainer({double height = 50, double width = 50}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static shimmerSpotlightLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: AppColors.blackCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Category Bar
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return Container(
                  width: 90,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
            ),
          ),
          // Card List
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.black12,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 140,
                                  height: 14,
                                  color: Colors.grey[700],
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  width: 100,
                                  height: 12,
                                  color: Colors.grey[700],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 72,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Description
                      Container(
                        width: double.infinity,
                        height: 12,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        height: 12,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: 12,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(height: 12),
                      // Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: List.generate(3, (_) {
                          return Container(
                            width: 100,
                            height: 26,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 12),
                      // Interaction Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (_) {
                          return Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 20,
                                height: 10,
                                color: Colors.grey[700],
                              ),
                            ],
                          );
                        }),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static shimmerProductDetailSpotlight() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: AppColors.blackCard,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // color: AppColors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: AppColors.white,
                    ),
                    Container(height: 14, width: 160, color: Colors.grey[700]),
                    const Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: AppColors.transparent,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  height: 200,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.blackCard,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Card Section
              Container(
                decoration: BoxDecoration(
                  color: AppColors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo + Title + Desc Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 14,
                                  width: 160,
                                  color: Colors.grey[700]),
                              const SizedBox(height: 8),
                              Container(
                                  height: 12,
                                  width: 120,
                                  color: Colors.grey[700]),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Tags
                    Row(
                      children: [
                        Container(
                          height: 26,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 26,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 26,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // For Support and For Roast Buttons
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              sizedTextfield,
              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 220,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.black12,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 12,
                                      width: 120,
                                      color: Colors.grey[700]),
                                  const SizedBox(height: 6),
                                  Container(
                                      height: 10,
                                      width: 100,
                                      color: Colors.grey[700]),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                              height: 15,
                              width: double.infinity,
                              color: Colors.grey[700]),
                          const SizedBox(height: 6),
                          Container(
                              height: 15,
                              width: double.infinity,
                              color: Colors.grey[700]),
                          const SizedBox(height: 6),
                          Container(
                              height: 15,
                              width: double.infinity,
                              color: Colors.grey[700]),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 40,
                              width: Get.width / 2,
                              decoration: BoxDecoration(
                                color: Colors.blue[700],
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              sizedTextfield,
              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return Container(
                      width: Get.width / 1.2,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.black12,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static buildShimmerHomeLanding() {
    final screenWidth = Get.width;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            shimmerBox(height: 45, width: double.infinity, radius: 100),
            const SizedBox(height: 20),

            // Hot topics (chips)
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, __) =>
                    shimmerBox(height: 32, width: 90, radius: 20),
              ),
            ),
            const SizedBox(height: 24),

            // Trending Title
            shimmerBox(height: 18, width: 100),
            const SizedBox(height: 16),

            // Post Card
            shimmerPostCard(screenWidth: screenWidth),
            const SizedBox(height: 16),
            shimmerPostCard(screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }

  static Widget shimmerBox(
      {double height = 14, double width = 100, double radius = 8}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  static Widget shimmerPostCard({required double screenWidth}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User row
          Row(
            children: [
              shimmerBox(height: 40, width: 40, radius: 20),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerBox(height: 14, width: screenWidth * 0.3),
                  const SizedBox(height: 4),
                  shimmerBox(height: 12, width: screenWidth * 0.2),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),

          // Title
          shimmerBox(height: 16, width: screenWidth * 0.7),
          const SizedBox(height: 8),
          shimmerBox(height: 14, width: screenWidth * 0.9),
          const SizedBox(height: 8),
          shimmerBox(height: 14, width: screenWidth * 0.6),
          const SizedBox(height: 16),

          // Image Placeholder
          shimmerBox(height: 160, width: double.infinity, radius: 16),
          const SizedBox(height: 12),

          // Reactions row
          Row(
            children: List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: shimmerBox(height: 24, width: 24, radius: 12),
              ),
            ),
          )
        ],
      ),
    );
  }

  static buildShimmerSeeAllPost() {
    return ListView.separated(
      itemCount: 5,
      padding: const EdgeInsets.all(12),
      separatorBuilder: (BuildContext context, int index) {
        return sizedTextfield;
      },
      itemBuilder: (BuildContext context, int index) {
        return shimmerPostCard(screenWidth: Get.width);
      },
    );
  }

  static buildShimmerRellsPage() {
    final screenWidth = Get.width;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                shimmerBox(height: 40, width: 40, radius: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerBox(height: 14, width: screenWidth * 0.4),
                      const SizedBox(height: 6),
                      shimmerBox(height: 12, width: screenWidth * 0.25),
                    ],
                  ),
                ),
                shimmerBox(height: 32, width: 32, radius: 16),
              ],
            ),
            const SizedBox(height: 16),

            // Image Placeholder
            shimmerBox(
                height: Get.width - 20, width: double.infinity, radius: 16),
            const SizedBox(height: 16),

            // Title
            shimmerBox(height: 20, width: screenWidth * 0.7),
            const SizedBox(height: 12),

            // Paragraph lines
            const SizedBox(height: 8),
            shimmerBox(height: 14, width: screenWidth * 0.85),
            const SizedBox(height: 8),
            shimmerBox(height: 14, width: screenWidth * 0.85),
            const SizedBox(height: 8),
            shimmerBox(height: 14, width: screenWidth * 0.85),
            const SizedBox(height: 8),
            shimmerBox(height: 14, width: screenWidth * 0.85),
            const SizedBox(height: 8),
            shimmerBox(height: 14, width: screenWidth * 0.85),
            const SizedBox(height: 8),
            shimmerBox(height: 14, width: screenWidth * 0.85),
            const SizedBox(height: 8),
            shimmerBox(height: 14, width: screenWidth * 0.85),
            const SizedBox(height: 8),
            shimmerBox(height: 14, width: screenWidth * 0.85),
            const SizedBox(height: 8),
            shimmerBox(height: 14, width: screenWidth * 0.85),
            const SizedBox(height: 8),
            shimmerBox(height: 14, width: screenWidth * 0.5),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  static Widget buildShimmerComment() {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, __) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row with avatar and name
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerBox(
                      height: 40, width: 40, radius: 20), // Circle avatar
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerBox(height: 12, width: 100),
                        const SizedBox(height: 6),
                        shimmerBox(height: 10, width: 60),
                      ],
                    ),
                  ),
                  const Icon(Icons.favorite_border, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 12),
              shimmerBox(height: 10, width: 200),
              const SizedBox(height: 8),
              shimmerBox(height: 10, width: 160),
              const SizedBox(height: 12),
              Row(
                children: [
                  shimmerBox(height: 10, width: 40),
                  const SizedBox(width: 12),
                  shimmerBox(height: 10, width: 80),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget buildShimmerCompanyScreen() {
    final screenWidth = Get.width;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            shimmerBox(height: 45, width: double.infinity, radius: 100),
            const SizedBox(height: 24),

            // Company Card
            shimmerBox(height: 90, width: double.infinity, radius: 16),
            const SizedBox(height: 24),

            // Filter Tabs (All, Funding Size's, etc.)
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, __) =>
                    shimmerBox(height: 32, width: 100, radius: 20),
              ),
            ),
            const SizedBox(height: 24),

            // Funding Cards (Market Size, Current Funding, etc.)
            shimmerFundingCard(screenWidth),
            const SizedBox(height: 20),
            shimmerFundingCard(screenWidth),
            const SizedBox(height: 20),
            shimmerFundingCard(screenWidth),
          ],
        ),
      ),
    );
  }

  static Widget shimmerFundingCard(double screenWidth) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1E1E1E),
      highlightColor: const Color(0xFF2C2C2C),
      child: Container(
        width: screenWidth,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2B2B2B),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Image Placeholder
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(width: 16),
            // Text Placeholders
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerBox(height: 16, width: 120),
                  const SizedBox(height: 8),
                  shimmerBox(height: 12, width: 180),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: shimmerBox(height: 30, width: 70, radius: 100),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget buildShimmerAffilatedMember() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) => shimmerGridCard(),
      ),
    );
  }

  static Widget shimmerGridCard() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1E1E1E),
      highlightColor: const Color(0xFF2C2C2C),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2B2B2B),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image or Icon Placeholder
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 12),
            shimmerBox(height: 16, width: 80),
            const SizedBox(height: 8),
            shimmerBox(height: 12, width: 100),
          ],
        ),
      ),
    );
  }
}
