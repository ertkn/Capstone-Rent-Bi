import 'dart:io';

import 'package:capstone_rent_bi/models/product.dart';
import 'package:capstone_rent_bi/screens/chatpages/chatpage_view.dart';
import 'package:capstone_rent_bi/screens/home/favourite/favourite_screen.dart';
import 'package:capstone_rent_bi/screens/home/product/widgets/searchBar.dart';
import 'package:capstone_rent_bi/screens/home/product//widgets/body.dart';
import 'package:capstone_rent_bi/screens/home/product_add_screen/product_add_screen.dart';
import 'package:capstone_rent_bi/screens/home/user_settings/user_settings_screen.dart';
import 'package:capstone_rent_bi/services/auth.dart';
import 'package:capstone_rent_bi/services/product_service.dart';
import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/utilities/user_preferences.dart';
import 'package:capstone_rent_bi/widgets/button_app_bar.dart';
import 'package:capstone_rent_bi/widgets/custom_circular_indicator.dart';
import 'package:capstone_rent_bi/widgets/navigationDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FloatingActionButtonLocation _floatingActionButtonLocation =
      FloatingActionButtonLocation.centerDocked;
  final ImagePicker _pickerImage = ImagePicker();

  int _lastSelectedIndex = 0;

  final List<Widget> screens = [
    const Body(),
    const ChatPageView(),
    const FavouriteScreen(),
    const UserSettingsScreen()
  ];

  buildDialog(BuildContext context) async {
    await showDialog<bool>(
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
                Navigator.pushReplacementNamed(context,'/login');
              },
              child: const Text('YES',style: TextStyle(color: Color(0xffff2222)),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context,'/home');
              },
              child: const Text('NO',style: TextStyle(color: Color(0xffff2222)),),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      buildInitialise();
    });
    super.initState();
  }

  Future buildInitialise() async{
    if((AuthService().isUserNull() == null || AuthService().isUserNull()?.isAnonymous == true) && _lastSelectedIndex != 0){
      return await buildDialog(context);
    }/*else{
      return screens[_lastSelectedIndex];
    }*/
  }
/*
  isUserLogIn(){
    if(UserPreferences.loggedInUser.uuid == '' || UserPreferences.loggedInUser.uuid == null){
      buildInitialise()
    }
  }
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _lastSelectedIndex == 0 ? buildAppBar(context) : null,
      // body: IndexedStack(index: _lastSelectedIndex, children: screens),
      body: screens[_lastSelectedIndex],
      // body: _lastSelectedIndex == 0 ? buildDialog(context) : screens[_lastSelectedIndex],
      //isSearching: _isSearch,
      endDrawer: NavigationDrawer(),
      // backgroundColor: Colors.transparent,
      // backgroundColor: Colors.grey,
      // drawer: NavigationDrawer(),
      floatingActionButtonLocation: _floatingActionButtonLocation,
      floatingActionButton: _buildFloatingActionButton(context),
      bottomNavigationBar: _buildFabBottomAppBar(),
    );
  }

  void _selectedTab(int index) {
    setState(() {
      _lastSelectedIndex = index;
    });
  }

  FABBottomAppBar _buildFabBottomAppBar() {
    return FABBottomAppBar(
      height: screenHeightPercentage(context,percentage: 0.1),
      centerItemText: 'SELL',
      color: Colors.grey,
      selectedColor: Color(0xffda3333),
      notchedShape: const CircularNotchedRectangle(),
      onTabSelected: _selectedTab,
      items: [
        FABBottomAppBarItem(iconData: Icons.home, text: 'HOME'),
        FABBottomAppBarItem(iconData: Icons.chat, text: 'CHAT'),
        FABBottomAppBarItem(iconData: Icons.favorite, text: 'FAV'),
        FABBottomAppBarItem(iconData: Icons.person, text: 'ACCOUNT'),
      ],
    );
  }

  /*BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      // elevation: 5,
      color: Colors.white,
      notchMargin: 5,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          )
        ],
      ),
    );
  }*/
  _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      splashColor: Colors.white,
      onPressed: () async {
/*        final pickedFile = await _pickerImage.pickImage(source: ImageSource.gallery,maxWidth: 1920);
        if (pickedFile != null) {
          File imageFile = File(pickedFile.path);
          String imageURL = await ProductService().getMediaURL(imageFile);
          // ProductService().addProduct();
        }*/
        await Navigator.pushNamed(context, '/productadd');
        },
      child: const Icon(
        Icons.camera_alt,
        color: Colors.black,
        size: 27.5,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      foregroundColor: Colors.transparent,
      backgroundColor: Colors.white,
      primary: true,
      // elevation: 3,

      // leadingWidth: 75,
      // leading: buildProfileButton(context),
      // toolbarHeight: 65,
      // backgroundColor: const Color(0xFFC186B0),
      // centerTitle: true,
      //screenWidthPercentage(context, percentage: 0.025),
      // backgroundColor: const Color(0xFFB6CFEC),
      // automaticallyImplyLeading: false,

      centerTitle: false,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildProfileButton(context),
          const SearchBar(),
        ],
      ),
      actions: [buildFilterButton(context)],
    );
  }

  Container buildFilterButton(BuildContext context) {
    return Container(
      // alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(right: 10),
      child: TextButton(
        onPressed: () => Navigator.of(context).pushNamed('/'),
        child: const Text(
          'Filters',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xcdec6d6d),
            fontSize: 18,
            letterSpacing: 0,
            fontFamily: 'RobotoSlab',
          ),
        ),
      ),
    );
  }

  Center buildProfileButton(BuildContext context) {
    return Center(
      child: IconButton(
        // padding: EdgeInsets.only(right: screenWidthPercentage(context, percentage: 0.0005)),
        //0.0375
        tooltip: 'profile page',
        color: Colors.transparent,
        iconSize: screenWidthPercentage(context, percentage: 0.1),
        // onPressed: () => Navigator.pop(context),
        onPressed: () => Navigator.pushNamed(context, '/userset'),
/*           icon: CircleAvatar(
            foregroundImage: NetworkImage(UserPreferences.myUser.imagePath),
            // backgroundImage: NetworkImage(),
             backgroundColor: Colors.transparent,
            radius: screenHeightPercentage(context,percentage: 0.5),
          ),*/
        icon: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          // backgroundImage: NetworkImage(UserPreferences.myUser.imagePath),
          child: Image.network(
            // 'https://pbs.twimg.com/media/FHfttxDWQAAJQNK?format=jpg&name=large',
            UserPreferences.myUser.imagePath ?? placeholderSmall, //'assets/google.jpg',
            // semanticLabel: 'Profile Picture',
            height: screenHeightPercentage(context, percentage: 0.1) /
                screenWidthPercentage(context, percentage: 0.1) *
                20,
            width: screenHeightPercentage(context, percentage: 0.1) /
                screenWidthPercentage(context, percentage: 0.1) *
                20,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                ? child
                : CustomCircularIndicator(
                    color: Colors.black,
                    backgroundColor: Colors.transparent,
                  ),
          ),
        ),
      ),
    );
  }
}
/*        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(
              screenWidthPercentage(context, percentage: 0.15),
              screenHeightPercentage(context, percentage: 1),
            ),
            padding: EdgeInsets.only(right: screenWidthPercentage(context,percentage: 0.01)),
            elevation: 0.0,
            primary: Colors.amber,
          ),
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            // Navigator.pushNamed(context, '/home');
          },
          child: CircleAvatar(
            child: Image.network(
              'https://pbs.twimg.com/media/FHfttxDWQAAJQNK?format=jpg&name=large',
              // color: Color(0xBE385C89),
              color: Colors.black38,
              loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                  ? child
                  : const CircularProgressIndicator(
                      color: Colors.black,
                      // backgroundColor: Colors.transparent,
                    ),
              //semanticLabel: 'go without sign',
            ),
          ),
        ),*/

