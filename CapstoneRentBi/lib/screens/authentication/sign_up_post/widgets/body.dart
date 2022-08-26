/*
import 'package:capstone/screens/authentication/sign_up_post/widgets/sing_up_post_form.dart';
import 'package:capstone/utilities/constants.dart';
import 'package:capstone/utilities/spacing.dart';
import 'package:flutter/material.dart';
*/

part of '../sign_up_post.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: backgroundDecorationStyle,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              screenWidthPercentage(context, percentage: 0.085),
              screenHeightPercentage(context, percentage: 0.075),
              screenWidthPercentage(context, percentage: 0.085),
              screenHeightPercentage(context, percentage: 0.05),
            ),
            child: Column(
              children: [
                // verticalSpaceSmall,
                const Text(
                  'Create Account',
                  // textAlign: TextAlign.right,
                  style: subtleStyle,
                ),
                verticalSpaceTiny,
                SizedBox(
                  width: screenWidthPercentage(context, percentage: 0.7),
                  child: Text(
                    'Enter your address, phone number and your info for sign up',
                    // textAlign: TextAlign.right,
                    style: fieldTextStyle.copyWith(
                      color: const Color(0xBE244D80),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                verticalSpaceRegular,
                const SignUpPostForm(),
              ],
            ),
            // padding: EdgeInsets.fromLTRB(100, 0, 0, 0),4
          ),
        ),
      ),
    );
  }
}
