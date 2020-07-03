import 'package:flutter/material.dart';
import 'package:mobile_shop/component/general_code.dart';
import 'package:mobile_shop/component/main_drawer.dart';
import 'package:mobile_shop/screens/home.dart';

class Departments extends StatelessWidget {
  static final route = "departments";
  @override
  Widget build(BuildContext context) {
    final Home home = Home();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("الأقسام"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
        drawer: MainDrawer(),
        body: Container(
          color: Colors.amberAccent[100],
          child: home.departmentsElements(
            context,
            1.0,
            0.0,
            MyBrands.brands,
          ),
        ),
      ),
    );
  }
}
