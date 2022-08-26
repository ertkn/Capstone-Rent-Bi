// To parse this JSON data, do
//
//     final favouriteMapModel = favouriteMapModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FavouriteMapModel favouriteMapModelFromJson(String str) => FavouriteMapModel.fromJson(json.decode(str));

String favouriteMapModelToJson(FavouriteMapModel data) => json.encode(data.toJson());

class FavouriteMapModel {
  FavouriteMapModel({
    required this.favouriteProduct,
  });

  FavouriteProduct? favouriteProduct;

  factory FavouriteMapModel.fromRawJson(String str) => FavouriteMapModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FavouriteMapModel.fromJson(Map<String, dynamic> json) {
    print('json["favourites"] => ${json["favourites"]}');
    return FavouriteMapModel(
    favouriteProduct: json["favourites"] == null ? null : FavouriteProduct.fromJson(json["favourites"]),
  );
  }

  Map<String, dynamic> toJson() => {
    "favourite_product": favouriteProduct == null ? null : favouriteProduct?.toJson(),
  };
}

FavouriteProduct favouriteProductFromJson(String str) => FavouriteProduct.fromJson(json.decode(str));

String favouriteProductToJson( data) => json.encode(data.toJson());


class FavouriteProduct {
  FavouriteProduct({
    required this.price,
    required this.id,
    required this.title,
    required this.image,
    required this.seller,
    this.buyer = '',
  });

  String price;
  String id;
  String title;
  String image;
  String seller;
  String buyer;

  factory FavouriteProduct.fromRawJson(Map<String, dynamic> str) => FavouriteProduct.fromJson(str);

  String toRawJson() => json.encode(toJson());


  factory FavouriteProduct.fromJson(Map<String, dynamic> json) => FavouriteProduct(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    image: json["image"] == null ? null : json["image"],
    seller: json["seller"] == null ? null : json["seller"],
    buyer: json["buyer"] == null ? null : json["buyer"],
    price: json["price"] == null ? null : json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "image": image == null ? null : image,
    "seller": seller == null ? null : seller,
    "buyer": buyer == null ? null : buyer,
    "price": price == null ? null : price,
  };
}
