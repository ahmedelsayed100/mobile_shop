import 'package:flutter/material.dart';
import 'package:mobile_shop/posts/comments.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Post extends StatefulWidget {
  static final String route = "post";
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  String id = "";
  String username = "none";
  String email;
  final TextEditingController _addpost = TextEditingController();

  //this func using sharedpref for get user information
  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username");
    email = prefs.getString("email");
    id = prefs.getString("id");
    setState(() {
      if (username != null) {
        id = prefs.getString("id");
        username = prefs.getString("username");
        email = prefs.getString("email");
      }
    });
  }

//this func to get the user post
  Future getPost() async {
    var url = "http://10.0.2.2/mobtech/post.php";
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    return responseBody;
  }

  //this function to add post to database
  Future addPost() async {
    var url = "http://10.0.2.2/mobtech/addpost.php";
    var data = {
      'post': _addpost.text,
      'postuser': id,
    };
    var response = await http.post(url, body: data);
    var responseBody = jsonDecode(response.body);
    return responseBody;
  }

  @override
  void initState() {
    getPost();
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
              //the post card
              Container(
                margin: EdgeInsets.all(2),
                width: 250,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                        // width: 150,
                        height: MediaQuery.of(context).size.height,
                        child: FutureBuilder(
                            future: getPost(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return PostList(
                                        name: snapshot.data[index]['username'],
                                        postContent: snapshot.data[index]
                                            ['post'],
                                        postId: snapshot.data[index]['post_id'],
                                      );
                                    });
                              } else {
                                print('filed');
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ),
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
                    onPressed: () {
                      addPost();
                      setState(() {
                        _addpost.text = "";
                      });
                    },
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
                  controller: _addpost,
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

class PostList extends StatelessWidget {
  final name;
  final postContent;
  final postId;
  PostList({this.name, this.postContent, this.postId});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Container(
              margin: EdgeInsets.only(top: 10),
              child: Text("$name"),
            ),
            subtitle: Text("$postContent"),
            isThreeLine: true,
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 30,
            ),
            trailing: IconButton(icon: Icon(Icons.filter), onPressed: () {}),
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
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Comments(
                        postId: postId,
                      );
                    }));
                    // (Comments.route, arguments: [postId]);
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
    );
  }
}
