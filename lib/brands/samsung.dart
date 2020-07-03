import 'package:flutter/material.dart';

class Samsung extends StatelessWidget {
  static final route = "samsung";
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("سامسونج"),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
