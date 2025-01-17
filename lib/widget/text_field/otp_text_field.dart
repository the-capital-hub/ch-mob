import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../utils/appcolors/app_colors.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    super.key,
    this.onChanged,
    this.focusNode,
    required this.controller,
    required this.onCompleted,
    this.onSubmitted,
    this.obscureText = false,
    this.pinLength = 6,
    this.height = 56,
    this.width = 56,
    this.autoFocus = false,
  });
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final int pinLength;
  final bool obscureText;
  final void Function(String) onCompleted;
  final void Function(String)? onSubmitted;
  final double height;
  final double width;
  final bool autoFocus;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Pinput(
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      autofillHints: const <String>[AutofillHints.oneTimeCode],
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      autofocus: autoFocus,
      obscureText: obscureText,
      obscuringCharacter: '✱',
      length: pinLength,
      defaultPinTheme: PinTheme(
        width: width,
        height: height,
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        decoration: BoxDecoration(
          color: AppColors.blackCard,
          border: Border.all(color: AppColors.white12),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: width,
        height: height,
        textStyle: theme.textTheme.headlineSmall,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(color: theme.colorScheme.primary, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
      onCompleted: onCompleted,
      focusNode: focusNode,
      controller: controller,
      onSubmitted: onSubmitted,
    );
  }
}
