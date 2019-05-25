///
/// `to_do_provider.dart`
/// Class contains data of to-do provider
/// Source: Mostly modified from my flutter_assignment_02

import 'dart:async';
import 'package:sqflite/sqflite.dart';

final String tableAccount = 'account';
final String columnId = '_id';
final String columnUserId = 'userId';
final String columnName = 'name';
final String columnAge = 'age';
final String columnPassword = 'password';

class Account {
  int _id;
  String _userId;
  String _name;
  int _age;
  String _password;

  Account({String userId, String name, int age, String password}) {
    this._userId = userId;
    this._name = name;
    this._age = age;
    this._password = password;
  }

  Account.fromMap(Map<String, dynamic> map) {
    this._id = map[columnId];
    this._userId = map[columnUserId];
    this._name = map[columnName];
    this._age = map[columnAge];
    this._password = map[columnPassword];
  }

  int get id => this._id;
  set id(int id) => this._id = id;

  String get userId => this._userId;
  set userId(String userId) => this._userId = userId;

  String get name => this._name;
  set name(String name) => this._name = name;

  int get age => this._age;
  set age(int age) => this._age = age;

  String get password => this._password;
  set password(String password) => this._password = password;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnUserId: this._userId,
      columnName: this._name,
      columnAge: this._age,
      columnPassword: this._password,
    };

    if (this._id != null) {
      map[columnId] = this._id;
    }

    return map;
  }
}

class AccountProvider {
  Database _database;

  Database get database => this._database;

  Future open({String path = 'account.db'}) async {
    String databasesPath = await getDatabasesPath();
    path = databasesPath + path;

    this._database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute('''
          CREATE TABLE $tableAccount (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnUserId TEXT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnAge INTEGER NOT NULL,
            $columnPassword TEXT NOT NULL
          );
        ''');
      },
    );
  }

  Future<Account> insert(Account account) async {
    account.id = await this._database.insert(
          tableAccount,
          account.toMap(),
        );

    return account;
  }

  Future<Account> getAccount(int id) async {
    List<Map> maps = await this._database.query(
          tableAccount,
          columns: [columnId, columnUserId, columnName, columnAge, columnPassword],
          where: '$columnId = ?',
          whereArgs: [id],
        );

    if (maps.length > 0) {
      return Account.fromMap(maps.first);
    }

    return null;
  }

  Future<Account> getAccountByUserId(String userId) async {
    List<Map> maps = await this._database.query(
          tableAccount,
          columns: [columnId, columnUserId, columnName, columnAge, columnPassword],
          where: '$columnUserId = ?',
          whereArgs: [userId],
        );

    if (maps.length > 0) {
      return Account.fromMap(maps.first);
    }

    return null;
  }

  Future<int> delete(int id) async {
    return await this._database.delete(
      tableAccount,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteByUserId(String userId) async {
    return await this._database.delete(
      tableAccount,
      where: '$columnId = ?',
      whereArgs: [userId],
    );
  }

  Future<void> update(Account account) async {
    await this._database.update(
      tableAccount,
      account.toMap(),
      where: '$columnId = ?',
      whereArgs: [account.id],
    );
  }

  Future close() async {
    database.close();
  }
}
