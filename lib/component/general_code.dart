import 'package:flutter/material.dart';
import 'package:mobile_shop/brands/page_details.dart';

class MyBrands {
  static List<String> brands = [
    "samsung",
    "huwawi",
    "iphone",
    "oppo",
    "xioma",
    "infinx",
    "tecno",
    "lenovo",
    "real me",
    "oppo",
    "xioma",
    "infinx",
  ];
  static List<String> images = [
    "assets/images/p1.jpg",
    "assets/images/p2.jpg",
    "assets/images/p3.jpg",
    "assets/images/p4.jpg",
    "assets/images/p1.jpg",
    "assets/images/p2.jpg",
    "assets/images/p3.jpg",
    "assets/images/p4.jpg",
    "assets/images/p1.jpg",
    "assets/images/p2.jpg",
    "assets/images/p3.jpg",
    "assets/images/p4.jpg",
  ];
  Widget departmentsElements(BuildContext context, double height1,
      double paddingHeight, List<String> brand, String destination) {
    return Container(
      height: MediaQuery.of(context).size.height * height1,
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
          itemCount: 12,
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * paddingHeight),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20 / 2,
            childAspectRatio: 2 / 2,
          ),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, position) {
            return Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Card(
                elevation: 2,
                child: GridTile(
                  footer: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.5),
                    child: Text(
                      "${brand[position]}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  child: InkWell(
                    child: Image.asset(
                      images[position],
                      fit: BoxFit.contain,
                    ),
                    onTap: () {
                      // Navigator.of(context).pop(brand[position]);
                      // Navigator.of(context).pushNamed(
                      //   destination,
                      // );

                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => Samsung(
                                  pageName: brand[position],
                                )),
                      );
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}
