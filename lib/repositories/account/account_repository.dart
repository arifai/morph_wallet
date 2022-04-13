import 'package:morph_wallet/cores/repo.dart';
import 'package:morph_wallet/utils/crypto_util.dart';

class AccountRepository {
  static AccountRepository? _singleton;
  MorphRepo? repo;

  factory AccountRepository() {
    _singleton ??= AccountRepository.internal();

    return _singleton!;
  }

  AccountRepository.internal() {
    repo = MorphRepo('account');
  }

  Future<void> create({
    required String name,
    required String mnemonic,
    required String password,
  }) {
    // debugPrint('{ $name, $mnemonic, $password }');

    return repo!.putData('result', {
      'name': name,
      'mnemonic': toHash(mnemonic),
      'password': toHash(password),
    });
  }

  Future<bool> hasAccount() async {
    var account = await getAccount();

    return account != null;
  }

  Future<String?> getAccount() async {
    return await repo!.getData('result').then((value) {
      // debugPrint(value!['name'].toString());
      if (value!.isNotEmpty) {
        return value['name'] as String;
      } else {
        return null;
      }
    });
  }
}
