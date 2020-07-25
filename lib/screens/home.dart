import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_shop/brands/page_details.dart';
import 'package:mobile_shop/component/general_code.dart';
import 'package:mobile_shop/component/main_drawer.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:mobile_shop/component/search.dart';

class Home extends StatefulWidget {
  static final route = "home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static List<String> images = [
    "assets/images/brands/samsung.jpg",
    "assets/images/brands/huawei.jpg",
    "assets/images/brands/iphone.jpg",
    "assets/images/brands/oppo.jpg",
    "assets/images/brands/xioma.jpg",
    "assets/images/brands/realme.jpg",
    "assets/images/brands/samsung.jpg",
    "assets/images/brands/huawei.jpg",
    "assets/images/brands/iphone.jpg",
    "assets/images/brands/oppo.jpg",
    "assets/images/brands/xioma.jpg",
    "assets/images/brands/realme.jpg",
  ];

  final List<dynamic> mobileList = [];

  Future getData() async {
    var url = "http://10.0.2.2/mobtech/search.php";
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    for (int i = 0; i < data.length; i++) {
      mobileList.add(data[i]['name']);
    }
    // return data;
    print(mobileList);
  }

  @override
  void initState() {
    getData();
    // Departments(
    //   myWidget: departmentsElements(
    //       context, 1.0, 0.0, MyBrands.brands, Samsung.route),
    // );
    super.initState();
  }

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
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: DataSearch(dataList: mobileList));
              },
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: Container(
          color: Colors.grey.withOpacity(0.2),
          width: double.infinity,
          height: 800,
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
                  context, 0.6, 0.2, MyBrands.brands, Samsung.route),
            ],
          ),
        ),
      ),
    );
  }

  Widget carousleImageViwer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      width: double.infinity,
      child: Carousel(
        boxFit: BoxFit.cover,
        borderRadius: true,
        animationCurve: Curves.bounceOut,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 5.0,
        overlayShadowColors: Colors.blueAccent.withOpacity(1),
        dotIncreasedColor: Colors.yellowAccent,
        dotBgColor: Colors.black.withOpacity(0.3),
        dotPosition: DotPosition.bottomCenter,
        overlayShadowSize: 5,
        overlayShadow: true,
        dotVerticalPadding: 1.0,
        dotIncreaseSize: 2.5,
        showIndicator: true,
        indicatorBgPadding: 8.0,
        images: [
          Image.asset(
            MyBrands.newProducts[0],
            fit: BoxFit.cover,
          ),
          Image.asset(
            MyBrands.newProducts[1],
            fit: BoxFit.cover,
          ),
          Image.asset(
            MyBrands.newProducts[2],
            fit: BoxFit.cover,
          ),
          Image.asset(
            MyBrands.newProducts[3],
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  Widget departmentsTitle(String title) {
    return Container(
      padding: const EdgeInsets.all(8),
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

  Widget categoryTypes(BuildContext context) {
    return Container(
      // width: 50,
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.builder(
        itemCount: MyBrands.brands.length,
        itemBuilder: (context, position) {
          return Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.19,
            child: Container(
              // height: 100,
              margin: EdgeInsets.all(1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                    images[position],
                    height: MediaQuery.of(context).size.height * 0.085,
                    width: MediaQuery.of(context).size.width * 0.19,
                  ),
                  // maxRadius: 20,

                  InkWell(
                    child: Text("${MyBrands.brands[position]}"),
                  )
                ],
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget departmentsElements(BuildContext context, double height1,
      double paddingHeight, List<String> brand, String destination) {
    return Container(
      height: MediaQuery.of(context).size.height * height1,
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
          itemCount: MyBrands.newProducts.length,
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
                margin: EdgeInsets.all(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridTile(
                    child: InkWell(
                      child: Image.asset(
                        MyBrands.newProducts[position],
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
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
              ),
            );
          }),
    );
  }
}
