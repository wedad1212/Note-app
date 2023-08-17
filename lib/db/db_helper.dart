import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static final int _version = 1;
  static final String _tableName = "Tasks";

  static Database? _db;

  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint("No init database");
      return;
    } else {
      try {
        String path = await getDatabasesPath() + 'Task.db';
        debugPrint("Create database");
        _db = await openDatabase(path, version: _version,
            onCreate: (Database db, int version) async {
              await db.execute('CREATE TABLE $_tableName ('
                  'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                  'title STRING,'
                  'note TEXT,'
                  'date STRING,'
                  'startTime STRING,'
                  'endTime STRING,'
                  'color INTEGER,'
                  'remind INTEGER,'
                  'isCompleted INTEGER,'
                  'repeat STRING)');

            });
      } catch (e) {

        print(e);
      }
    }
  }

  static Future<int> insert(Task task) async {
    try {
      debugPrint("insert Task");
      return await _db!.insert(_tableName, task.toJson());
    }
    catch (e) {
      debugPrint("no insert Task");
      return 100;
    }
  }
  static Future<int> deleteAll()async{
    return await _db!.delete(_tableName);
  }

  static Future<int> delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static Future<int> update(int id) async {
    try {
      return await _db!.rawUpdate('''
    UPDATE $_tableName
    SET isCompleted = ?
    WHERE id = ?
  
   ''', [1, id]);
    } catch (e) {
      print("error");

      return 200;
    }
  }

}
