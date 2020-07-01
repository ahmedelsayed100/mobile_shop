import 'package:flutter/material.dart';
import 'package:mobile_shop/screens/about.dart';
import 'package:mobile_shop/screens/contacts.dart';
import 'package:mobile_shop/screens/departments.dart';
import 'package:mobile_shop/screens/home.dart';
import 'package:mobile_shop/screens/settings.dart';

class MainDrawer extends StatefulWidget {
  static final route = "main drawer";
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final TextStyle _textStyle = TextStyle(
    fontSize: 20,
    color: Colors.blue,
    fontFamily: 'Cairo',
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        elevation: 3,
        child: ListView(
          children: <Widget>[
            acountInformation("Ahmed Elsayed", "ahmedfci5502gmail.com",
                "assets/images/flower.jpg"),
            listTilIitem("الرئيسية", Icons.home, Home.route),
            listTilIitem("الأقسام", Icons.category, Departments.route),
            Divider(
              color: Colors.red,
              height: 5,
            ),
            listTilIitem("الإعدادات", Icons.settings, Setting.route),
            listTilIitem("التواصل", Icons.call, Contacts.route),
            listTilIitem("حول", Icons.info, AboutApp.route),
            listTilIitem("تسجيل الخروج", Icons.exit_to_app, ""),
          ],
        ),
      ),
    );
  }

//the start of the acount inf inside UserAccountsDrawerHeader
  Widget acountInformation(String userName, String email, String imgUrl) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        userName,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      accountEmail: Text(
        email,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      currentAccountPicture: CircleAvatar(
        child: Icon(Icons.person),
      ),
      decoration: BoxDecoration(
        color: Colors.yellow,
        image: DecorationImage(
          image: AssetImage(
            imgUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
      // arrowColor: Colors.amber[500],
    );
  }

//the end of the account inf function

//this is the listtile for make the drawer elements to navigate to it
  Widget listTilIitem(String title, IconData icon, String distination) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      title: Text(
        title,
        style: _textStyle,
      ),
      trailing: Icon(
        icon,
        size: 30,
        color: Colors.blue,
      ),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(distination);
      },
    );
  }
  //the end of the list tile
}
