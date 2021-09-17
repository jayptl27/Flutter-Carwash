import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_carwash/models/bookings.dart';
import 'package:flutter_carwash/models/user.dart';

class DatabaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final FirebaseMessaging fcm = FirebaseMessaging.instance;

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference adminCollection =
      FirebaseFirestore.instance.collection('admin');

  final CollectionReference bookingsCollection =
      FirebaseFirestore.instance.collection('bookings');

  final CollectionReference ratingsCollection =
      FirebaseFirestore.instance.collection('ratings');

  final Reference storageReferenceUser =
      FirebaseStorage.instance.ref().child("userImages");

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      phonenumber: snapshot.data()['phonenumber'],
      pictureLink: snapshot.data()['profilePicture'] ?? null,
    );
  }

  //get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future setUserDetails(String email, String name, String phonenumber) async {
    return await userCollection.doc(uid).set({
      "email": email,
      "name": name,
      "phonenumber": phonenumber,
      "createdAt": FieldValue.serverTimestamp(),
      "platform": Platform.operatingSystem
    });
  }

//set ratings
  Future setRating({
    String selectedValue1,
    String selectedValue2,
    String selectedValue3,
    String feedback,
    String userId,
  }) async {
    try {
      User user = _firebaseAuth.currentUser;
      await ratingsCollection.doc().set({
        "Feedback": feedback,
        "quality_of_service": selectedValue1,
        "customer_service": selectedValue2,
        "prices": selectedValue3,
        "userID": user.uid,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//set booking
  Future setBooking({
    DateTime selectedDate,
    String regNo,
    String type,
    num price,
    String uid,
  }) async {
    try {
      User user = _firebaseAuth.currentUser;
      await bookingsCollection.doc().set({
        "userID": user.uid,
        "time": selectedDate,
        "Registration_Number": regNo,
        "Vehicle_Type": type,
        "TotalPrice": price,
        "approval": "Pending",
        // "Type1": "Interior Detailing",
        // "Type2": "Interior Disinfectant",
        // "Type3": "Exterior Body Wash",
        "Type4": "Full Exterior & Interior Cleaning",
        "Type5": "Engine Bay Detailing",
        "Type6": "Polishing & Buffing",
        // "Type7": "High-pressure Air Blow-out",
        // "Type8": "Wheel Clean & Tireshine",
        // "Type9": "Headlight Restoration",
      });
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<Booking>> bookingData(userId) {
    return bookingsCollection
        .where("userID", isEqualTo: userId)
        .orderBy("time")
        .where("time", isGreaterThanOrEqualTo: Timestamp.now())
        .orderBy("approval")
        .snapshots()
        .map(_bookingDataFromSnapshot);
  }

  List<Booking> _bookingDataFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((document) {
        DateTime time =
            DateTime.parse(document.data()['time'].toDate().toString());
        print(document);
        return Booking(
          bookingId: document.id ?? "",
          userId: document.data()['userID'] ?? "",
          approval: document.data()['approval'] ?? "",
          type: document.data()['Vehicle_Type'] ?? "",
          regNo: document.data()['Registration_Number'] ?? "",
          selectedDate: time,
          // type1: document.data()['Interior Detailing'] ?? "",
          // type2: document.data()['Interior Disinfectant'] ?? "",
          // type3: document.data()['Exterior Body Wash'] ?? "",
          type4: document.data()['Full Exterior & Interior Cleaning'] ?? "",
          type5: document.data()['Engine Bay Detailing'] ?? "",
          type6: document.data()['Polishing & Buffing'] ?? "",
          // type7: document.data()['High-pressure Air Blow-out'] ?? "",
          // type8: document.data()['Wheel Clean & Tireshine'] ?? "",
          // type9: document.data()['Headlight Restoration'] ?? "",
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateImage({String uid, String url}) async {
    try {
      await userCollection.doc(uid).update({"profilePicture": url});
    } catch (e) {
      print(e.toString());
    }
  }

  Future removeImage({String uid}) async {
    try {
      await userCollection.doc(uid).update({"profilePicture": null});
    } catch (e) {
      print(e.toString());
    }
  }
}
