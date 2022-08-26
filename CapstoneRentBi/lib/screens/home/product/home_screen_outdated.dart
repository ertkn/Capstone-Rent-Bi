import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/widgets/custom_circular_indicator.dart';
import 'package:capstone_rent_bi/widgets/navigationDrawer.dart';
import 'package:flutter/material.dart';

class HomeScreenOutdated extends StatefulWidget {
  const HomeScreenOutdated({Key? key}) : super(key: key);

  @override
  _HomeScreenOutdatedState createState() => _HomeScreenOutdatedState();
}

class _HomeScreenOutdatedState extends State<HomeScreenOutdated> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),

      // extendBodyBehindAppBar: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFB6CFEC),
                      Color(0xFF8BAACE),
                      Color(0xFF6788AC),
                      Color(0xFF37485C),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                color: const Color(0x60225e65),
                // color: const Color(0xff959393),

                height: 67.5,
                width: MediaQuery.of(context).size.width,
/*              padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 45,
                ),*/
                child: Wrap(
                  // crossAxisAlignment: WrapCrossAlignment.end,
                  // alignment: WrapAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // _buildBackButton(),
                    _buildSearchTab(),
                    _buildProfileIcon(),
                  ],
                ),
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchTab() {
    return Container(
      // color: Colors.indigoAccent,
      height: 38,
      width: MediaQuery.of(context).size.width * 0.8175,
      margin: const EdgeInsets.fromLTRB(0, 19.25, 0, 0),
      // decoration: kBoxDecorationStyle,
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: TextField(
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.bottom,
        // controller: controller,
        decoration: InputDecoration(
          // fillColor: Colors.indigoAccent,
          // filled: true,
          isDense: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(7.5),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular((7.5))),
            borderSide: BorderSide(color: Colors.black45, width: 1),
          ),
          // border:UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
          // disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 10, color: Colors.transparent)),
          icon: _buildBackButton(),
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
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      color: Colors.purple,
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black54,
      ),
      constraints: const BoxConstraints(minHeight: 0.0, minWidth: 0.0),
      tooltip: 'go back',
      onPressed: () => Navigator.pop(context),
    );
  }
/*  Widget _buildProfileIcon() {
    return Container(
      color: Colors.deepPurpleAccent,
      width: screenWidthPercentage(context,percentage: 0.15),
      // height: 67.5,
      height: screenHeightPercentage(context,percentage: 0.06),
      // color: Colors.black26,
      // padding: EdgeInsets.fromLTRB(7.5, 7.5, 2.5, 0),
      margin: const EdgeInsets.fromLTRB(5, 15, 0, 5),
      child: IconButton(
        // onPressed: () => print('pfp icon'),
        // onPressed: () => Navigator.pop(context),
        onPressed: () => Navigator.pushNamed(context, '/profile'),
        icon: Image.network(
          // 'https://pbs.twimg.com/media/FHfttxDWQAAJQNK?format=jpg&name=large',
          UserPreferences.myUser.imagePath,
          fit: BoxFit.fitHeight,
          loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
              ? child
              : const CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.transparent,
                ),
        ),
      ),
    );
  }*/
  Widget _buildProfileIcon() {
    return Container(
/*      width: 60,
      height: 45,*/
      width: screenWidthPercentage(context,percentage: 0.15),
      // height: 67.5,
      height: screenHeightPercentage(context,percentage: 0.06),
      // height: 67.5,
      color: Colors.deepPurpleAccent,
      // padding: EdgeInsets.fromLTRB(7.5, 7.5, 2.5, 0),
      alignment: Alignment.topRight,
      // margin: const EdgeInsets.fromLTRB(5, 15, 0, 5),
      child: IconButton(
        color: Colors.blue,
        iconSize: screenWidthPercentage(context, percentage: 0.05),
        // onPressed: () => print('pfp icon'),
        // onPressed: () => Navigator.pop(context),
        onPressed: () => Navigator.pushNamed(context, '/profile'),
        icon: Image.network(
          'https://pbs.twimg.com/media/FHfttxDWQAAJQNK?format=jpg&name=large',
          fit: BoxFit.fitHeight,
          loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
              ? child
              : CustomCircularIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.transparent,
                ),
        ),
      ),
    );
  }
}

