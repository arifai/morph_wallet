import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

abstract class BaseMorphRepository {
  /// Create new a [BoxCollection].
  Future<BoxCollection> get openCollection;

  /// Put some data from database.
  Future<dynamic> putData(String key, Map<String, dynamic> value);

  /// Get some data from database.
  Future<dynamic> getData(String key);

  /// Delete some data from database.
  Future<dynamic> deleteDate(String key);

  /// Clear or delete all boxes.
  void clear();

  /// Close & drop all chached keys and values from memory.
  void close();
}

class MorphRepositoy extends BaseMorphRepository {
  final String name;

  MorphRepositoy(this.name);

  @override
  Future<BoxCollection> get openCollection async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    return await BoxCollection.open(
      'morph_db',
      {name},
      path: appDocDir.path,
      key: HiveAesCipher(Hive.generateSecureKey()),
    );
  }

  @override
  Future<void> putData(String key, Map<String, dynamic> value) async {
    final box = await openCollection
        .then((value) => value.openBox<Map<String, dynamic>>(name));

    return box.put(key, value);
  }

  @override
  Future<Map<String, dynamic>?> getData(String key) async {
    final box = await openCollection
        .then((value) => value.openBox<Map<String, dynamic>>(name));

    return box.get(key);
  }

  @override
  Future<void> deleteDate(String key) async {
    final box = await openCollection
        .then((value) => value.openBox<Map<String, dynamic>>(name));

    return box.delete(key);
  }

  @override
  void clear() async {
    final box = await openCollection;

    box.openBox(name);
    box.deleteFromDisk();
  }

  @override
  void close() async {
    final box = await openCollection;

    box.openBox(name);
    box.close();
  }
}
