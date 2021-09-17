import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carwash/core/store.dart';
import 'package:flutter_carwash/models/user.dart';
import 'package:flutter_carwash/pages/screens/booking.dart';
import 'package:flutter_carwash/pages/screens/bookings/booking_status.dart';
import 'package:flutter_carwash/pages/screens/bookings/bookings_home.dart';
import 'package:flutter_carwash/pages/screens/cart_page.dart';
import 'package:flutter_carwash/pages/screens/forgot_pass.dart';
import 'package:flutter_carwash/pages/screens/homepage.dart';
import 'package:flutter_carwash/pages/screens/location.dart';
import 'package:flutter_carwash/pages/screens/login_page.dart';
import 'package:flutter_carwash/pages/screens/ratings.dart';
import 'package:flutter_carwash/pages/screens/signup_page.dart';
import 'package:flutter_carwash/services/auth.dart';
import 'package:flutter_carwash/utils/routes.dart';
import 'package:flutter_carwash/widgets/themes.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: VxState(store: MyStore(), child: MyApp())));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserFB>.value(
      value: Authentication().user,
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: MyTheme.lightTheme(context),
        darkTheme: MyTheme.darkTheme(context),
        debugShowCheckedModeBanner: false,
        initialRoute: MyRoutes.loginRoute,
        routes: {
          "/": (context) => LoginPage(),
          MyRoutes.loginRoute: (context) => LoginPage(),
          MyRoutes.homeRoute: (context) => HomePage(),
          MyRoutes.signupRoute: (context) => SignUpPage(),
          MyRoutes.forgotpassRoute: (context) => ForgotPassPage(),
          MyRoutes.cartRoute: (context) => CartPage(),
          MyRoutes.bookingRoute: (context) => BookingPage(),
          MyRoutes.bookingHomeRoute: (context) => MyBookings(),
          MyRoutes.bookingstatusRoute: (context) => Status(),
          MyRoutes.locationRoute: (context) => Loaction(),
          MyRoutes.ratingsRoute: (context) => ReviewsDemo(),
        },
      ),
    );
  }
}
