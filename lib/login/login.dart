import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_shop/screens/home.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  static final route = "login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  bool isLogin = true;
  String pageTitle = "تسجيل الدخول";
  String password;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _repasswordControll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mqh = MediaQuery.of(context).size.height;
    final mqw = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              // color: Colors.yellow[400],
              height: mqh,
              width: mqw,
            ),
            //this code for the top 1/2 circle
            Positioned(
              child: Transform.scale(
                scale: 1.2,
                child: Transform.translate(
                  offset: isLogin
                      ? Offset(0, -mqh * 0.36)
                      : Offset(0, -mqh * 0.395),
                  child: AnimatedContainer(
                    // curve: Curves.bounceInOut,
                    duration: Duration(milliseconds: 500),
                    width: mqw,
                    height: mqw,
                    decoration: BoxDecoration(
                      color: isLogin ? Colors.brown[800] : Colors.blue[500],
                      borderRadius: BorderRadius.circular(mqh),
                    ),
                  ),
                ),
              ),
            ),
            //this code for the left 1/2 circle
            Positioned(
              top: mqh * 0.38,
              child: Transform.scale(
                scale: 1,
                child: Transform.translate(
                  offset: Offset(-mqh * 0.46, 0),
                  child: AnimatedContainer(
                    curve: Curves.bounceInOut,
                    duration: Duration(milliseconds: 500),
                    width: mqw,
                    height: mqw,
                    decoration: BoxDecoration(
                      color: isLogin ? Colors.blue[300] : Colors.grey[500],
                      borderRadius: BorderRadius.circular(mqh),
                    ),
                  ),
                ),
              ),
            ),
            //this code for the content of the page
            Container(
              margin: EdgeInsets.only(top: mqh * 0.05),
              height: mqh,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      //this code for the title of the page

                      Text(
                        pageTitle,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: mqh * 0.03,
                      ),
                      //this code for the content of circle avatar

                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: isLogin ? mqw * 0.25 : mqw * 0.20,
                        height: isLogin ? mqh * 0.15 : mqh * 0.12,
                        decoration: BoxDecoration(
                            color: isLogin ? Colors.yellow : Colors.grey[400],
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 3,
                                  spreadRadius: 0.1),
                            ]),
                        //this code for the icons inside the circle avatar
                        child: Stack(
                          children: <Widget>[
                            positionedIcon(Icons.person, 50, 20),
                            positionedIcon(Icons.arrow_back, 29, 55),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      ///******************************************
                      ///******************************** **********/ */
                      //this is the start of the card code
                      ///******************************************/
                      Form(
                        // autovalidate: true,
                        key: isLogin ? _loginKey : _registerKey,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOutCirc,
                          height: isLogin ? mqh * 0.628 : mqh * 0.7,
                          width: mqw * 0.8,
                          child: Card(
                            borderOnForeground: true,
                            shadowColor: Colors.yellow,
                            elevation: 9,
                            // margin: EdgeInsets.all(8),
                            color: Colors.white.withOpacity(0.9),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //this code for the field og the user name
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        isLogin
                                            ? "البريد الألكتروني"
                                            : "اسم المستخدم",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 15.5,
                                        ),
                                      ),
                                    ),
                                    //calling for the code of text field for username
                                    textFieldContainer(
                                        hintText: isLogin
                                            ? "أدخل البريد الألكتروني "
                                            : "أدخل اسم المستخدم",
                                        controller: isLogin
                                            ? _emailController
                                            : _usernameController),
                                    //this is the lable for password
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8),
                                      child: Text(
                                        "الرقم السري",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 15.5,
                                        ),
                                      ),
                                    ),
                                    //calling for the code of text field for password

                                    textFieldContainer(
                                      hintText: "أدخل الرقم السري",
                                      controller: _passwordController,
                                    ),
                                    //calling for the code of text field for re enter the password

                                    !isLogin
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8),
                                            child: Text(
                                              "تأكيد الرقم السري",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15.5,
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    !isLogin
                                        ? textFieldContainer(
                                            hintText: "تأكيد الرقم السري",
                                            controller: _repasswordControll,
                                          )
                                        : SizedBox(),
                                    //this is the lable for email
                                    !isLogin
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8),
                                            child: Text(
                                              "البريد الإلكتروني",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15.5,
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            height: 10,
                                          ),
                                    !isLogin
                                        ? textFieldContainer(
                                            hintText: "ادخل البريد الإلكتروني",
                                            controller: _emailController,
                                          )
                                        : SizedBox(),

                                    //calling the forget password inkwell code
                                    isLogin
                                        ? forForgetPasswordOrSignUp(
                                            mqh: mqh,
                                            lable: "هل نسيت كلمة المرور؟",
                                            myfun: () {})
                                        : SizedBox(
                                            height: 10,
                                          ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    //calling the login button code
                                    centerForLoginButton(mqh),
                                    //calling the create acount password inkwell code
                                    SizedBox(
                                      height: 20,
                                    ),
                                    isLogin
                                        ? Center(
                                            child: forForgetPasswordOrSignUp(
                                              mqh: mqh,
                                              lable:
                                                  "ليس لديك حساب ؟  |\t إنشاء حساب؟",
                                              myfun: () {
                                                setState(() {
                                                  pageTitle = "إنشاء حساب";
                                                  isLogin = false;
                                                });
                                              },
                                            ),
                                          )
                                        : Center(
                                            child: forForgetPasswordOrSignUp(
                                              mqh: mqh,
                                              lable:
                                                  " لديك حساب ؟  |\t تسجيل الدخول؟",
                                              myfun: () {
                                                setState(() {
                                                  pageTitle = "تسجيل الدخول؟";
                                                  isLogin = true;
                                                });
                                              },
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textFieldContainer(
      {String hintText,
      bool secure,
      TextEditingController controller,
      Function valdFunc}) {
    return TextFormField(
      // autovalidate: true,
      obscureText: hintText.contains("الرقم السري") ? true : false,
      controller: controller,
      validator: (val) {
        switch (hintText) {
          case "أدخل اسم المستخدم":
            if (val.trim().isEmpty) {
              return "من فضلك أدخل إسم المستخدم";
            }
            // if (val.length < 0) {
            //   return "الرجاء ادخال اسم صحيح ";
            // }
            break;
          case "أدخل الرقم السري":
            if (val.isEmpty) {
              return "من فضلك أدخل كلمة المرور ";
            }
            if (val.length < 8) {
              return "من فضلك أدخل كلمة مرور مكونة من 8 أحرف";
            } else {
              setState(() {
                password = controller.text;
              });
            }

            break;
          case "تأكيد الرقم السري":
            if (val.isEmpty) {
              return "من فضلك أدخل كلمة المرور ";
            }
            if (val.length < 8) {
              return "من فضلك أدخل كلمة مرور مكونة من 8 أحرف";
            }
            if (val.isNotEmpty) {
              if (val != password) {
                return "كلمة السر غير متطابقة";
              }
            }
            break;
          case "ادخل البريد الإلكتروني":
            if (val.isEmpty) {
              return "من فضلك أدخل البريد الإكتروني ";
            }
            if (val.length < 10) {
              return "من فضلك أدخل بريد إلكتروني صحيح";
            }
            break;
        }

        // return "من فضلك أدخل إسم المستخدم";
      },
      decoration: InputDecoration(
        hintText: "$hintText",
        contentPadding: EdgeInsets.all(4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  Widget forForgetPasswordOrSignUp({double mqh, String lable, Function myfun}) {
    return SizedBox(
      height: mqh * 0.056,
      child: InkWell(
        child: Text(
          "$lable",
          style: TextStyle(
              color: lable == "هل نسيت كلمة المرور؟"
                  ? Colors.redAccent
                  : Colors.blue[600],
              fontSize: 16),
        ),
        onTap: myfun,
      ),
    );
  }

  Widget centerForLoginButton(double mqh) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          var data = isLogin
              ? {
                  'email': _emailController.text,
                  'password': _passwordController.text
                }
              : {
                  'username': _usernameController.text,
                  'email': _emailController.text,
                  'password': _passwordController.text,
                };
          var url = isLogin
              ? "http://10.0.2.2/mobtech/login.php"
              : "http://10.0.2.2/mobtech/signup.php";
          var response = await http.post(url, body: data);
          var responseBody = jsonDecode(response.body);
          print(responseBody);

          if (isLogin) {
            if (_loginKey.currentState.validate()) {
              if (responseBody['status'] == "success") {
                Navigator.of(context).pushNamed(Home.route);
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text("Username or password not correct!"),
                      title: Text("Error"),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("موافق")),
                      ],
                    );
                  },
                );
              }
            }
          }
          if (!isLogin) {
            if (_registerKey.currentState.validate()) {
              if (responseBody['status'] == "success") {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                        "تم إضافة مستخدم جديد",
                        textAlign: TextAlign.right,
                      ),
                      title: Text(
                        "إشعار",
                        textAlign: TextAlign.right,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "موافق",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    );
                  },
                );
                Navigator.of(context).pushNamed(Home.route);
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                        "!هذا البريد موجود بالفعل",
                        textAlign: TextAlign.right,
                      ),
                      title: Text(
                        "خطا",
                        textAlign: TextAlign.right,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "موافق",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            }
          }
        },
        color: Colors.blue[800],
        elevation: 4,
        textColor: Colors.white,
        padding: EdgeInsets.only(top: 6, right: 30, left: 30, bottom: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              isLogin ? "تسجيل" : "إنشاء حساب",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }

  Widget positionedIcon(IconData iconData, double size, double left) {
    return Positioned(
      top: isLogin ? 20 : 10,
      right: isLogin ? 20 : 10,
      left: isLogin ? left : left - 15,
      bottom: 20,
      child: Icon(
        iconData,
        size: isLogin ? size : size - 3,
        color: isLogin ? Colors.grey[600] : Colors.white,
        // color: Colors.si,
      ),
    );
  }
}
