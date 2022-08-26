import 'dart:io';

import 'package:capstone_rent_bi/models/FavouriteMapModel.dart';
import 'package:capstone_rent_bi/models/favourite.dart';
import 'package:capstone_rent_bi/models/product.dart';
import 'package:capstone_rent_bi/services/auth.dart';
import 'package:capstone_rent_bi/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();

  final String _productCollectionPath = "Product";
  final String _personSubCollectionPath = "Favourites";
  final String _personCollectionPath = "Users";
  final String _favouriteCollectionPath = "Favourites";

  String _mediaUrl = '';

  Future<String> getMediaURL(File pickedFile) async {
    return await _storageService.uploadMedia(pickedFile);
  }

  Future<ProductModel> addProduct(ProductModel productModel) async {
    var ref = _firestore.collection(_productCollectionPath);

    // _mediaUrl = await getMediaURL(pickedFile);

    // print(_mediaUrl);
    var documentRef = await ref.add(productModelToJson(productModel) as Map<String, dynamic>);

    // return ProductModel(id: documentRef.id, title: title, image: _mediaUrl);
    return ProductModel(
        id: productModel.id,
        title: productModel.title,
        price: productModel.price,
        seller: productModel.seller,
        image: productModel.image);
  }

  Stream<QuerySnapshot> getProduct(int? docNum) {
    Stream<QuerySnapshot<Map<String, dynamic>>> ref;
    if (docNum == null) {
      ref = _firestore.collection("Product").snapshots();
    } else {
      ref = _firestore.collection("Product").limit(docNum).snapshots();
    }

    return ref;
  }

  Future<void> removeProduct(String docId) {
    var ref = _firestore.collection("Product").doc(docId).delete();

    return ref;
  }

  Future<void> deleteFavourite(FavouriteProduct favouriteProduct) async {
    var user = AuthService().isUserNull();
    var favDocRef = _firestore.collection(_favouriteCollectionPath).doc(user?.uid ?? "");

    final updates = {
      "favourites.${favouriteProduct.id}": FieldValue.delete(),
    };
    favDocRef.update(updates);
  }

  Future<void> addFavourite(ProductModel productModel) async {
    var user = AuthService().isUserNull();
    var favDocRef = _firestore.collection(_favouriteCollectionPath).doc(user?.uid ?? "");
    var docRef = _firestore.collection(_personCollectionPath).doc(user?.uid ?? "");
    var subColRef = docRef.collection(_personSubCollectionPath);
    var subDocRef = subColRef.doc(_personSubCollectionPath);
    /*if(ref.snapshots().contains(productModel)==true){
    }*/
/*
    ref.snapshots().forEach((element) {
      if () {}
    }).then((value) => {}).catchError((onError) {}).whenComplete(() =>
        ref.set({'favourite_products': {"${DateTime
            .now()
            .microsecondsSinceEpoch}": productModel.id}}, SetOptions(merge: true),),);
*/
    // var obj = productModelToJson(productModel);

/*    favDocRef.get().then((value) {
      if (value.exists) {
        favDocRef.set({
          "favourites": {user?.uid ?? "": {(favouriteProductToJson(productModel))} }
          // "favourite_product": [(productModel.id)]
        }, SetOptions(merge: true)).catchError((error){print('error: $error');});
      } */ /*else {
        subDocRef.update({
          "favourite_product": FieldValue([(productModel.id)])
        });
      }*/ /*
    });*/
    favDocRef.get().then((value) {
      if (value.exists) {
        print('value.data()?.values: ${value.data()?.values}');
        print('productModelToJson(productModel): ${productModelToJson(productModel)}');
        print('favouriteProductToJson(productModel): ${favouriteProductToJson(productModel)}');
        favDocRef.set({
          "favourites": {
            "${productModel.id}": {
              "image":  productModel.image,
              "id":     productModel.id,
              "title":  productModel.title,
              "price":  productModel.price,
              "seller": productModel.seller,
              "buyer":  productModel.buyer ?? 'null',
              "view":   productModel.view,
            }
          }
          // "${user?.uid}" : productModelToJson(productModel)
          // "favourite_product": [(productModel.id)]
        }, SetOptions(merge: true)).catchError((error) {
          print('error: $error');
        });
      } else {
        subDocRef.update({
          "favourites": {
            "${productModel.id}": {
              "image":  productModel.image,
              "id":     productModel.id,
              "title":  productModel.title,
              "price":  productModel.price,
              "seller": productModel.seller,
              "buyer":  productModel.buyer ?? 'null',
              "view":   productModel.view,
            }
          }
        });
      }
    });

/*    subColRef.limit(1).get().then((value) {
      if (value.size == 0) {
        subDocRef.set({
          "favourite_product": [(productModel.id)]
        }, SetOptions(merge: true));
      } else {
        subDocRef.update({
          "favourite_product": FieldValue.arrayUnion([(productModel.id)])
        });
      }
    });*/
/*

  favDocRef.delete({
    productModel.id: _firestore.FieldValue.delete()
  });
*/

    /*favDocRef.delete().then((value) {

    },onError: (e) => print(e));
*/
    // ref.set({'favourite_products': {"${DateTime.now().microsecondsSinceEpoch}":productModel.id}},SetOptions(merge: true));
  }

  Future<void> incrementProductView(String productID) async {
    var ref = _firestore.collection(_productCollectionPath).doc(productID);
    ref.update({"view": FieldValue.increment(1)});
  }

  Future<FavouriteModel> getFavouriteID() async {
    List<String> favIDList = [];
    FavouriteModel favouriteModel = FavouriteModel(favouriteProduct: []);
    List<ProductModel> productModelList = [];
    ProductModel productModel;
    var user = AuthService().isUserNull();
    var docRef = _firestore.collection(_personCollectionPath).doc(user?.uid ?? "");
    var subColRef = docRef.collection(_personSubCollectionPath);
    var subDocRef = subColRef.doc(_personSubCollectionPath);

    await subColRef.limit(1).get().then((value) async {
      if (value.size > 0) {
        return FavouriteModel.fromJson(value.docs.first.data()).favouriteProduct;
        // print('val: ${value.docs.first.data()}');
        //
        // print('object: ${favouriteIDList.favouriteProduct}');
        // return favouriteIDList;
      }
    });
    return favouriteModel;
  }

  Future<ProductModel> addProductInScreen(ProductModel productModel, XFile pickedFile) async {
    var ref = _firestore.collection(_productCollectionPath);
    var user = AuthService().isUserNull();

    productModel.image = await _storageService.uploadMedia(File(pickedFile.path));

    // _mediaUrl = getMediaURL(pickedFile.path);

    var documentRef = await ref.add({
      'id': user?.uid,
      'image': productModel.image,
      'price': productModel.price,
      'title': productModel.title,
      'seller': user?.uid,
      'buyer': productModel.buyer,
      'view': 0,
      'description': productModel.description,
    });

    return productModel;
  }

