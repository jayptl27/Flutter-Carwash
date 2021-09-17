import 'package:flutter/material.dart';
import 'package:flutter_carwash/pages/screens/homepage.dart';
import 'package:flutter_carwash/widgets/themes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class Status extends StatelessWidget {
  final asset = "assets/images/confirmation.svg";
  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyTheme.creamColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: SvgPicture.asset(
                asset,
                height: devHeight * 0.25,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Your Booking has been requested, please wait for confirmation.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              "You can check your booking status at the booking section.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: Text(
                      "Go Home",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20,
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: MyTheme.darkBluishColor,
                        minimumSize: Size(100, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                    onPressed: () => Navigator.push(
                        context,
                        PageTransition(
                            child: HomePage(), type: PageTransitionType.fade))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
