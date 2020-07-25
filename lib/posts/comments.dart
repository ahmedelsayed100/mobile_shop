import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  static final String route = "comments";
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: double.infinity,
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
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ],
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
