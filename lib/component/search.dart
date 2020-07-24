import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_shop/brands/details.dart';
// import 'package:mobile_shop/brands/page_details.dart';
// import 'package:mobile_shop/brands/details.dart';
// import 'package:mobile_shop/brands/page_details.dart';
// import 'package:mobile_shop/brands/page_details.dart';
// import 'package:mobile_shop/brands/details.dart';

class DataSearch extends SearchDelegate<String> {
  List<dynamic> dataList = [];
  DataSearch({this.dataList});
  Future getSearchData() async {
    var url = "http://10.0.2.2/mobtech/searchmob.php";
    // var searchData = {"name", query};
    var response = await http.get(url);
    // var response = await http.post(url, body: searchData);
    var data = jsonDecode(response.body);
    return data;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // throw UnimplementedError();
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: getSearchData(),
        builder: (context, AsyncSnapshot snapshot) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, position) {
                // Samsung samsung = Samsung();
                if (snapshot.hasData) {
                  if (snapshot.data[position]['name'] == query) {
                    return SizedBox(
                      width: 200,
                      height: 600,
                      child: BodyConitner(
                        pageName: snapshot.data[position]['name'],
                      ),
                      // child: Samsung(
                      //   pageName: snapshot.data[position]['name'],
                      // ),
                    );
                  }
                }

                return Padding(padding: EdgeInsets.all(0));
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // IconButton(icon: Icon(Icons.clear), onPressed: () {});
    var searchQuery = query.isEmpty
        ? dataList
        : dataList.where((list) => list.startsWith(query)).toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: searchQuery.length,
          itemBuilder: (context, position) {
            return ListTile(
              leading: Icon(Icons.mobile_screen_share),
              title: Text(searchQuery[position]),
              onTap: () {
                query = searchQuery[position];
                showResults(context);
              },
            );
          }),
    );
  }
}

class BodyConitner extends StatelessWidget {
  Future getData() async {
    var url = "http://10.0.2.2/mobtech/index.php";
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }

  final String pageName;
  BodyConitner({this.pageName});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: FutureBuilder(
          future: getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, position) {
                  return Container(
                    // width: double.infinity,
                    color: Colors.blue.withOpacity(0.5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return Details(
                            name: data[position]['name'],
                            cameraMain: data[position]['camera_main'],
                            cpu: data[position]['cpu'],
                            imgUrl: "assets/images/p1.jpg",
                            price: data[position]['price'],
                            battery: data[position]['battery'],
                            cameraFeatures: data[position]['camera_features'],
                            cameraVideo: data[position]['camera_video'],
                            memory: data[position]['memory'],
                            screen: data[position]['screen'],
                            screenProtection: data[position]['screen_protect'],
                            screenResolution: data[position]['screen_res'],
                            storge: data[position]['storge'],
                            system: data[position]['system'],
                          );
                        }));
                      },
                      child: snapshot.data[position]['name'] != pageName
                          ? Center()
                          : Card(
                              color: Colors.white.withOpacity(1),
                              elevation: 5,
                              margin: EdgeInsets.all(6),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.23,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    //the calling of the product image contianer
                                    productImage(context),
                                    Container(
                                      child: Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            // this is the details title *"the start"*
                                            Container(
                                              child: Text(
                                                "المواصفات",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 19),
                                              ),
                                              alignment: Alignment.topRight,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 4, 8, 2),
                                            ),
                                            //*"the end"*
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                //calling the prduct details row *"the start"*
                                                productDetails(
                                                    "الاسم : ${snapshot.data[position]['name']}",
                                                    "المعالج : ${snapshot.data[position]['cpu']} النواة"),
                                                productDetails(
                                                    "الاسم: ${snapshot.data[position]['name']}",
                                                    "المعالج: ${snapshot.data[position]['cpu']} النواة"),

                                                productDetails(
                                                    "الاسم: ${snapshot.data[position]['battery']}",
                                                    "الكاميرا: ${snapshot.data[position]['camera_main']} ميجا بيكسل"),

                                                //*"the end"*
                                              ],
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget productImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: double.infinity,
      child: GridTile(
        child: Image.asset(
          "assets/images/p1.jpg",
          fit: BoxFit.cover,
        ),
        footer: Container(
          alignment: Alignment.center,
          height: 30,
          color: Colors.blue.withOpacity(0.8),
          child: FlatButton.icon(
            label: Text(
              "See More ",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget productDetails(String detail1, String detail2) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(child: Text("$detail1")),
          Expanded(
              child: Text(
            "$detail2",
            style: TextStyle(),
            overflow: TextOverflow.clip,
          )),
        ],
      ),
    );
  }
}
