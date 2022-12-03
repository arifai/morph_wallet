import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:morph_wallet/utils/wallet_util.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:solana/solana.dart' show Ed25519HDKeyPair, Wallet;
import 'package:worker_manager/worker_manager.dart';

class WalletService extends WalletUtil {
  late String mnemonic;
  late Wallet wallet;
  late String address;
  late String? secureKey = dotenv.env['SECURE_KEY'];
  late Key key = Key.fromUtf8(secureKey.toString());
  late IV iv = IV.fromLength(16);

  WalletService();

  @override
  String encryptString(String string) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cfb64));
    final encrypted = encrypter.encrypt(string, iv: iv);

    return encrypted.base64;
  }

  @override
  String decryptString(Encrypted encrypted) {
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    return decrypted;
  }

  @override
  List<String> generetaMnemonic() {
    final mnemonic = bip39.generateMnemonic();

    // Hasil bip39.generateMnemonic() akan di-split agar berbentuk List<String>.
    // Ini karena menyesuaikan kebutuhan yang ada di MnemonicWidget()
    return mnemonic.split(' ');
  }

  @override
  Future<Ed25519HDKeyPair> createKeypair(String mnemonic) async {
    final Ed25519HDKeyPair keyPair =
        await Ed25519HDKeyPair.fromMnemonic(mnemonic);

    return keyPair;
  }

  @override
  Future<void> loadKeypair() async {
    final Ed25519HDKeyPair keypair = await Executor().execute(arg1: mnemonic);

    wallet = keypair;
    address = wallet.address;
  }

  @override
  Future importWallet(String mnemonic) async {
    await loadKeypair();

    return;
  }
}
