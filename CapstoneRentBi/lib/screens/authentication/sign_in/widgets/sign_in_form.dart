import 'package:capstone_rent_bi/screens/authentication/sign_up/sign_up_screen.dart';
import 'package:capstone_rent_bi/screens/wrapper/wrapper.dart';
import 'package:capstone_rent_bi/services/auth.dart';
import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/utilities/snackbar.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/utilities/user_preferences.dart';
import 'package:capstone_rent_bi/widgets/custom_circular_indicator.dart';
import 'package:capstone_rent_bi/widgets/text_field_container.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // u.User newUser = UserPreferences.myUser;
  bool _rememberMe = false;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // String? email;
  bool _isLoading = false;
  bool isHidden = true;
  bool isValidate = false;
  bool _isSuccess = false;
  final String _home = 'home';
  final String _emailHint = 'Enter your Email';
  final String _passwordHint = 'Enter your Password';
  final String _loginButtonText = 'LOGIN';

  // bool val = false;

  // final passwordController = TextEditingController();
  // final emailController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // passwordController.dispose();
    // emailController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          buildEmailTextField(),
          verticalSpaceSmall,
          buildPasswordTextField(),
          verticalSpaceTiny,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildRememberMeCheckbox(),
              buildForgotPasswordBtn(),
            ],
          ),
          verticalSpaceTiny,
          buildLoginButton(),
          verticalSpaceRegular,
          buildSignupBtn(),
        ],
      ),
    );
  }

  Widget buildEmailTextField() {
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

              controller: _emailController,

/*              onChanged: (value) {
                if (emailValidatorRegExp.hasMatch(value)) {
                  setState(() {
                    random = Random().nextInt(100 - 15);
                  });
                  print('onChange' + '---' + '$random');
                }

                if (EmailValidator.validate(value)) {
                  setState(() {
                    // newUser.email = value;
                  });
                }
              },*/

              // onSaved: (newValue) => myUser.email = email,
              onSaved: (newValue) {
                setState(() {
                  // newUser.email = newValue;
                  UserPreferences.myUser.email = newValue ?? "";
                });
              },

              validator: (email) =>
                  email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null,

              decoration: InputDecoration(
                hintText: _emailHint,
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
                  onPressed: () => _emailController.clear(),
                ),
/*              suffixIcon: widget.controller.text.isEmpty
                ? Container(width: 0)
                : IconButton(
              icon: Icon(Icons.close),
              onPressed: () => widget.controller.clear(),
            ),*/
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildPasswordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Password', style: labelStyle),
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
              controller: _passwordController,
              style: fieldTextStyle,
              cursorColor: Colors.white,
              obscureText: isHidden,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),

              onSaved: (newValue) {
                setState(() {
                  // newUser.password = newValue;

                  /// UserPreferences.myUser.password = newValue;
                });
              },

              // onChanged: (value) => setState(() => password = value),
              // autofillHints: const [AutofillHints.password],
              // onEditingComplete: () => TextInput.finishAutofillContext(),
              // controller: widget.controller,
              // maxLength: 24,

              validator: (password) =>
                  password != null && password.length < 8 ? 'Enter min. 8 characters' : null,

              decoration: InputDecoration(
                // floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: _passwordHint,
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

  Widget buildForgotPasswordBtn() {
    return Container(
      height: screenHeightPercentage(context, percentage: 0.07),
      width: screenWidthPercentage(context, percentage: 0.36),
      alignment: Alignment.bottomRight,
      child: TextButton(
        // style: txtButtonStyle.copyWith(textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(fontSize: 18))),
        onPressed: () => print('Forgot Password Button Pressed'),
        child: Text(
          'Forgot Password?',
          style: labelStyle.copyWith(fontSize: screenWidthPercentage(context, percentage: 0.0275)),
        ),
      ),
    );
  }

  Widget buildRememberMeCheckbox() {
    return Container(
      height: screenHeightPercentage(context, percentage: 0.07),
      width: screenWidthPercentage(context, percentage: 0.36),
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.black,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = !_rememberMe;
                  print('inCheckbox: $_rememberMe');
                });
              },
            ),
          ),
          TextButton(
            child: Text('Remember me',
                style: labelStyle.copyWith(
                    fontSize: screenWidthPercentage(context, percentage: 0.0275))),
            onPressed: () {
              setState(() {
                _rememberMe = !_rememberMe;
                print('inTextButton: $_rememberMe');
              });
            },
          ),
        ],
      ),
    );
  }

  bool isRemember() {
    return _rememberMe = !_rememberMe;
  }

