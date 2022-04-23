import 'package:encrypt/encrypt.dart';
import 'package:solana/solana.dart' show Ed25519HDKeyPair;

abstract class WalletUtil {
  /// Generate new mnemonic
  List<String> generetaMnemonic();

  /// Encrypt string
  String encryptString(String string);

  /// Decrypt string
  String decryptString(Encrypted encrypted);

  /// Create key pair
  Future<Ed25519HDKeyPair> createKeypair(String mnemonic);

  /// Load keypair
  Future<void> loadKeypair();

  Future importWallet(String mnemonic);
}
