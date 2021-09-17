import 'package:flutter/material.dart';
import 'package:flutter_carwash/models/user.dart';
import 'package:flutter_carwash/pages/screens/profile/profilePicture.dart';
//import 'package:flutter_carwash/pages/screens/profile/profilePicture.dart';
import 'package:flutter_carwash/services/auth.dart';
import 'package:flutter_carwash/services/database.dart';
import 'package:flutter_carwash/shared/loadingWidget.dart';
import 'package:flutter_carwash/widgets/themes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email;
  Authentication _auth = Authentication();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: MyTheme.creamColor,
              appBar: AppBar(
                backgroundColor: MyTheme.creamColor,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                elevation: 0.0,
                title: Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto"),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/background3.png"),
                                fit: BoxFit.cover)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePicture()));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            child: Container(
                              alignment: Alignment(0.0, 2.5),
                              child: Hero(
                                  tag: 'profPic',
                                  child: userData.pictureLink != null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              userData.pictureLink),
                                          radius: 60.0,
                                        )
                                      : CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/person_placeholder.png"),
                                          radius: 60.0,
                                        )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        userData.name,
                        style: TextStyle(
                            fontSize: 25.0,
                            //color: Colors.blueGrey[600],
                            color: Colors.blueGrey[800],
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blueGrey[800],
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto"),
                      ),
                      Text(
                        userData.email,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blueGrey[600],
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins"),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Phone Number",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blueGrey[800],
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto"),
                      ),
                      Text(
                        userData.phonenumber,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blueGrey[600],
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins"),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton.icon(
                        onPressed: () => {
                          Dialogs.materialDialog(
                            context: context,
                            title: 'Reset Password',
                            msg:
                                'Once you input your email, we will send you a password reset link on your email',
                            actions: <Widget>[
                              TextFormField(
                                enabled: true,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  filled: true,
                                  focusColor: Colors.grey,
                                  hoverColor: Colors.grey,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                ),
                                validator: (val) => val.isEmpty
                                    ? "Please fill out this field"
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              IconsOutlineButton(
                                text: 'OK',
                                textStyle:
                                    TextStyle(color: MyTheme.bluishColor),
                                iconColor: Colors.green,
                                iconData: Icons.check,
                                onPressed: () {
                                  if (email != null) {
                                    var result = _auth.resetPassword(email);
                                    if (result == null) {
                                      Fluttertoast.showToast(
                                          msg: "An error occured",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "A password reset email has been sent to you!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please enter an email address",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }

                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          )
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                MyTheme.darkBluishColor)),
                        icon: Icon(Icons.lock),
                        label: Text("Change Password"),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return LoadingWidget();
          }
        });
  }
}
