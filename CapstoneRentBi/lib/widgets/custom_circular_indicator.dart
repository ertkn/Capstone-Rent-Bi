import 'package:flutter/material.dart';

class CustomCircularIndicator extends StatelessWidget {
  double? value;
  Color? backgroundColor;
  Color? color;
  Animation<Color?>? valueColor;
  double strokeWidth;
  String? semanticsLabel;
  String? semanticsValue;

  CustomCircularIndicator({this.value, this.backgroundColor, this.color, this.valueColor,
      this.strokeWidth = 4.0, this.semanticsLabel, this.semanticsValue, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        value: value,
        backgroundColor: backgroundColor,
        color: color,
        semanticsLabel: semanticsLabel,
        semanticsValue: semanticsValue,
        strokeWidth: strokeWidth,
        valueColor: valueColor,
      ),
    );
  }
}