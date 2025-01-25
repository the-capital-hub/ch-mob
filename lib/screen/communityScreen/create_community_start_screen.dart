import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCommunityStartScreen extends StatefulWidget {
  const CreateCommunityStartScreen({super.key});

  @override
  State<CreateCommunityStartScreen> createState() =>
      _CreateCommunityStartScreenState();
}

class _CreateCommunityStartScreenState
    extends State<CreateCommunityStartScreen> {
  TextEditingController nameController = TextEditingController();
  List<TextEditingController> optionsControllers = [
    TextEditingController(text: "Less than 10K"),
    TextEditingController(text: "10K - 100K"),
    TextEditingController(text: "100K - 500K"),
    TextEditingController(text: "Over 500K"),
  ];
  List<bool> isSelected = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        drawer: const DrawerWidget(),
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Create Community",
          hideBack: true,
          autoAction: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://i0.wp.com/mymotionguy.com/wp-content/uploads/2024/03/port-img02-1.jpg?fit=630,400&ssl=1",
                ),
              ),
              sizedTextfield,
              const TextWidget(text: "Start Building A Business", textSize: 18),
              sizedTextfield,
              sizedTextfield,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                      text: "What is the name of your community?",
                      textSize: 18),
                  const SizedBox(height: 4),
                  MyCustomTextField.textField(
                      lableText: "Enter Community Name",
                      hintText: "eg : Hub Community",
                      controller: nameController),
                      SizedBox(height: 15,),
                  // sizedTextfield,
                  const TextWidget(text: "How big is your community?", textSize: 18),
                  // sizedTextfield,
                  const SizedBox(height: 4),
                  // MyCustomTextField.textField(
                  //   lableText: "E.g. followers, mailing list, subscibers",
                  //     suffixIcon: GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           isSelected = [
                  //             true,
                  //             false,
                  //             false,
                  //             false
                  //           ]; // Toggle the state
                  //         });
                  //       },
                  //       child: Icon(
                  //         isSelected[0]
                  //             ? Icons.radio_button_checked
                  //             : Icons.radio_button_unchecked,
                  //         color: isSelected[0]
                  //             ? AppColors.primary
                  //             : AppColors
                  //                 .white54, // Change color based on selection
                  //       ),
                  //     ),
                  //     hintText: "",
                  //     readonly: true,
                  //     controller: optionsControllers[0]),
                  // sizedTextfield,
                  // MyCustomTextField.textField(
                  //     suffixIcon: GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           isSelected = [
                  //             false,
                  //             true,
                  //             false,
                  //             false,
                  //           ]; // Toggle the state
                  //         });
                  //       },
                  //       child: Icon(
                  //         isSelected[1]
                  //             ? Icons.radio_button_checked
                  //             : Icons.radio_button_unchecked,
                  //         color: isSelected[1]
                  //             ? AppColors.primary
                  //             : AppColors
                  //                 .white54, // Change color based on selection
                  //       ),
                  //     ),
                  //     hintText: "",
                  //     readonly: true,
                  //     controller: optionsControllers[1]),
                  // sizedTextfield,
                  // MyCustomTextField.textField(
                  //     suffixIcon: GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           isSelected = [
                  //             false,
                  //             false,
                  //             true,
                  //             false
                  //           ]; // Toggle the state
                  //         });
                  //       },
                  //       child: Icon(
                  //         isSelected[2]
                  //             ? Icons.radio_button_checked
                  //             : Icons.radio_button_unchecked,
                  //         color: isSelected[2]
                  //             ? AppColors.primary
                  //             : AppColors
                  //                 .white54, // Change color based on selection
                  //       ),
                  //     ),
                  //     hintText: "",
                  //     readonly: true,
                  //     controller: optionsControllers[2]),
                  // sizedTextfield,
                  // MyCustomTextField.textField(
                  //     suffixIcon: GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           isSelected = [
                  //             false,
                  //             false,
                  //             false,
                  //             true
                  //           ]; // Toggle the state
                  //         });
                  //       },
                  //       child: Icon(
                  //         isSelected[3]
                  //             ? Icons.radio_button_checked
                  //             : Icons.radio_button_unchecked,
                  //         color: isSelected[3]
                  //             ? AppColors.primary
                  //             : AppColors
                  //                 .white54, // Change color based on selection
                  //       ),
                  //     ),
                  //     hintText: "",
                  //     readonly: true,
                  //     controller: optionsControllers[3]),
                ]),
                 Expanded(
                   child: ListView.builder(
                    shrinkWrap: true,
                     itemCount: optionsControllers.length,  // Length of the controllers list
                     itemBuilder: (context, index) {
                       return MyCustomTextField.textField(
                         lableText: index == 0
                             ? "E.g. followers, mailing list, subscribers"
                             : '', // Add unique label for first field, others will be empty
                         hintText: "",
                         suffixIcon: GestureDetector(
                           onTap: () {
                             setState(() {
                               // Reset isSelected and update the clicked index to true
                               for (int i = 0; i < isSelected.length; i++) {
                                 isSelected[i] = false;
                               }
                               isSelected[index] = true; // Set the clicked radio button to selected
                             });
                           },
                           child: Icon(
                             isSelected[index]
                                 ? Icons.radio_button_checked
                                 : Icons.radio_button_unchecked,
                             color: isSelected[index]
                                 ? AppColors.primary
                                 : AppColors.white54, // Change color based on selection
                           ),
                         ),
                         readonly: true,
                         controller: optionsControllers[index],
                       );
                     },
                   ),
                 )
                
              
            ],
          ),
        ),
         bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 12,right:12,bottom: 12,),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                // Get.to(() => const CreateNewWebinarScreen());
              },
              title: "Create Community"),
        ),
      ),
    );
  }
}
