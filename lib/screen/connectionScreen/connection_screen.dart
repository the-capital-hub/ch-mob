import 'package:capitalhub_crm/controller/connectionController/connection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/appcolors/app_colors.dart';
import '../../utils/constant/app_var.dart';
import '../../utils/helper/helper.dart';
import '../../widget/appbar/appbar.dart';
import '../../widget/textwidget/text_widget.dart';
import '../drawerScreen/drawer_screen.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  ConnectionController connectionController = Get.put(ConnectionController());
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    connectionController.getReceivedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        drawer: const DrawerWidget(),
        appBar: HelperAppBar.appbarHelper(
            title: "Connection", hideBack: true, autoAction: true),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.black,
                padding: const EdgeInsets.only(bottom: 4),
                width: Get.width,
                child: TabBar(
                  controller: tabController,
                  dividerHeight: 0,
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                  indicatorPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  onTap: (val) {
                    if (val == 0) {
                      connectionController.getReceivedData();
                    } else if (val == 1) {
                      connectionController.getSentData();
                    } else if (val == 2) {
                      connectionController.getAcceptedData();
                    }
                  },
                  tabs: const [
                    SizedBox(
                        width: 70,
                        height: 40,
                        child: Center(
                            child: TextWidget(
                          text: "Received",
                          textSize: 14,
                        ))),
                    SizedBox(
                        width: 70,
                        height: 40,
                        child: Center(
                            child: TextWidget(
                          text: "Sent",
                          textSize: 14,
                        ))),
                    SizedBox(
                        width: 70,
                        height: 40,
                        child: Center(
                            child: TextWidget(
                          text: "Accepted",
                          textSize: 14,
                        ))),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  unselectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.normal),
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Obx(() => Expanded(
                    child: connectionController.isLoading.value
                        ? Helper.pageLoading()
                        : TabBarView(
                            controller: tabController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                                connectionTab(),
                                connectionTab(),
                                connectionTab(),
                              ]),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  connectionTab() {
    return connectionController.connectionData.isEmpty
        ? const Center(
            child: TextWidget(
              text: "No Data Found",
              textSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        : ListView.separated(
            itemCount: connectionController.connectionData.length,
            padding: const EdgeInsets.all(2),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                visualDensity: VisualDensity.compact,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                tileColor: AppColors.blackCard,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "${connectionController.connectionData[index].profilePicture}"),
                ),
                title: TextWidget(
                  text:
                      "${connectionController.connectionData[index].firstName} ${connectionController.connectionData[index].lastName}",
                  textSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text:
                          "${connectionController.connectionData[index].designation}",
                      textSize: 12,
                      color: AppColors.whiteCard,
                    ),
                    if (tabController.index != 2)
                      TextWidget(
                        text:
                            "${connectionController.connectionData[index].createdAt}",
                        textSize: 10,
                        color: AppColors.white54,
                      ),
                  ],
                ),
                trailing: tabController.index == 0
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              connectionController.acceptRequest(
                                  connectionController
                                      .connectionData[index].connectionId);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              color: AppColors.primary,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4),
                                child: TextWidget(text: "Accept", textSize: 12),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              connectionController.rejectRequest(
                                  connectionController
                                      .connectionData[index].connectionId);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              color: AppColors.black12,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4),
                                child: TextWidget(text: "Ignore", textSize: 12),
                              ),
                            ),
                          )
                        ],
                      )
                    : tabController.index == 1
                        ? InkWell(
                            onTap: () {
                              connectionController.cancelRequest(
                                  connectionController
                                      .connectionData[index].connectionId);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              color: AppColors.black12,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4),
                                child: TextWidget(
                                    text: "Cancel request", textSize: 12),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              connectionController.removeRequest(
                                  connectionController
                                      .connectionData[index].id);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              color: AppColors.black12,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4),
                                child: TextWidget(
                                    text: "Remove Conenction", textSize: 12),
                              ),
                            ),
                          ),
              );
            },
          );
  }
}
