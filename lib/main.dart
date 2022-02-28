import 'package:cs_ia/Constraint.dart';
import 'package:cs_ia/screens/Orderhistory.dart';
import 'package:cs_ia/screens/adminscreen.dart';
import 'package:cs_ia/screens/edit_profile.dart';
import 'package:cs_ia/screens/forgetpswd.dart';
import 'package:cs_ia/screens/home.dart';
import 'package:cs_ia/screens/login.dart';
import 'package:cs_ia/screens/navigation.dart';
import 'package:cs_ia/screens/register.dart';
import 'package:cs_ia/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(98, 104, 232, .1),
  100: Color.fromRGBO(98, 104, 232, .2),
  200: Color.fromRGBO(98, 104, 232, .3),
  300: Color.fromRGBO(98, 104, 232, .4),
  400: Color.fromRGBO(98, 104, 232, .5),
  500: Color.fromRGBO(98, 104, 232, .6),
  600: Color.fromRGBO(98, 104, 232, .7),
  700: Color.fromRGBO(98, 104, 232, .8),
  800: Color.fromRGBO(98, 104, 232, .9),
  900: Color.fromRGBO(98, 104, 232, 1),
};
MaterialColor colorCustom = MaterialColor(0xFF6268e8, color);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cs_ia',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: welcome(),
    );
  }
}
