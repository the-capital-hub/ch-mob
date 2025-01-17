import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:flutter/material.dart';

var transDuration = const Duration(milliseconds: 400);

var sizedTextfield = const SizedBox(height: 12);

var bgDec = const BoxDecoration(
    image: DecorationImage(
        image: AssetImage(PngAssetPath.bgImg),
        filterQuality: FilterQuality.low,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.color),
        fit: BoxFit.cover));
