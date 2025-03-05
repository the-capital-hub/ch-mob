import 'package:capitalhub_crm/controller/oneLinkController/one_link_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../utils/appcolors/app_colors.dart';
import '../../../widget/textWidget/text_widget.dart';
import '../../../widget/text_field/text_field.dart';

class InvestmentThesis extends StatefulWidget {
  final String question;
  final String answer;
  final int index;
  const InvestmentThesis({super.key, required this.question, required this.answer, required this.index});

  @override
  State<InvestmentThesis> createState() => _InvestmentThesisState();
}

class _InvestmentThesisState extends State<InvestmentThesis> {
  bool _showTextField=false;
  final TextEditingController answerController = TextEditingController();
  @override
  void initState() {
    super.initState();
    
    // Set the initial value of the controller
    answerController.text = widget.answer; // Set this to the value you want
    
    // Alternatively, if you want to set the value dynamically, you can do:
    // answerController.text = yourDynamicValue;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 10,),
        InkWell(
          onTap: (){
            setState(() {
              _showTextField=!_showTextField;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width:300,child: TextWidget(text: widget.question, textSize: 15,maxLine: 4)),
              Icon(_showTextField? Icons.arrow_drop_up :Icons.arrow_drop_down,color: AppColors.white,),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        if(_showTextField)
          Container(
            child: MyCustomTextField.textField(hintText: 'Add your answer',maxLine: 2,
                controller: answerController,
                
            ),
          ),
      ],
    );
  }
}
