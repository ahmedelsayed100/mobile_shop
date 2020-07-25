import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_shop/screens/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  saveUserInfo(String username, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username);
    prefs.setString("email", email);
    // print(prefs.setString("country", country));
  }

  @override
  void dispose() {
    _usernameController.text = "";
    _passwordController.text = "";
    _emailController.text = "";
    _repasswordControll.text = "";

    super.dispose();
  }

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
            //this code for calling the code to draw the 1/2 circle at the top of page
            positinedForDrawingCircles(mqh, mqw),
            //this code for calling the code to draw the 1/2 circle at the top of page
            positionedForDrawingLeftCircles(mqh, mqh),

            //this code for the content of the page
            Container(
              margin: EdgeInsets.only(top: mqh * 0.039),
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
                        height: mqh * 0.025,
                      ),
                      //this code for the content of circle avatar
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: isLogin ? mqw * 0.22 : mqw * 0.20,
                          height: isLogin ? mqh * 0.13 : mqh * 0.12,
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
                              positionedIcon(Icons.person, 50, 22),
                              positionedIcon(
                                  Icons.arrow_back, 29, isLogin ? 46 : 55),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
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
                          height: isLogin ? mqh * 0.56 : mqh * 0.7,
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
                                      padding: const EdgeInsets.only(bottom: 5),
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
                                          top: 4.0, bottom: 4),
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
                                                top: 4.0, bottom: 4),
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
                                                top: 4.0, bottom: 4),
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
                                            height: 4,
                                          ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    //calling the login button code
                                    centerForLoginButton(mqh),
                                    //calling the create acount password inkwell code
                                    SizedBox(
                                      height: 6,
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
                                                  pageTitle = "تسجيل الدخول";
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

                      !isLogin
                          ? Center(
                              child: Text(
                                "or",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            )
                          : SizedBox(),

                      //this code for face and google sign in
                      !isLogin
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: 5, left: 4),
                                      padding:
                                          EdgeInsets.fromLTRB(12, 4, 12, 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.redAccent,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          signButtonWithSocail(
                                              imgUrl:
                                                  'assets/images/gogle.png'),
                                          Text(
                                            "Sign With",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: 5, left: 4),
                                      padding:
                                          EdgeInsets.fromLTRB(12, 4, 12, 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blueAccent,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          signButtonWithSocail(
                                              imgUrl: 'assets/images/face.png'),
                                          Text(
                                            "Sign in with",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
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

  //this code for the top 1/2 circle
  Widget positinedForDrawingCircles(double mqh, double mqw) {
    return Positioned(
      child: Transform.scale(
        scale: 1.2,
        child: Transform.translate(
          offset: isLogin ? Offset(0, -mqh * 0.375) : Offset(0, -mqh * 0.395),
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
    );
  }

  //this code for the left 1/2 circle
  Widget positionedForDrawingLeftCircles(double mqh, double mqw) {
    return Positioned(
      top: mqh * 0.23,
      child: Transform.scale(
        scale: 1,
        child: Transform.translate(
          offset: Offset(-mqh * 0.5, 0),
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
    );
  }
  //this code for making the text field to use it with all user inputs

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

//this code for making the inkwell text for forgetting password
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

//this code for making the login and sign up button
  Widget centerForLoginButton(double mqh) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          var data = isLogin
              ? {
                  'email': _emailController.text.toLowerCase(),
                  'password': _passwordController.text
                }
              : {
                  'username': _usernameController.text,
                  'email': _emailController.text.toLowerCase(),
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
                //this to deploy alert dialog to make loding before login
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          content: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 40),
                            child: Text("Loading.."),
                          ),
                          CircularProgressIndicator(),
                        ],
                      ));
                    });
                saveUserInfo(responseBody['username'], responseBody['email']);
                Navigator.of(context).pushNamed(Home.route);
              } else {
                //this to deploy alert dialog to tell user somthing wrong
                showAlertDialog(
                  alertMessage: "البريد او الرقم السري خطا!",
                  titleMessage: "خطا",
                  flatButton: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("موافق")),
                );
              }
            }
          }
          if (!isLogin) {
            if (_registerKey.currentState.validate()) {
              if (responseBody['status'] == "success") {
                //this code to deploy alert message to tell user that new user added

                showAlertDialog(
                  alertMessage: "تم إضافة مستخدم جديد",
                  titleMessage: "إشعار",
                  flatButton: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "موافق",
                      textAlign: TextAlign.left,
                    ),
                  ),
                );

                Navigator.of(context).pushNamed(Home.route);
              } else {
                //this code to deploy alert message to tell user this email already exist
                showAlertDialog(
                  alertMessage: "!هذا البريد موجود بالفعل",
                  titleMessage: "خطا",
                  flatButton: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "موافق",
                        textAlign: TextAlign.left,
                      )),
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

//this code for alert user about somthing
  void showAlertDialog(
      {var alertMessage, var titleMessage, FlatButton flatButton}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("$alertMessage"),
          title: Text("$titleMessage"),
          actions: <Widget>[
            // FlatButton(onPressed: myFun, child: Text("موافق")),
            flatButton
          ],
        );
      },
    );
  }

//this code for drawing icon inside the circle avatar
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

//this code for make sign in using facebook
  Widget signButtonWithSocail({String imgUrl, String destination}) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: CircleAvatar(
        backgroundImage: ExactAssetImage("$imgUrl"),
      ),
      margin: EdgeInsets.only(left: 10),
    );
  }
}
