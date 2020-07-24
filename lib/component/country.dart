import 'package:flutter/material.dart';
import 'package:mobile_shop/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Country extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  var isSelected = "مصر";
  List<String> countries = [
    'مصر',
    'السعودية',
    'سوريا',
    'الجزائر',
    'الإمارات',
    'الأردن',
  ];

  saveSelectedCountery(String country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("country", country);
    print(prefs.setString("country", country));
  }

  getSelectedCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      isSelected = prefs.getString("country") ?? "";
    });
    if (isSelected != null) {
      Navigator.of(context).pushNamed(Home.route);
    }

    print(isSelected);
  }

  @override
  void initState() {
    getSelectedCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getSelectedCountry();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("أختر  الدولة"),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              //egpty
              radiolistTile(0),

              //saudi
              radiolistTile(1),
              //syria
              radiolistTile(2),
              //algeria
              radiolistTile(3),
              //emirats
              radiolistTile(4),
              //gurdin
              radiolistTile(5),
              RaisedButton(
                onPressed: () {
                  saveSelectedCountery(isSelected);
                  if (isSelected != null) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Home()));
                  }
                },
                child: Text("حفظ"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget radiolistTile(int index) {
    return RadioListTile(
        value: countries[index],
        groupValue: isSelected,
        title: Text(countries[index]),
        onChanged: (value) {
          setState(() {
            isSelected = value;
          });
          saveSelectedCountery(isSelected);
        });
  }
}
