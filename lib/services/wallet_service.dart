import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:morph_wallet/cores/locator.dart';
import 'package:morph_wallet/models/wallet_account/keypair.dart';
import 'package:morph_wallet/models/wallet_account/wallet_account.dart';
import 'package:morph_wallet/repositories/account/account_repository.dart';
import 'package:morph_wallet/services/solana_rpc_service.dart';
import 'package:morph_wallet/utils/wallet_util.dart';
import 'package:solana/solana.dart';

final String secureKey = '${dotenv.env['SECURE_KEY']}';

mixin WalletSetupMixin {
  final IV iv = IV.fromLength(16);
  late Key key = Key.fromUtf8(secureKey);
  late Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cfb64));
}

class WalletService extends WalletUtil with WalletSetupMixin {
  @override
  String encryptString(String string) {
    final Encrypted encrypted = encrypter.encrypt(string, iv: iv);

    return encrypted.base64;
  }

  @override
  String decryptString(Encrypted encrypted) {
    final String decrypted = encrypter.decrypt(encrypted, iv: iv);

    return decrypted;
  }

  @override
  List<String> generetaMnemonic() {
    final Mnemonic mnemonic = Mnemonic.generate(
      Language.english,
      passphrase: '${dotenv.env['PASSPHRASE']}',
    );

    return mnemonic.words;
  }

  @override
  Future<Ed25519HDKeyPair> createKeypair(Keypair keypair) async {
    final Ed25519HDKeyPair keyPair = await Ed25519HDKeyPair.fromMnemonic(
      keypair.mnemonic ?? '',
      account: keypair.account,
      change: keypair.change,
    );

    return keyPair;
  }

  @override
  Future<String?> getAddress() async {
    final AccountRepository accountRepo = locator<AccountRepository>();
    final WalletAccount? account = await accountRepo.loadWallet();

    return account?.address;
  }

  @override
  Future<int> getBalance(String address) async {
    final SolanaRpcService rpcService = locator<SolanaRpcService>();

    return await rpcService.rpcClient.getBalance(
      address,
      commitment: Commitment.confirmed,
    );
  }
}
