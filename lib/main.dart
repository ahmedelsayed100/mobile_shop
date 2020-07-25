import 'package:flutter/material.dart';
import 'package:mobile_shop/brands/page_details.dart';
import 'package:mobile_shop/component/main_drawer.dart';
import 'package:mobile_shop/login/login.dart';
import 'package:mobile_shop/posts/comments.dart';
import 'package:mobile_shop/screens/about.dart';
import 'package:mobile_shop/screens/contacts.dart';
import 'package:mobile_shop/screens/departments.dart';
import 'package:mobile_shop/screens/home.dart';
import 'package:mobile_shop/posts/post.dart';
import 'package:mobile_shop/screens/settings.dart';

import 'component/country.dart';

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
      home: Country(),
      // initialRoute: Home.route,
      routes: {
        Home.route: (context) => Home(),
        MainDrawer.route: (context) => MainDrawer(),
        Departments.route: (context) => Departments(),
        AboutApp.route: (context) => AboutApp(),
        Setting.route: (context) => Setting(),
        Contacts.route: (context) => Contacts(),
        Samsung.route: (context) => Samsung(),
        Login.route: (ctx) => Login(),
        Post.route: (ctx) => Post(),
        Comments.route: (ctx) => Comments(),
      },
    );
  }
}
