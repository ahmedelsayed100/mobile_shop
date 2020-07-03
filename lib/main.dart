import 'package:flutter/material.dart';
import 'package:mobile_shop/brands/samsung.dart';
import 'package:mobile_shop/component/main_drawer.dart';
import 'package:mobile_shop/screens/about.dart';
import 'package:mobile_shop/screens/contacts.dart';
import 'package:mobile_shop/screens/departments.dart';
import 'package:mobile_shop/screens/home.dart';
import 'package:mobile_shop/screens/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Cairo"),
      title: "Mobile Store",
      initialRoute: Home.route,
      routes: {
        Home.route: (context) => Home(),
        MainDrawer.route: (context) => MainDrawer(),
        Departments.route: (context) => Departments(),
        AboutApp.route: (context) => AboutApp(),
        Setting.route: (context) => Setting(),
        Contacts.route: (context) => Contacts(),
        Samsung.route: (context) => Samsung(),
      },
    );
  }
}
