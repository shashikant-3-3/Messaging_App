import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import "./pages/login_page.dart";
import './pages/registration_page.dart';
import './pages/home_page.dart';

import './services/navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Something went wrong");
          throw new Exception("Something went wrong in firebase intialisation");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'JustChat',
            navigatorKey: NavigationService.instance.navigatorKey,
            theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Color.fromRGBO(42, 117, 188, 1),
              accentColor: Color.fromRGBO(42, 117, 188, 1),
              backgroundColor: Color.fromRGBO(28, 27, 27, 1),
            ),
            initialRoute: "login",
            routes: {
              "login": (BuildContext _context) => LoginPage(),
              "register": (BuildContext _context) => RegistrationPage(),
              "home": (BuildContext _context) => HomePage(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}
