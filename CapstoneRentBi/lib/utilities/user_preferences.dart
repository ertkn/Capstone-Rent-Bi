import 'dart:convert';

import 'package:capstone_rent_bi/models/user.dart';

class UserPreferences {
  static UserModel loggedInUser = UserModel(uuid: '', firstName: '', lastName: '', email: '');
  static UserModel myUser = UserModel(
    uuid: 'jo23qı9u4rzsf',
    firstName: 'Ertekin',
    lastName: 'Özçelik',
    email: 'ert@gmail.com',
    // password: '124235',
    // imagePath: 'capstone/assets/anato_finnstark.jpg',
    imagePath: 'https://pbs.twimg.com/media/FHfttxDWQAAJQNK?format=jpg&name=large',
    // about: 'dev',
      phoneNumber: '05343400988',
    about:
    'Integer id dignissim sem. Praesent hendrerit enim nisl, consequat bibendum lorem tempor vitae.'
        ' In finibus augue eget laoreet scelerisque. Nunc accumsan lacinia nibh quis mattis.'
        ' Aliquam in nisi risus. Fusce dignissim ligula ac augue tristique congue. Mauris congue rutrum ligula,'
        ' quis euismod elit mattis non.',
    /*address: {
      addressDistrict: 'pendik',
      addressCity: 'istanbul',
      addressCountry: 'türkiye'
    },*/
      addressInList: myAddress,
      birthdate: myBirthDay, timestamp: null,
  );

  static Address myAddress = Address(
      addressDistrict: 'pendik',
      addressCity: 'istanbul',
      addressCountry: 'türkiye'
  );

  // String json = jsonEncode(myAddress);
  static Birthdate myBirthDay = Birthdate(
      day: 12,
      month: 17,
      year: 1997,
  );

  static UserModel newUser = UserModel(
    uuid: '',
    firstName: '',
    lastName: '',
    email: '',
    // password: '',
    imagePath: '',
    // imagePath: 'https://pbs.twimg.com/media/FHfttxDWQAAJQNK?format=jpg&name=large',
    about: 'Integer id dignissim sem. Praesent hendrerit enim nisl, consequat bibendum lorem tempor vitae.'
        ' In finibus augue eget laoreet scelerisque. Nunc accumsan lacinia nibh quis mattis.'
        ' Aliquam in nisi risus. Fusce dignissim ligula ac augue tristique congue. Mauris congue rutrum ligula,'
        ' quis euismod elit mattis non.',
    /*address: '',
    addressDistrict: '',
    addressCity: '',
    addressCountry: '',*/
    // addressInGeneral: '',
    addressInList: myAddress,
    phoneNumber: '05343400988',
    birthdate: myBirthDay, timestamp: null ,
  );
}

/*  static Address myAdress = Address(
    addressCity: "",
    addressCountry: "",
    addressDistrict: "",
  );*/