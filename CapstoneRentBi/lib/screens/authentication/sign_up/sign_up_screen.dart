import 'package:capstone_rent_bi/screens/authentication/sign_up/widgets/body.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const NavigationDrawer(),
      appBar: buildAppBar(context),
      body: const Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    const String _signIn = 'home';
    const String _actionToolTip = 'be guest';
    const String _leadingToolTip = 'go back';

    return AppBar(
      backgroundColor: const Color(0xFFB6CFEC),
      leading: IconButton(
        padding: EdgeInsets.only(left: screenWidthPercentage(context, percentage: 0.1)),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xBE385C89),
        ),
        constraints: const BoxConstraints(minHeight: 0.0, minWidth: 0.0),
        tooltip: _leadingToolTip,
        onPressed: () => Navigator.pop(context),
      ),
      actions: [IconButton(
          tooltip: _actionToolTip,
          padding: EdgeInsets.only(right: screenWidthPercentage(context, percentage: 0.135)),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/$_signIn');
            // Navigator.popUntil(context,ModalRoute.withName('/home'));
          },
          icon: const Icon(
            Icons.close,
            size: 32,
            color: Color(0xBE385C89),
          ),
        )
      ],
    );
  }
}