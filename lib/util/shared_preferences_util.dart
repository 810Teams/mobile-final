///
/// `shared_preferences_util.dart`
/// Class contains shared preferences and file reading/writing methods
/// Source: Reading docs and copied from them.
/// 

import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class SharedPreferencesUtil {
  static void saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  static Future<String> loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('user_id'));
  }

  static void saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }

  static Future<String> loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString('name'));
  }

  static Future<String> getLocalPath() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> getLocalFile({String fileName = 'data.txt'}) async {
    final String path = await getLocalPath();
    return File(path + '/' + fileName);
  }

  static Future<String> getFileContent({String fileName = 'data.txt'}) async {
    try {
      final file = await getLocalFile(fileName: fileName);
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }

  static void writeFileContent({String fileName = 'data.txt', String data = ''}) async {
    final file = await getLocalFile(fileName: fileName);
    file.writeAsString(data);
  }
}
