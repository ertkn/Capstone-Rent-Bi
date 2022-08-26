import 'package:capstone_rent_bi/models/FavouriteMapModel.dart';
import 'package:capstone_rent_bi/models/favourite.dart';
import 'package:capstone_rent_bi/models/product.dart';
import 'package:capstone_rent_bi/screens/home/product/widgets/product_card.dart';
import 'package:capstone_rent_bi/screens/home/product_details/details_screen.dart';
import 'package:capstone_rent_bi/services/auth.dart';
import 'package:capstone_rent_bi/services/product_service.dart';
import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/widgets/custom_circular_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  FavouriteModel favouriteIDList = FavouriteModel(favouriteProduct: []);
  FavouriteProduct favouriteProduct =
      FavouriteProduct(id: '', title: '', image: '', seller: '', price: '');
  List<FavouriteProduct> favProductList = [];
  FavouriteMapModel favMapModel = FavouriteMapModel(
      favouriteProduct: FavouriteProduct(id: '', title: '', image: '', seller: '', price: ''));
  List<FavouriteMapModel> favouriteMapModel = [];
  List<ProductModel> productModelList = [];
  ProductService procService = ProductService();

/*  @override
  void initState() {
    */ /*WidgetsBinding.instance.addPostFrameCallback((_) async {
      buildInitialise();
    });*/ /*
*/ /*    SchedulerBinding.instance.addPostFrameCallback((_) {
      print("SchedulerBinding");
    });*/ /*
  }*/

  buildDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (context) => buildAlertDialog(context),
      barrierDismissible: false,
    );
  }

  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      content: const Text('Continue with Email'),
      title: const Text('Confirm'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              onPressed: () {
                AuthService().signOutUser();
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'YES',
                style: TextStyle(color: Color(0xffff2222)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text(
                'NO',
                style: TextStyle(color: Color(0xffff2222)),
              ),
            ),
          ],
        ),
      ],
    );
  }

/*  Future buildInitialise() async{
    if(AuthService().isUserNull() == null || AuthService().isUserNull()?.isAnonymous == true){
      await buildDialog(context);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          height: screenHeight(context),
          width: screenWidth(context),
          child: Column(
            children: [
              Container(
                height: screenHeightPercentage(context, percentage: 0.1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Favourites',
                      style: headerStyle,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                height: screenHeightPercentage(context, percentage: 0.725),
                width: double.infinity,
                // child: AuthService().isUserNull() == null || AuthService().isUserNull()?.isAnonymous == true ? buildDialog(context) : _buildStreamBuilder(),
                child: _buildStreamBuilder(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<DocumentSnapshot<Object?>> _buildStreamBuilder() {
    return StreamBuilder<DocumentSnapshot>(
      stream: ProductService().getFavourite(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text(
              'No Favourites',
              style: TextStyle(fontSize: 20),
            ),
          );
          return CustomCircularIndicator();
        } else {
          if (snapshot.data != null && snapshot.data!.exists) {
            print('ahgashgsdgh ${snapshot.data?.exists}');
            Map doc = snapshot.data?.get('favourites');
            // Map<String,Map<String,dynamic>> snap = snapshot.data?.data();

            // print('json["favourites"] => ${doc["favourites"]}');

            favProductList = [];
            doc.forEach((key, value) {
              // print('value: $value');

              favProductList.add(FavouriteProduct.fromRawJson(value));
            });
            favProductList.forEach((element) {
              print('foreach${element.toJson()}');
            });
            // favouriteMapModel.add(favouriteMapModelFromJson(snapshot.data!.data().toString()));
            // doc?.get('Favourites');

            // print('doc: ${doc}');
            // print('how many: ${snapshot.data?.data()}');

            productModelList = [];
            // favouriteMapModel = FavouriteMapModel(favouriteProduct: []);
            favouriteMapModel = [];
/*                        snap.forEach((element) {
                        print('inner => ${element.data()}');
                        favouriteMapModel
                            .add(favouriteMapModelFromJson(element.data()));
                      });*/
            // doc.forEach((key, value) { favouriteIDList.favouriteProduct.add(value); print(favouriteIDList.favouriteProduct);});
            // print('list => ');
            // ProductService().getFavourite();
/*                    productModelList.asMap().forEach((index, element) {
                    print('$index => ${element.toRawJson()}');
                  });*/
            return _buildCustomScrollView(context);
          } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCircularIndicator(),
                  TextButton(
                    style: elvButtonStyle,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: Text(
                      'No Registeration. Press for login',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ]);
          }
        }
