import 'package:capitalhub_crm/controller/profileController/profile_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/profileModel/subscription_model.dart';
import '../../utils/helper/helper.dart';
import '../../utils/paymentService/payment_service.dart';

class SubscriptionScreen extends StatefulWidget {
  bool fromCampaign;
  SubscriptionScreen({super.key, required this.fromCampaign});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    profileController.getSubscriptionList(widget.fromCampaign);
    super.initState();
  }

  final CashFreePaymentService paymentService = CashFreePaymentService();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Pricing Plans"),
        body: Obx(
          () => profileController.isLoading.value
              ? Helper.pageLoading()
              : ListView.separated(
                  separatorBuilder: (context, index) => sizedTextfield,
                  itemCount: profileController.subscriptionList.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (BuildContext context, int index) {
                    SubscriptionData plan =
                        profileController.subscriptionList[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(16),
                        border: plan.isPopularChoice!
                            ? Border.all(color: AppColors.golden, width: 2)
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (plan.isPopularChoice!)
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextWidget(
                                    text: 'Popular Choice',
                                    color: AppColors.black,
                                    textSize: 14),
                              ),
                            ),
                          if (plan.isPopularChoice!) const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                  text: plan.name!,
                                  fontWeight: FontWeight.bold,
                                  textSize: 22),
                              const Icon(Icons.auto_awesome,
                                  color: AppColors.golden),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              TextWidget(
                                  text: plan.orignalPrice!,
                                  textSize: 16,
                                  textDecoration: TextDecoration.lineThrough),
                              if (plan.orignalPrice!.isNotEmpty)
                                const SizedBox(width: 8),
                              if (plan.discountPercentage!.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: TextWidget(
                                      text: "${plan.discountPercentage!} %",
                                      color: Colors.white,
                                      textSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              if (plan.discountPercentage!.isNotEmpty)
                                const SizedBox(width: 8),
                              TextWidget(
                                  text: plan.priceWithDuration!,
                                  color: Colors.greenAccent,
                                  textSize: 18,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextWidget(
                            text: plan.description!,
                            textSize: 14,
                            color: AppColors.grey,
                            maxLine: 10,
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: plan.benifits!.map<Widget>((feature) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_circle_outline,
                                        color: Colors.white, size: 16),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: TextWidget(
                                          text: feature, textSize: 15),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          AppButton.outlineButton(
                              onButtonPressed: () {
                                if (plan.priceForPayment != 0) {
                                  Helper.loader(context);
                                  profileController
                                      .createSubscription(plan.name!)
                                      .then((v) {
                                    if (v) {
                                      paymentService.pay(
                                          profileController.cfOrderId,
                                          profileController.cfPaymentSessionId);
                                    }
                                  });
                                }
                              },
                              fontSize: 16,
                              title: plan.priceForPayment == 0
                                  ? "Current Plan"
                                  : "Purchase Now")
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
