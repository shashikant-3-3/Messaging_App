import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/Pages/Login_Page.dart';
import 'package:messaging_app/Pages/home_Page.dart';
import 'package:messaging_app/Pages/registration_page.dart';
import './services/navigation.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messaging App',
      navigatorKey: NavigationService.instance.navigatorkey,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(42, 117, 188, 1),
        accentColor: Color.fromRGBO(42, 117, 188, 1),
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
      ),
      initialRoute: "login",
      routes: {
        "login" : (BuildContext _context) =>LoginPage(),
        "register":(BuildContext _context) => RegistrationPage(),
        "home":(BuildContext _context) => HomePage(),
      },
    );
  }
}