/*Widget _buildSocialBtn(Function _onTap, AssetImage logo) {
  return GestureDetector(
    onTap: () => _onTap,
    child: Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2.5),
            blurRadius: 5.0,
          ),
        ],
        image: DecorationImage(
          image: logo,
        ),
      ),
    ),
  );
}*/

/*Widget _buildSearchRow() {
    return Container(
      height: 42.5,
      width: 340,
      margin: const EdgeInsets.fromLTRB(2.25, 35, 0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      // decoration: kBoxDecorationStyle,
      padding: const EdgeInsets.symmetric(horizontal: 7.5),
      child: TextField(
        // textAlign: TextAlign.start,
        // controller: controller,
        decoration: InputDecoration(
          // border: OutlineInputBorder(),
          // border:UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
          // disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 10, color: Colors.transparent)),
          icon: GestureDetector(
            child: IconButton(
              icon: const Icon(Icons.search,),
              color: Colors.black45,
              onPressed: () => print('searched'),
              tooltip: 'search',
            ),
          ),
          suffixIcon: GestureDetector(
            child: IconButton(
              onPressed: () => print('closed'),
              icon: const Icon(Icons.close),
              tooltip: 'delete',
              color: Colors.black26,
            ),
            // onTap: () => FocusScope.of(context).unfocus(),
          ),
          // hintText: 'Marka, ürün, üye, #etiket ara',
          hintText: 'RentBi\'de Ara',
          hintStyle: TextStyle(
            fontFamily: 'OpenSans',
          ),
          // border: OutlineInputBorder(),
        ),
      ),
    );
  }
}*/

/*          enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.red, width: 10.0)),*/
/*            borderSide: BorderSide(
              color: Colors.tealAccent,
              width: 100.0,
              style: BorderStyle.values.,
            ),*/
/*                    const TextField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    )*/

/*child: Text(
                  'Home Screen',
                  style: TextStyle(
                    color: Color(0xFF6C6969),
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                ),
              ),*/
/*      appBar: AppBar(
        actions: [
          // _buildSearchRow(),
        ],
      ),*/
/*
      appBar: AppBar(
        //actions: [_buildSocialBtnRow()],
        // centerTitle: true,
        //title: const Text('RentBi',style: TextStyle(color: Color(0xBE385C89)),),
        actions: <Widget>[
          child: Row(
            children: [
              _buildSocialBtnRow()
            ],
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xBE385C89),
        foregroundColor: Color(0xBE010A17),
        backgroundColor: Color(0xfff5f5f5),
        elevation: 0.75,
      ),
*/
/*child: FittedBox(
        fit: BoxFit.contain,
        child: Row(
          children: const [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png'),
              backgroundColor: Colors.transparent,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      // borderRadius: 10,
                      )),
            ),
          ],
        ),
      ),*/
/*return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          */ /*_buildSocialBtn(
                () => print('Login with Facebook'),
            const AssetImage(
              'assets/google.jpg',
            ),
          ),*/ /*
          FittedBox(
            fit: BoxFit.none,
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: TextField(
              decoration: InputDecoration(
                 border: OutlineInputBorder(
                  // borderRadius: 10,
                )
              ),

            ),
          )
        ],
      ),
    );*/

/*      decoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        // border: BoxBorder(CircleBorder(side: BorderSide(width: 10))),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2.5),
            blurRadius: 5.0,
          ),
        ],
        image: DecorationImage(
          image: AssetImage(
            'assets/anato_finnstark.jpg',
          ),
        ),
      ),*/

/*      child: CircleAvatar(
        radius: 22.5,
        child: IconButton(
          onPressed: ()=> print('pfp'), icon: ImageIcon(image: ),
        ),
      ),*/
/*child: CircleAvatar(
        // radius: (50),
        backgroundColor: Colors.transparent,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image.asset('assets/facebook.jpg'),
            )
            // Image.asset('assets/fb.JPG'),
            ),
      ),*/
/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _updateAppbar();
    super.initState();
  }

  void _updateAppbar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RaisedButton(
            child: Text('Navigate to second screen'),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) => SecondScreen()))
                .whenComplete(() => Future.delayed(Duration(milliseconds: 500)).then((_) => _updateAppbar()))));
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
*/
