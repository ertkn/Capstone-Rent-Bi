/*
import 'package:capstone_rent_bi/models/user.dart';
import 'package:capstone_rent_bi/services/user_service.dart';
import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/utilities/user_preferences.dart';
import 'package:capstone_rent_bi/widgets/custom_circular_indicator.dart';
import 'package:capstone_rent_bi/widgets/toUpperCase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
*/

part of '../profilenew.dart';

class Body extends StatefulWidget {
  final UserModel _userCredentialModel;
  final bool _isEnabled;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // int isEdit = 0;

   Body({required formKey,required userModel,required isEnabled, Key? key})
      : _userCredentialModel = userModel,
        _isEnabled = isEnabled,
         _formKey = formKey,
        super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String profileNewPath = 'profilenew';
  UserModel get userCredentialModel => widget._userCredentialModel;
  GlobalKey<FormState> get formKey => widget._formKey;
  bool get isEnabled => widget._isEnabled;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController  = TextEditingController();
  final TextEditingController emailController     = TextEditingController();
  final TextEditingController phoneController     = TextEditingController();
  final TextEditingController aboutController     = TextEditingController();
  // final _formKey = GlobalKey<FormState>();

  String firstNameText ='FIRST NAME';
  String lastNameText ='LAST NAME';
  String emailText ='EMAIL';
  String phoneText ='PHONE NUMBER';
  String aboutText ='ABOUT YOURSELF';

  /*void getData() async {
    // Response response = await get(Uri.http('jsonplaceholder.typicode.com', '/todos/1' ));
    Response response =
        await get(Uri.http('worldtimeapi.org', 'api/timezone/Europe/Istanbul'));
    Map data = jsonDecode(response.body);
    // print('$data\n\n');
    String timezone = data['timezone'];
    String utcDatetime = data['utc_datetime'];

    String offset = data['utc_offset'].substring(1, 3);
    print('${data['utc_offset']}  ' '  ${offset}');
    String datetime = data['datetime'];
    print('timezone: $timezone'
        '\nutc_datetime: $utcDatetime'
        '\ndatetime: $datetime');

    DateTime now = DateTime.parse(datetime);
    print('\nBefore DateTime datetime: ${now}');

    now = now.add(Duration(hours: int.parse(offset)));
    print('After  DateTime datetime: ${now}');
  }*/

/*
  @override
  void initState() {
    super.initState();
    getData();
  }
*/
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    aboutController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> profileLabels = [
      // verticalSpaceTiny,
      Container(
        // color: Colors.black12,
        // padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
        padding: PagePaddingSmall.only(),
        child: Text(
          'USER INFORMATION',
          style: appBarTitleStyle.copyWith( fontWeight: FontWeight.bold),
          // textAlign: TextAlign.left,
        ),
      ),
      verticalSpaceSmall,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: PagePaddingSmall.only(),
            child: Text(
              firstNameText,
              style: profileTitleStyle.copyWith(fontSize: 18),
            ),
          ),
          verticalSpaceTiny,
          TextFormField(
            // minLines: 3,
            // maxLines: 5,
            // enableInteractiveSelection: false,
            // readOnly: true,
            controller: firstNameController,
            readOnly: !isEnabled,
            enabled: isEnabled,
            style: profileTitleStyle,
            cursorColor: Colors.white,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),

            // controller: firstNameController,

            validator: (value) => value != null && (value.length > 50 || value.isEmpty)
                ? 'Name length must be between 1-50 characters'
                : null,

