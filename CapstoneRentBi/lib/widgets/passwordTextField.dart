import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/widgets/text_field_container.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  PasswordTextField({Key? key, required this.controller}) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isHidden = true;
  String password = '';
  final String _passwordHintText = 'Enter your Password';


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: labelStyle,
        ),
        verticalSpaceTiny,
        /*Container(
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            // autofillHints: const [AutofillHints.password],
            // onEditingComplete: () => TextInput.finishAutofillContext(),
            controller: widget.controller,
            maxLength: 24,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isHidden,
            style: hintTextStyle,
            validator: (password) => password != null && password.length<5
                ? 'Enter min. 5 characters'
                : null,

            decoration: InputDecoration(
              hintText: 'Enter your Password',
              hintStyle: hintTextStyle,
              border: InputBorder.none,
              // contentPadding: EdgeInsets.only(top: 10.0),
              prefixIcon: const Icon(
                // Icons.email,
                Icons.lock,
                color: Colors.white,
              ),

              suffixIcon: IconButton(
                icon: isHidden
                    ? const Icon(
                        Icons.visibility_off,
                        color: Colors.white54,
                      )
                    : const Icon(
                        Icons.visibility,
                        color: Colors.white70,
                      ),
                onPressed: togglePasswordVisibility,
              ),
            ),
          ),
        ),*/
        Stack(
          children: [
            const TextFieldContainer(),
            TextFormField(
              style: fieldTextStyle,
              cursorColor: Colors.white,
              obscureText: isHidden,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),

              onSaved: (newValue) => print(newValue),

              onChanged: (value) => setState(() => password = value),
              // autofillHints: const [AutofillHints.password],
              // onEditingComplete: () => TextInput.finishAutofillContext(),
              // controller: widget.controller,
              // maxLength: 24,

              validator: (password) => password != null && password.length < 5 ? 'Enter min. 5 characters' : null,

              decoration: InputDecoration(
                // floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: _passwordHintText,
                hintStyle: fieldTextStyle,
                border: InputBorder.none,
                // contentPadding: EdgeInsets.only(top: 10.0),
                prefixIcon: const Icon(
                  // Icons.email,
                  Icons.lock,
                  color: Colors.white,
                ),

                suffixIcon: IconButton(
                  icon: isHidden
                      ? const Icon(
                          Icons.visibility_off,
                          color: Colors.white54,
                        )
                      : const Icon(
                          Icons.visibility,
                          color: Colors.white70,
                        ),
                  onPressed: togglePasswordVisibility,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}

/*
class BuildTextField extends StatelessWidget {

  String labelText;
  String hintText;
  bool obscure;
  TextInputType textInputType;
  IconData iconType;


  BuildTextField({
    Key? key,
    required this.labelText,
    required this.textInputType,
    required this.iconType,
    required this.hintText,
    required this.obscure,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          labelText,
          style: labelStyle,
        ),
        // const SizedBox(height: 5.0),
        verticalSpaceTiny,
        Container(
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 50.0,
          child: TextField(
            keyboardType: textInputType,
            obscureText: obscure,

/*            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),*/
            style: hintTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              // contentPadding: EdgeInsets.only(top: 10.0),
              prefixIcon: Icon(
                // Icons.email,
                iconType,
                color: Colors.white,
              ),
              hintText: hintText,
              hintStyle: hintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}

*/