/*                if (!snapshot.hasData) {
                return Center(child: CustomCircularIndicator());
              }
              return _buildCustomScrollView(context);*/
      },
    );
  }

  CustomScrollView _buildCustomScrollView(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _foundRichText(),
        ),
        SliverGrid(
          delegate: _buildSliverChildBuilderDelegate(),
          gridDelegate: _sliverGridDelegate(context),
        )
      ],
    );
  }

  Center _foundRichText() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${favProductList.length}',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            ),
            const TextSpan(
              text: ' adet bulundu',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate((BuildContext context, int index) {
      // productModelList.add(productModelFromJson(snapshot.data!.docs[index].data().toString()));
      // DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
      return _buildProductCard(index, context);
    }, childCount: favProductList.length);
  }

  SliverGridDelegateWithFixedCrossAxisCount _sliverGridDelegate(BuildContext context) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: screenWidthPercentage(context, percentage: 0.01), //0.25
      mainAxisSpacing: screenHeightPercentage(context, percentage: 0.01), //0.25
      mainAxisExtent: screenHeightPercentage(context, percentage: 0.4), //0.3
      // childAspectRatio: screenWidthPercentage(context,percentage: 0.8),
      // childAspectRatio: 0.5,
    );
  }

  ProductCard _buildProductCard(int index, BuildContext context) {
    // ProductModel _productModel = ProductModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
    print('favProductList[index].toJson() => ${favProductList[index].toJson()}');
    return ProductCard(
      isFav: true,
      favouriteModel: favProductList[index],
      index: index,
      press: () async {
        // print('favProductList[index]: ${favProductList[index]}');

        // print('snapshot => ${docSnapshot.data()}');
        // print('model => ${productModelToJson(_productModel)}');
        // print('model => ${_productModel.toRawJson()}');
        if (AuthService().isUserNull() != null) {
          // print('is in?');

          if (AuthService().isUserNull()?.isAnonymous == false) {
            // print('productModel => ${favProductList[index].toJson()}');

            await ProductService().incrementProductView(favProductList[index].id);
          }
        }
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailsScreen(),
          ),
        );
      },
    );
  }
}

/*
  @override
  void initState() {
    if (AuthService().isUserNull() == null || AuthService().isUserNull()?.isAnonymous == true) {
      print('INIT STATE is in?');
      buildDialog(context);
    }
*/
/*    getID().then((value) async {
      // favouriteIDList = value;
      print('inner: ${favouriteIDList.favouriteProduct}');
    });
    print('outter: ${favouriteIDList.favouriteProduct}');*/
/*

    getID().then((value) => null);
    super.initState();
  }
*/
/*  Future getID() async {
    // return await ProductService().getFavouriteID().then((value) => favouriteIDList.favouriteProduct = value.toList());
*/
/*    await procService.getFavouriteID(favouriteIDList).then((value) async{
      favouriteIDList.favouriteProduct = value.favouriteProduct;
      // productModelList = value;
      print('inner $productModelList');
    }).catchError((error){print('error:$error');});
    print('outter $productModelList');*/
/*
  favouriteIDList = await procService.getFavouriteID();

    // await procService.getFavouriteProductWithID(favouriteIDList.favouriteProduct);
  }*/
/*
SliverList(delegate: SliverChildBuilderDelegate((context, index) {
return
},*/
/*                if (!snapshot.hasData) {
                  return Center(child: CustomCircularIndicator());
                }
                return _buildCustomScrollView(context);*/

/*                child: FutureBuilder<List<ProductModel>>(
                  future: procService.getFavouriteProductWithID(favouriteIDList.favouriteProduct, productModelList),
                  builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
                    print('snapshot.data --> ${snapshot.data}');
                    if (!snapshot.hasData) {
                      print('no data');
                      return CustomCircularIndicator(color: Colors.pink,);
                    } else {
                      if (snapshot.data != null) {
                        print('how many favourite => ${snapshot.data?.length}');
                        // print('snapshot ${}');
                        // snapshot.data?.docs.forEach((element) {return print(element.data()); });
                        // snapshot.data?.forEach((element) {return print('asfd${element.toJson()}');});


                        */ /*favouriteIDList = FavouriteModel(favouriteProduct: []);
                        snapshot.data!.docs.forEach((element) {
                          // print('inner => ${element.data()}');
                          favouriteIDList = favouriteModelFromJson(element.data().toString());
                        });
                        // print('list => ');
                        favouriteIDList.toJson().forEach((index, element) {
                          print('$index => ${element.toRawJson()}');
                        });*/ /*
                        // return _buildCustomScrollView(context, snapshot);
                        return Container();
                      } else {
                        return CustomCircularIndicator();
                      }
                    }
*/ /*                if (!snapshot.hasData) {
                  return Center(child: CustomCircularIndicator());
                }
                return _buildCustomScrollView(context);*/ /*
                  },
                ),*/
