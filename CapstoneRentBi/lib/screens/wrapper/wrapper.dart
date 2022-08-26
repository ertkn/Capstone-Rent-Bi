import 'package:capstone_rent_bi/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:capstone_rent_bi/screens/home/product/home_screen.dart';
import 'package:capstone_rent_bi/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../authentication/sign_up_post/sign_up_post.dart';

class Wrapper extends StatefulWidget {
  final String _toWhere;
  String get toWhere => _toWhere;

  const Wrapper({Key? key, toWhere}) :_toWhere = toWhere ??'home' ,super(key: key);
  // const Wrapper({Key? key, toWhere}) :_toWhere = toWhere ??'userset' ,super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final AuthService _authService = AuthService();
  final String _toAuthorization = 'login';
  String get toAuthorization => _toAuthorization;

/*  void routeIfUserLoggedIn() async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => _auth.currentUser == null
            ?  LoginScreen()
            :  HomeScreen(),
      ),
    );
  }*/

  @override
  void initState() {
    super.initState();
    // routeIfUserLoggedIn();
    // print(_auth.currentUser.toString());
    Future.delayed(const Duration(milliseconds: 750)).then((_) => routeScreen());
    //Duration(milliseconds: 750)
    // routeScreen();
  }

  void routeScreen() => AuthService().isUserNull() == null
      ? Navigator.popAndPushNamed(context,'/$toAuthorization')
      : Navigator.pushNamedAndRemoveUntil(context,'/${widget.toWhere}',(route) => false,);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xBE244D80),
      body: Center(
        child: SpinKitFadingCircle(
          duration: const Duration(milliseconds: 1200),
          itemBuilder: (BuildContext context, int index) {
            return  const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                // color: index.isEven ? Colors.red : Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }
}

/*  @override
  void initState() {
    super.initState();
    // routeIfUserLoggedIn();
    // print(_auth.currentUser.toString());
    Future.delayed(const Duration(milliseconds: 750)).then((_) => routeScreen());//Duration(milliseconds: 750)
  }

  void routeScreen() => _auth.currentUser == null
      ? Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()))
      : Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
          */