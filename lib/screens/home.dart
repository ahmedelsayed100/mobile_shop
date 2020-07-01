import 'package:flutter/material.dart';
import 'package:mobile_shop/component/main_drawer.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Home extends StatelessWidget {
  static final route = "home";

  final List<String> images = [
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
          title: Text("Mobile Store"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
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
              departmentsTitle(),
              Container(
                // width: 50,
                height: 160,
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, position) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      // color: Colors.red,
                      width: 130,
                      height: 100,
                      child: Container(
                        // alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(60)),
                        child: ListTile(
                          isThreeLine: true,
                          title: Image.asset(
                            "assets/images/cat.png",
                            width: 70,
                            fit: BoxFit.cover,
                            height: 70,
                          ),
                          subtitle: Container(
                            padding: EdgeInsets.only(top: 8),
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
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.1,
              //   width: double.infinity,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     // itemCount: 8,
              //     children: <Widget>[
              //       ListTile(
              //         title: Image.asset(
              //           images[0],
              //           width: 50,
              //           height: 50,
              //         ),
              //         subtitle: Container(
              //           child: Text("samsung"),
              //         ),
              //       ),
              // ],
              // itemBuilder: (context, position) {
              //   return ListTile(
              //     title: Image.asset(
              //       images[position],
              //       width: 50,
              //       height: 50,
              //     ),
              //     subtitle: Container(
              //       child: Text("samsung"),
              //     ),
              //   );
              // },

              //calling departments elements
              departmentsElements(context),
            ],
          ),
        ),
      ),
    );
  }

//the start of the casuosle image viewr widget element(1)
  Widget carousleImageViwer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
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
  // the start of the departments title
  Widget departmentsTitle() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Text(
        "الأقسام",
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 24,
          color: Colors.blue,
        ),
      ),
    );
  }

  //tht start of the departmet elements
  Widget departmentsElements(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(8),
      // margin: const EdgeInsets.all(8),
      child: GridView.builder(
          itemCount: 8,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20 / 2,
            childAspectRatio: 2 / 2,
          ),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, position) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 250,
              height: 150,
              child: Card(
                elevation: 4,
                child: GridTile(
                  footer: Container(
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.4),
                    child: Text("samsoung"),
                  ),
                  child: Image.asset(
                    images[position],
                    fit: BoxFit.contain,
                  ),
                ),
                // color: Colors.transparent,
              ),
            );
          }),
    );
  }
}