/*  List<ProductModel> getFavouriteProductWithID() {//getting product with ID
    // List<String> favouriteList = getFavourite();
    List<ProductModel> productModelList = [];
    int count=0;
    List instance = [];
    for(count;count==favouriteList.length;count++){
      _firestore.collection(_productCollectionPath).where("id", arrayContainsAny: favouriteList).snapshots().forEach((element) {productModelList.add( productModelFromJson(element as Map<String,dynamic>));});
      // productModelList.add(productModelFromJson(ref));
      // instance.add(_firestore.collection(_productCollectionPath).doc(favouriteList[count]).snapshots());
      print(productModelList[count].toJson());
    }
      return productModelList;
    Map<String, dynamic> ref = {};
    int length = favItemIDList.length;
    print('favItemIDList: ${favItemIDList}');

    for(var i;i==length;i++){
      ref = _firestore.collection(_productCollectionPath).where("id", arrayContainsAny: favItemIDList[i]).get() as Map<String, dynamic>;
      productModelList.add(productModelFromJson(ref));
    }
    List<ProductModel> productList = productModelList;

    return productList;

  }*/

  Stream<DocumentSnapshot> getFavourite() {
    var user = AuthService().isUserNull();
    print(user?.uid ?? "");
/*    if(user!.isAnonymous){
      return null;
    }*/
    var docRef = _firestore.collection(_favouriteCollectionPath).doc(user?.uid ?? "");
    // var subColRef = docRef.collection(_personSubCollectionPath);
    // var subDocRef = subColRef.doc(_personSubCollectionPath);
    List<String> favouriteModel = [];
    // print('aşlsfjkasdşlf ${docRef.get()}');
    var snapshot = docRef
        .snapshots(); /*
    snapshot.forEach((element) {
      favouriteModel.add(element.get('favourites'));
    });*/
    // return subColRef.snapshots();
/*    subColRef.limit(1).get().then(
            (value) {
          if (value.size > 0) {
            print(value);
            snapshot = value;
            // favouriteModel = FavouriteModel.fromJson(value.docs.first.data()).favouriteProduct;
            // print('val: ${value.docs.first.data()}');
            //
            // print('object: ${favouriteIDList.favouriteProduct}');
            // return favouriteIDList;
          }
        }
    );*/

    // snapshot.isEmpty.then((value) => null).catchError((error){return error;});
    // print('favouriteModel: $favouriteModel');
    // return favouriteModel;
    // return snapshot;
/*
    subColRef.limit(1).get().then(
            (value) async {
          if (value.size > 0) {
            return ProductModel.fromJson(value.docs.first.data());
            // print('val: ${value.docs.first.data()}');
            //
            // print('object: ${favouriteIDList.favouriteProduct}');
            // return favouriteIDList;
          }
        }
    );
*/
    return snapshot;
  }
