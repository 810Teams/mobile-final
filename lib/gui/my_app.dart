///
/// `my_app.dart`
///

import 'package:flutter/material.dart';
import 'package:mobilefinal/gui/homepage.dart';
import 'package:mobilefinal/gui/login_page.dart';
import 'package:mobilefinal/gui/register_page.dart';
import 'package:mobilefinal/model/account.dart';
import 'package:mobilefinal/util/shared_preferences_util.dart';

class MyApp extends StatelessWidget {
  final AccountProvider _database = AccountProvider();

  MyApp() {
    this._database.open();
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferencesUtil.loadUserId().then((value) {
      if (value != null) {
        this._database.getAccountByUserId(value).then((account) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Homepage(account)),
          );
        });
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
