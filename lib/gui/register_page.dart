///
/// `register_page.dart`
/// 

import 'package:flutter/material.dart';
import 'package:mobilefinal/model/account.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final AccountProvider _database = AccountProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _controllerUserId = TextEditingController();
  static final TextEditingController _controllerName = TextEditingController();
  static final TextEditingController _controllerAge = TextEditingController();
  static final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    this._database.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTER'),
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
                  // NOTES: The exam said the password length must be *more than 6*
                  if (value.length <= 6) {
                    return 'Password must be more than 6 characters long';
                  }
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Register New Account".toUpperCase()),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  if (this._formKey.currentState.validate()) {
                    this
                        ._database
                        .insert(
                          Account(
                            userId: _controllerUserId.text,
                            name: _controllerName.text,
                            age: int.parse(_controllerAge.text),
                            password: _controllerPassword.text,
                          ),
                        )
                        .then((_) {
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
