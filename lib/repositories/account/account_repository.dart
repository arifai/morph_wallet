import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:morph_wallet/cores/morph_repository.dart';
import 'package:morph_wallet/services/wallet_service.dart';

class AccountRepository {
  static AccountRepository? _singleton;
  late WalletService walletService;
  MorphRepositoy? repo;

  factory AccountRepository() {
    _singleton ??= AccountRepository.internal();

    return _singleton!;
  }

  AccountRepository.internal() {
    repo = MorphRepositoy('account');
  }

  Future<void> create(String name, String mnemonic, String password) async {
    await repo?.putData('result', {
      'name': name,
      'mnemonic': WalletService().encryptString(mnemonic),
      'password': WalletService().encryptString(password),
    });

    return;
  }

  FutureOr<String?> getWalletAccountName() async {
    return await repo?.getData('result').then((value) {
      debugPrint('Account result: $value');

      if (value!.isNotEmpty) {
        return value['name'];
      } else {
        return null;
      }
    });
  }

  FutureOr<bool> hasAccount() async {
    final String? accountName = await getWalletAccountName();

    return accountName != null;
  }
}
