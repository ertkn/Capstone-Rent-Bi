// library my_lib;
/*
import 'dart:convert';

import 'package:capstone/models/categories.dart';
import 'package:capstone/services/auth.dart';
import 'package:capstone/utilities/constants.dart';
import 'package:capstone/utilities/snackbar.dart';
import 'package:capstone/utilities/spacing.dart';
import 'package:capstone/utilities/user_preferences.dart';
import 'package:capstone/widgets/text_field_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
*/

part of '../sign_up_post.dart';

class SignUpPostForm extends StatefulWidget {
  const SignUpPostForm({Key? key}) : super(key: key);

  @override
  _SignUpPostFormState createState() => _SignUpPostFormState();
}

class _SignUpPostFormState extends State<SignUpPostForm> {

  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // final String _personCollectionPath = 'Users';

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();
  final String categoryItems = 'category_json/categories.json';
  // FocusNode focusNodePhone = FocusNode();
  FocusNode focusNodeAddress = FocusNode();
  final phoneNumberController = TextEditingController();
  final addressBoxController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // final String _addressHintText = 'Enter your Address';
  final String _phoneHintText = 'Enter your Phone Number';
  final String _addressHintText = 'about yourself';


  // String selectedCountryItem = data[0].location.toString();

  String? selectedCountryItem;
  String selectedCountryItemNotNull = '';

  // int selectedCountryItemIndex = 0;
  Locations itemLocation = Locations();
  Locations itemLocationCity = Locations();

  // String selectedSublocationItem = data[[0]].location.toString();
  // String selectedCityItem = data[0].children![0].location.toString();

  String? selectedCityItem;
  String selectedCityItemNotNull = '';

  String? selectedDistrictItem;
  String selectedDistrictItemNotNull = '';

  // String selectedDistrictItem = data[0].children![0].sublocation![0].toString();

  List<bool> isDisableDropDown = [true, true];
  bool isValidate = false;
  List _items = [];
  Map items = {};
  List country = [];
  List city = [];
  List district = [];

