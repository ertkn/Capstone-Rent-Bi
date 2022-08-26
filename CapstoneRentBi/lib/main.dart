import 'package:capstone_rent_bi/models/user.dart';
import 'package:capstone_rent_bi/screens/chatpages/chatpage_view.dart';
import 'package:capstone_rent_bi/screens/home/product_add_screen/product_add_screen.dart';
import 'package:capstone_rent_bi/screens/home/user_settings/profile/profilenew.dart';
import 'package:capstone_rent_bi/screens/wrapper/wrapper.dart';
import 'package:capstone_rent_bi/services/auth.dart';
import 'package:capstone_rent_bi/services/user_service.dart';
import 'package:capstone_rent_bi/utilities/theme.dart';
import 'package:capstone_rent_bi/utilities/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/home/product/home_screen.dart';
import 'screens/home/user_settings/profile/profile.dart';
import 'screens/home/user_settings/user_settings_screen.dart';
import 'screens/settings/settings.dart';
import 'screens/authentication/sign_in/sign_in_screen.dart';
import 'screens/authentication/sign_up/sign_up_screen.dart';
import 'screens/authentication/sign_up_post/sign_up_post.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());


  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      // UserModel.fromJson();
      print('User is currently signed out!');
    } else {
      if(user.isAnonymous == false){
        UserService().getUserCredential().forEach((element) {element.data()?.forEach((key, value) {UserPreferences.loggedInUser = userModelFromJson(value);});});
        // print('User is signed in! ${FirebaseAuth.instance.currentUser}');
        print('User is signed in!');
      }else{
        print('User is currently anonymous!');
      }
    }
  });

  // runApp(ExpansionTileSample());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Renting App',
      debugShowCheckedModeBanner: false,
/*      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),*/
      //home: const MyHomePage(title: 'RentBi'),
      // home: LoginScreen(),
      theme: theme(),
      initialRoute: '/',
      routes: {
        '/' : (context) => const Wrapper(),
        '/login' : (context) => LoginScreen(),
        // '/home' : (context) => HomeScreen(),
        '/home' : (context) => const HomeScreen(),
        '/signup' : (context) => const SignupScreen(),
        '/userset' : (context) => const UserSettingsScreen(),
        '/profile' : (context) => const Profile(),
        '/profilenew' : (context) => const ProfileScreenNew(),
        '/setting' : (context) => const Settings(),
        '/signuppost' : (context) => SignUpPost(),
        '/cart': (context) => const ChatPageView(),
        '/productadd': (context) => const ProductAddScreen(),
        // '/login' : (contex) => LoginScreen(),
      },
      // home: SignupScreen(),
      // home: HomeScreen(),
    );
  }
}
/*

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Widget _sizedBox (double _height, double _width) => SizedBox(height: _height, width: _width);


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            _sizedBox(50, 0),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            _sizedBox(15,0),
            GestureDetector(
              onTap: _incrementCounter,
              child: Container(
                  color: const Color(0xff9575cd),
                  padding: const EdgeInsets.fromLTRB(30,15,30,15),
                  height: 50,
                  width: 145,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //padding: EdgeInsets.all(0),
                      children: <Widget>[
                        const Icon(Icons.email_rounded),
                        _sizedBox(0,10),
                        Text((_counter%2) > 0 ? 'ODD: ${_counter%2}' : 'EVEN: ${_counter%2}'),
                      ]
                  )
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: const Color(0xff9575cd),
        tooltip: 'Increment',
        child: const Icon(Icons.add),

      ),
    );
  }
}
*/
