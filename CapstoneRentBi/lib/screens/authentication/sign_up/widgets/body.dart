import 'package:capstone_rent_bi/screens/authentication/sign_up/widgets/sign_up_form.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:flutter/material.dart';
import 'package:capstone_rent_bi/utilities/constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        decoration: backgroundDecorationStyle,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
                screenWidthPercentage(context, percentage: 0.1),
                screenHeightPercentage(context, percentage: 0.05),
                screenWidthPercentage(context, percentage: 0.1),
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
                    'Enter your name, email and password for sign up',
                    // textAlign: TextAlign.right,
                    style: fieldTextStyle.copyWith(
                      color: const Color(0xBE244D80),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                verticalSpaceRegular,
                const SignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
/*            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceSmall,
                const Text(
                  'Create Account',
                  // textAlign: TextAlign.right,
                  style: subtleStyle,
                ),
                verticalSpaceTiny,
                SizedBox(
                  width: screenWidthPercentage(context, percentage: 0.7),
                  child: Text(
                    'Enter your name, email and password for sign up',
                    // textAlign: TextAlign.right,
                    style: fieldTextStyle.copyWith(
                      color: const Color(0xBE244D80),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                verticalSpaceRegular,
                _buildFirstNameTF(),
                verticalSpaceSmall,
                _buildLastNameTF(),
                verticalSpaceSmall,
                EmailTextField(controller: emailController),
                verticalSpaceSmall,
                PasswordTextField(
                  controller: passwordController,
                ),
                verticalSpaceMedium,
                _buildLoginBtn(),
              ],
            ),*/
/*  Row buildBackCloseButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xBE385C89),
          ),
          constraints: const BoxConstraints(minHeight: 0.0, minWidth: 0.0),
          tooltip: 'go back',
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            Navigator.pushNamed(context, '/home');
          },
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            //padding: const EdgeInsets.all(15.0),
            primary: Colors.transparent,
          ),
          child: const Icon(
            Icons.close_outlined,
            size: 32,
            color: Color(0xBE385C89),
            //semanticLabel: 'go without sign',
          ),
        ),
      ],
    );
  }*/
}
