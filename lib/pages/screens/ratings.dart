import 'package:flutter/material.dart';
import 'package:flutter_carwash/services/database.dart';
import 'package:flutter_carwash/widgets/themes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reviews_slider/reviews_slider.dart';

class ReviewsDemo extends StatefulWidget {
  @override
  _ReviewsDemoState createState() => _ReviewsDemoState();
}

class _ReviewsDemoState extends State<ReviewsDemo> {
  int selectedValue1;
  int selectedValue2;
  int selectedValue3;
  String feedback = "";

  void onChange1(int value) {
    setState(() {
      selectedValue1 = value;
    });
  }

  void onChange2(int value) {
    setState(() {
      selectedValue2 = value;
    });
  }

  void onChange3(int value) {
    setState(() {
      selectedValue3 = value;
    });
  }

  submitRating(BuildContext context) async {
    DatabaseService().setRating(
      selectedValue1: selectedValue1.toString(),
      selectedValue2: selectedValue2.toString(),
      selectedValue3: selectedValue3.toString(),
      feedback: feedback,
    );
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    Fluttertoast.showToast(
        msg: "Review Successfully Posted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    await Future.delayed(Duration(seconds: 1));
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final maxLines = 6;
    return Scaffold(
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
          "Ratings & Review",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              //fontSize: 24.0,
              fontFamily: "Roboto"),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'How was the quality of the service you received?',
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: Color.fromRGBO(28, 40, 51, 1),
                    fontSize: 16.0),
              ),
              //SizedBox(height: 5),
              ReviewSlider(
                optionStyle: TextStyle(
                  color: MyTheme.darkBluishColor,
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                onChange: onChange1,
                initialValue: 2,
              ),
              Center(
                child: Text(
                  selectedValue1.toString(),
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                ),
              ),
              //SizedBox(height: 5),
              Text(
                'How is our Customer Service?',
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: Color.fromRGBO(28, 40, 51, 1),
                    fontSize: 16.0),
              ),
              //SizedBox(height: 5),
              ReviewSlider(
                optionStyle: TextStyle(
                  color: MyTheme.darkBluishColor,
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                onChange: onChange2,
                initialValue: 2,
              ),
              Center(
                child: Text(
                  selectedValue2.toString(),
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                ),
              ),
              //SizedBox(height: 5),
              Text(
                'How are the prices of our services?',
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: Color.fromRGBO(28, 40, 51, 1),
                    fontSize: 16.0),
              ),
              //SizedBox(height: 5),
              ReviewSlider(
                optionStyle: TextStyle(
                  color: MyTheme.darkBluishColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
                onChange: onChange3,
                initialValue: 2,
              ),
              Center(
                child: Text(
                  selectedValue3.toString(),
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                ),
              ),
              const Divider(
                color: Color.fromRGBO(171, 178, 185, 1),
                height: 20,
                indent: 0,
                thickness: 1,
                endIndent: 0,
              ),
              Center(
                child: Text(
                  "We will be pleased to hear from you.",
                  style: TextStyle(
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: maxLines * 30.0,
                child: TextField(
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.blueGrey[500]),
                    ),
                    hintText: "Enter your Feedback",
                    fillColor: Color.fromRGBO(228, 230, 241, 1),
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      feedback = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: FloatingActionButton.extended(
                    backgroundColor: MyTheme.darkBluishColor,
                    heroTag: "ReviewBtn",
                    onPressed: () => submitRating(context),
                    icon: Icon(Icons.feedback_rounded),
                    label: Text("Submit Review")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
