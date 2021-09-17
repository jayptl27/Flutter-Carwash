import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carwash/services/auth.dart';
import 'package:flutter_carwash/widgets/themes.dart';
// import 'package:page_transition/page_transition.dart';

import 'login_page.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  String email = "";
  String error = "";
  bool loading = false;
  String success = "";
  bool emailInputEnabled = true;

  final Authentication _authentication = Authentication();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          reverse: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/password.png",
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Reset Password,",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.0,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Let's get you up and running!",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.blueGrey[900]),
                            ),
                            hintText: "Enter Email address",
                            labelText: "Email",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Email cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        FloatingActionButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                emailInputEnabled = false;
                                loading = true;
                              });
                              dynamic result =
                                  await _authentication.resetPassword(email);
                              if (result == null) {
                                setState(() {
                                  emailInputEnabled = true;
                                  error =
                                      "Failed to sign in! Please check your credentials";
                                  loading = false;
                                });
                              } else if (result == true) {
                                setState(() {
                                  success =
                                      "Email successfully sent! Please check your mailbox to reset your password.";
                                  loading = false;
                                });
                              }
                            }

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          backgroundColor: MyTheme.darkBluishColor,
                          child: Icon(CupertinoIcons.arrow_right),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
