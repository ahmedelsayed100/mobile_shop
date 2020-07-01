import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  static final route = "settings";
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(" الإعدادات"),
          centerTitle: true,
        ),
        body: Container(
          child: Text("i'm setting app"),
        ),
      ),
    );
  }
}
