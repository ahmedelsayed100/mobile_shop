import 'package:flutter/material.dart';
import 'package:mobile_shop/login/login.dart';
import 'package:mobile_shop/screens/about.dart';
import 'package:mobile_shop/screens/contacts.dart';
import 'package:mobile_shop/screens/departments.dart';
import 'package:mobile_shop/screens/home.dart';
import 'package:mobile_shop/posts/post.dart';
import 'package:mobile_shop/screens/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {
  static final route = "main drawer";
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool islogin = false;
  String username;
  String email;
  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username");
    email = prefs.getString("email");
    setState(() {
      if (username != null) {
        username = prefs.getString("username");
        email = prefs.getString("email");
        islogin = true;
      }
    });
  }

  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontFamily: 'Cairo',
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        elevation: 3,
        child: ListView(
          children: <Widget>[
            acountInformation(username, email, "assets/images/p2.jpg"),
            listTilIitem("الرئيسية", Icons.home, Home.route),
            listTilIitem("الأقسام", Icons.category, Departments.route),
            islogin
                ? listTilIitem(
                    "إضافة منشور", Icons.add_circle_outline, Post.route)
                : SizedBox(),
            Divider(
              color: Colors.red,
              height: 1,
            ),
            listTilIitem("الإعدادات", Icons.settings, Setting.route),
            listTilIitem("التواصل", Icons.call, Contacts.route),
            listTilIitem("حول", Icons.info, AboutApp.route),
            islogin
                ? listTilIitem("تسجيل الخروج", Icons.exit_to_app, Home.route)
                : listTilIitem("تسجيل الدخول", Icons.exit_to_app, Login.route),
          ],
        ),
      ),
    );
  }

//the start of the acount inf inside UserAccountsDrawerHeader
  Widget acountInformation(String userName, String email, String imgUrl) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        !islogin ? "" : userName,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      accountEmail: Text(
        !islogin ? "" : email,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      currentAccountPicture: CircleAvatar(
        child: Icon(Icons.person),
        backgroundImage: ExactAssetImage(imgUrl),
        backgroundColor: Colors.yellow,
      ),
      decoration: BoxDecoration(
        // color: Colors.yellow,
        image: DecorationImage(
          image: AssetImage(
            "assets/images/ground.jpg",
          ),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(Colors.indigo, BlendMode.multiply),
        ),
      ),
      // arrowColor: Colors.amber[500],
    );
  }

//the end of the account inf function

//this is the listtile for make the drawer elements to navigate to it
  Widget listTilIitem(String title, IconData icon, String distination) {
    return ListTile(
      // contentPadding: const EdgeInsets.all(1),
      title: Text(
        title,
        style: _textStyle,
      ),
      leading: Icon(
        icon,
        size: 26,
        color: Colors.blue,
      ),
      onTap: () async {
        if (!islogin) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("username");
          prefs.remove('email');

          await Navigator.of(context).pushNamed(distination);
        } else {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(distination);
        }
      },
    );
  }
  //the end of the list tile
}
