import 'package:flutter/material.dart';

const horizontalSpaceTiny = SizedBox(width: 5);
const horizontalSpaceSmall = SizedBox(width: 10);
const horizontalSpaceRegular = SizedBox(width: 15);
const horizontalSpaceMedium = SizedBox(width: 25);
const horizontalSpaceLarge = SizedBox(width: 50);

const verticalSpaceTiny = SizedBox(height: 5);
const verticalSpaceSmall = SizedBox(height: 10);
const verticalSpaceRegular = SizedBox(height: 15);
const verticalSpaceMedium = SizedBox(height: 25);
const verticalSpaceLarge = SizedBox(height: 50);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;
double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;