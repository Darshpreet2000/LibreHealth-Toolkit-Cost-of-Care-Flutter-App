import 'package:curativecare/screens/home/home_screen.dart';
import 'package:curativecare/screens/search/search_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Home(),
        '/SearchProcedure': (context) => SearchProcedure(),
      },
      initialRoute: '/',
    );
  }
}

