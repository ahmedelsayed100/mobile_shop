// import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  final String name;
  final String cameraMain;
  final String cameraFeatures;
  final String cameraVideo;
  final String cpu;
  final String imgUrl;
  final String price;
  final String screen;
  final String screenProtection;
  final String screenResolution;
  final String system;
  final String memory;
  final String battery;
  final String storge;

  Details(
      {this.name,
      this.cameraMain,
      this.cameraFeatures,
      this.cameraVideo,
      this.cpu,
      this.imgUrl,
      this.price,
      this.screen,
      this.screenProtection,
      this.screenResolution,
      this.system,
      this.memory,
      this.battery,
      this.storge});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  /*
  *
  *
  */
//this function to get data from database
  Future getData() async {
    var url = "http://10.0.2.2/mobtech/index.php";
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }
//this function to get data from sharedprference

  String testCountry;
  var country;
  SharedPreferences prefs;
  getSelectedCountry() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      country = prefs.getString("country");
    });
    print(country);
  }

  checkCountry() {
    switch (country) {
      case 'مصر':
        return "${widget.price} جنية مصري";
        break;
      case 'السعودية':
        return "${widget.price} ريال سعودي";

        break;
      case 'سوريا':
        return "${widget.price} ليرة سورية";

        break;
      case 'الجزائر':
        return "${widget.price} فرنك جزائري";

        break;
      case 'الأردن':
        return "${widget.price} دينار أردني";

        break;
      case 'الإمارات':
        return "${widget.price} درهم إماراتي";

        break;
    }
    return "";
  }

  @override
  void initState() {
    getData();
    getSelectedCountry();
    // country = checkCountry();

    super.initState();
  }

  final color1 = Colors.blue;

  final color2 = Colors.white;

  final color3 = Colors.redAccent;

  @override
  Widget build(BuildContext context) {
    print(checkCountry());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("التفاصيل"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  // padding: EdgeInsets.only(bottom: 100),
                  child: ListView(
                    children: <Widget>[
                      //calling the product image here
                      productImage(context),
                      //this the title of details
                      Container(
                        padding: EdgeInsets.all(8),
                        // height: 30,
                        child: Text(
                          "المواصفات",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      //this continer include the phone specifiction
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(2),
                        child: ListView(
                          children: <Widget>[
                            productProperities(context, "الموديل :\t",
                                widget.name, color1, _textStyle1),
                            productProperities(context, "المعالج :\t",
                                widget.cpu, color2, _textStyle2),
                            productProperities(context, "الكاميرا : ",
                                widget.cameraMain, color1, _textStyle1),
                            productProperities(context, "البطارية : ",
                                widget.battery, color2, _textStyle2),
                            productProperities(context, "الشاشة : ",
                                widget.screen, color1, _textStyle1),
                            productProperities(context, "النظام : ",
                                widget.system, color2, _textStyle2),
                            productProperities(context, "خصائص الكاميرا : ",
                                widget.cameraFeatures, color1, _textStyle1),
                            productProperities(context, "كاميرا الفيديو : ",
                                widget.cameraVideo, color2, _textStyle2),
                            productProperities(context, " الذاكرة الداخلية : ",
                                widget.storge, color1, _textStyle1),
                            productProperities(context, " الذاكرة العشوائية : ",
                                widget.memory, color2, _textStyle2),
                            productProperities(context, " حماية الشاشة : ",
                                widget.screenProtection, color1, _textStyle1),
                            productProperities(context, " دقة الشاشة : ",
                                widget.screenResolution, color2, _textStyle2),

                            //this the title of details
                            Container(
                              padding: EdgeInsets.all(8),
                              // height: 30,
                              alignment: Alignment.center,

                              child: Text(
                                "الأسعار",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red),
                              ),
                            ),

                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: productProperities(
                                  context,
                                  "السعر",
                                  " : ${checkCountry()}  ",
                                  color3,
                                  _textStyle1),
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {},
          child: Icon(
            Icons.add_shopping_cart,
          ),
          elevation: 3,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  final _textStyle1 = TextStyle(
    fontSize: 20,
  );

  final _textStyle2 = TextStyle(
    fontSize: 20,
    color: Colors.blue,
  );

  Widget productImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: GridTile(
          child: Image.asset(widget.imgUrl),
          footer: Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 2),
            height: MediaQuery.of(context).size.height * 0.07,
            color: Colors.black.withOpacity(0.4),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${widget.name}",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.blue[900], fontSize: 19),
                ),
                Text(
                  "${checkCountry()} ",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(color: Colors.red[900], fontSize: 18),
                ),
              ],
            ),
          )),
    );
  }

  Widget productProperities(BuildContext context, String text1, String text2,
      Color color, TextStyle _textstyle) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 1,
      color: color,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
            overflow: TextOverflow.visible,
            maxLines: 3,

            // textWidthBasis: TextWidthBasis.longestLine,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: "$text1", style: TextStyle(color: Colors.black)),
                TextSpan(text: "$text2", style: _textstyle),
              ],
              style: _textstyle,
            ),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
