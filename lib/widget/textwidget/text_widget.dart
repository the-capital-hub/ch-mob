// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/appcolors/app_colors.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double textSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLine;
  final TextAlign? align;
  final TextStyle? googleStyle;
  final TextDecoration? textDecoration;
  final bool? googleFont;
  const TextWidget({
    Key? key,
    required this.text,
    required this.textSize,
    this.fontWeight,
    this.googleFont,
    this.color,
    this.maxLine,
    this.align,
    this.googleStyle,
    this.textDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text.tr,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLine,
        textAlign: align,
        style:
        googleFont==null||googleFont==true?
         GoogleFonts.outfit(
            textStyle: TextStyle(
          fontSize: textSize ,
          decoration: textDecoration,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color ?? AppColors.white,
        )):

        googleStyle ??
            Theme.of(context).textTheme.displayLarge!.copyWith(
                  decoration: textDecoration,
                  fontSize: textSize,
                  fontWeight: fontWeight ?? FontWeight.normal,
                  color: color??AppColors.white,
                ),
        );
  }
}