            onSaved: (newValue) {
              setState(() {
                // UserPreferences.myUser.firstName = newValue ?? nullStringPlaceHolder;
                userCredentialModel.firstName = newValue ?? nullStringPlaceHolder;
              });
            },

            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              // labelText: '${UserPreferences.myUser.firstName}',
              labelText: userCredentialModel.firstName.toCapitalized(),
              labelStyle: const TextStyle(color: Colors.black),

/*          border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid,width: 2)
          ),*/
              border: UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              // contentPadding: const EdgeInsets.fromLTRB(25, 25, 0, 5),
              contentPadding: PagePaddingSmall.only(),
            ),
          ),
        ],
      ),
      verticalSpaceSmall,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: PagePaddingSmall.only(),
            child: Text(
              lastNameText,
              style: profileTitleStyle.copyWith(fontSize: 18),
            ),
          ),
          verticalSpaceTiny,
          TextFormField(
            controller: lastNameController,
            readOnly: !isEnabled,
            enabled: isEnabled,
            cursorColor: Colors.white,
            style: profileTitleStyle,
            keyboardType: TextInputType.name,

            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),

            // controller: lastNameController,

            validator: (value) => value != null && (value.length > 50 || value.isEmpty)
                ? 'Name length must be between 1-50 characters'
                : null,

            onSaved: (newValue) {
              setState(() {
                // UserPreferences.myUser.lastName = newValue ?? nullStringPlaceHolder;
                userCredentialModel.lastName = newValue ?? nullStringPlaceHolder;
              });
            },

            decoration: InputDecoration(
              // labelText: '${UserPreferences.myUser.lastName}',
              labelText: userCredentialModel.lastName.toCapitalized(),
              labelStyle: const TextStyle(color: Colors.black),

              border: UnderlineInputBorder(),
              // contentPadding: const EdgeInsets.fromLTRB(25, 25, 0, 5),
              contentPadding: PagePaddingSmall.only(),

/*          border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid,width: 2)
          ),*/
              // contentPadding: EdgeInsets.only(top: 10.0),
/*          prefixIcon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
          Icons.close,
          color: Colors.white54,
            ),
            onPressed: () => firstNameController.clear(),
          ),
          hintText: 'Enter your Last Name',
          hintStyle: hintTextStyle,*/
            ),
          ),
        ],
      ),
      verticalSpaceSmall,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: PagePaddingSmall.only(),
            child: Text(
              emailText,
              style: profileTitleStyle.copyWith(fontSize: 18),
            ),
          ),
          verticalSpaceTiny,
          TextFormField(
            controller: emailController,
            readOnly: !isEnabled,
            enabled: isEnabled,
            cursorColor: Colors.white,
            style: profileTitleStyle,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),

            // controller: emailController,

