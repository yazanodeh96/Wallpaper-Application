import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "favorites.db";
  static final _databaseVersion = 1;

  static final table = 'favorites';

  static final columnId = 'id';
  static final columnimgUrl = 'imgUrl';

  static Database? _database;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnimgUrl TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(String imgUrl) async {
    Database db = await instance.database;
    return await db.insert(table, {columnimgUrl: imgUrl});
  }

  Future<int> delete(String imgUrl) async {
    Database db = await instance.database;
    return await db
        .delete(table, where: '$columnimgUrl = ?', whereArgs: [imgUrl]);
  }

  Future<List<String>> getFavorites() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (index) {
      return maps[index][columnimgUrl];
    });
  }
}
