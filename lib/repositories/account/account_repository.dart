import 'package:flutter/rendering.dart';
import 'package:morph_wallet/cores/repo.dart';
import 'package:morph_wallet/services/wallet_service.dart';

class AccountRepository {
  static AccountRepository? _singleton;
  late WalletService walletService;
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
  }) async {
    await walletService.importWallet(mnemonic);

    await repo!.putData('result', {
      'name': name,
      'mnemonic': WalletService().encryptString(mnemonic),
      'password': WalletService().encryptString(password),
    });

    return;
  }

  Future<bool> hasAccount() async {
    var accountName = await getWalletAccountName();

    return accountName != null;
  }

  Future<String?> getWalletAccountName() async {
    return await repo!.getData('result').then((value) {
      debugPrint('This account data: $value');

      if (value!.isNotEmpty) {
        return value['name'] as String;
      } else {
        return null;
      }
    });
  }
}
