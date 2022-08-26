import 'package:capstone_rent_bi/models/product.dart';
import 'package:capstone_rent_bi/screens/home/product/widgets/product_card.dart';
import 'package:capstone_rent_bi/screens/home/product_details/details_screen.dart';
import 'package:capstone_rent_bi/services/auth.dart';
import 'package:capstone_rent_bi/services/product_service.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/widgets/custom_circular_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<ProductModel> productModelList = [];
  final int _docNum = 20;

/*  @override
  void initState() {
    print('object');
    productModelList = [];
    productModelList.asMap().forEach(
      (index, element) {print('$index => ${element.toRawJson()}');},
    );
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: screenHeight(context),
          width: screenWidth(context),
          // color: Colors.transparent,
          // decoration: const BoxDecoration(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: ProductService().getProduct(_docNum),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CustomCircularIndicator();
                } else {
                  if (snapshot.data != null) {
                    // print('how many');
                    productModelList = [];
                    snapshot.data!.docs.forEach((element) {
                      // print('inner => ${element.data()}');
                      productModelList
                          .add(productModelFromJson(element.data() as Map<String, dynamic>));
                    });
                    // print('list => ');
/*                    productModelList.asMap().forEach((index, element) {
                      print('$index => ${element.toRawJson()}');
                    });*/
                    return _buildCustomScrollView(context, snapshot);
                  } else {
                    return CustomCircularIndicator();
                  }
                }
/*                if (!snapshot.hasData) {
                  return Center(child: CustomCircularIndicator());
                }
                return _buildCustomScrollView(context);*/
              },
            ),
          ),
        ),
      ),
    );
  }

/*if (!snapshot.hasData) {
                  return CustomCircularIndicator();
                }
                else {
                  if (snapshot.data != null) {

                      final messages = snapshot.data!.docs;
                      List<Text> messageWidgets = [];

                      for (var element in messages) {
                        final messageText = element['text'];
                        final messageSender = element['sender'];

                        final messageWidget =
                        Text('$messageText from $messageSender');
                        messageWidgets.add(messageWidget);
                      }
                      return Column(
                        children: messageWidgets,
                      );

                  } else {
                    return CustomCircularIndicator();
                  }
                }*/
  CustomScrollView _buildCustomScrollView(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _foundRichText(),
        ),
        SliverGrid(
            delegate: _buildSliverChildBuilderDelegate(snapshot),
            gridDelegate: _sliverGridDelegate(context))
      ],
    );
  }

  Center _foundRichText() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${productModelList.length}',
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

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
      AsyncSnapshot<QuerySnapshot> snapshot) {
    return SliverChildBuilderDelegate((BuildContext context, int index) {
      // productModelList.add(productModelFromJson(snapshot.data!.docs[index].data().toString()));
      DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
      return _buildProductCard(docSnapshot, index, context);
    }, childCount: snapshot.data?.docs.length);
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

  ProductCard _buildProductCard(DocumentSnapshot docSnapshot, int index, BuildContext context) {
    // ProductModel _productModel = ProductModel.fromJson(docSnapshot.data() as Map<String, dynamic>);

    return ProductCard(
      isFav: false,
      productModel: productModelList[index],
      index: index,
      press: () async {
        // print('snapshot => ${docSnapshot.data()}');
        // print('model => ${productModelToJson(_productModel)}');
        // print('model => ${_productModel.toRawJson()}');
        if (AuthService().isUserNull() != null) {
          print('is in?');
          if (AuthService().isUserNull()?.isAnonymous == false) {
            print('productModel => ${productModelList[index].toJson()}');
            await ProductService().incrementProductView(productModelList[index].id);
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

/*ProductCard(
                          index: index,
                          press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailsScreen(),
                            ),
                          ),
                        ),*/
/*            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => ProductCard(
                      index: index,
                      press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailsScreen(),
                        ),
                      ),
                    ),
                  ),
                  // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidthPercentage(context, percentage: 0.01), //0.25
                    mainAxisSpacing: screenHeightPercentage(context, percentage: 0.01), //0.25
                    mainAxisExtent: screenHeightPercentage(context, percentage: 0.225), //0.3
                    // childAspectRatio: 0.5,
                  ),
                ),
              ],
            ),*/
