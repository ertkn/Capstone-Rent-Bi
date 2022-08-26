import 'package:capstone_rent_bi/models/user.dart';
import 'package:capstone_rent_bi/services/user_service.dart';
import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/utilities/page_padding.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/utilities/user_preferences.dart';
import 'package:capstone_rent_bi/widgets/custom_circular_indicator.dart';
import 'package:capstone_rent_bi/widgets/toUpperCase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

part 'widgets/Body.dart';

class ProfileScreenNew extends StatefulWidget {
  const ProfileScreenNew({Key? key}) : super(key: key);

  @override
  State<ProfileScreenNew> createState() => _ProfileScreenNewState();
}

class _ProfileScreenNewState extends State<ProfileScreenNew> {
  late UserModel userCredential;
  bool _isEnabled = false;
  final formKey = GlobalKey<FormState>();
  String profileNewPath = 'profilenew';

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();

  final String _firstNameText ='FIRST NAME';
  String _lastNameText ='LAST NAME';
  String _emailText ='EMAIL';
  String _phoneText ='PHONE NUMBER';
  String _aboutText ='ABOUT YOURSELF';

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
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: UserService().getUserCredential(),
            builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData) {
                print('data yok');
                return CustomCircularIndicator();
                // return const Center(child: Text('No such DATA',style: TextStyle(fontSize: 20),),);
              } else {
                if (snapshot.data != null) {
                  Map<String, dynamic> tempMap = snapshot.data?.data() ?? {};
                  var obj;
                  tempMap.forEach((key, value) {obj = value;});
                  tempMap.forEach((key, value) {userCredential = userModelFromJson(value);});
                  print('asfişöa=> ${obj}');
                  print('asfişöa=> ${userCredential.toJson()}');
                  setController();
                  // userCredential = userModelFromJson(tempMap.map((key, value) => value));
/*                  print('data: ${snapshot.data?.data()}');
                  print('data: ${snapshot.data}');
                  print(userCredential.toJson());*/
                  // var modal;
                  // userCredential = fetchData;
                  // print('userModel: ${modal}');
                  /*                 return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) => profileLabels[index],
                      childCount: profileLabels.length,
                    ),
                  );*/
                  return Form(
                    key: formKey,
                    child: _buildCustomScrollView(context),
                  );
                } else {
                  return CustomCircularIndicator();
                }
              }
            },
          ),
        ),
      ),
    );
  }

  void setController(){
    firstNameController = TextEditingController(text: userCredential.firstName);
    lastNameController = TextEditingController(text: userCredential.lastName);
    emailController = TextEditingController(text: userCredential.email);
    phoneController = TextEditingController(text: userCredential.phoneNumber);
    aboutController = TextEditingController(text: userCredential.about);
  }

  CustomScrollView _buildCustomScrollView(BuildContext context) {
    List<Widget> profileLabels = [
      // verticalSpaceTiny,
      Container(
        // color: Colors.black12,
        // padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
        padding: const PagePaddingSmall.only(),
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
            padding: const PagePaddingSmall.only(),
            child: Text(
              _firstNameText,
              style: profileTitleStyle.copyWith(fontSize: 18),
            ),
          ),
          verticalSpaceTiny,
          TextFormField(
            // minLines: 3,
            // maxLines: 5,
            // enableInteractiveSelection: false,
            // readOnly: true,
            showCursor: true,
            controller: firstNameController,
            readOnly: !_isEnabled,
            enabled: _isEnabled,
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
                userCredential.firstName = newValue ?? nullStringPlaceHolder;
              });
            },

            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              // labelText: '${UserPreferences.myUser.firstName}',
              // labelText: userCredential.firstName.toCapitalized(),
              // labelStyle: const TextStyle(color: Colors.black),

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
            padding: const PagePaddingSmall.only(),
            child: Text(
              _lastNameText,
              style: profileTitleStyle.copyWith(fontSize: 18),
            ),
          ),
          verticalSpaceTiny,
          TextFormField(
            showCursor: true,
            controller: lastNameController,
            readOnly: !_isEnabled,
            enabled: _isEnabled,
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
                userCredential.lastName = newValue ?? nullStringPlaceHolder;
              });
            },

            decoration: const InputDecoration(
              // labelText: '${UserPreferences.myUser.lastName}',
              // labelText: userCredential.lastName.toCapitalized(),
              // labelStyle: const TextStyle(color: Colors.black),

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
            padding: const PagePaddingSmall.only(),
            child: Text(
              _emailText,
              style: profileTitleStyle.copyWith(fontSize: 18),
            ),
          ),
          verticalSpaceTiny,
          TextFormField(
            showCursor: true,
            controller: emailController,
            readOnly: !_isEnabled,
            enabled: _isEnabled,
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
                userCredential.email = newValue ?? nullStringPlaceHolder;
              });
            },

            validator: (email) =>
            email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null,

            decoration: const InputDecoration(
              // labelText: '${UserPreferences.myUser.email}',
              // labelText: userCredential.email.toCapitalized(),
              // labelStyle: const TextStyle(color: Colors.black),
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
            padding: const PagePaddingSmall.only(),
            child: Text(
              _phoneText,
              style: profileTitleStyle.copyWith(fontSize: 18),
            ),
          ),
          verticalSpaceTiny,
          TextFormField(
            showCursor: true,
            controller: phoneController,
            readOnly: !_isEnabled,
            enabled: _isEnabled,
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
                      userCredential.phoneNumber = newValue ?? nullStringPlaceHolder;
                },
              );
            },
            validator: (val) => val != null && val.length != 11 ? 'Enter 11 digit' : null,
            decoration: const InputDecoration(
              // labelText: '${UserPreferences.myUser.phoneNumber}',
              // labelText: userCredential.phoneNumber?.toCapitalized(),
              // labelStyle: const TextStyle(color: Colors.black),
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
            padding: const PagePaddingSmall.only(),
            child: Text(
              _aboutText,
              style: profileTitleStyle.copyWith(fontSize: 18),
            ),
          ),
          verticalSpaceTiny,
          TextFormField(
            showCursor: true,
            controller: aboutController,
            readOnly: !_isEnabled,
            enabled: _isEnabled,
            cursorColor: Colors.white,
            style: profileTitleStyle,
            keyboardType: TextInputType.name,

            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),

            // controller: lastNameController,

            validator: (value) => value != null && (value.length > 500 || value.isEmpty)
                ? 'Name length must be between 1-500 characters'
                : null,

            onSaved: (newValue) {
              setState(() {
                // UserPreferences.myUser.lastName = newValue ?? nullStringPlaceHolder;
                userCredential.about = newValue;
              });
            },

            decoration: const InputDecoration(
              // labelText: !_isEnabled ? null : userCredential.about?.toCapitalized(),
              // labelStyle: const TextStyle(color: Colors.black),
              border: UnderlineInputBorder(),
              // contentPadding: const EdgeInsets.fromLTRB(25, 25, 0, 5),
              contentPadding: PagePaddingSmall.only(),

            ),
          ),
        ],
      ),
      verticalSpaceSmall,
    ];

    return CustomScrollView(
      slivers: <Widget>[
        _sliverAppBar(context),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            // (context, index) => _customTextFormField(emailController, userCredentialModel.firstName),
                (context, index) => profileLabels[index],
            childCount: profileLabels.length,
          ),
        )
        // Body(userModel: userCredential,isEnabled: _isEnabled,formKey: formKey),
        // Body(isEdit: _enabled,),
        /*SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => profileLabels[index],
                childCount: profileLabels.length,
              ),
            ),*/
      ],
    );
  }

  SliverAppBar _sliverAppBar(BuildContext context) {
    return SliverAppBar(
        // collapsedHeight: 100,
        // backgroundColor: Colors.amberAccent,
        floating: true,
        elevation: 3,
        pinned: true,
        leading: Container(
          margin: EdgeInsets.only(left: screenWidthPercentage(context, percentage: 0.07)),
          decoration: favBoxDecoration,
          child: IconButton(
            // padding: EdgeInsets.only(left: screenWidthPercentage(context, percentage: 0.0175)),
            alignment: Alignment.center,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              // color: Color(0xBE385C89),
            ),
            // constraints: const BoxConstraints(minHeight: 100.0, minWidth: 0.0),
            tooltip: 'go back',
            onPressed: () => Navigator.pop(context),
          ),
        ),
/*            centerTitle: true,
            title: const Text(
              'User Setting',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'OpenSans',
              ),
            ),*/
        expandedHeight: screenHeightPercentage(context, percentage: 0.5),

        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.all(15),
          collapseMode: CollapseMode.parallax,
          background: Image.network(
            // UserPreferences.myUser.imagePath ?? placeholderSmall,
            userCredential.imagePath.toString(),
            fit: BoxFit.cover,
          ),
          centerTitle: true,
          title: Text(
            // '${UserPreferences.myUser.firstName}' '${UserPreferences.myUser.lastName}',
            '${userCredential.firstName.toCapitalized()}\t${userCredential.lastName.toCapitalized()}',
            style: appBarTitleStyle.copyWith(
              color: Colors.white,
              // letterSpacing: -1.5,
              // wordSpacing: 2.5,
            ),
          ),
        ),

        actions: <Widget>[
          Container(
            // padding: EdgeInsets.only( right: screenWidthPercentage(context, percentage: 0.000515)),
            // height: screenHeightPercentage(context,percentage: 0.051),
            width: screenWidthPercentage(context, percentage: 0.1),
            // margin: EdgeInsets.fromLTRB(0, screenWidthPercentage(context, percentage: 0.03), screenWidthPercentage(context, percentage: 0.05), screenWidthPercentage(context, percentage: 0.03)),
            margin: EdgeInsets.only(right: screenWidthPercentage(context, percentage: 0.05)),
            decoration: favBoxDecoration,
            child: IconButton(
              // padding: EdgeInsets.only(right: screenWidthPercentage(context, percentage: 0.0375)),
              tooltip: 'edit',
              // color: Colors.pink,
              // iconSize: screenWidthPercentage(context, percentage: 0.1),
              // onPressed: () => Navigator.pop(context),
              // onPressed: () => Navigator.pushNamed(context, '/'),
              onPressed: () {

                if(_isEnabled == false){
                  setState(() {
                    _isEnabled = !_isEnabled;
                  });
                }else{
                  saveButton();
                }
                },
/*              icon: const Icon(
                Icons.edit,
                // iconData[_e],
                size: 30,
              ),*/
              icon: getEditIcon(),
            ),
          ),
        ],
      );
  }

  saveButton(){
    final form = formKey.currentState!;
    if(form.validate()){
      setState(() {
        _isEnabled = !_isEnabled;
      });
      form.save();
      print('MODEL: ${userCredential.toJson()}');
      UserService().updateUserCredential(userCredential);
      Navigator.pushReplacementNamed(context, '/$profileNewPath');
    }
  }

  Icon getEditIcon() {
    return _isEnabled == false
        ? const Icon(
            Icons.edit,
            color: Colors.black,
            // iconData[_e],
            // size: 30,
          )
        : const Icon(
            Icons.save,
            color: Colors.black,
            // iconData[_e],
            // size: 30,
          );
  }
}

/*
getRandomColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)],
}*/
