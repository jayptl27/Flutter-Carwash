import 'package:flutter/material.dart';
import 'package:flutter_carwash/models/bookings.dart';
import 'package:flutter_carwash/pages/screens/bookings/booking.dart';
import 'package:intl/intl.dart';

class BookingTile extends StatelessWidget {
  final Booking booking;
  BookingTile({this.booking});

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat.MMMMEEEEd().format(booking.selectedDate);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Colors.grey[200]),
        margin: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 0.0),
        child: ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BookingIndividual(bookingId: booking.bookingId),
            ),
          ),
          title: Text("Booking for ${booking.regNo}",
              style: TextStyle(fontFamily: "Poppins", fontSize: 18.0)),
          subtitle: Text("Date : $formattedTime",
              style: TextStyle(fontFamily: "Poppins")),
          trailing: Text(booking.approval),
        ),
      ),
    );
  }
}
