import 'package:hive_flutter/hive_flutter.dart';

abstract class BaseMorphRepository {
  Future<Box<dynamic>> setupBox();
  Future<void> close();
  Future<void> clearAll();
  Future<void> putData<E>(String key, E value);
  Future<Map<String, dynamic>?> getData(String key);
}

class MorphRepositoy extends BaseMorphRepository {
  final String name;

  MorphRepositoy(this.name);

  late Box box = Hive.box(name);

  @override
  Future<void> clearAll() async => box.deleteAll(box.keys);

  @override
  Future<void> close() async => await box.close();

  @override
  Future<Box> setupBox() async {
    return await Hive.openBox(
      name,
      encryptionCipher: HiveAesCipher(Hive.generateSecureKey()),
    );
  }

  @override
  Future<void> putData<E extends dynamic>(String key, E value) async {
    return await box.put(key, value);
  }

  @override
  Future<Map<String, dynamic>?> getData(String key) async {
    return await box.get(key)?.cast<String, dynamic>();
  }
}
