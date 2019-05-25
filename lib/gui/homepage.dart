///
/// `homepage.dart`
///

import 'package:flutter/material.dart';
import 'package:mobilefinal/gui/friend_list_page.dart';
import 'package:mobilefinal/gui/profile_page.dart';
import 'package:mobilefinal/model/account.dart';
import 'package:mobilefinal/util/shared_preferences_util.dart';

class Homepage extends StatefulWidget {
  final Account _account;

  Homepage(this._account);

  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage> {
  String _currentQuote = '';

  void refreshState() {
    SharedPreferencesUtil.getFileContent(fileName: 'quote.txt').then((value) {
      setState(() {
        this._currentQuote = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this.refreshState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          Text(
            'Hello ' + widget._account.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.grey[700]),
          ),
          SizedBox(height: 10.0),
          Text(
            'This is my quote "' + this._currentQuote + '".',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            child: RaisedButton(
              child: Text('Profile Setup'),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(widget._account, this.refreshState),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            child: RaisedButton(
              child: Text('My Friends'),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FriendListPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            child: RaisedButton(
              child: Text('Sign Out'),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                SharedPreferencesUtil.saveUserId(null);
                SharedPreferencesUtil.saveName(null);
                Navigator.pushReplacementNamed(context, 'LoginPage');
              },
            ),
          ),
        ],
      ),
    );
  }
}