/*      leading: IconButton(
        padding: EdgeInsets.only(left: screenWidthPercentage(context, percentage: 0.025)),
        alignment: Alignment.center,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black38,
          // color: Color(0xBE385C89),
        ),
        // constraints: const BoxConstraints(minHeight: 100.0, minWidth: 0.0),
        tooltip: 'go back',
        onPressed: () => Navigator.pop(context),
      ),*/

/*title: SizedBox(
        // color: Colors.indigoAccent,
        height: screenHeightPercentage(context, percentage: 0.045),
        width: screenWidthPercentage(context, percentage: 0.65),
        // margin: const EdgeInsets.fromLTRB(0, 19.25, 0, 0),
        // decoration: kBoxDecorationStyle,
        // padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.black12,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          // controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            // fillColor: Colors.indigoAccent,
            // filled: true,
            // isDense: true,
            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7.5))),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular((7.5))),
              borderSide: BorderSide(color: Colors.black45, width: 1),
            ),
            // border:UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
            // disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 10, color: Colors.transparent)),
            constraints: const BoxConstraints(
              minHeight: 0,
              minWidth: 0,
            ),

            prefixIcon: IconButton(
              icon: const Icon(
                Icons.search,
              ),
              color: Colors.black45,
              onPressed: () => print('searched'),
              tooltip: 'search',
            ),
            suffixIcon: IconButton(
              onPressed: () => print('closed'),
              // onPressed: () => controller.clear(),
              icon: const Icon(Icons.close),
              tooltip: 'delete',
              color: Colors.black26,
            ),
            // hintText: 'Marka, ürün, üye, #etiket ara',
            hintText: 'RentBi\'de Ara',
            hintStyle: const TextStyle(
              fontFamily: 'OpenSans',
            ),
            // isCollapsed: false,
            // border: OutlineInputBorder(),
          ),
        ),
      ),*/

/*
      leading: Center(
        child: Text(
          'Rent-Bi',
          textAlign: TextAlign.center,
          style: appBarTitleStyle.copyWith(
            color: const Color(0xFF37485C),
            fontSize: 24,
            letterSpacing: -2.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
*/