/*        onChanged: (value) {
*/ /*                if (emailValidatorRegExp.hasMatch(value)) {
              setState(() {
                random = Random().nextInt(100 - 15);
              });
              print('onChange' + '---' + '$random');
            }*/ /*

          if (EmailValidator.validate(value)) {
            setState(() {
          // newUser.email = value;
            });
          }
        },*/

            // onSaved: (newValue) => myUser.email = email,
            onSaved: (newValue) {
              setState(() {
                // UserPreferences.myUser.email = newValue ?? nullStringPlaceHolder;
                userCredentialModel.email = newValue ?? nullStringPlaceHolder;
              });
            },

            validator: (email) =>
            email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null,

            decoration: InputDecoration(
              // labelText: '${UserPreferences.myUser.email}',
              labelText: userCredentialModel.email.toCapitalized(),
              labelStyle: const TextStyle(color: Colors.black),
              border: UnderlineInputBorder(),
              // contentPadding: const EdgeInsets.fromLTRB(25, 25, 0, 5),
              contentPadding: PagePaddingSmall.only(),

/*
          border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid,width: 2)
          ),*/
/*          prefixIcon: const Icon(
            Icons.email,
            color: Colors.white,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
          Icons.close,
          color: Colors.white54,
            ),
            onPressed: () => emailController.clear(),
          ),
          hintText: 'Enter your Email',
          hintStyle: hintTextStyle,*/
/*                suffixIcon: emailController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => emailController.clear(),
                  ),*/
            ),
          ),
        ],
      ),
      verticalSpaceSmall,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: PagePaddingSmall.only(),
            child: Text(
              phoneText,
              style: profileTitleStyle.copyWith(fontSize: 18),
            ),
          ),
          verticalSpaceTiny,
          TextFormField(
            controller: phoneController,
            readOnly: !isEnabled,
            enabled: isEnabled,
            // focusNode: focusNodePhone,
            style: profileTitleStyle,
            cursorColor: Colors.white,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            // controller: phoneNumberController,
            maxLength: 11,

            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],

            // onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(focusNodeAddress),

            onSaved: (newValue) {
              setState(
                () {
                  // int phoneInt = int.parse(newValue!),
                  // UserPreferences.myUser.phoneNumber = newValue ?? nullStringPlaceHolder;
                  userCredentialModel.phoneNumber = newValue ?? nullStringPlaceHolder;
                },
              );
            },
            validator: (val) => val != null && val.length != 11 ? 'Enter 11 digit' : null,
            decoration: InputDecoration(
              // labelText: '${UserPreferences.myUser.phoneNumber}',
              labelText: userCredentialModel.phoneNumber?.toCapitalized(),
              labelStyle: const TextStyle(color: Colors.black),
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              /* border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid,width: 2)
          ),*/
              border: UnderlineInputBorder(),
              // contentPadding: const EdgeInsets.fromLTRB(25, 25, 0, 5),
              contentPadding: PagePaddingSmall.only(),

              // contentPadding: EdgeInsets.only(top: 10.0),
/*          prefixIcon: const Icon(
            Icons.phone_iphone,
            color: Colors.white,
          ),

          suffixIcon: IconButton(
            icon: const Icon(
          Icons.close,
          color: Colors.white54,
            ),
            onPressed: () => phoneNumberController.clear(),
          ),
          hintText: 'Enter your Phone Number',
          hintStyle: hintTextStyle,*/
            ),
          ),
        ],
      ),
      verticalSpaceSmall,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: PagePaddingSmall.only(),
            child: Text(
              aboutText,
              style: profileTitleStyle.copyWith(fontSize: 18),
            ),
          ),
          verticalSpaceTiny,
          TextFormField(
            controller: aboutController,
            readOnly: !isEnabled,
            enabled: isEnabled,
            cursorColor: Colors.white,
            style: profileTitleStyle,
            keyboardType: TextInputType.name,

            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),

            // controller: lastNameController,

            validator: (value) => value != null && (value.length > 500 || value.isEmpty)
                ? 'Name length must be between 1-500 characters'
                : null,

            onSaved: (newValue) {
              setState(() {
                // UserPreferences.myUser.lastName = newValue ?? nullStringPlaceHolder;
                userCredentialModel.about = newValue;
              });
            },

            decoration: InputDecoration(
              labelText: userCredentialModel.about?.toCapitalized(),
              labelStyle: const TextStyle(color: Colors.black),
              border: UnderlineInputBorder(),
              // contentPadding: const EdgeInsets.fromLTRB(25, 25, 0, 5),
              contentPadding: PagePaddingSmall.only(),

            ),
          ),
        ],
      ),
      verticalSpaceSmall,
      /*Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:  PagePaddingSmall.only(),
            child: Text(
              aboutText,
              style: profileTitleStyle.copyWith(fontSize: 18),
            ),
          ),
          verticalSpaceTiny,
              TextFormField(
                textAlignVertical: TextAlignVertical.top,
                maxLines: 7,
                maxLength: 200,
                readOnly: !isEnabled,
                enabled: isEnabled,
                style: profileTitleStyle,
                // textAlign: TextAlign.center,
                cursorColor: Colors.black,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                controller: aboutController,
                onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                onSaved: (newValue) {
                  setState(() {
                    userCredentialModel.about = newValue ?? nullStringPlaceHolder;
                    // tempPass = newValue ?? '';
                    // print('TextField: $tempPassword');
                  });
                },
                validator: (text) => text != null && text.isEmpty ? 'about yourself' : null,
                decoration: InputDecoration(
                  // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  hoverColor: Colors.yellow,
                  focusColor: Colors.blue,
                  // filled: true,
                  fillColor: Colors.deepOrangeAccent,
                  // alignLabelWithHint: true,
                  enabled: false,
                  labelText: userCredentialModel.about,
                  labelStyle: TextStyle(color: Colors.black),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  // hintText: userCredentialModel.about,
                  hintStyle: TextStyle(color: Colors.black),
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                ),
              ),
        ],
      ),*/
      /*InkWell(
        onTap: () => Navigator.pushNamed(context, '/'),
        child: Container(
          height: screenHeightPercentage(context, percentage: 0.125),
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
          child: Text(
            // '${UserPreferences.myUser.about}',
            '${userCredentialModel.about}',
            overflow: TextOverflow.fade,
            maxLines: 4,
            // iconData: Icons.logout,
            // navPath: () => Navigator.pushNamed(context, '/'),
          ),
        ),
      ),*/
    ];
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        // (context, index) => _customTextFormField(emailController, userCredentialModel.firstName),
        (context, index) => profileLabels[index],
        childCount: profileLabels.length,
      ),
    );
  }


}
/*      menuBuilder(
        title: '${UserPreferences.myUser.firstName}',
        // iconData: Icons.person_outline,
        navPath: () => Navigator.pushNamed(context, '/profile'),
      ),
      menuBuilder(
        title: '${UserPreferences.myUser.lastName}',
        // iconData: Icons.favorite_border,
        navPath: () => Navigator.pushNamed(context, '/cart'),
      ),
      // buildDivider(context),
      menuBuilder(
        title: '${UserPreferences.myUser.email}',
        // iconData: Icons.shopping_cart_outlined,
        navPath: () => Navigator.pushNamed(context, '/cart'),
      ),
      // buildDivider(context),
      menuBuilder(
        title: '${UserPreferences.myUser.phoneNumber}',
        // iconData: Icons.settings_rounded,
        navPath: () => Navigator.pushNamed(context, '/settings'),
      ),*/
