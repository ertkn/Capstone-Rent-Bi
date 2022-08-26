import 'package:flutter/material.dart';

class CustomTextButton extends TextButton {
  late final VoidCallback? _onPressedFunction;

  CustomTextButton(void Function()? onPressed, ButtonStyle buttonStyle, Widget childWidget)
      : super(onPressed: onPressed, style: buttonStyle, child: childWidget);
// CustomTextButton copyWith()
}
