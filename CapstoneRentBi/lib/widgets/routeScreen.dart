/*import 'package:capstone_rent_bi/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:capstone_rent_bi/screens/home/product/home_screen.dart';
import 'package:capstone_rent_bi/services/auth.dart';
import 'package:flutter/material.dart';

class RouteDelay {
  final BuildContext _parentContext;
  final String _toAuthorization = 'login';
  final String _toWhere;

  RouteDelay(this._parentContext, this._toWhere);

  Future routeScreenDelay()async{
    // await Future.delayed(const Duration(milliseconds: 750)).then((_) => routeScreen());
    print('_toWhere: '+_toWhere);
    routeScreen();
  }

*//*
  void routeScreen() => AuthService().isUserNull() == null
      ? Navigator.pushReplacement(_parentContext,
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()))
      : Navigator.pushReplacement(_parentContext,
      MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));*//*

  void routeScreen() => AuthService().isUserNull() == null
      ? Navigator.popUntil(_parentContext,ModalRoute.withName('/$_toAuthorization'))
      : Navigator.popUntil(_parentContext,ModalRoute.withName('/$_toWhere'));
}*/