/*    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: UserService().getUserCrendential(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if(!snapshot.hasData){
              return const Center(child: Text('No Favourites',style: TextStyle(fontSize: 20),),);
            }else{
              if(snapshot.data != null){

                print('data: ${snapshot.data?.data()}');

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => profileLabels[index],
                    childCount: profileLabels.length,
                  ),
                );
              }else{
                return CustomCircularIndicator();
              }
            }
          },
         ),
      ),
    );*/
/*_customTextFormField(TextEditingController controller, String fieldName, int? maxLength, int? maxLine) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: labelStyle,
        ),
        verticalSpaceTiny,
        Stack(
          children: [
            const TextFieldContainer(),
            TextFormField(
              style: fieldTextStyle,
              cursorColor: Colors.white,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              controller: controller,
              onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
              maxLength: maxLength ?? 1,
              maxLines: maxLine ?? 1,

              onSaved: (newValue) {
                setState(() {
                  // UserPreferences.newUser.password = newValue ?? '';
                  userCredentialModel.firstName = newValue ?? null;
                  // print('TextField: $tempPassword');
                });
              },
              validator: (text) {
                switch (fieldName) {
                  case 'firstName':
                    return text != null ? 'Enter your name' : null;
                    // break;
                  case 'lastName':
                    return text != null ? 'Enter your last name' : null;
                    // break;
                  case 'email':
                    return text != null && !EmailValidator.validate(text) ? 'Enter a valid email' : null;
                    // break;
                  case 'phoneNumber':
                    return text != null && text.length != 11 ? 'Enter 11 digit' : null;
                    // break;
                  case 'about':
                    return text != null && text.isEmpty ? 'about yourself' : null;
                    // break;
                }
                // return text != null && text.length < 5 ? 'Enter min. 5 characters' : null;
              },
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ],
    );
  }*/

/*getKeyboardType(String fieldName){
    switch (fieldName) {
      case 'firstName':
        return TextInputType.name;
    // break;
      case 'lastName':
        return TextInputType.name;
    // break;
      case 'email':
        return TextInputType.emailAddress;
    // break;
      case 'phoneNumber':
        return TextInputType.phone;
    // break;
      case 'about':
        return TextInputType.multiline;
    // break;
    }
  }*/

/*Widget menuBuilder({required String title, required Function() navPath}) {
    return SimpleSettingsTile(
      // leading: iconWidget(iconData),
      title: title,
      subtitle: '',
      onTap: navPath,
      enabled: true,
      // child: SettingsScreen(),
    );
  }*/
