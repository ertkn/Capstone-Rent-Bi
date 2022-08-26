import 'package:capstone_rent_bi/models/categories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
class ProductModel{
  String id,title,image,price,seller;
  String? buyer;
  // List<Categories>? categories;

  ProductModel({required this.id,required this.title,required this.image,required this.price,required this.seller,required this.buyer});

  ProductModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    title=json['title'];
    image=json['image'];
    price=json['price'];
    seller=json['seller'];
    buyer=json['buyer'] ?? 'null';
    if(json['category']!=null){
      categories=<Categories>[];
      json['categories'].forEach((v){
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['price'] = price;
    data['seller'] = seller;
    data['buyer'] = buyer;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return "($id,$title,$seller,$buyer,$image)";
  }
}
*/
import 'dart:convert';

ProductModel productModelFromJson(Map<String, dynamic> str) => ProductModel.fromJson(str);

String productModelToJson(ProductModel productModel) => json.encode(productModel.toJson());

class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.seller,
             this.buyer,
    required this.image,
             this.view,
  });

  String id;
  String title;
  String price;
  String seller;
  String? buyer;
  String image;
  int? view;

  ProductModel copyWith({
    String? id,
    String? title,
    String? price,
    String? seller,
    String?  buyer,
    String? image,
    int? view,
  }) =>
      ProductModel(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        seller: seller ?? this.seller,
        buyer: buyer ?? this.buyer,
        image: image ?? this.image,
        view:  view ?? this.view
      );

  factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    seller: json["seller"],
    buyer: json["buyer"] ?? 'null',
    image: json["image"],
    view: json["view"] ?? 0,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    "id":     id,
    "title":  title,
    "price":  price,
    "seller": seller,
    "buyer":  buyer ?? 'null',
    "image":  image,
    "view": view,
  };
}

var map={
  "title":"bershka",
  "image":"url",
  "price":"149.99",
  "categories":[{
    "category":"sweat",
    "subcategory":"hoodies"
  }]
};

Map _categoriesMap = {
  "Car": {
    "Brand":{
      "Audi": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Bmw": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Chevrolet": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Citroen": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Dacia": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Fiat": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Ford": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Honda": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Hyundai": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Jeep": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Kia": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Lamborghini": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Land Rover": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Mercedes-Benz": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Mitsubishi": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Nissan": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Opel": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Peugeot": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Porsche": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Renault": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Skoda": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Subaru": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Suzuki": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Tofas": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Toyota": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Volvo": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
      "Volkswagen": {
        "model": [
          'series 1',
          'series 2',
          'series 3',
          'series 4',
          'series 5',
          'series 6',
          'series 7',
          'series 8',
          'series 9',
          'series X',
          'series Z',
          'series M',
        ]
      },
    }
  },
  "Electronics": {
    "Subcategory": {
      "Cameras":{},
      "Computers":{},
      "Other":{},
      "Phones":{},
      "Speakers & Headphones":{},
      "Tvs":{},
    }
  },
  "Home and Appliances": {
    "Beeding & Rugs":{},
    "Cookware & Tableware":{},
    "Décor":{},
    "Furniture":{},
    "Home Applines":{},
    "Home Improvement":{},
    "Others":{},
  },
  "Gaming": {},
  "Sports and Outdoors": {},
  "Tools and Gardening": {},
  "Fashion and Accessories": {},
  "Movies,Books and Music": {},
  "Baby and Child": {},
  "Others": {},
};