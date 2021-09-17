import 'package:flutter/material.dart';
import 'package:flutter_carwash/pages/screens/login_page.dart';
import 'package:flutter_carwash/services/auth.dart';
import 'package:flutter_carwash/shared/loadingWidget.dart';
import 'package:flutter_carwash/widgets/themes.dart';
import 'package:page_transition/page_transition.dart';

class SignUpPage extends StatefulWidget {
  final Function toggleView;
  SignUpPage({this.toggleView});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email = "";
  String password = "";
  String name = "";
  String phonenumber = "";
  String error = "";
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final Authentication _authentication = Authentication();

  moveToLogin(context) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      dynamic result = await _authentication.registerWithEmailAndPassword(
          email, password, phonenumber, name);

      if (result == null) {
        setState(() {
          error = "Please give a valid email";
          loading = false;
        });
      }
      await Future.delayed(Duration(seconds: 1));
      await Navigator.push(context,
          PageTransition(child: LoginPage(), type: PageTransitionType.rotate));
      _formKey.currentState.reset();
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingWidget()
        : SafeArea(
            child: Material(
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 28.0, horizontal: 6.0),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        child: Text(
                                          "Create Account,",
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.0,
                                            height: 1.1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        child: Text(
                                          "Let's get you signed up!",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Image.asset(
                                "assets/images/signup.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 8.0),
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.blueGrey[900]),
                                    ),
                                    hintText: "Enter Full Name",
                                    labelText: "Full Name",
                                  ),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Name cannot be empty";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.blueGrey[900]),
                                    ),
                                    hintText: "Enter Phone Number",
                                    labelText: "Phone Number",
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Phone Number cannot be empty";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      phonenumber = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.blueGrey[900]),
                                    ),
                                    hintText: "Enter Email address",
                                    labelText: "Email",
                                  ),
                                  keyboardType: TextInputType.emailAddress,
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.blueGrey[900]),
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
                                  height: 20.0,
                                ),
                                ElevatedButton(
                                  onPressed: () => {
                                    moveToLogin(context),
                                  },
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                      backgroundColor: MyTheme.darkBluishColor,
                                      minimumSize: Size(400, 55),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      )),
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
                                    "Already have an Account ? Sign In",
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: LoginPage(),
                                            type: PageTransitionType.fade));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
