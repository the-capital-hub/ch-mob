// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/appcolors/app_colors.dart';
import '../textwidget/text_widget.dart';

class DropDownWidget extends StatefulWidget {
  final String status;
  final String? lable;

  final Color? borderColor;
  final List<String> statusList;
  final Function(String?) onChanged;
  final double? circleVal;
  final double? height;
  final RxBool? isValidate;

  const DropDownWidget(
      {Key? key,
      required this.status,
      this.lable,
      required this.statusList,
      required this.onChanged,
      this.circleVal,
      this.isValidate,
      this.borderColor,
      this.height})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.lable != null)
          TextWidget(
              text: widget.lable!, textSize: 14, fontWeight: FontWeight.w500),
        if (widget.lable != null) const SizedBox(height: 8),
        Container(
          height: widget.height ?? 50,
          padding: const EdgeInsets.only(left: 0, right:0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: AppColors.blackCard,
            borderRadius: BorderRadius.circular(widget.circleVal ?? 6),
            border: Border.all(color:widget.borderColor?? AppColors.transparent, width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                isExpanded: true,
                icon:  Icon(Icons.arrow_drop_down,
                    color: AppColors.white54),
                hint: TextWidget(
                    text: widget.status,
                    textSize: 14,
                    color: AppColors.white,
                    maxLine: 2,
                    align: TextAlign.left),
                iconEnabledColor: AppColors.black,
                iconDisabledColor: AppColors.black,
                isDense: false,
                borderRadius: BorderRadius.circular(4),
                dropdownColor: Colors.grey.shade700,
                items: widget.statusList.map((String value) {
                  return DropdownMenuItem(
                      value: value,
                      child: TextWidget(
                        text: value,
                        color: AppColors.white,
                        textSize: 16,
                        fontWeight: FontWeight.w400,
                      ));
                }).toList(),
                onChanged: widget.onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
