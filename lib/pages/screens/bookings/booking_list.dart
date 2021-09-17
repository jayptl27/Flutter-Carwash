import 'package:flutter/material.dart';
import 'package:flutter_carwash/models/bookings.dart';
import 'package:flutter_carwash/pages/screens/bookings/booking_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BookingList extends StatefulWidget {
  @override
  _BookingListState createState() => _BookingListState();
}

final String asset = "assets/images/lady_waiting.svg";

class _BookingListState extends State<BookingList> {
  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    final bookings = Provider.of<List<Booking>>(context) ?? [];
    if (bookings.isEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              asset,
              width: devWidth * 0.8,
            ),
            Text(
              "Once you book for a carwash, check back here!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  wordSpacing: 2.0),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
          itemBuilder: (context, index) {
            return BookingTile(booking: bookings[index]);
          },
          itemCount: bookings.length);
    }
  }
}
