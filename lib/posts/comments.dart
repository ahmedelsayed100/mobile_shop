import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Comments extends StatefulWidget {
  static final String route = "comments";
  final postId;
  Comments({this.postId});
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  Future getComment() async {
    var url = "http://10.0.2.2/mobtech/comments.php";
    var data = {'postid': widget.postId};
    var response = await http.post(url, body: data);
    var responseBody = jsonDecode(response.body);
    return responseBody;
  }

  @override
  void initState() {
    getComment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Container(),
              Positioned(
                bottom: 0,
                left: 5,
                right: 5,
                // top: 1,
                child: Container(
                  // width: 500,/
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            size: 30,
                          ),
                          splashColor: Colors.blue,
                          onPressed: () {}),
                      Expanded(
                        // width: 200,
                        child: TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.send,
                                  size: 30,
                                ),
                                splashColor: Colors.blue,
                                onPressed: () {}),
                            hintText: "كتابة تعليق",
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                child: Container(
                  height: MediaQuery.of(context).size.height - 70,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 25),
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                        future: getComment(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            print("ji");
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                for (int x = 0; x < snapshot.data.length; x++)
                                  CommentList(snapshot.data[x]['username'],
                                      snapshot.data[x]['comment']),
                              ],
                            );
                          } else {
                            print('filed');
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentList extends StatelessWidget {
  final username;
  final comment;
  CommentList(this.username, this.comment);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Container(
          margin: EdgeInsets.all(10),
          child: Text("$username"),
        ),
        subtitle: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          color: Colors.grey[300],
          child: Text(
            "$comment",
            style: TextStyle(fontSize: 17, color: Colors.blue[800]),
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}