  // List<List<String>> location_list = [{'istanbul':['pendik']}];
  //[{'istanbul':[{'pendik'}]}]
  @override
  void initState() {
    super.initState();
    readJson();
    phoneNumberController.addListener(() {
      /*final String text =emailController.text.toUpperCase();
      emailController.value = emailController.value.copyWith(
        text: text,
        selection: TextSelection(baseOffset: text.length-9, extentOffset: text.length-2),
        composing: TextRange.empty,
      );*/
    });
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    // controller.dispose();
    super.dispose();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString(categoryItems);
    final _data = await json.decode(response);
    setState(() {
      _items = _data["countries"];
      // items = _data["countries"];
      // print('data: $_data');
      // print('items: $_items');
      // print('${_items.map((e) => null).toList()}');
      print('_items: ${_items.map((e) => '${e}')}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildPhoneNoFormText(context),
          // verticalSpaceMedium,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Location',
                style: labelStyle,
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  buildCountryDropdownButton(),
                  horizontalSpaceSmall,
                  buildCityDropdownButton(),
                  horizontalSpaceSmall,
                  buildDistrictDropdownButton(),
                ],
              ),
            ],
          ),
          // verticalSpaceRegular,
          verticalSpaceSmall,
          buildAddressFormText(context),
          verticalSpaceMedium,
          buildLoginButton(),
          // DropdownButton(items: items, onChanged: onChanged)
        ],
      ),
    );
  }

  Column buildAddressFormText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'About',
          style: labelStyle,
        ),
        verticalSpaceTiny,
        Container(
          decoration: boxDecorationStyle.copyWith(
            shape: BoxShape.rectangle,
            color: const Color(0xBE385C89),
          ),
          // padding: const EdgeInsets.only(top: 20),
          child: TextFormField(
            // scrollPadding: const EdgeInsets.only(top: 50),
            focusNode: focusNodeAddress,
            style: fieldTextStyle,
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            controller: addressBoxController,
            maxLines: 3,
            textAlign: TextAlign.center,
            // minLines: null,
            // minLines: 2,
            // maxLines: 5,
            maxLength: 200,

            // onEditingComplete: ,
            //   r"^[a-z ,.'-]+$"
/*
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9-.,/ ]+( [a-zA-Z0-9_]+)*')),
                ],
*/

            onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),

            onSaved: (address) {
              setState(
                () {
                  // int phoneInt = int.parse(newValue!),
                  UserPreferences.newUser.about = address ?? nullStringPlaceHolder;
                },
              );
            },

            validator: (text) => text != null && text.isEmpty ? 'about yourself' : null,

            decoration: InputDecoration(
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: _addressHintText,
              hintStyle: hintTextStyle,

              /*hintStyle: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),*/
              contentPadding: const EdgeInsets.only(top: 42.5),

              border: InputBorder.none,
              /*border: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                          width: 3,
                      ),
                  ),*/
              // contentPadding: EdgeInsets.only(top: 10.0),
              prefixIcon: const Icon(
                Icons.home,
                color: Colors.white,
              ),

              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white54,
                ),
                onPressed: () => addressBoxController.clear(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container buildDistrictDropdownButton() {
    return Container(
      decoration: boxDecorationStyle,
      alignment: Alignment.centerLeft,
      width: screenWidthPercentage(context, percentage: 0.25),
      height: screenHeightPercentage(context, percentage: 0.0625),
      padding: const EdgeInsets.only(left: 15),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
/*            disabledHint: Text('asfasfasgsadghsh'),
            focusColor: Colors.amber,
            disabledHint: Text('district'),
            underline: const SizedBox(),
            decoration: InputDecoration(
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.location_city)
                // hintText: 'adfg'
              ),
            borderRadius: BorderRadius.circular(10),
            menuMaxHeight: 150,
            dropdownColor: const Color(0xFFFFFFFF),*/

            itemHeight: 50,
            alignment: Alignment.centerLeft,
            elevation: 0,
            isExpanded: true,
            style: fieldTextStyle,
            decoration: buildInputDecoration(),
            dropdownColor: const Color(0xCD000000),
            hint: buildHintText('District'),

/*
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_city),
                // alignLabelWithHint: true,
                constraints: BoxConstraints(

                  maxWidth: screenWidthPercentage(context, percentage: 0.55),
                  minWidth: screenWidthPercentage(context, percentage: 0.35),
                )

              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.all(Radius.circular(25) ),
              // borderSide: BorderSide(width: 30,color: Colors.amber,style: BorderStyle.solid )
              // )
            ),
            // iconSize: 25,
            icon: const Icon(
              Icons.location_city,
              color: Colors.white,
              size: 20,
            ),
*/

            // onChanged: disableCityDropDown[1] ? null : (e) => setState(() => selectedDistrictItem = e.toString()),

            onSaved: (district) {
              setState(
                () {
                  // int phoneInt = int.parse(newValue!),
                  print('District: ' + district.toString());
                  // UserPreferences.myUser.addressCountry = newValue.toString();
                  UserPreferences.myAddress.addressDistrict = district.toString();
                },
              );
            },

            onChanged: (districtName){
              setState(() {
                selectedDistrictItem = districtName.toString();
                print('selectedDistrictItem: ${selectedDistrictItem}');
              });
            },
            /*validator: (location) => location != null && isDisableDropDown[1] == true ||
                    selectedDistrictItemNotNull != selectedDistrictItem
                ? 'select a location'
                : null,*/
/*            validator: (districtItem) => selectedDistrictItem == null
                ? 'select a location'
                : null,*/

            validator: (districtName){
              setState(() {
                selectedDistrictItem == null
                    ? 'select a location'
                    : null;
              });
            },

            value: selectedDistrictItem,

            items: city.map<DropdownMenuItem<String>>((item) {
              // print('innerdistrict: ${city}');
              return DropdownMenuItem<String>(
                onTap: (){
                  setState(() {
                    district.add(item);
                    print('district: ${district}');
                  });
                },
                alignment: Alignment.centerLeft,
                value: item,
                child: Text(
                  item,
                ),
              );
            }).toList()

/*          items: data[data.indexOf(returnCityIndexOf())]
              .sublocation!
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item.toString(),
                  child: Text(
                    item.toString(),
                  ),
                ),
              )
              .toList(),*/

            ),
      ),
    );
  }

  Container buildCityDropdownButton() {
/*    print('first: ${data[data.indexOf('element')].children![0].sublocation!.join(',')}');
    print('second: ${data[0].children}');
    print('third: ${data.indexOf(returnIndexOf())}');
    // print('outter returnIndexOf: '+returnIndexOf().toString());
    // print(''+data.toString());
    // print(data[indexOfListItem()]);
    // data.map((item) => item.location);

    print(data.where((item) =>
        item.location.toString().contains(selectedCountryItem!)).toList());
    print('SelectCityItem: ' +
        selectedCityItem.toString() +
        '-/- disableCityDropDown: ' +
        disableCityDropDown.toString());*/

    return Container(
      decoration: boxDecorationStyle,
      alignment: Alignment.centerLeft,
      width: screenWidthPercentage(context, percentage: 0.25),
      height: screenHeightPercentage(context, percentage: 0.0625),
      padding: const EdgeInsets.only(left: 15),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          // borderRadius: BorderRadius.circular(10),
          // menuMaxHeight: 150,
          // dropdownColor: const Color(0xFFFFFFFF),

          isExpanded: true,
          itemHeight: 50,
          alignment: Alignment.centerLeft,
          elevation: 0,
          decoration: buildInputDecoration(),
          style: fieldTextStyle,
          dropdownColor: const Color(0xCD000000),
          hint: buildHintText('City'),

/*
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.location_city),
              // alignLabelWithHint: true,
              constraints: BoxConstraints(

                maxWidth: screenWidthPercentage(context, percentage: 0.55),
                minWidth: screenWidthPercentage(context, percentage: 0.35),
              )

            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(25) ),
            // borderSide: BorderSide(width: 30,color: Colors.amber,style: BorderStyle.solid )
            // )
          ),


          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontFamily: 'RobotoSlab',
          ),

          iconSize: 25,
          icon: const Icon(
            Icons.location_city,
            color: Colors.white,
            size: 20,
          ),
          hint: Text(
            'City',
            style: hintTextStyle.copyWith(
              color: Colors.white54,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
*/

          onSaved: (city) {
            setState(
              () {
                // int phoneInt = int.parse(newValue!),
                print('City: ' + city.toString());
                // UserPreferences.myUser.addressCountry = newValue.toString();
                UserPreferences.myAddress.addressCity = city.toString();
              },
            );
          },

/*          validator: (value) {
            if (value != null && isDisableDropDown[1] == true ||
                selectedCityItem != selectedCityItemNotNull) {
              return 'select your city';
            } else {
              null;
            }
          },*/

          validator: (cityItem) {
            setState(() {
              selectedCityItem == null
                  ? 'select a location'
                  : null;
            });
          },

          // onChanged: disableCityDropDown[0] ? null : (e) => setState(() => selectedCityItem = e.toString(),),
/*          onChanged: (value) {
            if (isDisableDropDown[0] && selectedCountryItem == null) {
              null;
            } else {
              setState(() {
                isDisableDropDown[1] = false;
                selectedCityItem = value.toString();
                print('selectedcityitem: ${selectedCityItem}');
                selectedCityItemNotNull = selectedCityItem!;
                selectedDistrictItem = null;
                // print('${itemLocation.location?.join()}');
              });
            }
          },*/
        onChanged: (cityName){
          setState(() {
            selectedCityItem = cityName.toString();
            print('selectedcityitem: ${selectedCityItem}');
            district = [];
            selectedDistrictItem = null;
          });
        },
/*      items: data[data.indexOf(returnCityIndexOf())]
              .children!
              .map(
                (item) => DropdownMenuItem<String>(
                  // value: item.children![0].location.toString(),
                  value: item.location.toString(),
                  child: Text(
                    item.location.toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              )
              .toList(),*/
          value: selectedCityItem,

          // items: _items.where((element) => element.toString().contains('${selectedCountryItem}')).map((item) {
          items: country.map<DropdownMenuItem<String>>((item) {
            // item = item[0];
            // print('innercity: ${item}');
            // print('inner citydropdown: ${item['cityname']} /// item: ${item}');
            return DropdownMenuItem<String>(
              alignment: Alignment.centerLeft,
              // value: item.children![0].location.toString(),
              onTap: (){
                setState(() {
                  city = item['district'];
                  district = [];
                  print('city${city}');
                });
              },
              child: Text(
                item['cityname'],
              ),
              value: item['cityname'],
            );
          }).toList(),
        ),
      ),
    );
  }

