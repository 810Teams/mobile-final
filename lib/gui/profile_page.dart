///
/// `register_page.dart`
///

import 'package:flutter/material.dart';
import 'package:mobilefinal/model/account.dart';
import 'package:mobilefinal/util/shared_preferences_util.dart';

class ProfilePage extends StatefulWidget {
  final Account _account;
  final Function _refreshState;

  ProfilePage(this._account, this._refreshState);

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final AccountProvider _database = AccountProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _controllerUserId = TextEditingController();
  static final TextEditingController _controllerName = TextEditingController();
  static final TextEditingController _controllerAge = TextEditingController();
  static final TextEditingController _controllerPassword = TextEditingController();
  static final TextEditingController _controllerQuote = TextEditingController();

  void loadFields() {
    _controllerUserId.text = widget._account.userId;
    _controllerName.text = widget._account.name;
    _controllerAge.text = widget._account.age.toString();
    _controllerPassword.text = widget._account.password;
  }

  @override
  void initState() {
    super.initState();
    this.loadFields();
    SharedPreferencesUtil.getFileContent(fileName: 'quote.txt').then((value) {
      _controllerQuote.text = value;
    });
    this._database.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Form(
        key: this._formKey,
        child: Center(
          child: ListView(
            padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _controllerUserId,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'User ID',
                ),
                validator: (String value) {
                  if (value.length < 6 || value.length > 12) {
                    return 'User ID must be in 6 to 12 characters long';
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _controllerName,
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  hintText: 'Name',
                ),
                validator: (String value) {
                  if (value.trim().split(' ').length != 2) {
                    return 'Invalid name format';
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _controllerAge,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  hintText: 'Age',
                ),
                validator: (String value) {
                  try {
                    if (int.parse(value) < 10) {
                      return 'Sorry, too young to use this application.';
                    } else if (int.parse(value) > 80) {
                      return 'Sorry, too old to use this application.';
                    }
                  } catch (e) {
                    return 'Invalid integer format';
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Password',
                ),
                validator: (String value) {
                  if (value.length <= 6) {
                    return 'Password must be more than 6 characters long';
                  }
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _controllerQuote,
                maxLines: 4,
                decoration: InputDecoration(
                  icon: Icon(Icons.note),
                  hintText: 'Quote',
                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Save"),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  if (this._formKey.currentState.validate()) {
                    widget._account.userId = _controllerUserId.text;
                    widget._account.name = _controllerName.text;
                    widget._account.age = int.parse(_controllerAge.text);
                    widget._account.password = _controllerPassword.text;
                    SharedPreferencesUtil.writeFileContent(
                      fileName: 'quote.txt',
                      data: _controllerQuote.text,
                    );
                    this._database.update(widget._account).then((_) {
                      widget._refreshState();
                      Navigator.pop(context);
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
