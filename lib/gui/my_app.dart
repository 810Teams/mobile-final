///
/// `my_app.dart`
///

import 'package:flutter/material.dart';
import 'package:mobilefinal/gui/login_page.dart';
import 'package:mobilefinal/gui/register_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        'LoginPage': (context) => LoginPage(),
        'RegisterPage': (context) => RegisterPage(),
      },
    );
  }
}
