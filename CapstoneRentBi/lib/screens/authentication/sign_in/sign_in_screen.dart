import 'package:capstone_rent_bi/screens/authentication/sign_in/widgets/body.dart';
import 'package:capstone_rent_bi/utilities/page_padding.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/widgets/text_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utilities/constants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final String _skipTile = 'Skip';

  // String get skipTile => _skipTile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}