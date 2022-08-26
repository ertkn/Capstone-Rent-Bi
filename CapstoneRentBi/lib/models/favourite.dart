// To parse this JSON data, do
//
//     final favouriteModel = favouriteModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FavouriteModel favouriteModelFromJson(String str) => FavouriteModel.fromJson(json.decode(str));

String favouriteModelToJson(FavouriteModel data) => json.encode(data.toJson());

class FavouriteModel {
  List<String> favouriteProduct;

  FavouriteModel({
    required this.favouriteProduct,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
    favouriteProduct: List<String>.from(json["favourite_product"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "favourite_product": List<dynamic>.from(favouriteProduct.map((x) => x)),
  };
}