/*  Future<QuerySnapshot> getFavouriteID(FavouriteModel fav) async {
    List<String> favIDList = [];
    FavouriteModel favouriteModel = FavouriteModel(favouriteProduct: []);
    List<ProductModel> productModelList = [];
    ProductModel productModel;
    var user = AuthService().isUserNull();
    var docRef = _firestore.collection(_personCollectionPath).doc(user?.uid ?? "");
    var subColRef = docRef.collection(_personSubCollectionPath);
    var subDocRef = subColRef.doc(_personSubCollectionPath);
    var ref;

    // return subColRef.snapshots();

    // FavouriteModel favouriteModel = FavouriteModel.fromJson();

    await subColRef.limit(1).get().then(
      (value) async{
        if (value.size > 0) {
          print('afa');
*/ /*          value.docs.map((event) {
            print('event: $event');
            // return favIDList.add(event.data().values.toList() as String);
            // favIDList.add(event.data()?.values);
            // favIDList.add(event);
          });*/ /*
          // value.docs.first.data().forEach((key, value) {});

          // print('favIDList => $favIDList -- ${value.docs.first.data().values}');
          print('favIDList => $favIDList -- ${value.docs.first.data().values}');
          // return {};
*/ /*          value.docs.first.data().entries.map((e) {
            return  print(e.value);
          });*/ /*
          fav = await FavouriteModel.fromJson(value.docs.first.data());
          print('val: ${value.docs.first.data()}');

          print('object: ${fav.favouriteProduct}');
          ref = await _firestore.collection(_productCollectionPath).where("id", whereIn:   fav.favouriteProduct).get().then((value) async {
            productModelList.add(ref);
            productModel = await productModelFromJson(ref);
            print('afaasf: ${await productModel.toJson()}');

            return await ref;          });

          productModelList.add(ref);
          productModel = await productModelFromJson(ref);
          print('afaasf: ${await productModel.toJson()}');

          return await ref;
          // return getFavouriteProductWithID(favouriteModel.favouriteProduct);
        }
        return ref;
      },
    );
    return ref;
    // favIDList.forEach((element) {print(element);});

    // favIDList.add() subDocRef.snapshots().
    // print('subDocRef: ${subDocRef.snapshots().forEach((element) {favIDList.addAll })}');
    // return subColRef.snapshots();
  }*/

/*  Future getFavouriteProductWithID(List favItemIDList,List<ProductModel> prodModel) async{
    var ref;
    var queries;
    ref = await _firestore.collection(_productCollectionPath).where("id", arrayContainsAny:   favItemIDList).get();

    await productModelFromJson(ref);
    print(await productModelFromJson(ref));

    return ref;

  }*/
}

/*  Future<ProductModel> addProduct(String title, File pickedFile) async {
    var ref = _firestore.collection(_personCollectionPath);

    _mediaUrl = await _storageService.uploadMedia(pickedFile);

    print(_mediaUrl);
    var documentRef = await ref.add({'title': title, 'image': _mediaUrl});

    return ProductModel(id: documentRef.id, title: title, image: _mediaUrl);
  }
*/