/*
   cityindexof() {
    // return _items[_items.indexOf(['${selectedCountryItem}'])];
    //  print('country2: ${country}');
    //  print('countryasmap: ${country.asMap()}');
    print('country3: ${country.map((e) => e['city'])}');
    var _city = country.map((e) => e['city']);
    print('_city: ${_city}');

    // print('country3: ${country.where((element) => element)}');
    return _city.map((e) => null);

*/
/*    print(
        'cityindexof: ${_items.where((element) => element.toString().contains('${selectedCountryItem}')).map((e) => e).toList()}');
    List _city =
        _items.where((element) => element.toString().contains('${selectedCountryItem}')).toList();

    print('_city: ${_city.map((e) => e['city'])}');

    _city.map(
      (e) {
        city.add(e);
      },
    ).toList();
    print('city: ${city.toString()}');*//*

  }
*/

  Container buildCountryDropdownButton() {
    // print('outter: '+ads());
    return Container(
      decoration: boxDecorationStyle,
      alignment: Alignment.centerLeft,
      width: screenWidthPercentage(context, percentage: 0.25),
      height: screenHeightPercentage(context, percentage: 0.0625),
      padding: const EdgeInsets.only(left: 15),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          isExpanded: true,
          // borderRadius: BorderRadius.circular(10),
          // menuMaxHeight: 150,
          itemHeight: 50,
          alignment: Alignment.centerLeft,
          elevation: 0,
          dropdownColor: const Color(0xCD000000),
          hint: buildHintText('Country'),
          decoration: buildInputDecoration(),
          style: fieldTextStyle,

/*          // iconSize: 25,
          icon: const Icon(
            Icons.location_city,
            color: Colors.white,
            size: 20,
          ),

          hint: Text(
            'Country',
            style: hintTextStyle.copyWith(
              color: Colors.white54,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),*/

          value: selectedCountryItem,

/*          onTap: () async{
            await readJson();
          },*/

/*          onChanged: (value) {
            // print('valuıe: ${value} /// country: ${country}');
            setState(() {
              nullAssign();
              // itemLocation = Locations();
              selectedCountryItem = value.toString();
              selectedCountryItemNotNull = selectedCountryItem!;
              print('selectedCountryItem: ' +
                  selectedCountryItem.toString() +
                  ' | Value: ' +
                  value.toString());
              //print('temp: ${data.map((e) => null)}');
              // print('selectedCountryItemNotNull: ' + selectedCountryItemNotNull);
              cityindexof();
            });
          },*/

          onChanged: (countryName){
            selectedCountryItem = countryName.toString();
            print('selectedCountryItem: ${selectedCountryItem}');
            nullAssign();
          },

          onSaved: (country) {
            setState(
              () {
                // int phoneInt = int.parse(newValue!),
                print('Country: ' + country.toString());
                // UserPreferences.myUser.addressCountry = newValue.toString();
                UserPreferences.myAddress.addressCountry= country.toString();
              },
            );
          },

/*          validator: (value) {
            if (value != null && isDisableDropDown[0] == true ||
                selectedCountryItem != selectedCountryItemNotNull) {
              return 'select your country';
            } else {
              null;
            }
          },*/

          validator: (countryItem) {
            setState(() {
              selectedCountryItem == null
                  ? 'select a location'
                  : null;
            });
          },

          // onChanged: (e) => setState(() => selectedCountryItem = e.toString()),
          items: _items.map<DropdownMenuItem<String>>((item) {
            // country.add(item['countryname']);
            // selectedCountryItemIndex = data.indexOf(item);
            // print('inner dropdownmenu: ${item['countryname']} /// item: ${item}');

            return DropdownMenuItem<String>(
              alignment: Alignment.centerLeft,
              value: item['countryname'],
              onTap: () {
                setState(() {
                  // print('inner item: ${item}');
                  // country.add(item['city']);
                  country = item['city'];
                  // city = [];
                  // district = [];
                  print('country: ${country}');
                  // print('countey: $country');
                });
                // print('country: $country');
                // item.forEach((key,value) { });
              },
              child: Text(
                item['countryname'],
                // style: const TextStyle(fontSize: 24),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Text buildHintText(String hintText) {
    return Text(
      hintText,
      style: hintTextStyle,
    );
  }

/*  TextStyle buildTextStyle() {
    return const TextStyle(
      fontSize: 16,
      color: Colors.white,
      // fontWeight: FontWeight.w400,
    );
  }*/

  InputDecoration buildInputDecoration() {
    return InputDecoration(
        // prefixIcon: const Icon(Icons.location_city, color: Colors.white),
        constraints: BoxConstraints(
      maxWidth: screenWidthPercentage(context, percentage: 0.6),
      minWidth: screenWidthPercentage(context, percentage: 0.3),
    )

        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(25) ),
        // borderSide: BorderSide(width: 30,color: Colors.amber,style: BorderStyle.solid )
        // )
        );
  }

  void nullAssign() {
    // country = [];
    city = [];
    district = [];
    selectedCityItem = null;
    selectedDistrictItem = null;
    isDisableDropDown[0] = false;
    isDisableDropDown[1] = true;
    itemLocationCity = Locations();
  }

  Locations returnCityIndexOf() {
    data.map((item) {
      // print('start' + item.toString());
      // print('selectedCountryItemNotNull:' + selectedCountryItemNotNull.toString());
      // print('item.location:' +item.location.toString());
      // print('IN/itemLocation:' +itemLocation.location.toString());
      if (item.location.toString().contains(selectedCountryItemNotNull.toString()) &&
          selectedCountryItem != null) {
        // if(selectedCountryItemNotNull == ''){
        //   itemLocation = item;
        //   print('inner/itemLocation:' +itemLocation.location.toString());
        //   return itemLocation;
        // }
        // print('asd');
        // print('item: ' + item.toString());
        // print('item.location.toString(): ' + item.location.toString());
        // print('selectedCountryItem.toString(): ' + selectedCountryItemNotNull.toString());
        itemLocation = item;
        // print('IN/itemLocation:' +itemLocation.location.toString());
        // print('inner: ' + item.toString());
      }
      // return item;
    }).toList();
    // print('end: ' + itemLocation.toString());
    // print('OUT/itemLocation:' +itemLocation.location.toString());

    return itemLocation;
  }

  Locations returnDistrictIndexOf() {
    data.map((outter) {
      // print('start' + item.toString());
      // print('selectedCountryItemNotNull:' + selectedCountryItemNotNull.toString());
      // print('item.location:' +item.location.toString());
      // print('IN/itemLocation:' +itemLocation.location.toString());
      // print('selectedCityItem.toString(): ' + selectedCityItem.toString());
      if (outter.location.toString().contains(selectedCountryItemNotNull.toString()) &&
          selectedCityItem != null) {
        // if(selectedCountryItemNotNull == ''){
        //   itemLocation = item;
        //   print('returnDistrictIndexOf (inner): /itemLocationCity: => ' +itemLocationCity.location.toString());
        //   print('selectedCityItemNotNull.toString(): ' + selectedCityItemNotNull.toString());
//   return itemLocation;
        // }
        // print('asd');
        // print('item: ' + item.toString());
        // print('item.location.toString(): ' + item.location.toString());
        // print('selectedCountryItem.toString(): ' + selectedCountryItemNotNull.toString());
        outter.children?.map((inner) {
          if (inner.location.toString().contains(selectedCityItemNotNull.toString()) &&
              selectedCityItem != null) {
            // print('selectedCityItemNotNull.toString(): ' + selectedCityItemNotNull.toString());
            itemLocationCity = inner;
            // print('returnDistrictIndexOf (inner in): /itemLocationCity: => ' +itemLocationCity.location.toString());
          }
        }).toList();
        // itemLocation = outter;
        // print('IN/itemLocation:' +itemLocation.location.toString());
        // print('inner: ' + item.toString());
      }
      // return item;
    }).toList();
    // print('end: ' + itemLocation.toString());
    // print('returnDistrictIndexOf (OUT)/itemLocationCity: => ' + itemLocationCity.location.toString());
    // print('returnDistrictIndexOf (OUT)/itemLocation: => ' + itemLocation.location.toString());

    return itemLocationCity;
  }

/*  LoginButton buildLoginButton() {
    return LoginButton(
      buttonText: 'Sign Up',
      onPressedFunction: validFunction,
    );
  }*/

  Container buildLoginButton() {
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
        onPressed: () {
          final form = formKey.currentState!;
          // readJson();
          if (form.validate()) {
            // validFunction();
/*            if(await buildDialog() == true){
              print('goes to registered');
              _registerWithEmailNPassword();
            }*/
            buildDialog().then((context) async{
              if (isValidate == true) {
                // print('goes to registered');
                form.save();
                await _registerWithEmailNPassword();
              }
            });
            // _registerWithEmailNPassword();
            // print('out to registered: ${isValidate.toString()}');
          }
        },
        // onPressed: () => print('Login Button Pressed'),
        child: const Text(
          'Sign Up',
          style: buttonTextStyle,
        ),
      ),
    );
  }

/*  void validFunction() async {
    final form = formKey.currentState!;

    if (form.validate()) {
      await buildDialog();
      // final emails = emailController.text;
      form.save();
      _registerWithEmailNPassword();

      print('Phone Number: ' +
          '${UserPreferences.newUser.phoneNumber}' +
          '\nDistrict: ' +
          '${UserPreferences.newUser.addressDistrict}' +
          '\nCity: ' +
          '${UserPreferences.newUser.addressCity}' +
          '\nCountry: ' +
          '${UserPreferences.newUser.addressCountry}' +
          '\nAddress: ' +
          '${UserPreferences.newUser.address}');

      Navigator.pushNamed(context, '/home');
      // print('${emailController.text}');
      */ /*ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text('Your email is $email'),
        ));*/
  /*

    }
  }*/

  buildDialog() async {
    await showDialog<bool>(
      context: context,
      builder: (context) => buildAlertDialog(),
      barrierDismissible: false,
    );
  }

  AlertDialog buildAlertDialog() {
    return AlertDialog(
      content: Text('Do you validate this records'),
      title: const Text('Confirm'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  isValidate = true;
                  Navigator.of(context).pop(isValidate);
                });
              },
              child: const Text('YES'),
            ),
            TextButton(
              onPressed: () {
                isValidate = false;
                Navigator.of(context).pop(isValidate);
              },
              child: const Text('NO'),
            ),
          ],
        ),
      ],
    );
  }

  Future _registerWithEmailNPassword() async {
    try {
      /*final UserCredential userCredential = await _authService.createUserWithEmailAndPassword(
        email: UserPreferences.newUser.email,
        password: UserPreferences.newUser.password,
      );
      final User? user = userCredential.user;*/
      final User? user = await _authService.registerWithUserCredential(context,UserPreferences.newUser, SignUpPost()._tempPass ?? '');
      // print('SignUpPost().password: ${SignUpPost().password}');
      SignUpPost()._tempPass='';
/*      FirebaseFirestore.instance.collection('users').doc().set({
        'uid': user.uid,
        'first name': UserPreferences.newUser.firstName,
        'last name': UserPreferences.newUser.lastName,
        'email': user.email,
        'password': UserPreferences.newUser.password,
        'phone number': UserPreferences.newUser.phoneNumber,
        'about': UserPreferences.newUser.about,
        'address': UserPreferences.newUser.address,
        'district': UserPreferences.newUser.addressDistrict,
        'city': UserPreferences.newUser.addressCity,
        'country': UserPreferences.newUser.addressCountry,
        // 'isEmailVerified': user.emailVerified, // will also be false
        'photoUrl': UserPreferences.newUser.imagePath, // will always be null
      });*/

      if (user != null) {
        setState(() {
          SnackBarMessage.showSnackBar(context,
              text: 'Register accomplished\n\n'
              // '${user.uid}\t'
                  '${UserPreferences.newUser.firstName} '
                  '${UserPreferences.newUser.lastName}');
        });
        Navigator.pushReplacementNamed(context, '/home');
        // UserPreferences.newUser.password = '';
      } else {
        setState(() {
          SnackBarMessage.showSnackBar(context, text: 'r-register, it seems failed..');
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        SnackBarMessage.showSnackBar(context,
            text: 'ouch!! register is failed!\n\n${e.toString()}');
      });
    }
  }


/*  Future<User?> registerWithUserCredential(
      UserModel userToRegister,
      // String tempPass,
      ) async {
    try {
      // print('tempPass: $tempPass');
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userToRegister.email,
        password: userToRegister.password ?? 'null',
      );

      User? user = userCredential.user;

      await _firebaseFirestore.collection(_personCollectionPath).doc(user?.uid ?? "").set({
        'userId': user?.uid ?? "",
        'firstName': userToRegister.firstName,
        'lastname': userToRegister.lastName,
        'email': userToRegister.email,
        'about': userToRegister.about,
        'phoneNumber': userToRegister.phoneNumber,
        'address': userToRegister.addressInGeneral,
        'image': userToRegister.imagePath,
        // 'birthDate': '$day/$month/$year',
        'birthDate': userToRegister.birthdate?.toJson(),
      });

      return user;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        print('${UserPreferences.newUser.password}');
      }
      else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    _firebaseAuth.signOut();
    print('signOutUser()');
    return null;
  }*/

  Column buildPhoneNoFormText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Phone No',
          style: labelStyle,
        ),
        verticalSpaceTiny,
        Stack(
          children: [
            const TextFieldContainer(),
            TextFormField(
              // focusNode: focusNodePhone,
              style: fieldTextStyle,
              cursorColor: Colors.white,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              controller: phoneNumberController,
              maxLength: 11,

              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],

              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(focusNodeAddress),

              onSaved: (newValue) {
                setState(
                  () {
                    // int phoneInt = int.parse(newValue!),
                    /// UserPreferences.newUser.phoneNumber = int.parse(newValue!);
                    UserPreferences.newUser.phoneNumber = newValue;
                  },
                );
              },
              validator: (val) => val != null && val.length != 11 ? 'Enter 11 digit' : null,
              decoration: InputDecoration(
                // floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: _phoneHintText,
                hintStyle: hintTextStyle,
                border: InputBorder.none,
                // contentPadding: EdgeInsets.only(top: 10.0),
                prefixIcon: const Icon(
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
              ),
            ),
          ],
        ),
      ],
    );
  }

  /*Future<User?> registerWithUserCredential(
      UserModel userToRegister,
      // String tempPass,
      ) async {
    try {
      // print('tempPass: $tempPass');
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userToRegister.email,
        password: userToRegister.password ?? 'null',
      );

      User? user = userCredential.user;

      await _firebaseFirestore.collection(_personCollectionPath).doc(user?.uid ?? "").set({
        'userId': user?.uid ?? "",
        'firstName': userToRegister.firstName,
        'lastname': userToRegister.lastName,
        'email': userToRegister.email,
        'about': userToRegister.about,
        'phoneNumber': userToRegister.phoneNumber,
        'address': userToRegister.addressInGeneral,
        'image': userToRegister.imagePath,
        // 'birthDate': '$day/$month/$year',
        'birthDate': userToRegister.birthdate?.toJson(),
      });

      return user;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        print('${UserPreferences.newUser.password}');
      }
      else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    _firebaseAuth.signOut();
    print('signOutUser()');
    return null;
  }*/

}
