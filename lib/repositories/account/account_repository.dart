import 'dart:async';

import 'package:encrypt/encrypt.dart';
import 'package:morph_wallet/cores/morph_repository.dart';
import 'package:morph_wallet/models/wallet_account/keypair.dart';
import 'package:morph_wallet/models/wallet_account/wallet_account.dart';
import 'package:morph_wallet/services/wallet_service.dart';
import 'package:morph_wallet/widgets/commons/constants.dart';

class AccountRepository {
  static final AccountRepository _singleton = AccountRepository._internal();
  final WalletService _walletService = WalletService();
  MorphRepositoy? _repo;

  factory AccountRepository() => _singleton;

  AccountRepository._internal() {
    _repo = MorphRepositoy(RepoKeys.account);
  }

  Future<void> create(String name, String password, String? mnemonic) async {
    final int count = await _incrementDerivationDigits();

    await _repo?.putData<Map<String, dynamic>>(
      RepoKeys.entries,
      WalletAccount(
        name,
        WalletService().encryptString(password),
        keypair: Keypair(mnemonic, count, count),
      ).toMap(),
    );
  }

  Future<WalletAccount?> loadWallet() async {
    final Map<String, dynamic>? entries =
        await _repo?.getData(RepoKeys.entries);
    late WalletAccount? account;

    if (entries != null) {
      final Map<dynamic, dynamic> keypairEntries = entries['keypair'];
      final Keypair keypair = Keypair(
        keypairEntries['mnemonic'],
        keypairEntries['account'],
        keypairEntries['change'],
      );

      account = WalletAccount(
        entries['name'],
        WalletService().decryptString(Encrypted.from64(entries['password'])),
        wallet: await _walletService.createKeypair(keypair),
      );
    } else {
      account = null;
    }

    return account;
  }

  Future<int> _incrementDerivationDigits() async {
    final WalletAccount? account = await loadWallet();
    late int count = 0;

    if (account != null) {
      return count = account.keypair?.account ?? 0 + 1;
    } else {
      return count;
    }
  }

  Future<bool> hasAccount() async {
    final WalletAccount? account = await loadWallet();

    if (account != null) {
      return true;
    } else {
      return false;
    }
  }
}
