import 'package:flutter/material.dart';
import './screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RootedWI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen()
    );
  }
}
