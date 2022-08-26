import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressedFunction;

  const LoginButton({
    Key? key,
    required this.buttonText,
    required this.onPressedFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: elvButtonStyle,
        /*onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        ),*/
        onPressed: onPressedFunction,
        // onPressed: () => print('Login Button Pressed'),
        child: Text(
          buttonText,
          style: buttonTextStyle,
        ),
      ),
    );
  }
}
