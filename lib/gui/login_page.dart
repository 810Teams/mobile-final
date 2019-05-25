///
/// `login_page.dart`
///

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobilefinal/gui/homepage.dart';
import 'package:mobilefinal/model/account.dart';
import 'package:mobilefinal/util/alert.dart';
import 'package:mobilefinal/util/shared_preferences_util.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final AccountProvider _database = AccountProvider();
  static final TextEditingController _controllerUserId = TextEditingController();
  static final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Step #1: Open database
    this._database.open().then((_) {
      // Step #2: Try loading user ID from shared preferences
      SharedPreferencesUtil.loadUserId().then((value) {
        // Step #3: Check if user ID is not null
        if (value != null) {
          // Step #4: Wait for complete build
          SchedulerBinding.instance.addPostFrameCallback((__) {
            // Step #5: Get account data from SQFLite with specific user ID
            this._database.getAccountByUserId(value).then((account) {
              // Step #6: Push to homepage
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage(account)));
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 32.0, right: 32.0),
          children: <Widget>[
            Container(
              child: Image.asset('assets/key.jpg'),
              padding: EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
            ),
            SizedBox(height: 24.0),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _controllerUserId,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'User ID',
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _controllerPassword,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 24.0),
            RaisedButton(
              child: Text('LOGIN'),
              padding: EdgeInsets.all(8.0),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {
                _controllerUserId.text = _controllerUserId.text.trim();
                if (_controllerUserId.text.isEmpty || _controllerPassword.text.isEmpty) {
                  Alert.displayAlert(
                    context,
                    title: 'Login Failed',
                    content: 'Please fill out this form.',
                  );
                } else {
                  this._database.getAccountByUserId(_controllerUserId.text).then((account) {
                    if (account == null || _controllerPassword.text != account.password) {
                      Alert.displayAlert(
                        context,
                        title: 'Login Failed',
                        content: 'Invalid user or password.',
                      );
                    } else {
                      SharedPreferencesUtil.saveUserId(_controllerUserId.text);

                      this._database.getAccountByUserId(_controllerUserId.text).then((value) {
                        // Logic: Save before push
                        SharedPreferencesUtil.saveName(value.name);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage(account)),
                        );
                      });
                    }
                  });
                }
              },
            ),
            Container(
              child: FlatButton(
                child: Text('Register New Account'),
                textColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.only(right: 0.0),
                onPressed: () {
                  Navigator.pushNamed(context, 'RegisterPage');
                },
              ),
              alignment: Alignment.topRight,
            )
          ],
        ),
      ),
    );
  }
}
