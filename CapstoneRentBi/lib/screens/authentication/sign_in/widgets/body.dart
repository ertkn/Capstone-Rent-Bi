import 'package:capstone_rent_bi/screens/authentication/sign_in/widgets/sign_in_form.dart';
import 'package:capstone_rent_bi/screens/wrapper/wrapper.dart';
import 'package:capstone_rent_bi/services/auth.dart';
import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/utilities/page_padding.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../widgets/text_button_widget.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();
  final String signIn = 'Sign In';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _skipTile = 'Skip';
  final String _home = 'home';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFB6CFEC),
                  Color(0xFF8BAACE),
                  Color(0xFF6788AC),
                  Color(0xFF37485C),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
/*              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 100.0,
              ),*/
              padding: const PagePadding.all(),
              child: SizedBox(
                height: screenHeightPercentage(context, percentage: 0.8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        // height: screenHeightPercentage(context, percentage: 0.05),
                        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                          CustomTextButton(
                            () => _singInAnonymously(context),
                            txtButtonStyle,
                            buildText(),
                          ),
                        ]),
                      ),
                    ),
                    Flexible(
                      flex: 9,
                      child: Container(
                        // height: screenHeightPercentage(context, percentage: 0.75),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(signIn, style: subtleStyle),
                            verticalSpaceSmall,
                            const SignInForm(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

/*
  _singInAnonymously(BuildContext context) async {
    await _auth.signInAnonymously();
    Navigator.pushReplacementNamed(context, '/home');
  }
*/

  _singInAnonymously(BuildContext context) async {
    await _authService.signInAnonymously(context);
    // const Wrapper(toWhere: 'home',);
    Navigator.pushReplacementNamed(context, '/$_home');
  }

  Text buildText() {
    return Text(
      _skipTile,
      style: subtleStyle.copyWith(fontSize: 18, color: const Color(0xFF417FC2)),
    );
  }
}
