import 'package:capstone_rent_bi/models/FavouriteMapModel.dart';
import 'package:capstone_rent_bi/models/product.dart';
import 'package:capstone_rent_bi/services/auth.dart';
import 'package:capstone_rent_bi/services/product_service.dart';
import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:flutter/material.dart';
/*

class ProductCard extends StatefulWidget {
  final int index;
  final Function press;
  const ProductCard({Key? key, required this.index, required this.press}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      elevation: 5,
      // side: BorderSide(color: Colors.black, width: 1),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      // margin: EdgeInsets.all(3),
      child: InkWell(
        child: Center(child: Text('DATA=>[${widget.index}]')),
        onTap: () {
          press
        },
      ),
    );
  }
}
*/

class ProductCard extends StatefulWidget {
  final ProductModel? _productModel;
  final FavouriteProduct? _favouriteProduct;
  final bool isFav;
  final int index;
  final Function press;

  const ProductCard({
    Key? key,
    productModel,
    favouriteModel,
    required this.isFav,
    required this.index,
    required this.press,
  })  : _productModel = productModel,
        _favouriteProduct = favouriteModel,
        super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  ProductModel? get productModel => widget._productModel;

  FavouriteProduct? get favouriteModel => widget._favouriteProduct;

  bool get isFav => widget.isFav;

/*
  @override
  void initState() {
    print('favProduct => ${favouriteModel?.image} \nproductModel => ${productModel?.image}');
    super.initState();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black12, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () => widget.press(),
        child: _buildCenter(context),
      ),
    );
  }

  _buildCenter(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Stack(
        // overflow: Overflow.visible,
        // fit: StackFit.passthrough,
        alignment: Alignment.topRight,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                height: screenHeightPercentage(context, percentage: 0.2),
                // padding: const EdgeInsets.all(10.0),
                /*child: isFav
                    ? ClipRRect(
                        // borderRadius: BorderRadius.circular(20),
                        child: Image.network(favouriteModel?.image ?? placeholderSmall,
                            fit: BoxFit.contain))
                    : ClipRRect(
                        // borderRadius: BorderRadius.circular(20),
                        child: Image.network(productModel?.image ?? placeholderSmall,
                            fit: BoxFit.contain)),*/
                child: ClipRRect(
                  child: Image.network('${getImageURL()}',),
                ),
              ),
              verticalSpaceTiny,
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${getPriceText()}',
                      overflow: TextOverflow.ellipsis,
                      style: productCardPriceStyle,
                    ),
/*                    isFav
                        ? Text(
                            '${favouriteModel?.price}',
                            overflow: TextOverflow.ellipsis,
                            style: productCardPriceStyle,
                          )
                        : Text(
                            '${productModel?.price}',
                            overflow: TextOverflow.ellipsis,
                            style: productCardPriceStyle,
                          ),*/

                    Text(
                      '${getTitleText()}',
                      overflow: TextOverflow.ellipsis,
                      style: productCardTitleStyle,
                    ),
                    // verticalSpaceTiny,
/*                    isFav
                        ? Text(
                            '${favouriteModel?.title}',
                            overflow: TextOverflow.ellipsis,
                            style: productCardTitleStyle,
                          )
                        : Text(
                            '${productModel?.title}',
                            overflow: TextOverflow.ellipsis,
                            style: productCardTitleStyle,
                          ),*/
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: screenHeightPercentage(context, percentage: 0.055),
            // width: ,
            // decoration: getFavBoxDecoration(),
            decoration: favBoxDecoration,
            child: IconButton(
              onPressed: () {
                if (AuthService().isUserNull() != null) {
                  if (AuthService().isUserNull()?.isAnonymous == false) {
    /*                isFav
                        ? ProductService().deleteFavourite(favouriteModel!)
                        : ProductService().addFavourite(productModel!);
                    print('signed');*/
                    if(isFav == true){
                      print('here in delete func');
                      ProductService().deleteFavourite(favouriteModel!);
                    }else{
                      print('here in add func');
                      ProductService().addFavourite(productModel!);
                    }
                  }
                  else {
                    buildDialog(context);
                    print('not signed');
                  }
                } else {
                  buildDialog(context);
                  print('not signed');
                }
              },
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.black,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? getImageURL(){
    if(favouriteModel?.image != null){
      return favouriteModel?.image;
    }else{
      return productModel?.image;
    }
  }
  String? getPriceText(){
    if(favouriteModel?.price != null){
      return favouriteModel?.price;
    }else{
      return productModel?.price;
    }
  }
  String? getTitleText(){
    if(favouriteModel?.title != null){
      return favouriteModel?.title;
    }else{
      return productModel?.title;
    }
  }
  BoxDecoration getFavBoxDecoration(){
    if(isFav == true){
      return favBoxDecoration.copyWith(color: Colors.red);
    }else{
      return favBoxDecoration;
    }
  }

  getFavFunc(){
    if(isFav == true){
      return ProductService().deleteFavourite(favouriteModel!);
    }else{
      return ProductService().addFavourite(productModel!);
    }
  }

  buildDialog(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      builder: (context) => buildAlertDialog(context),
      barrierDismissible: true,
    );
  }

  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      content: Text('Continue with Email'),
      title: const Text('Confirm'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              style: elvButtonStyle,
              onPressed: () {
                AuthService().signOutUser();
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('YES',style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              style: elvButtonStyle,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('NO',style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ],
    );
  }
}
