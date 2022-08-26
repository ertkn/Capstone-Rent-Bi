import 'package:capstone_rent_bi/services/auth.dart';
import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/utilities/user_preferences.dart';
import 'package:capstone_rent_bi/widgets/custom_circular_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class Body extends StatefulWidget {

  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      buildInitialise();
    });

/*
    Future.delayed(Duration.zero, () {
    });
*/
    super.initState();
  }

/*
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    buildInitialise();
  }
*/


  Future buildInitialise() async{
    if(AuthService().isUserNull() == null || AuthService().isUserNull()?.isAnonymous == true){
    await buildDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // color: Colors.white,
/*        decoration: BoxDecoration(
          // color: Colors.grey[100],
        ),*/
        child: ListView(
          padding: EdgeInsets.symmetric(
            // horizontal: screenWidthPercentage(context, percentage: 0.0000025),
            // vertical: screenHeightPercentage(context, percentage: 0.000025),
            horizontal: screenWidthPercentage(context, percentage: 0.01),
            vertical: screenHeightPercentage(context, percentage: 0.01),
          ),
          children: <Widget>[
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/profilenew'),
              // enableFeedback: true,excludeFromSemantics: true,
              splashColor: Colors.black12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  // alignment: Alignment.center,
                  height: screenHeightPercentage(context, percentage: 0.1875),
                  // color: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(
                      0, screenWidthPercentage(context, percentage: 0.1), 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        // backgroundImage: NetworkImage(UserPreferences.myUser.imagePath),
                        child: Image.network(
                          // 'https://pbs.twimg.com/media/FHfttxDWQAAJQNK?format=jpg&name=large',
                          UserPreferences.loggedInUser.imagePath ?? placeholderSmall,
                          // semanticLabel: 'Profile Picture',
                          height: screenHeightPercentage(context,
                                  percentage: 0.25) /
                              screenWidthPercentage(context, percentage: 0.1) *
                              20,
                          width: screenHeightPercentage(context,
                                  percentage: 0.25) /
                              screenWidthPercentage(context, percentage: 0.1) *
                              20,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${UserPreferences.loggedInUser.firstName} ${UserPreferences.loggedInUser.lastName}',
                            style: appBarTitleStyle.copyWith(
                                wordSpacing: -3, letterSpacing: -1.75),
                          ),
                          Text(
                            '${UserPreferences.loggedInUser.email}',
                            style: appBarTitleStyle.copyWith(
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: Colors.black87),
                    ],
                  ),
                ),
              ),
            ),
            SettingsGroup(
              title: 'USER',
              children: [
                verticalSpaceTiny,
                menuBuilder(
                  title: 'Profile',
                  iconData: Icons.person_outline,
                  navPath: () {
                    return Navigator.pushNamed(context, '/profilenew');

                    /*if(AuthService().isUserNull() == null){

                    }else{
                      return Navigator.pushNamed(context, '/profilenew');
                    }*/
                  },
                  color: const Color(0xb268bce2),
                ),
                menuBuilder(
                  title: 'Favourites',
                  iconData: Icons.favorite_border,
                  navPath: () => Navigator.pushNamed(context, '/cart'),
                  color: const Color(0xffff5871),
                ),
// buildDivider(context),0xb26ccb79//0x9a6882e2//0xb268bce2//0xdae26872//0x6310287b
                menuBuilder(
                  title: 'Shopping Cart',
                  iconData: Icons.shopping_cart_outlined,
                  navPath: () => Navigator.pushNamed(context, '/home'),
                  color: const Color(0xb26ccb79),
                ),
                menuBuilder(
                  title: 'Chat',
                  iconData: Icons.chat_bubble_outline,
                  navPath: () => Navigator.pushNamed(context, '/chat'),
                  color: const Color(0xb26c8fcb),
                ),
// buildDivider(context),0xb2e26893
              ],
            ),
            SettingsGroup(
              title: 'SETTINGS',
              children: <Widget>[
                verticalSpaceTiny,
                menuBuilder(
                  title: 'Settings',
                  iconData: Icons.settings_rounded,
                  navPath: () => Navigator.pushNamed(context, '/settings'),
                  color: const Color(0x9a68a9e2),
                ),
// buildDivider(context),0xcde2ab68
                menuBuilder(
                  title: 'Send Feedback',
                  iconData: Icons.feedback_outlined,
                  navPath: () => Navigator.pushReplacementNamed(context, '/'),
                  color: const Color(0xdadee268),
                ), //
                menuBuilder(
                  title: 'Report A Bug',
                  iconData: Icons.bug_report_outlined,
                  navPath: () => Navigator.pushNamed(context, '/'),
                  color: const Color(0x749b68e2),
                ),
                menuBuilder(
                  title: 'Logout',
                  iconData: Icons.logout,
                  navPath: () async {
                    if(_auth.currentUser != null){
                      print('_auth.currentUser != null');
                      await _auth.signOut();
                    }
                    Navigator.pushReplacementNamed(context, '/') ;
                  },
                  color: const Color(0xdae26872),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuBuilder({required String title,required IconData iconData,required Function() navPath,required Color color}) {
    return SizedBox(
      height: 68,
      width: double.infinity,
      // color: Colors.transparent,
      // decoration: BoxDecoration(color: Colors.transparent),
      child: SimpleSettingsTile(
        title: title,
        enabled: true,
        leading: iconWidget(iconData, color),
        onTap: navPath,
        subtitle: '',
/*        child: SettingsScreen(
          children: [],
        ),
        child: Container(
          height: 25,
          width: 50,
          child: Text('âsfasf',style: TextStyle(color: Colors.blueAccent),),
          color: Colors.amberAccent,
          // decoration: BoxDecoration(color: Colors.black),
        ),*/
      ),
    );
  }

  Container iconWidget(IconData iconData, Color color) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        size: 24,
        color: Colors.black,
      ),
    );
  }

  Divider buildDivider(BuildContext context) {
    return Divider(
      height: screenHeightPercentage(context, percentage: 0.025),
      color: const Color(0xFF0E2B4E),
      thickness: 1,
      indent: screenWidthPercentage(context, percentage: 0.1),
      endIndent: screenWidthPercentage(context, percentage: 0.1),
    );
  }

  buildDialog(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      builder: (context) => buildAlertDialog(context),
      barrierDismissible: false,
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
}
/*InkWell(
              splashColor: Colors.white70,
              onTap: () => Navigator.pushNamed(context, '/profile'),
              child: Container(
                // color: Colors.white70,
                height: screenHeightPercentage(context, percentage: 0.125),
                width: screenWidthPercentage(context, percentage: 0.9),
                alignment: Alignment.bottomCenter,
                // padding: const EdgeInsets.fromLTRB(25, 25, 0, 0),
                child: Material(
                  // color: Colors.white10,
                  borderRadius: BorderRadius.circular(100),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
/*                  child: SimpleSettingsTile(
                    title: '${UserPreferences.myUser.firstName} ${UserPreferences.myUser.lastName}',
                    subtitle: '${UserPreferences.myUser.email}',
                    leading: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 55,
                      backgroundImage: NetworkImage(
                          'https://pbs.twimg.com/media/FJFssbhWQAAB32g?format=jpg&name=large'),
                      *//*child: InkWell(
                        // splashColor: Colors.blue,
                        // borderRadius: BorderRadius.circular(275),
                        onTap: () => Navigator.pushNamed(context, '/'),
                      ),*//*

                    ),
                    onTap: () => Navigator.pushNamed(context, '/profile'),
                    enabled: true,
                    child: const Profile(),
                  ),*/
                  /*child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 55,
                        backgroundImage: const NetworkImage(
                            'https://pbs.twimg.com/media/FJFssbhWQAAB32g?format=jpg&name=large'),
                        child: InkWell(
                          // splashColor: Colors.blue,
                          // borderRadius: BorderRadius.circular(275),
                          onTap: () => Navigator.pushNamed(context, '/profile'),
                        ),

                      ),

                      horizontalSpaceMedium,
                      RichText(
                        text: TextSpan(
                          text: '${UserPreferences.myUser.firstName} ${UserPreferences.myUser.lastName}\n\n' +
                              '${UserPreferences.myUser.email}',
                          style: const TextStyle(
                            height: 0.75,
                            color: Colors.black,
                            backgroundColor: Colors.transparent,
                            fontSize: 18,
                            wordSpacing: -1,
                            letterSpacing: -1,
                            fontWeight: FontWeight.w600,
                            // height: 100,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(context, '/profile'),
                        ),
                      ),
                    ],
                  ),*/
                  child: ListTile(
                    title: Text('${UserPreferences.myUser.firstName} ${UserPreferences.myUser.lastName}'),
                    subtitle: Text('${UserPreferences.myUser.email}'),
                    leading:  Container(
                      height: 200,
                      width: 200,
                      child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 55,
                        backgroundImage: NetworkImage(
                            'https://pbs.twimg.com/media/FJFssbhWQAAB32g?format=jpg&name=large'),
                        /*child: InkWell(radius: 100,
                          splashColor: Colors.black12,
                          borderRadius: BorderRadius.circular(50),
                          onTap: () => Navigator.pushNamed(context, '/profile'),
                        ),*/

                      ),
                    ),
                    enabled: true,
                    onTap: () => Navigator.pushNamed(context, '/profile'),
                    // textColor: Colors.amber,
                    tileColor: Colors.transparent,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    // contentPadding: EdgeInsets.all(5),
                    contentPadding: EdgeInsets.only(right: 30),
                    minLeadingWidth: 0,
                    horizontalTitleGap: 0,
                    shape: ,

                  ),
                ),
              ),
            ),*/

