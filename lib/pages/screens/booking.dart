import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carwash/core/store.dart';
import 'package:flutter_carwash/models/cart.dart';
import 'package:flutter_carwash/services/database.dart';
import 'package:flutter_carwash/utils/routes.dart';
import 'package:flutter_carwash/widgets/themes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String regNo = "";
  String type = "";
  String error = "";
  DateTime selectedDate;

  DatabaseService databaseService = new DatabaseService();

  final CartModel _cart = (VxState.store as MyStore).cart;
  final String asset = "assets/images/datepicker.svg";

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Hatchback',
      'label': 'Hatchback',
    },
    {
      'value': 'Saloon',
      'label': 'Saloon',
    },
    {
      'value': 'Sedan',
      'label': 'Sedan',
    },
    {
      'value': 'SUV',
      'label': 'SUV',
    },
  ];

  final _formKey = GlobalKey<FormState>();

  confirmBooking(BuildContext context) async {
    print(selectedDate);
    if (selectedDate == null) {
      error = "Please enter preffered date & time.";
    }

    if (_formKey.currentState.validate()) {
      DatabaseService().setBooking(
        selectedDate: selectedDate,
        price: _cart.totalPrice,
        type: type,
        regNo: regNo,
      );
      setState(() {});
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.bookingstatusRoute);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: devWidth * 0.35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "You are almost done,",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: devHeight * 0.05),
                        SvgPicture.asset(
                          asset,
                          width: devWidth * 0.2,
                          height: devHeight * 0.2,
                        ),
                      ],
                    ),
                    SizedBox(height: devHeight * 0.01),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'Please fill in the details below.',
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DateTimeField(
                          onDateSelected: (DateTime value) {
                            setState(() {
                              selectedDate = value;
                            });
                          },
                          enabled: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.event_note,
                              color: Colors.grey[600],
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: MyTheme.darkBluishColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.blueGrey[900]),
                            ),
                            hintText: "Enter Preferred Date & Time",
                            labelText: "Date & Time",
                          ),
                          firstDate: DateTime.now().subtract(Duration(days: 0)),
                          lastDate: DateTime.now().add(Duration(days: 4)),
                          selectedDate: selectedDate,
                        ),
                        Center(
                          child: Text(
                            error,
                            style: TextStyle(
                                color: Colors.red[700], fontSize: 12.0),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              CupertinoIcons.number,
                              color: Colors.grey[600],
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey[600]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: MyTheme.darkBluishColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.blueGrey[900]),
                            ),
                            hintText: "Enter Registration Number",
                            labelText: "Registration Number",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Field cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              regNo = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SelectFormField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              CupertinoIcons.car_detailed,
                              color: Colors.grey[600],
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey[600]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: MyTheme.darkBluishColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.blueGrey[900]),
                            ),
                            labelText: "Vehicle Type",
                          ),
                          items: _items,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Field cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              type = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: "\$ ${_cart.totalPrice}",
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.money_rounded,
                              color: Colors.grey[600],
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.grey[600]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: MyTheme.darkBluishColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.blueGrey[900]),
                            ),
                            labelText: "Total Price",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () => confirmBooking(context),
                          child: Text(
                            "Submit",
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
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//DropDownFormField(
//   titleText: 'Vehicle Type',
//   hintText: 'Select one option',
//   value: type,
//   validator: (value) {
//     if (value.isEmpty) {
//       return "Field cannot be empty";
//     }
//     return null;
//   },
//   onChanged: (value) {
//     setState(() {
//       type = value;
//     });
//   },
//   dataSource: [
//     {
//       "display": "",
//       "value": "",
//     },
//     {
//       "display": "Hatchback",
//       "value": "Hatchback",
//     },
//     {
//       "display": "Saloon",
//       "value": "Saloon",
//     },
//     {
//       "display": "Sedan",
//       "value": "Sedan",
//     },
//     {
//       "display": "SUV",
//       "value": "SUV",
//     },
//   ],
//   textField: 'display',
//   valueField: 'value',
// ),
