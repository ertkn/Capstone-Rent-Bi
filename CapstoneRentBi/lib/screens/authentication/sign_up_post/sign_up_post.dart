import 'dart:convert';

import 'package:capstone_rent_bi/models/categories.dart';
import 'package:capstone_rent_bi/services/auth.dart';
import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/utilities/snackbar.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/utilities/user_preferences.dart';
import 'package:capstone_rent_bi/widgets/routeScreen.dart';
import 'package:capstone_rent_bi/widgets/text_field_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/user.dart';
import '../../wrapper/wrapper.dart';

part 'widgets/body.dart';
part 'widgets/sing_up_post_form.dart';

class SignUpPost extends StatelessWidget {
  String? _tempPass;
  SignUpPost({Key? key,tempPass }) : _tempPass = tempPass,super(key: key);
  String? get tempPass => _tempPass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
    );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFFB6CFEC),
      // backgroundColor: Colors.transparent,
      leading: IconButton(
        padding: EdgeInsets.only(left: screenWidthPercentage(context, percentage: 0.1)),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xBE385C89),
        ),
        constraints: const BoxConstraints(minHeight: 0.0, minWidth: 0.0),
        tooltip: 'go back',
        onPressed: () {
          Navigator.pop(context);
          // print('tempPass in sign up: $password');

        },
      ),
      actions: [
        IconButton(
          tooltip: 'be guest',
          padding: EdgeInsets.only(right: screenWidthPercentage(context, percentage: 0.135)),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
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
/*  final String? _password;
  String get password =>_password ?? 'null';*/