/*        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 60.0,
            offset: Offset(0, 2),
          ),
        ],*/
/*Container(
// margin: EdgeInsets.all(10),
// padding: EdgeInsets.all(25),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 10, left: 25),

              height: screenHeightPercentage(context, percentage: 0.2),
              width: screenWidthPercentage(context, percentage: 0.75),

              decoration: const BoxDecoration(
                // color: Color(0xffbebebe),
                color: Colors.white,
              ),

              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/profile'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
/*                  SizedBox(
                          width: 275,
                          height: 125,
                          child: SimpleSettingsTile(
                            title: '',
                            subtitle: '',
                            child: Container(
                              width: 150,
                              height: 150,
                              child: Column(

                              ),
                            ),
                          ),

                          SimpleSettingsTile(
                            title: '${UserPreferences.myUser.firstName} ${UserPreferences.myUser.lastName}',
                            subtitle: '${UserPreferences.myUser.phoneNumber}',
                            enabled: true,
                            onTap: () => Navigator.pushNamed(context, '/profile'),

                            leading: InkWell(
                              // onTap: ()=> Navigator.pushNamed(context,'/profile'),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  'https://pbs.twimg.com/media/FJFssbhWQAAB32g?format=jpg&name=large',
                                  scale: 1,
                                  alignment: Alignment.bottomCenter,
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                  // width: double.maxFinite,
                                  // height: double.maxFinite,
                                ),
                              ),
                            ),
                          ),
                        ),*/
