import 'package:flutter/material.dart';

class Departments extends StatelessWidget {
  static final route = "departments";
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("الأقسام"),
          centerTitle: true,
        ),
        body: Container(
          child: Text("i'm department of app"),
        ),
      ),
    );
  }
}