/*
  Widget buildLoginBtn() {
    return LoginButton(
      buttonText: 'LOGIN',
      onPressedFunction: validFunction,
    );
  }
*/

  Container buildLoginButton() {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: IgnorePointer(
        ignoring: _isLoading,
        child: ElevatedButton(
          style: elvButtonStyle,
          /*onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          ),*/
          onPressed: () async {
            /*
            DateTime _now = DateTime.now();
            var moonLanding = DateTime.parse("1969-07-20 20:18");
            print('timestamp: ${moonLanding} --> ${_now.hour}:${_now.minute}:${_now.second}.${_now.millisecond}');*/
            final form = formKey.currentState!;
            if (form.validate() && form != null) {
              form.save();
              // print(_emailController.text);
              // print(_passwordController.text);
              await _signIn();

              // validFunction();
/*             val = (await buildDialog())!;
              if(val == true){
                print('goes to registered');
                await _registerWithEmailNPassword();
              }*/

/*            buildDialog().then((_) {
                if(isValidate == true){
                  print('goes to registered');
                  _registerWithEmailNPassword();
                }
              });*/

              // print('out to registered: ${isValidate.toString()}');

              // print('BuildDialog: ${buildDialog()}');
              // _registerWithEmailNPassword();
            }
          },
          // onPressed: () => print('Login Button Pressed'),
          child: _isLoading ? CustomCircularIndicator() : Text(_loginButtonText, style: buttonTextStyle),
        ),
      ),
    );
  }

/*  Future _signIn() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final User? user = userCredential.user;
      // _isSuccess =true;
      SnackBarMessage.showSnackBar(context,
          // text: 'welcome back ${UserPreferences.myUser.firstName}',
          text:'welcome back ${user?.uid ?? '---'}\n${user?.email ?? '---'}\n${user?.displayName ?? '---'}');
      Navigator.pushReplacementNamed(context, '/$_home');
    } on FirebaseAuthException catch (e) {
      // _isSuccess = false;
      SnackBarMessage.showSnackBar(
        context,
        text: 'ouch an error catched! ${e.message}',
      );
    } catch (e) {
      // _isSuccess = false;
      SnackBarMessage.showSnackBar(
        context,
        text: 'ouch an error catched!! ${e.toString()}',
      );
      debugPrint(e.toString());
    }
  }*/

  Future _signIn() async {
    if (await AuthService().signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          context,
        ) !=
        null) {
      // const Wrapper(toWhere: 'home',);
      Navigator.pushReplacementNamed(context, '/$_home');
    } else {
      print('[package:capstone_rent_bi/screens/authentication/sign_in/widgets/sign_in_form.dart]:413 _signIn --> signing has failed due some reason');
    }
  }

/*  Future _signIn() async {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      AuthService()
          .signInWithEmailAndPassword(_emailController.text, _passwordController.text,context)
          .then((value) {
        if(value!=null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
        print('isValueNull? --> $value');
      }).catchError((error) {
        print(error);
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
      // const Wrapper(toWhere: 'home',);
    } else {
      print('empty fields!');
    }
  }*/

  bool isLoading(){
    return _isLoading = !_isLoading;
  }

  Widget buildSignupBtn() {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen())),
      // Navigator.pushNamedAndRemoveUntil(context,'signuppost',(route) => false,arguments:{"args1":_passwordController.text,"args2":_emailController.text} ),

      // onTap: () => print('routed to Sign-up page'),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Widget _closeButton() {
  return Positioned(
    top: 120.0,
    right: 20,
    // height: 25.0,
    // width: 25.0,
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
  );
}*/

/*

  PasswordTextField buildPasswordTextFieldd() =>
      PasswordTextField(controller: controller);
*/

/*
  EmailTextField buildEmailTextField() {
    return  EmailTextField(controller: controller);
  }
*/
