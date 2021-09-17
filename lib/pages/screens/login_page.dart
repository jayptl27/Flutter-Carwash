import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carwash/pages/screens/forgot_pass.dart';
import 'package:flutter_carwash/pages/screens/homepage.dart';
import 'package:flutter_carwash/pages/screens/signup_page.dart';
import 'package:flutter_carwash/services/auth.dart';
import 'package:flutter_carwash/shared/loadingWidget.dart';
import 'package:flutter_carwash/widgets/themes.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage({this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  String email = "";
  String password = "";
  String error = "";

  final _formKey = GlobalKey<FormState>();
  final Authentication _authentication = Authentication();

  moveToHome(context) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      dynamic result =
          await _authentication.signInWithEmailAndPassword(email, password);
      Navigator.push(
          context,
          PageTransition(
              child: HomePage(), type: PageTransitionType.bottomToTop));

      if (result == null) {
        setState(() {
          error = "Failed to sign in! Please check your credentials";
          loading = false;
          Navigator.pop(
              context,
              PageTransition(
                  child: LoginPage(), type: PageTransitionType.bottomToTop));
        });
      }
      await Future.delayed(Duration(seconds: 3));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return loading
        ? LoadingWidget()
        : Material(
            color: Colors.white,
            child: SafeArea(
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottom),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/login.png",
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "Welcome Back,",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 46,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.0,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          "Let's get you signed in!",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            fontWeight: FontWeight.w100,
                            color: Colors.grey[700],
                          ),
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
                                height: 20.0,
                              ),
                              TextFormField(
                                obscureText: true,
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
                                  hintText: "Enter Password",
                                  labelText: "Password",
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Password cannot be empty";
                                  } else if (value.length < 6) {
                                    return "Password length should be atleast 6 characters long";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              FloatingActionButton(
                                onPressed: () => moveToHome(context),
                                backgroundColor: MyTheme.darkBluishColor,
                                child: Icon(CupertinoIcons.arrow_right),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  error,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.0),
                                ),
                              ),
                              TextButton(
                                child: Text(
                                  "Don't have an Account yet? Sign Up",
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpPage()));
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: SignUpPage(),
                                          type: PageTransitionType
                                              .rightToLeftWithFade));
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "Forgot Password",
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: ForgotPassPage(),
                                          type: PageTransitionType
                                              .leftToRightWithFade));
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
