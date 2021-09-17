import 'package:flutter/material.dart';
import 'package:flutter_carwash/models/bookings.dart';
import 'package:flutter_carwash/models/user.dart';
import 'package:flutter_carwash/pages/screens/bookings/booking_list.dart';
import 'package:flutter_carwash/services/database.dart';
import 'package:provider/provider.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB>(context);
    return StreamProvider<List<Booking>>.value(
        value: DatabaseService().bookingData(user.uid),
        child: Scaffold(
          backgroundColor: Color.fromRGBO(247, 249, 249, 1),
          appBar: AppBar(
            leading: TextButton.icon(
                //padding: EdgeInsets.all(0.0),
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Colors.black),
                label: Text("")),
            elevation: 0.0,
            title: Text("Upcoming Bookings",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto")),
            backgroundColor: Color.fromRGBO(247, 249, 249, 1),
          ),
          body: Container(child: SizedBox(child: BookingList())),
        ));
  }
}
