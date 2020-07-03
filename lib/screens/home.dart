import 'package:flutter/material.dart';
import 'package:mobile_shop/component/general_code.dart';
import 'package:mobile_shop/component/main_drawer.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:mobile_shop/screens/about.dart';
// import 'package:mobile_shop/screens/about.dart';

class Home extends StatelessWidget {
  static final route = "home";
  // MyBrand myBrand = MyBrand();

  final List<String> images = [
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
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mobile Store"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: Container(
          color: Colors.grey.withOpacity(0.2),
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            // scrollDirection: Axis.vertical,
            children: <Widget>[
              //calling caruosl image viwer
              carousleImageViwer(context),
              //calling the department title
              departmentsTitle("الأقسام"),
              //calling departments types images
              categoryTypes(context),
              //calling the Last products
              departmentsTitle("أخر المنتجات"),
              //calling departments elements
              departmentsElements(
                context,
                0.6,
                0.2,
                MyBrands.brands,
              ),
            ],
          ),
        ),
      ),
    );
  }

//the start of the casuosle image viewr widget element(1)
  Widget carousleImageViwer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.24,
      width: double.infinity,
      child: Carousel(
        boxFit: BoxFit.fill,
        borderRadius: true,
        animationCurve: Curves.bounceOut,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 8.0,
        overlayShadowColors: Colors.blueAccent.withOpacity(1),
        dotIncreasedColor: Colors.yellow,
        dotBgColor: Colors.black.withOpacity(0.3),
        dotPosition: DotPosition.bottomCenter,
        overlayShadowSize: 10,
        overlayShadow: true,
        dotVerticalPadding: 6.0,
        dotIncreaseSize: 2.5,
        showIndicator: true,
        indicatorBgPadding: 7.0,
        images: [
          Image.asset(
            "assets/images/p1.jpg",
            fit: BoxFit.cover,
          ),
          Image.asset(
            "assets/images/p2.jpg",
            fit: BoxFit.cover,
          ),
          Image.asset(
            "assets/images/p3.jpg",
            fit: BoxFit.cover,
          ),
          Image.asset(
            "assets/images/p4.jpg",
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  // the end of the caruosle function
  // the start of the departments title element(2)
  Widget departmentsTitle(String title) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 25,
          color: Colors.blue,
        ),
      ),
    );
  }

  //the end of the category title
//the start of the category type function
  Widget categoryTypes(BuildContext context) {
    return Container(
      // width: 50,
      height: MediaQuery.of(context).size.height * 0.124,
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, position) {
          return Container(
            margin: EdgeInsets.all(5),
            // color: Colors.red,
            // width: 120,
            width: MediaQuery.of(context).size.width * 0.2,

            // height: 100,
            child: Container(
              // alignment: Alignment.center,
              padding: EdgeInsets.all(10),

              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * 0.2),
              ),
              child: ListTile(
                isThreeLine: true,
                title: Image.asset(
                  "assets/images/cat.png",
                  // width: 70,
                  // width: MediaQuery.of(context).size.width * 0.52,

                  fit: BoxFit.cover,
                  // height: 70,
                  height: MediaQuery.of(context).size.height * 0.062,
                ),
                subtitle: Container(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    "samsung",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
  //the end of the catgeory types function

  // tht start of the departmet elements(3)
  Widget departmentsElements(BuildContext context, double height1,
      double paddingHeight, List<String> brand) {
    return Container(
      height: MediaQuery.of(context).size.height * height1,
      // height: double.infinity,
      padding: const EdgeInsets.all(8),
      // margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.4),
      // margin: const EdgeInsets.all(8),
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
              // width: MediaQuery.of(context).size.width * 0.2,
              // height: 150,
              child: Card(
                elevation: 2,
                child: GridTile(
                  footer: Container(
                    height: MediaQuery.of(context).size.height * 0.045,
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
                      Navigator.of(context).pushNamed(AboutApp.route);
                    },
                  ),
                ),
                // color: Colors.transparent,
              ),
            );
          }),
    );
  }
  //the end of category element fucntion
}
