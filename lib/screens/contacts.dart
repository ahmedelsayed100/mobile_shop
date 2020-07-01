import 'package:flutter/material.dart';

class Contacts extends StatelessWidget {
  static final route = "contacts";
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("وسائل التواصل"),
          centerTitle: true,
        ),
        body: Container(
          child: Text("i'm contacts app"),
        ),
      ),
    );
  }
}
