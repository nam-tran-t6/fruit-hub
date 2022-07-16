import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'app_sql_query.dart';

class DatabaseHelper {
  static const String DB_NAME = 'fruit-hub-app.db';
  static const int DB_VERSION = 1;

  //Only 1 instance of database should be created in app
  Database? _db;

  static final DatabaseHelper _singleton = DatabaseHelper._internal();

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _singleton;
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDatabase();
    }
    return _db!;
  }

  Future<Database> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final databasesPath = await getDatabasesPath();

    _db = await openDatabase(
      path.join(databasesPath, DB_NAME),
      version: DB_VERSION,
      onCreate: (Database db, int version) async {
        await db.execute(AppSqlQuery.CREATE_TABLE_ADDED_ITEM);
      },
    );
    return _db!;
  }
}
