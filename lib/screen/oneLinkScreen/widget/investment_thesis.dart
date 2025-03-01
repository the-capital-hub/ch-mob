import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../utils/appcolors/app_colors.dart';
import '../../../widget/textWidget/text_widget.dart';
import '../../../widget/text_field/text_field.dart';

class InvestmentThesis extends StatefulWidget {
  final String title;
  const InvestmentThesis({super.key, required this.title});

  @override
  State<InvestmentThesis> createState() => _InvestmentThesisState();
}

class _InvestmentThesisState extends State<InvestmentThesis> {
  bool _showTextField=false;
  final TextEditingController textEditingController = TextEditingController();


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
              TextWidget(text: widget.title, textSize: 15),
              Icon(_showTextField? Icons.arrow_drop_up :Icons.arrow_drop_down,color: AppColors.white,),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        if(_showTextField)
          Container(
            child: MyCustomTextField.textField(hintText: 'Add your answer',
                controller: textEditingController
            ),
          ),
      ],
    );
  }
}
