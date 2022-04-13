import 'dart:io' as io;
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper.internal();
  static Database? _db;
  static final DbHelper _instance = DbHelper.internal();

  factory DbHelper() => _instance;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();

    return _db!;
  }

  initDb() async {
    debugPrint('Creating the database...');

    const String dbName = 'morph_wallet.db';
    io.Directory dir = await getApplicationDocumentsDirectory();
    String filePath = join(dir.path, dbName);

    return await openDatabase(filePath, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {}
}
