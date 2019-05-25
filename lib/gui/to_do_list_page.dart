///
/// `to_do_list_page.dart`
///

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobilefinal/model/friend.dart';
import 'package:mobilefinal/util/custom.dart';

class ToDoListPage extends StatefulWidget {
  final Friend _friend;

  ToDoListPage(this._friend);

  @override
  State<StatefulWidget> createState() {
    return _ToDoListPageState();
  }
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<dynamic> _toDoList = List<dynamic>();

  Future<dynamic> fetchPost() async {
    final response = await http.get(
      'https://jsonplaceholder.typicode.com/todos?userId=' +
          widget._friend.id.toString(),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body).map((e) => ToDo.fromMap(e)).toList();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPost().then((value) {
      setState(() {
        this._toDoList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
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
                ._toDoList
                .map((e) => Custom.getCustomCard(context,
                        name: e.id.toString(),
                        subtitle: e.title +
                            '\n\n' +
                            ((e.completed) ? 'Completed' : ''),
                        trailing: Text(''), onTap: () {
                      // NOTES: No furthur child pages
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
