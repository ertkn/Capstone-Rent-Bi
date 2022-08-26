import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/utilities/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // collapsedHeight: 100,
            // backgroundColor: Colors.amberAccent,
            floating: true,
            elevation: 3,
            pinned: true,
            leading: IconButton(
              padding: EdgeInsets.only(left: screenWidthPercentage(context, percentage: 0.075)),
              alignment: Alignment.center,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                // color: Color(0xBE385C89),
              ),
              // constraints: const BoxConstraints(minHeight: 100.0, minWidth: 0.0),
              tooltip: 'go back',
              onPressed: () => Navigator.pop(context),
            ),
/*            centerTitle: true,
            title: const Text(
              'User Setting',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'OpenSans',
              ),
            ),*/
            expandedHeight: screenHeightPercentage(context, percentage: 0.25),

            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(15),
              collapseMode: CollapseMode.parallax,
              background: Image.network(
                UserPreferences.myUser.imagePath ?? placeholderSmall,
                fit: BoxFit.cover,
              ),
              centerTitle: true,
              title: Text(
                '${UserPreferences.myUser.firstName}''${UserPreferences.myUser.lastName}',
                style: appBarTitleStyle.copyWith(
                  color: Colors.white,
                  letterSpacing: -1.5,
                  wordSpacing: 2.5,
                ),
              ),
            ),

            actions: <Widget>[
              IconButton(
                padding: EdgeInsets.only(right: screenWidthPercentage(context, percentage: 0.0375)),
                tooltip: 'quit',
                color: Colors.white,
                // iconSize: screenWidthPercentage(context, percentage: 0.1),
                // onPressed: () => Navigator.pop(context),
                onPressed: () => Navigator.pushNamed(context, '/'),
                icon: const Icon(
                  Icons.logout,
                  size: 30,
                ),
              ),
            ],
          ),

/*          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, index) {
              return Container(
                padding: EdgeInsets.only(left:25),
                height: 50,
                alignment: Alignment.centerLeft,
                // color: Colors.deepPurple[100 * (index % 9)],
                color: Colors.white,
                child: Column(
                  children: */
          /*[
                    Text('orange $index',style: TextStyle(
                      color: Colors.deepPurple[100 * (index % 9)],
                      letterSpacing: -0.75,
                      fontSize: 20,
                    ),),
                  ],*/
          /*
                  <Widget>[
                    menuBuilder(
                        title: 'Profile',
                        iconData: Icons.person_outline,
                        navPath: () => Navigator.pushNamed(context, '/profile')),
                  ]
                ),
              );
            }, childCount: 5),
          ),*/

          SliverFixedExtentList(
            itemExtent: screenHeightPercentage(context, percentage: 0.1),
            delegate: SliverChildListDelegate(
              [
                // verticalSpaceTiny,
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
                // buildDivider(context),
                menuBuilder(
                  title: 'Shopping Cart',
                  iconData: Icons.shopping_cart_outlined,
                  navPath: () => Navigator.pushNamed(context, '/home'),
                ),
                // buildDivider(context),
                menuBuilder(
                  title: 'Settings',
                  iconData: Icons.settings_rounded,
                  navPath: () => Navigator.pushNamed(context, '/settings'),
                ),
                // buildDivider(context),
                menuBuilder(
                  title: 'Logout',
                  iconData: Icons.logout,
                  navPath: () => Navigator.pushNamed(context, '/home'),
                ),
                menuBuilder(
                  title: 'Report A Bug',
                  iconData: Icons.bug_report_outlined,
                  navPath: () => Navigator.pushNamed(context, '/home'),
                ),
                menuBuilder(
                  title: 'Send Feedback',
                  iconData: Icons.logout,
                  navPath: () => Navigator.pushNamed(context, '/home'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget menuBuilder({required String title, required IconData iconData, required Function() navPath}) {
    return SimpleSettingsTile(
      leading: iconWidget(iconData),
      title: title,
      subtitle: '',
      onTap: navPath,
      enabled: true,
    );
  }

  ClipRRect iconWidget(IconData iconData) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 35,
        width: 35,
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 60.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          iconData,
          size: 24,
          color: Colors.black,
        ),
      ),
    );
  }
}

/*      leading: Icon(
        iconData,
        color: Colors.black,
        size: 32,
      ),

      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xBF000000),
          fontSize: 26,
          letterSpacing: -1.5,
          // fontWeight: FontWeight.w600,
        ),
      ),

      // minLeadingWidth: 45,
      // minVerticalPadding: 5,
      // horizontalTitleGap: 27.5,
      contentPadding: const EdgeInsets.all(20),*/

/*    return TextFormField(
      onTap: navPath,readOnly: true,

      style: fieldTextStyle,
      // cursorColor: Colors.white,
      // keyboardType: TextInputType.name,

      // textInputAction: TextInputAction.next,
      // onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),

      // controller: firstNameController,
      //
      // validator: (value) => value != null && (value.length > 50 || value.isEmpty)
      //     ? 'Name length must be between 1-50 characters'
      //     : null,

      // onSaved: (newValue) {
      //   setState(() {
      //     UserPreferences.myUser.firstName = newValue;
      //   });
      // },
      enabled: true,

      decoration: InputDecoration(

        labelText: title,
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 30, style: BorderStyle.solid)),
        contentPadding: EdgeInsets.only(top: 10.0),
        prefixIcon: Icon(
          iconData,
          color: Colors.black,
          size: 30,
        ),
        // hintText: 'Enter your First Name',
        // hintStyle: hintTextStyle,
      ),
    );*/