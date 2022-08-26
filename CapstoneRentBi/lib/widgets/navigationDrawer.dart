import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/utilities/user_preferences.dart';
import 'package:capstone_rent_bi/widgets/custom_circular_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class NavigationDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.white),
        // color: Colors.deepPurpleAccent,
        // height: screenHeightPercentage(context, percentage: 0.5),
        // width: screenWidthPercentage(context),
        height: screenHeightPercentage(context),
        width: screenWidthPercentage(context, percentage: 0.75),
        child: ListView(children: <Widget>[
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/profilenew'),
            // enableFeedback: true,excludeFromSemantics: true,
            // splashColor: Colors.black87,
            child: Container(
              // alignment: Alignment.center,
              height: screenHeightPercentage(context, percentage: 0.25),
              color: const Color(0x653E6F93),
              // padding: EdgeInsets.fromLTRB(0, screenWidthPercentage(context, percentage: 0.1), 0, 0,),
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    // backgroundImage: NetworkImage(UserPreferences.myUser.imagePath),
                    child: Image.network(
                      // 'https://pbs.twimg.com/media/FHfttxDWQAAJQNK?format=jpg&name=large',
                      UserPreferences.myUser.imagePath ?? placeholderSmall,
                      // semanticLabel: 'Profile Picture',
                      height:
                          screenHeightPercentage(context, percentage: 0.25) /
                              screenWidthPercentage(context, percentage: 0.1) *
                              17.5,
                      width: screenHeightPercentage(context, percentage: 0.25) /
                          screenWidthPercentage(context, percentage: 0.1) *
                          17.5,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : CustomCircularIndicator(
                                  color: Colors.lightBlue,
                                  backgroundColor: Colors.transparent,
                                ),
                    ),
                    // clipBehavior: Clip.antiAliasWithSaveLayer,
                  ),
                  // horizontalSpaceLarge,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${UserPreferences.myUser.firstName} ${UserPreferences.myUser.lastName}',
                        style: appBarTitleStyle.copyWith(
                             letterSpacing: -0.5),
                      ),
                      Text(
                        '${UserPreferences.myUser.email}',
                        style: appBarTitleStyle.copyWith(
                          fontSize: 18,
                          letterSpacing: -2,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                  /*const Icon(Icons.arrow_forward_ios, color: Colors.black87),*/
                ],
              ),
            ),
          ),
/*          TextFormField(

          ),*/
/*
          menuBuilder(
            title: 'Discover',
            iconData: Icons.home_filled,
            navPath: () => Navigator.pushNamed(context, '/home'),
          ),
          menuBuilder(
            title: 'Profile',
            iconData: Icons.person_outline,
            navPath: () => Navigator.pushNamed(context, '/profile'),
          ),
          menuBuilder(
            title: 'Favourites',
            iconData: Icons.favorite_border,
            navPath: () => Navigator.pushNamed(context, '/cart'),
          ),
          menuBuilder(
            title: 'Shopping Cart',
            iconData: Icons.shopping_cart_outlined,
            navPath: () => Navigator.pushNamed(context, '/cart'),
          ),
          menuBuilder(
            title: 'Settings',
            iconData: Icons.settings,
            navPath: () => Navigator.pushNamed(context, '/settings'),
          ),
          menuBuilder(
            title: 'Log out',
            iconData: Icons.logout,
            navPath: () => Navigator.pushNamed(context, '/'),
          ),
        ],
      ),
*/
          // verticalSpaceTiny,
          menuBuilder(
            title: 'Discover',
            iconData: Icons.home_filled,
            navPath: () => Navigator.pushNamed(context, '/home'),
          ),
          menuBuilder(
            title: 'Profile',
            iconData: Icons.person,
            navPath: () => Navigator.pushNamed(context, '/profile'),
            // color: const Color(0xb268bce2),
          ),
          menuBuilder(
            title: 'Shopping Cart',
            iconData: Icons.shopping_cart_rounded,
            navPath: () => Navigator.pushNamed(context, '/home'),
            // color: const Color(0xb26ccb79),
          ),
          menuBuilder(
            title: 'Chat',
            iconData: Icons.chat_bubble_rounded,
            navPath: () => Navigator.pushNamed(context, '/chat'),
            // color: const Color(0xb26c8fcb),
          ),
          menuBuilder(
            title: 'Logout',
            iconData: Icons.logout,
            navPath: () async {
              await _auth.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
            // color: const Color(0xdae26872),
          ),
          const Divider(
            color: Colors.black12,
            height: 5,
            thickness: 1,
          ),
          // verticalSpaceTiny,
// buildDivider(context),0xcde2ab68
          menuBuilder(
            title: 'Send Feedback',
            iconData: Icons.feedback_rounded,
            navPath: () => Navigator.pushReplacementNamed(context, '/'),
            // color: const Color(0xdadee268),
          ), //
          menuBuilder(
            title: 'Report A Bug',
            iconData: Icons.bug_report_rounded,
            navPath: () => Navigator.pushNamed(context, '/'),
            // color: const Color(0x749b68e2),
          ),
          menuBuilder(
            title: 'Settings',
            iconData: Icons.settings_rounded,
            navPath: () => Navigator.pushNamed(context, '/settings'),
            // color: const Color(0x9a68a9e2),
          ),
        ]));
  }

  Widget menuBuilder({
    required String title,
    required IconData iconData,
    required Function() navPath,
  }) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      // color: Colors.transparent,
      // decoration: BoxDecoration(color: Colors.transparent),
      child: ListTile(
        onTap: navPath,
        leading: iconWidget(iconData),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            letterSpacing: 0,
            wordSpacing: 0,
          ),
        ),
        style: ListTileStyle.drawer,
        enabled: true,
        // subtitle: const Text(''),
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.5,
          vertical: 0,
        ),
        horizontalTitleGap: 7.5,
        minLeadingWidth: 0,

        // visualDensity: const VisualDensity(vertical: -4),
      ),
    );
  }

  SizedBox iconWidget(IconData iconData) {
    return SizedBox(
      height: 35,
      width: 35,
/*      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),*/
      child: Icon(
        iconData,
        size: 26,
        color: Colors.black87,
      ),
    );
  }

/* Widget menuBuilder({required String title, required IconData iconData, required Function() navPath}) {
    return ListTile(
      // tileColor: Colors.deepOrange,
      leading: Icon(
        iconData,
        color: Colors.black,
        size: 32,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xBF000000),
          fontSize: 18,
          letterSpacing: 1.5,
          // fontWeight: FontWeight.w600,
        ),
      ),
      onTap: navPath,
      // minLeadingWidth: 45,
      // minVerticalPadding: 5,
      // horizontalTitleGap: 27.5,
      contentPadding: const EdgeInsets.symmetric(horizontal: 35, vertical: 0),
    );
  }*/
}
/*        width: screenWidthPercentage(context,percentage: 1),
        decoration: backgroundDecorationStyle,*/
