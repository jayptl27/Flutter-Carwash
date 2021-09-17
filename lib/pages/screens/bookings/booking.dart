import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_carwash/pages/screens/ratings.dart';
import 'package:flutter_carwash/widgets/themes.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class BookingIndividual extends StatefulWidget {
  final String bookingId;
  BookingIndividual({Key key, @required this.bookingId}) : super(key: key);
  @override
  _BookingIndividualState createState() => _BookingIndividualState();
}

class _BookingIndividualState extends State<BookingIndividual> {
  var url =
      'https://us-central1-carwash-final-flutter-pr-ca4e0.cloudfunctions.net/paypalPayment';
  bool loading = false;
  var booking;
  var user;

  final String phone = 'tel:0718609565';

  _callPhone() async {
    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      throw 'Could not Call Phone';
    }
  }

  @override
  void initState() {
    super.initState();
    getSchedule();
  }

  getSchedule() async {
    setState(() {
      loading = true;
    });
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("bookings")
          .doc(widget.bookingId)
          .get();
      setState(() {
        booking = doc.data();
        loading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        loading = false;
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container()
        : Scaffold(
            backgroundColor: MyTheme.creamColor,
            appBar: AppBar(
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
                "Booking Status",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    //fontSize: 24.0,
                    fontFamily: "Roboto"),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.bookmark_rounded,
                      size: 50,
                      color: MyTheme.darkBluishColor,
                    ),
                    title: Text(
                      "Booking Details",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Color.fromRGBO(28, 40, 51, 1),
                          fontSize: 20.0),
                    ),
                    subtitle: Text(
                      "Information about your carwash booking",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(228, 230, 241, 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          DateFormat('EEEE MMMM d - HH:m a')
                              .format(DateTime.parse(
                                  booking["time"].toDate().toString()))
                              .toString(),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 20,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        Text(
                          "Vehicle Type",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          booking["Vehicle_Type"],
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 20,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        Text(
                          "Registration Number",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          booking["Registration_Number"],
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 20,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        Text(
                          "Service Requested",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          booking["Type4"],
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        Text(
                          booking["Type5"],
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        Text(
                          booking["Type6"],
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 20,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        Text(
                          "Service Price",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          booking["TotalPrice"].toString(),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 20,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        Text(
                          "Approval",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          booking["approval"],
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  booking["approval"] == "Booked"
                      ? Container(
                          alignment: Alignment.bottomCenter,
                          child: Wrap(
                            spacing: 20.0,
                            runSpacing: 8.0,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.spaceEvenly,
                            alignment: WrapAlignment.spaceEvenly,
                            //crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              FloatingActionButton.extended(
                                backgroundColor: MyTheme.darkBluishColor,
                                icon: Icon(Icons.payment_sharp),
                                label: Text("Make Payment"),
                                onPressed: () async {
                                  var request = BraintreeDropInRequest(
                                      tokenizationKey:
                                          'sandbox_tv39v53v_cwwspnfcwpjj263m',
                                      collectDeviceData: true,
                                      paypalRequest: BraintreePayPalRequest(
                                          amount:
                                              booking['TotalPrice'].toString(),
                                          //'20.00',
                                          displayName: 'Carshine'),
                                      cardEnabled: true,
                                      maskCardNumber: true,
                                      maskSecurityCode: true);

                                  BraintreeDropInResult result =
                                      await BraintreeDropIn.start(request);
                                  if (result != null) {
                                    print(
                                        result.paymentMethodNonce.description);
                                    print(result.paymentMethodNonce.nonce);

                                    final http.Response response =
                                        await http.post(Uri.tryParse(
                                            '$url?payment_method_nonce=${result.paymentMethodNonce.nonce}&device_data=${result.deviceData}'));

                                    final payResult = jsonDecode(response.body);
                                    if (payResult['result'] == 'success')
                                      Fluttertoast.showToast(
                                          msg: "Payment Successful",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    print('payment done');
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              FloatingActionButton.extended(
                                  backgroundColor: MyTheme.darkBluishColor,
                                  heroTag: "BtnCall1",
                                  onPressed: () => _callPhone(),
                                  icon: Icon(Icons.call),
                                  label: Text("Call")),
                            ],
                          ),
                        )
                      : SizedBox(),
                  booking["approval"] == "Rejected"
                      ? Center(
                          child: FloatingActionButton.extended(
                              backgroundColor: MyTheme.darkBluishColor,
                              heroTag: "BtCall2",
                              onPressed: () => _callPhone(),
                              icon: Icon(Icons.call),
                              label: Text("Call")),
                        )
                      : SizedBox(),
                  booking["approval"] == "Pending"
                      ? Center(
                          child: FloatingActionButton.extended(
                              backgroundColor: MyTheme.darkBluishColor,
                              heroTag: "BtnCall3",
                              onPressed: () => _callPhone(),
                              icon: Icon(Icons.call),
                              label: Text("Call")),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: FloatingActionButton.extended(
                        backgroundColor: Colors.black87,
                        heroTag: "ReviewBtn",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReviewsDemo()));
                        },
                        icon: Icon(Icons.rate_review_sharp),
                        label: Text("Post Review")),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
  }
}
