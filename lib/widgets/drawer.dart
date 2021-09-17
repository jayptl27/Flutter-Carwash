import 'package:flutter_carwash/models/user.dart';
import 'package:flutter_carwash/pages/screens/bookings/bookings_home.dart';
import 'package:flutter_carwash/pages/screens/location.dart';
import 'package:flutter_carwash/pages/screens/login_page.dart';
import 'package:flutter_carwash/pages/screens/profile/imageViewer.dart';
import 'package:flutter_carwash/pages/screens/profile/profile.dart';
import 'package:flutter_carwash/services/auth.dart';
import 'package:flutter_carwash/services/database.dart';
import 'package:flutter_carwash/shared/loadingWidget.dart';
import 'package:flutter_carwash/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  final Authentication _authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return SafeArea(
              child: Drawer(
                child: Container(
                  color: MyTheme.darkBluishColor,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ImageView(url: userData.pictureLink)));
                        },
                        child: Container(
                          width: double.infinity,
                          //height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              alignment: Alignment(0.0, 2.5),
                              child: Hero(
                                  tag: 'image-view',
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
                      Container(
                        height: 80,
                        child: DrawerHeader(
                          padding: EdgeInsets.zero,
                          child: UserAccountsDrawerHeader(
                            decoration:
                                BoxDecoration(color: MyTheme.darkBluishColor),
                            margin: EdgeInsets.zero,
                            accountName: Text("${userData.name}"),
                            accountEmail: Text("${userData.email}"),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.profile_circled,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Profile",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.timer,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Bookings",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyBookings()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.location,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Location",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loaction()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Logout",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onTap: () async {
                          // await _authentication.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()));
                        },
                      ),
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
