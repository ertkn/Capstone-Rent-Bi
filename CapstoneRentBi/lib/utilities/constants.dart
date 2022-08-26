import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const kTextColor = Color(0xFF757575);
/*class HintText{
  final String _hint;
  String get hint => _hint;
  HintText([this._hint ='']);

  String getHintText(){
    return 'Enter your $hint';
  }
}*/

String hintText([String? hint]) {
  return 'Enter your ${hint ?? 'null'}';
}

String nullStringPlaceHolder = 'unknown';

String placeholderSmall = 'https://via.placeholder.com/50';
String placeholderMedium = 'https://via.placeholder.com/150';
String placeholderLarge = 'https://via.placeholder.com/300';


const kTextColorW = Color(0xFFFFFFFF);
const kTextColorB = Color(0xFF000000);

const defaultDuration = Duration(milliseconds: 250);

final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

const fieldTextStyle = TextStyle(
  color: Colors.white,
  // fontFamily: 'OpenSans',
  fontSize: 16,
);

const productCardTitleStyle = TextStyle(
  color: Colors.black,
  letterSpacing: -0.5,
  fontStyle: FontStyle.normal,
  // fontFamily: 'OpenSans',
  fontSize: 15,
);

const profileTitleStyle = TextStyle(
  wordSpacing: 1,
  color: Colors.black,
  letterSpacing: -0.5,
  overflow: TextOverflow.ellipsis,
  // fontFamily: 'OpenSans',
  fontSize: 16,
);

BoxDecoration favBoxDecoration = const BoxDecoration(
  shape: BoxShape.circle,
  color: Colors.white,
// borderRadius:BorderRadius.zero,
// border: Border.all(color: Colors.black12),
  boxShadow: [
    BoxShadow(
      color: Colors.black26,
      offset: Offset(0, 5),
      blurRadius: 10,
      spreadRadius: .5,
// blurStyle: BlurStyle.outer,
    )
  ],
);

const productCardPriceStyle = TextStyle(
  color: Colors.black,
  letterSpacing: 0.5,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
  // fontFamily: 'OpenSans',
  fontSize: 20,
);

const appBarTitleStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  // fontFamily: 'OpenSans',
  fontWeight: FontWeight.w500,
  letterSpacing: -0.75,
);

const hintTextStyle = TextStyle(
  color: Colors.white,
  // fontFamily: 'OpenSans',
  fontSize: 14.5,
  // fontWeight: FontWeight.w300,
);

const subtleStyle = TextStyle(
  color: Color(0xBE244D80),
  // fontFamily: 'RobotoSlab',
  fontSize: 30.0,
  fontWeight: FontWeight.w500,
);

const labelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  // fontFamily: 'OpenSans',
);

const headerStyle = TextStyle(
  fontSize: 24,
  color: Colors.black,
  fontWeight: FontWeight.bold,
  // fontFamily: 'OpenSans',
);

const buttonTextStyle = TextStyle(
  color: Color(0xFF527DAA),
  letterSpacing: 1.5,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  // fontFamily: 'OpenSans',
);

final boxDecorationStyle = BoxDecoration(
  // color: const Color(0xFF6CA8F1),
  // // color: const Color(0xFF9AABCE),
  // color: const Color(0xFF56739E),
  // color: const Color(0xFF4E70A3),
  // color: const Color(0xFF465E7F),
  // color: const Color(0xFF637997),
  // color: const Color(0xFF6283B4),
  // color: const Color(0xB26283B4),
  // color: const Color(0x252E5E9E),
  // color: const Color(0x66425866),
  // color: const Color(0x9AAFC5DE),
  // color: const Color(0x32CEDEEE),
  // color: const Color(0x414C7197),
  // color: const Color(0x4D7878CB),
  // color: const Color(0xFFB9936C),
  color: const Color(0xBE385C89),

  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

const backgroundDecorationStyle = BoxDecoration(
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
);
/*
const textFieldInputDecoration = InputDecoration(
  border: InputBorder.none,
  hintStyle: hintTextStyle,
);
*/

ButtonStyle elvButtonStyle = ElevatedButton.styleFrom(
  elevation: 5.0,
  padding: const EdgeInsets.all(15.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
  ),
  primary: Colors.white,
);

ButtonStyle txtButtonStyle = TextButton.styleFrom(
//elevation: 0.0,
  padding: const EdgeInsets.only(right: 0.0),
  primary: Colors.white,
/*  textStyle: const TextStyle(
    color: Color(0xFF37485C),fontSize: 18,
  ),*/
  textStyle: buttonTextStyle,
  backgroundColor: Colors.transparent,
//shadowColor:
);

/*
final textFieldContainer = Container(
  alignment: Alignment.centerLeft,
  decoration: boxDecorationStyle,
  height: 50.0,
);
*/

/*Widget column = Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    const Text(
      'First Name',
      style: labelStyle,
    ),
    verticalSpaceTiny,
    Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 50.0,
        ),
        TextFormField(
          cursorColor: Colors.white,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          style: hintTextStyle,
          validator: (value) => value != null && (value.length > 50 || value.isEmpty)
              ? 'Name length must be between 1-50 characters'
              : null,
          decoration: const InputDecoration(
            border: InputBorder.none,
            // contentPadding: EdgeInsets.only(top: 10.0),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            hintText: 'Enter your Firs Name',
            hintStyle: hintTextStyle,
          ),
        ),
      ],
    ),
  ],
);*/

/*
TextField textFieldSample = const TextField(
  obscureText: false,
  keyboardType: TextInputType.text,
  // keyboardType: textInputType,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),

  style: hintTextStyle,
  decoration: InputDecoration(
    border: InputBorder.none,
    // contentPadding: EdgeInsets.only(top: 10.0),
    prefixIcon: Icon(
      Icons.email,
      // iconType,
      color: Colors.white,
    ),
    hintText: 'Enter your Email',
    hintStyle: hintTextStyle,
  ),
);
*/
