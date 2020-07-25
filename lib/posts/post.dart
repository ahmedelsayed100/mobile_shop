import 'package:flutter/material.dart';
import 'package:mobile_shop/posts/comments.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Post extends StatefulWidget {
  static final String route = "post";
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  String username;
  String email;
  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username");
    email = prefs.getString("email");
    setState(() {
      if (username != null) {
        username = prefs.getString("username");
        email = prefs.getString("email");
      }
    });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("المنشورات"),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.indigo[300],
          child: ListView(
            children: <Widget>[
              //this calling for calling the code of posting a post
              postApost(),
              Card(
                margin: const EdgeInsets.all(6),
                elevation: 5,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text("$username")),
                      subtitle: Text(
                          "السلام عليكم ورحمة الله وبركاته لدي هاتف بحالة جيدة أريد بيعه"),
                      isThreeLine: true,
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 30,
                      ),
                      trailing: IconButton(
                          icon: Icon(Icons.filter), onPressed: () {}),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton.icon(
                          icon: Icon(Icons.thumb_up),
                          onPressed: () {},
                          label: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              "إعجاب",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                        // Divider(),
                        Container(
                          padding: EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                          ),
                          child: FlatButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushNamed(Comments.route);
                            },
                            label: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                "تعليق",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            icon: Icon(Icons.insert_comment),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget postApost() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      // height: 150,

      child: Column(
        children: <Widget>[
          Card(
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),

              // isThreeLine: true,
              subtitle: Container(
                width: double.infinity,
                child: FlatButton(
                    onPressed: () {},
                    color: Colors.grey[200],
                    child: Text(
                      "نشر",
                      style: TextStyle(fontSize: 18),
                    )),
              ),
              isThreeLine: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  maxLines: 10,
                  minLines: 1,
                  maxLength: 255,
                  autocorrect: true,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                  ),
                  smartQuotesType: SmartQuotesType.enabled,
                  decoration: InputDecoration(
                    hintText: "كتابة منشور",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
