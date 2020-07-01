import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  static final route = "about app";
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("حول التطبيق"),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: AboutDialog(
            applicationIcon: Icon(Icons.mobile_screen_share),
            applicationLegalese: "hello",
            applicationName: "mobile shop",
            applicationVersion: "verion:1.0",
            children: <Widget>[
              Text("hello everyone i'm very happy to open my app")
            ],
          ),
        ),
      ),
    );
  }
}
