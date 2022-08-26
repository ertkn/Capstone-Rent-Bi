import 'package:capstone_rent_bi/screens/home/user_settings/widgets/body.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/services/auth.dart';
import 'package:flutter/material.dart';

class UserSettingsScreen extends StatefulWidget {

  const UserSettingsScreen({Key? key})
      :
        super(key: key);

  // FirebaseAuth get auth => _auth;

  @override
  _UserSettingsScreenState createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      backgroundColor: Colors.white,
/*      appBar: AppBar(
        backgroundColor: Color(0xFF527DAA),
        title: Text('Your Profile'),
        centerTitle: true,
        elevation: 0,
      ),*/

      // drawer: const NavigationDrawer(),

      appBar: buildAppBar(context),
      // bottomNavigationBar: NavigationDrawer(),

      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: screenHeightPercentage(context, percentage: 0.07),
      // toolbarHeight: 65,
      foregroundColor: Colors.transparent,
      backgroundColor: const Color(0xFFB6CFEC),
      primary: true,
      elevation: 0,
      // centerTitle: true,
      // titleSpacing: screenWidthPercentage(context, percentage: 0.02),

      // backgroundColor: const Color(0xFFB6CFEC),
      leading: IconButton(
        padding: EdgeInsets.only(
            left: screenWidthPercentage(context, percentage: 0.0525)),
        alignment: Alignment.center,
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          // color: Color(0xBE385C89),
        ),
        // constraints: const BoxConstraints(minHeight: 100.0, minWidth: 0.0),
        tooltip: 'go back',
        onPressed: () => Navigator.pop(context),
      ),

      centerTitle: true,
      title: const Text(
        'User Settings',
        style: TextStyle(
          color: Colors.black,
          fontSize: 26,
          // fontFamily: 'OpenSans',
          letterSpacing: -2,
        ),
      ),

      actions: [
        IconButton(
          padding: EdgeInsets.only(
              right: screenWidthPercentage(context, percentage: 0.0375)),
          tooltip: 'quit',
          color: Colors.black,
          iconSize: screenWidthPercentage(context, percentage: 0.1),
          // onPressed: () => Navigator.pop(context),
          onPressed: () async {
            // await widget._auth.signOut();
            await _authService.signOutUser();
            Navigator.pushReplacementNamed(context, '/');
          },
          icon: const Icon(
            Icons.logout,
            size: 30,
          ),
        ),
      ],
    );
  }
}
/*          IconButton(
            padding: EdgeInsets.only(right: screenWidthPercentage(context, percentage: 0.0375)),
            tooltip: 'quit',
            color: Colors.transparent,
            iconSize: screenWidthPercentage(context, percentage: 0.1),
            // onPressed: () => Navigator.pop(context),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
*/ /*           icon: CircleAvatar(
            foregroundImage: NetworkImage(UserPreferences.myUser.imagePath),
            // backgroundImage: NetworkImage(),
             backgroundColor: Colors.transparent,
            radius: screenHeightPercentage(context,percentage: 0.5),
          ),*/ /*
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              // backgroundImage: NetworkImage(UserPreferences.myUser.imagePath),
              child: Image.network(
                // 'https://pbs.twimg.com/media/FHfttxDWQAAJQNK?format=jpg&name=large',
                UserPreferences.myUser.imagePath,
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
                    : const CircularProgressIndicator(
                        color: Colors.black,
                        backgroundColor: Colors.transparent,
                      ),
              ),
            ),
          ),*/
/*title: SizedBox(
        // color: Colors.indigoAccent,
        height: screenHeightPercentage(context, percentage: 0.045),
        width: screenWidthPercentage(context, percentage: 0.65),
        // margin: const EdgeInsets.fromLTRB(0, 19.25, 0, 0),
        // decoration: kBoxDecorationStyle,
        // padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: TextField(
          cursorColor: Colors.black12,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.bottom,
          // controller: controller,
          decoration: InputDecoration(
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
