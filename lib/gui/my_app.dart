///
/// `my_app.dart`
///

import 'package:flutter/material.dart';
import 'package:mobilefinal/gui/login_page.dart';
import 'package:mobilefinal/gui/register_page.dart';
import 'package:mobilefinal/util/shared_preferences_util.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SharedPreferencesUtil.loadUserId().then((value) {
      if (value != null) {
        
      }
    });

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
