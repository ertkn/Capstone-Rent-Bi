/*import 'dart:math';

import 'package:capstone/utilities/spacing.dart';
import 'package:capstone/utilities/constants.dart';
import 'package:capstone/widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class EmailTextField extends StatefulWidget {
  final TextEditingController controller;

  const EmailTextField({Key? key, required this.controller}) : super(key: key);

  @override
  _EmailTextFieldState createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  int random = Random().nextInt(100 - 55) * 3;
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(onListen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);
    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: labelStyle,
        ),
        verticalSpaceTiny,
        Stack(
          children: [
            const TextFieldContainer(),
            TextFormField(
              cursorColor: Colors.white,
              style: fieldTextStyle,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),

              controller: widget.controller,

              onChanged: (value) {
                if(EmailValidator.validate(value)){
                  setState(() {
                    random = Random().nextInt(100-15);
                  });
                  print('onChange'+ '---' + '$random');
                }
              },

              // onSaved: (newValue) => myUser.email = email,
              onSaved: (newValue) {
                print('onSaved');
              },
              validator: (email) =>
                  email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null,

              decoration: InputDecoration(
                hintText: 'Enter your Email',
                hintStyle: fieldTextStyle,
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white54,
                  ),
                  onPressed: () => widget.controller.clear(),
                ),

              ),
            ),
          ],
        )
      ],
    );
  }
}*/
/*              suffixIcon: widget.controller.text.isEmpty
                ? Container(width: 0)
                : IconButton(
              icon: Icon(Icons.close),
              onPressed: () => widget.controller.clear(),
            ),*/