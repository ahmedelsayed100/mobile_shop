import 'package:flutter/material.dart';

import 'package:mobile_shop/brands/page_details.dart';
import 'package:mobile_shop/component/general_code.dart';

import 'package:mobile_shop/component/main_drawer.dart';
import 'package:mobile_shop/screens/home.dart';

class Departments extends StatelessWidget {
  static final route = "departments";
  final Home home = Home();
  final MyBrands brands = MyBrands();
  @override
  Widget build(BuildContext context) {
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
          color: Colors.grey[300],
          child: brands.departmentsElements(
              context, 1.0, 0.0, MyBrands.brands, Samsung.route),
        ),
      ),
    );
  }
}
