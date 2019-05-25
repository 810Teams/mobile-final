///
/// `friend_list_page.dart`
///

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobilefinal/gui/to_do_list_page.dart';
import 'package:mobilefinal/model/friend.dart';
import 'package:mobilefinal/util/custom.dart';

class FriendListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FriendListPageState();
  }
}

class _FriendListPageState extends State<FriendListPage> {
  List<dynamic> _friendList = List<dynamic>();

  void refreshState() {
    setState(() {});
  }

  Future<dynamic> fetchPost() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      return json.decode(response.body).map((e) => Friend.fromMap(e)).toList();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPost().then((value) {
      setState(() {
        this._friendList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend List'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            child: RaisedButton(
              child: Text('Back'),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Column(
            children: this
                ._friendList
                .map((e) => Custom.getCustomCard(context,
                        name: e.id.toString() + ' : ' + e.name,
                        subtitle: e.email + '\n' + e.phone + '\n' + e.website,
                        onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ToDoListPage(e)),
                      );
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
