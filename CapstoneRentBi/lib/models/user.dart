import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(Map<String,dynamic> str) => UserModel.fromJson(str);

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
   required this.uuid,
   required this.firstName,
   required this.lastName,
   required this.email,
    this.about,
    this.phoneNumber,
    this.imagePath,
    this.timestamp,
    // this.addressInGeneral,
    this.addressInList,
    this.birthdate,
  });

  String uuid;
  String firstName;
  String lastName;
  String email;
  String? about;
  String? phoneNumber;
  String? imagePath;
  Timestamp? timestamp;
  // String? addressInGeneral;
  Address? addressInList;
  Birthdate? birthdate;

  UserModel copyWith({
    String? uuid,
    String? firstName,
    String? lastName,
    String? email,
    String? about,
    String? phoneNum,
    String? image,
    Timestamp? timestamp,
    // String? address,
    Address? addressInList,
    Birthdate? birthdate,
  }) =>
      UserModel(
        uuid: uuid ?? this.uuid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        about: about ?? this.about,
        phoneNumber: phoneNum ?? this.phoneNumber,
        imagePath: image ?? this.imagePath,
        timestamp: timestamp ?? this.timestamp,
        // addressInGeneral: address ?? this.addressInGeneral,
        addressInList: addressInList ?? this.addressInList,
        birthdate: birthdate ?? this.birthdate,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uuid: json["uuid"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    about: json["about"],
    phoneNumber: json["phone_number"],
    imagePath: json["image"],
    // addressInGeneral: json["address"],
    addressInList: Address.fromJson(json["address"]),
    birthdate: Birthdate.fromJson(json["birth_date"]),
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "about": about,
    "phoneNumber": phoneNumber,
    "image": imagePath,
    // "address": addressInGeneral,
    "address": addressInList?.toJson(),
    "birthDate": birthdate?.toJson(),
    "timestamp": timestamp,
  };
}

class Address {
  Address({
    this.addressDistrict,
    this.addressCity,
    this.addressCountry,
  });

  String? addressDistrict;
  String? addressCity;
  String? addressCountry;

  Address copyWith({
    String? addressDistrict,
    String? addressCity,
    String? addressCountry,
  }) =>
      Address(
        addressDistrict: addressDistrict ?? this.addressDistrict,
        addressCity: addressCity ?? this.addressCity,
        addressCountry: addressCountry ?? this.addressCountry,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    addressDistrict: json["addressDistrict"],
    addressCity: json["addressCity"],
    addressCountry: json["addressCountry"],
  );

  Map<String, dynamic> toJson() => {
    "addressDistrict": addressDistrict,
    "addressCity": addressCity,
    "addressCountry": addressCountry,
  };
}

class Birthdate {
  Birthdate({
    this.day,
    this.month,
    this.year,
  });

  int? day;
  int? month;
  int? year;

  Birthdate copyWith({
    int? day,
    int? month,
    int? year,
  }) =>
      Birthdate(
        day: day ?? this.day,
        month: month ?? this.month,
        year: year ?? this.year,
      );

  factory Birthdate.fromJson(Map<String, dynamic> json) => Birthdate(
    day: json["day"],
    month: json["month"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "month": month,
    "year": year,
  };
}
