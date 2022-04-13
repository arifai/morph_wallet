import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:morph_wallet/utils/db_helper.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class Repo {
  void clear();
}

class MorphRepo extends Repo {
  final String key;
  bool _isFirstInit = false;

  MorphRepo(this.key);

  Future<Database> get getDb async {
    final dbClient = await DbHelper().db;
    if (_isFirstInit) {
      return dbClient;
    }

    debugPrint('CREATE OR READ TABLE $key ON DATABASE...');
    dbClient
        .execute(
            'CREATE TABLE IF NOT EXISTS $key (t_key TEXT PRIMARY KEY, t_val TEXT)')
        .then((_) {},
            onError: (e) => debugPrint('Error while creating $key table: $e'));
    _isFirstInit = true;

    return dbClient;
  }

  @override
  void clear() async {
    final dbClient = await getDb;

    dbClient.rawQuery('DROP TABLE $key');
    _isFirstInit;
  }

  Future<Map<String, dynamic>?> getData(String storeName) async {
    final dbClient = await getDb;
    List<Map> result = await dbClient
        .rawQuery('SELECT * FROM $key WHERE t_key=\'$storeName\' LIMIT 1');

    Map<String, dynamic> resultData;

    if (result.isNotEmpty) {
      resultData = jsonDecode(result.first["t_val"]);
    } else {
      resultData = {};
    }

    return resultData;
  }

  Future<void> putData(String storeName, Map<String, dynamic> data) async {
    final dbClient = await getDb;

    await dbClient.rawQuery(
        'INSERT OR REPLACE INTO $key (t_key, t_val) VALUES (?, ?)',
        [storeName, jsonEncode(data)]);
  }
}