/*                      TextButton(
                              style: ButtonStyle(elevation: MaterialStateProperty.),
                              onPressed: () => Navigator.pushNamed(context, '/profile'),
                              child: ,
                            ),
                            Text(
                              '${UserPreferences.myUser.firstName} ${UserPreferences.myUser.lastName}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),*/
                        TextButton.icon(
                          onPressed: () => Navigator.pushNamed(context, '/'),
                          icon: ClipRRect(borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                            'https://pbs.twimg.com/media/FJFssbhWQAAB32g?format=jpg&name=large',
                            fit: BoxFit.fitHeight,
                            height: 75,
                            width: 75,
                          ),),
                          label: Text(
                            '${UserPreferences.myUser.firstName} ${UserPreferences.myUser.lastName}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                letterSpacing: -1,
                                wordSpacing: -2,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              /*Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
// onTap: ()=> Navigator.pushNamed(context,'/profile'),
                    child: CircleAvatar(
                        // radius: 90.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            'https://pbs.twimg.com/media/FJFssbhWQAAB32g?format=jpg&name=large',
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                            height: double.maxFinite,
                          ),
                        ),
                        radius: 55,
// backgroundColor: Color(0xFF778899),
                        backgroundImage:
                            const NetworkImage('https://pbs.twimg.com/media/FHfttxDWQAAJQNK?format=jpg&name=large')
// NetworkImage('https://pbs.twimg.com/media/FIP5cJrWYAEyhAy?format=jpg&name=large'),
                        ),
                  ),
                ],
              ),*/
// color: Colors.indigo[200],
            ),*/
/*                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          'https://pbs.twimg.com/media/FJFssbhWQAAB32g?format=jpg&name=large',
                          scale: 1,
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                          loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                              ? child
                              : const CircularProgressIndicator(
                                  color: Colors.black,
                                  backgroundColor: Colors.transparent,
                                ),

                          // width: double.maxFinite,
                          // height: double.maxFinite,
                        ),
                      ),*/

/*                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/profile'),
                        child: Text(
                          '${UserPreferences.myUser.firstName} ${UserPreferences.myUser.lastName}',
                          style: const TextStyle(
                            color: Colors.black,
                            backgroundColor: Colors.black,
                            fontSize: 20,
                            wordSpacing: -2,
                            letterSpacing: -1,
                            fontWeight: FontWeight.w600,
                            height: 100,
                          ),
                        ),
                        style: TextButton.styleFrom(elevation: 0),
                      ),*/
/*                        child: Ink.image(
                          image: const NetworkImage(
                            'https://pbs.twimg.com/media/FJFssbhWQAAB32g?format=jpg&name=large',
                          ),
                          height: 85,
                          width: 85,
                          fit: BoxFit.contain,

                        ),*/
/*                      Container(
                        color: Colors.transparent,
                        width: 100,
                        height: 100,
                        child: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 55,
                          backgroundImage: NetworkImage(
                              'https://pbs.twimg.com/media/FJFssbhWQAAB32g?format=jpg&name=large'),
*/
/*                          child: InkWell(
                            // splashColor: Colors.blue,
                            // borderRadius: BorderRadius.circular(275),
                            onTap: () => Navigator.pushNamed(context, '/profile'),
                          ),*/
/*
                        ),
                      ),*/
