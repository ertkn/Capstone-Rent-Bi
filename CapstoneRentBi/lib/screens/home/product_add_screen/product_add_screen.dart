/*
import 'package:flutter/material.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({Key? key}) : super(key: key);

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
*/
import 'dart:io';
import 'package:capstone_rent_bi/models/product.dart';
import 'package:capstone_rent_bi/services/product_service.dart';
import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/utilities/custom_text_strings.dart';
import 'package:capstone_rent_bi/utilities/snackbar.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/utilities/user_preferences.dart';
import 'package:capstone_rent_bi/widgets/custom_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({Key? key}) : super(key: key);

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final TextEditingController _productController = TextEditingController();
  final ProductService _productService = ProductService();
  final ProductModel _productModel =
      ProductModel(id: '', title: '', price: '', seller: '', image: '');

  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  dynamic _foodImage;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _body(),
    );
  }

  _body() {
    return Container(
      decoration: backgroundDecorationStyle,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _mainBody(),
                _saveButton(context),
              ],
            ),
          ),
          if (_isLoading) CustomCircularIndicator(),
        ],
      ),
    );
  }

  Flexible _mainBody() {
    return Flexible(
      child: ListView(
        children: [
          // _bodyTitle(),
          const SizedBox(
            height: 20,
          ),
          _bodyImage(),
          const SizedBox(
            height: 30,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _foodTextField(),
            ),
          ),
          _bodyContainer(),
        ],
      ),
    );
  }

/*  Widget _bodyTitle() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          CustomTextString.addText,
        ),
      ),
    );
  }*/

  Container _bodyContainer() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _foodTextField(),
      ),
    );
  }

  TextField _foodTextField() {
    return TextField(
        cursorColor: Colors.blue,
        controller: _productController,
        maxLines: 7,
        decoration: InputDecoration(
          hintText: CustomTextString.addProductText,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ));
  }

  Column _bodyImage() {
    return Column(
      children: [
        Center(
          child: _imagePlace(),
        ),
        const SizedBox(
          height: 10,
        ),
        _imageRow(),
      ],
    );
  }

  Row _imageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _cameraContainer(),
        const SizedBox(
          width: 10,
        ),
        _galeryContainer(),
      ],
    );
  }

  Container _cameraContainer() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.camera_alt,
          color: Color(0xFF527DAA),
        ),
        onPressed: () => _onImageButtonPressed(
          ImageSource.camera,
          context: context,
        ),
      ),
    );
  }

  Container _galeryContainer() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.image,
          color: Color(0xFF527DAA),
        ),
        onPressed: () => _onImageButtonPressed(
          ImageSource.gallery,
          context: context,
        ),
      ),
    );
  }

  Container _imagePlace() {
    if (_foodImage != null) {
      return _fileImage();
    } else {
      if (_pickImage != null) {
        return _networkImage();
      } else {
        return _circleImage();
      }
    }
  }

  Container _fileImage() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
            File(_foodImage!.path),
          ),
        ),
      ),
    );
  }

  Container _networkImage() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(_pickImage)),
      ),
    );
  }

  Container _circleImage() {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        /*child: CircleAvatar(

          backgroundImage: Image.network(placeholderSmall),
          radius: height * 0.08,
        ),*/
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            // 'https://pbs.twimg.com/media/FHfttxDWQAAJQNK?format=jpg&name=large',
            UserPreferences.loggedInUser.imagePath ?? placeholderSmall,
            // semanticLabel: 'Profile Picture',
            height: screenHeightPercentage(context, percentage: 0.25) /
                screenWidthPercentage(context, percentage: 0.1) *
                17.5,
            width: screenHeightPercentage(context, percentage: 0.25) /
                screenWidthPercentage(context, percentage: 0.1) *
                17.5,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                ? child
                : CustomCircularIndicator(
                    color: Colors.lightBlue,
                    backgroundColor: Colors.transparent,
                  ),
          ),
        ),
      ),
    );
  }

  Padding _saveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
          onTap: () => _saveButtonOnTap(),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF6788AC),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 40,
            child: Center(
              child: Text(
                CustomTextString.addText,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )),
    );
  }

  void _saveButtonOnTap() {
    if (_productController.text.isNotEmpty && _foodImage != null) {
      setState(() {
        _isLoading = true;
      });
      _productService.addProductInScreen(_productModel, _foodImage ?? '').then((value) {
        Navigator.pop(context);
      }).catchError((error) {
        SnackBarMessage.showSnackBar(context,
            text: 'ouch!! register is failed!\n\n${CustomTextString.errorText}');
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      SnackBarMessage.showSnackBar(context,
          text: 'ouch!! register is failed!\n\n${CustomTextString.errorText}');
    }
  }

  void _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
  }) async {
    try {
      final pickedFile = await _pickerImage.pickImage(source: source);
      setState(() {
        _foodImage = pickedFile!;
      });
    } catch (error) {
      setState(() {
        _pickImage = error;
      });
    }
  }
}
